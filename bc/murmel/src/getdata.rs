//! after send loadfilter message in bloomfilter mod we can get merkleblock in this mod and get
//! loadfilter message do not get any response.
//! we get response here
use crate::chaindb::SharedChainDB;
use crate::error::Error;
use crate::hooks::HooksMessage;
use crate::p2p::{
    P2PControlSender, PeerId, PeerMessage, PeerMessageReceiver, PeerMessageSender, SERVICE_BLOOM,
};
use crate::timeout::{ExpectedReply, SharedTimeout};
use bitcoin::network::message::NetworkMessage;
use bitcoin::network::message_blockdata::{InvType, Inventory};
use bitcoin::network::message_bloom_filter::{MerkleBlockMessage};
use bitcoin::{BitcoinHash, Transaction};
use bitcoin_hashes::hash160;
use bitcoin_hashes::hex::FromHex;
use bitcoin_hashes::hex::ToHex;

use bitcoin_hashes::Hash;
use log::{error, info, trace, warn};
use std::sync::mpsc;
use std::thread;
use std::time::Duration;
use crate::db::lazy_db_default;

const PUBLIC_KEY: &str = "0291ee52a0e0c22db9772f237f4271ea6f9330d92b242fb3c621928774c560b699";

pub struct GetData {
    chaindb: SharedChainDB,
    //send a message
    p2p: P2PControlSender<NetworkMessage>,
    timeout: SharedTimeout<NetworkMessage, ExpectedReply>,
    hook_receiver: mpsc::Receiver<HooksMessage>,
}

impl GetData {
    pub fn new(
        chaindb: SharedChainDB,
        p2p: P2PControlSender<NetworkMessage>,
        timeout: SharedTimeout<NetworkMessage, ExpectedReply>,
        hook_receiver: mpsc::Receiver<HooksMessage>,
    ) -> PeerMessageSender<NetworkMessage> {
        let (sender, receiver) = mpsc::sync_channel(p2p.back_pressure);

        let mut getdata = GetData {
            chaindb,
            p2p,
            timeout,
            hook_receiver,
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
            while let Ok(msg) = receiver.recv_timeout(Duration::from_millis(3000)) {
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
                                        let sqlite =
                                            lazy_db_default().lock();
                                        sqlite.update_newest_header(block_hash, timestamp.to_string());
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

            while let Ok(msg) = self.hook_receiver.recv_timeout(Duration::from_millis(1000)) {
                match msg {
                    HooksMessage::ReceivedHeaders(pid) => {
                        warn!("hooks for received headers");
                        self.get_data(pid, true).expect("GOT HOOKS error");
                    }
                    HooksMessage::Others => (),
                }
            }
            self.timeout
                .lock()
                .unwrap()
                .check(vec![ExpectedReply::MerkleBlock]);
        }
    }

    fn is_serving_blocks(&self, peer: PeerId) -> bool {
        if let Some(peer_version) = self.p2p.peer_version(peer) {
            return peer_version.services & SERVICE_BLOOM != 0;
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
            return Ok(());
        }

        let mut block_hashes: Vec<String> = Vec::new();
        {
            let sqlite = lazy_db_default().lock();
            let (_block_hash, timestamp) = sqlite.init();
            block_hashes = sqlite.query_header(timestamp, add);
        }

        if block_hashes.len() == 0 {
            return Ok(());
        }

        let mut inventory_vec = vec![];
        for block_hash in block_hashes {
            let inventory = Inventory::new(InvType::FilteredBlock, block_hash.as_str());
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
        warn!("got a vec of 100 merkleblock");
        let merkleblock = merkle_vec.last().unwrap();
        info!("got 100 merkleblock {:#?}", merkleblock);
        self.get_data(peer, true)?;
        Ok(())
    }

    // Handle tx return value
    fn tx(&mut self, tx: &Transaction, _peer: PeerId, hash160: String) -> Result<(), Error> {
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
                    let sqlite = lazy_db_default().lock();
                    sqlite.insert_txout(
                        tx_hash.to_hex(),
                        asm.clone(),
                        vout.value.to_string(),
                        index,
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
                let sqlite = lazy_db_default().lock();
                sqlite.insert_txin(
                    tx_hash.to_hex(),
                    sig_script.clone(),
                    prev_tx,
                    prev_vout.to_string(),
                    sequence.to_string(),
                )
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
