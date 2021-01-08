//! after send loadfilter message in bloomfilter mod we can get merkleblock in this mod and get
//! loadfilter message do not get any response.
//! we get response here
use crate::error::Error;
use crate::hooks::{HooksMessage, ShowCondition};
use crate::p2p::{
    P2PControlSender, PeerId, PeerMessage, PeerMessageReceiver, PeerMessageSender, SERVICE_BLOCKS,
    SERVICE_BLOOM,
};
use crate::timeout::{ExpectedReply, SharedTimeout};
use bitcoin::network::message::NetworkMessage;
use bitcoin::network::message_blockdata::{InvType, Inventory};
use bitcoin::network::message_bloom_filter::MerkleBlockMessage;
use bitcoin::{BitcoinHash, Transaction};
use bitcoin_hashes::hash160;
use bitcoin_hashes::hex::FromHex;
use bitcoin_hashes::hex::ToHex;

use crate::constructor::CondvarPair;
use crate::db::{RB_CHAIN, RB_DETAIL};
use bitcoin_hashes::Hash;
use log::{error, info, trace, warn};
use std::ops::Deref;
use std::sync::{mpsc, Arc};
use std::thread;
use std::time::Duration;

const PUBLIC_KEY: &str = "0291ee52a0e0c22db9772f237f4271ea6f9330d92b242fb3c621928774c560b699";

pub struct GetData<T> {
    //send a message
    p2p: P2PControlSender<NetworkMessage>,
    timeout: SharedTimeout<NetworkMessage, ExpectedReply>,
    hook_receiver: mpsc::Receiver<HooksMessage>,
    condvar_pair: CondvarPair<T>,
}

