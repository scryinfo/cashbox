//! after send loadfilter message in bloomfilter mod we can get merkleblock in this mod and get
//! loadfilter message do not get any response.
//! we get response here
use crate::error::Error;
use crate::hooks::{HooksMessage, ShowCondition};
use crate::p2p::{
    P2PControlSender, PeerId, PeerMessage, PeerMessageReceiver, PeerMessageSender, SERVICE_BLOCKS,
};
use crate::timeout::{ExpectedReply, SharedTimeout};
use bitcoin::network::message::NetworkMessage;
use bitcoin::network::message_blockdata::{InvType, Inventory};
use bitcoin::network::message_bloom_filter::MerkleBlockMessage;
use bitcoin::{BitcoinHash, Transaction};
use bitcoin_hashes::hex::ToHex;

use crate::constructor::CondvarPair;
use crate::db::{RB_CHAIN, RB_DETAIL, VERIFY};
use log::{error, info, trace};
use std::ops::Deref;
use std::sync::{mpsc, Arc};
use std::thread;
use std::time::Duration;

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
        let mut merkle_vec = vec![];
        loop {
            //This method is the message receiving end, that is, an outlet of the channel, a consumption end of the Message
            while let Ok(msg) = receiver.recv_timeout(Duration::from_millis(9000)) {
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
                            {
                                let block_hash = merkleblock.prev_block.to_hex();
                                let timestamp = merkleblock.timestamp;
                                {
                                    RB_DETAIL.update_progress(block_hash, timestamp.to_string());
                                }
                            }

                            if merkle_vec.len() <= 100 {
                                merkle_vec.push(merkleblock.clone());
                            } else {
                                if self.is_serving_blocks(pid) {
                                    self.merkleblock(&merkle_vec, pid)
                                        .expect("merkle block vector failed");
                                }
                                merkle_vec.clear();
                            }
                            Ok(())
                        }
                        NetworkMessage::Tx(ref tx) => self.tx(tx, pid),
                        NetworkMessage::Ping(_) => {
                            if self.is_serving_blocks(pid) {
                                trace!("serving blocks peer={}", pid);
                                //Make a request GetData
                                self.get_data(pid, true)
                            } else {
                                Ok(())
                            }
                        }
                        _ => Ok(()),
                    },
                    _ => Ok(()),
                } {
                    error!("Error processing headers: {}", e);
                }
            }
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
        {
            error!("wait_for filter condition");
            let ref pair = self.condvar_pair;
            let &(ref lock, ref cvar) = Arc::deref(pair);
            let mut condition = lock.lock();
            while (*condition).get_filter() == false {
                let r = cvar.wait_for(&mut condition, Duration::from_secs(5));
                if r.timed_out() {
                    info!("wait_for filter condition timeout");
                    return Ok(());
                }
            }
        }
        info!("get fillter_ready condition");

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
        info!("send getdata message");
        self.p2p
            .send_network(peer, NetworkMessage::GetData(inventory_vec));
        Ok(())
    }

    fn merkleblock(
        &mut self,
        merkle_vec: &Vec<MerkleBlockMessage>,
        peer: PeerId,
    ) -> Result<(), Error> {
        info!("got a vec of 100 merkleblock");
        let merkleblock = merkle_vec.last().unwrap();
        info!("got 100 merkleblock {:#?}", merkleblock);
        self.get_data(peer, true)?;
        Ok(())
    }

    // Handle tx return value
    fn tx(&mut self, tx: &Transaction, _peer: PeerId) -> Result<(), Error> {
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
                if current_hash.eq(&*VERIFY.1) {
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
            if iter3.eq(&*VERIFY.1) {
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
}

mod test {

    #[test]
    pub fn test_calc_sig() {
        use bitcoin_hashes::hash160;
        use bitcoin_hashes::hex::FromHex;
        use bitcoin_hashes::hex::ToHex;
        use bitcoin_hashes::Hash;

        let compressed_pub_key: &str =
            "02a485e265a661def2d9db1f5880fb07e96ffc0ffcec0f403d61a08aa21b1bdeb4";
        let decode: Vec<u8> = FromHex::from_hex(compressed_pub_key).expect("Invalid public key");
        let hash = hash160::Hash::hash(&decode[..]);
        let sig = hash.to_hex();
        println!("{}", sig);
    }
}