impl<T: Send + 'static + ShowCondition> GetData<T> {
    pub fn new(
        p2p: P2PControlSender<NetworkMessage>,
        timeout: SharedTimeout<NetworkMessage, ExpectedReply>,
        hook_receiver: mpsc::Receiver<HooksMessage>,
        condvar_pair: CondvarPair<T>,
    ) -> PeerMessageSender<NetworkMessage> {
        let (sender, receiver) = mpsc::sync_channel(p2p.back_pressure);

        let mut getdata = GetData {
            p2p,
            timeout,
            hook_receiver,
            condvar_pair,
        };

        thread::Builder::new()
            .name("GetData".to_string())
            .spawn(move || getdata.run(receiver))
            .unwrap();

        PeerMessageSender::new(sender)
    }

    //Loop through messages
    fn run(&mut self, receiver: PeerMessageReceiver<NetworkMessage>) {
        let hash160 = self.hash160("");
        let mut merkle_vec = vec![];
        loop {
            //This method is the message receiving end, that is, an outlet of the channel, a consumption end of the Message
            while let Ok(msg) = receiver.recv_timeout(Duration::from_millis(4000)) {
                if let Err(e) = match msg {
                    PeerMessage::Connected(pid, _) => {
                        if self.is_serving_blocks(pid) {
                            trace!("serving blocks peer={}", pid);
                            //Make a request GetData
                            self.get_data(pid, false)
                        } else {
                            Ok(())
                        }
                    }
                    PeerMessage::Disconnected(_, _) => Ok(()),
                    PeerMessage::Incoming(pid, msg) => match msg {
                        NetworkMessage::MerkleBlock(ref merkleblock) => {
                            if self.is_serving_blocks(pid) {
                                {
                                    let block_hash = merkleblock.prev_block.to_hex();
                                    let timestamp = merkleblock.timestamp;
                                    {
                                        RB_DETAIL
                                            .update_progress(block_hash, timestamp.to_string());
                                    }
                                }

                                if merkle_vec.len() <= 100 {
                                    merkle_vec.push(merkleblock.clone());
                                } else {
                                    self.merkleblock(&merkle_vec, pid)
                                        .expect("merkle block vector failed");
                                    merkle_vec.clear();
                                }
                                Ok(())
                            } else {
                                Ok(())
                            }
                        }
                        NetworkMessage::Tx(ref tx) => {
                            if self.is_serving_blocks(pid) {
                                self.tx(tx, pid, hash160.clone())
                            } else {
                                Ok(())
                            }
                        }
                        NetworkMessage::Ping(_) => Ok(()),
                        _ => Ok(()),
                    },
                    _ => Ok(()),
                } {
                    error!("Error processing headers: {}", e);
                }
            }
            
            self.timeout
                .lock()
                .unwrap()
                .check(vec![ExpectedReply::MerkleBlock, ExpectedReply::Tx]);
        }
    }

    fn is_serving_blocks(&self, peer: PeerId) -> bool {
        if let Some(peer_version) = self.p2p.peer_version(peer) {
            return peer_version.services & SERVICE_BLOCKS != 0;
        }
        false
    }

    // retrieve data
    fn get_data(&mut self, peer: PeerId, add: bool) -> Result<(), Error> {
        if self
            .timeout
            .lock()
            .unwrap()
            .is_busy_with(peer, ExpectedReply::MerkleBlock)
        {
            error!("busy with merkleblock");
            return Ok(());
        }

        if self
            .timeout
            .lock()
            .unwrap()
            .is_busy_with(peer, ExpectedReply::Tx)
        {
            error!("busy with Tx");
            return Ok(());
        }

        {
            error!("wait_for filter condition");
            let ref pair = self.condvar_pair;
            let &(ref lock, ref cvar) = Arc::deref(pair);
            let mut condition = lock.lock();
            while (*condition).get_filter() == false {
                let r = cvar.wait_for(&mut condition, Duration::from_secs(5));
                if r.timed_out() {
                    error!("wait_for filter condition timeout");
                    return Ok(());
                }
            }
        }
        error!("get fillter_ready condition");

        let mut header_vec: Vec<String> = vec![];
        {
            let p = RB_DETAIL.progress();
            header_vec = RB_CHAIN.fetch_scan_header(p.timestamp, add);
        }

        if header_vec.len() == 0 {
            return Ok(());
        }

        let mut inventory_vec = vec![];
        for header in header_vec {
            let inventory = Inventory::new(InvType::FilteredBlock, header.as_str());
            inventory_vec.push(inventory);
        }
        self.p2p
            .send_network(peer, NetworkMessage::GetData(inventory_vec));
        Ok(())
    }

    fn merkleblock(
        &mut self,
        merkle_vec: &Vec<MerkleBlockMessage>,
        peer: PeerId,
    ) -> Result<(), Error> {
        self.timeout
            .lock()
            .unwrap()
            .received(peer, 1, ExpectedReply::MerkleBlock);
        info!("got a vec of 100 merkleblock");
        let merkleblock = merkle_vec.last().unwrap();
        info!("got 100 merkleblock {:#?}", merkleblock);
        self.get_data(peer, true)?;
        Ok(())
    }

    // Handle tx return value
    fn tx(&mut self, tx: &Transaction, peer: PeerId, hash160: String) -> Result<(), Error> {
        self.timeout
            .lock()
            .unwrap()
            .received(peer, 1, ExpectedReply::Tx);

        info!("Tx {:#?}", tx.clone());
        let tx_hash = &tx.bitcoin_hash();
        let vouts = tx.clone().output;
        let mut index = -1;
        for vout in vouts {
            index += 1;
            let script = vout.script_pubkey;
            if script.is_p2pkh() {
                let asm = script.asm();
                let mut iter = asm.split_ascii_whitespace();
                iter.next();
                iter.next();
                iter.next();
                let current_hash = iter.next().unwrap_or(" ");
                if current_hash.eq(hash160.as_str()) {
                    RB_DETAIL.save_txout(
                        tx_hash.to_hex(),
                        asm.clone(),
                        vout.value.to_string(),
                        index.to_string(),
                    );
                }
            }
        }

        let vines = tx.clone().input;
        for vin in vines {
            let script = vin.script_sig;
            let prev_output = vin.previous_output;
            let prev_tx = prev_output.txid.to_hex();
            let prev_vout = prev_output.vout;
            let sequence = vin.sequence;
            let sig_script = script.asm();
            let mut iter = sig_script.split_ascii_whitespace();
            iter.next();
            iter.next();
            iter.next();
            let iter3 = iter.next().unwrap_or(" ");
            if iter3.eq(PUBLIC_KEY) {
                RB_DETAIL.save_txin(
                    tx_hash.to_hex(),
                    sig_script.clone(),
                    prev_tx,
                    prev_vout.to_string(),
                    sequence,
                );
            }
        }
        Ok(())
    }

    ///Calculation hash160
    fn hash160(&self, _public_key: &str) -> String {
        let decode: Vec<u8> = FromHex::from_hex(PUBLIC_KEY).expect("Invalid public key");
        let hash = hash160::Hash::hash(&decode[..]);
        warn!("HASH160 {:?}", hash.to_hex());
        hash.to_hex()
    }
}
