//! after send loadfilter message in bloomfilter mod we can get merkleblock in this mod and get
//! loadfilter message do not get any response.
//! we get response here
use std::collections::HashMap;
use std::sync::mpsc;
use std::thread;
use std::time::Duration;

use bitcoin_hashes::hex::ToHex;
use futures::executor::block_on;
use log::{error, info, trace};

use bitcoin::{BitcoinHash, Transaction};
use bitcoin::consensus::serialize as btc_serialize;
use bitcoin::network::message::NetworkMessage;
use bitcoin::network::message_blockdata::{Inventory, InvType};
use bitcoin::network::message_bloom_filter::MerkleBlockMessage;

use crate::broadcast_queue::CondPair;
use crate::db::{GlobalRB, Verify};
use crate::error::Error;
use crate::kit::vec_to_string;
use crate::p2p::{
    P2PControlSender, PeerId, PeerMessage, PeerMessageReceiver, PeerMessageSender, SERVICE_BLOCKS,
};
use crate::timeout::{ExpectedReply, SharedTimeout};

pub struct GetData {
    //send a message
    p2p: P2PControlSender<NetworkMessage>,
    timeout: SharedTimeout<NetworkMessage, ExpectedReply>,
    pair: CondPair<usize>,
}

impl GetData {
    pub fn new(
        p2p: P2PControlSender<NetworkMessage>,
        timeout: SharedTimeout<NetworkMessage, ExpectedReply>,
        pair: CondPair<usize>,
    ) -> PeerMessageSender<NetworkMessage> {
        let (sender, receiver) = mpsc::sync_channel(p2p.back_pressure);

        let mut getdata = GetData { p2p, timeout, pair };

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
            while let Ok(msg) = receiver.recv_timeout(Duration::from_millis(6000)) {
                if let Err(e) = match msg {
                    PeerMessage::Connected(pid, _) => {
                        // wait for loadfilter
                        if self.is_serving_blocks(pid) {
                            trace!("serving blocks peer={}", pid);
                            //Make a request GetData
                            self.get_data(pid, false, true)
                        } else {
                            Ok(())
                        }
                    }
                    PeerMessage::Disconnected(_, _) => Ok(()),
                    PeerMessage::Incoming(pid, msg) => match msg {
                        NetworkMessage::MerkleBlock(ref merkleblock) => {
                            {
                                info!("{:#?}", merkleblock);
                                let block_hash = merkleblock.prev_block.to_hex();
                                let timestamp = merkleblock.timestamp;
                                {
                                    block_on(
                                        GlobalRB::global()
                                            .detail
                                            .update_progress(block_hash, timestamp.to_string()),
                                    );
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
                                self.get_data(pid, true, false)
                            } else {
                                Ok(())
                            }
                        }
                        NetworkMessage::Inv(ref inv) => {
                            if self.is_serving_blocks(pid) {
                                self.inv(inv, pid)
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
            self.timeout
                .lock()
                .unwrap()
                .check(vec![ExpectedReply::MerkleBlock]);
        }
    }

    fn is_serving_blocks(&self, peer: PeerId) -> bool {
        if let Some(peer_version) = self.p2p.peer_version(peer) {
            return peer_version.services & SERVICE_BLOCKS != 0;
        }
        false
    }

    // retrieve data
    // wait -> wait for filter
    //         use in Connected need wait
    //         use in other condition don't need wait(ping and get 100 merkleblock)
    fn get_data(&mut self, peer: PeerId, add: bool, wait: bool) -> Result<(), Error> {
        if wait {
            error!("wait_for filter condition");
            let &(ref lock, ref cvar) = &*(self.pair);
            let mut start = lock.lock();
            while *start == 0 {
                let r = cvar.wait_for(&mut start, Duration::from_secs(4));
                if r.timed_out() {
                    info!("wait_for filter condition timeout");
                    return Ok(());
                }
            }
        }
        info!("get fillter_ready condition");
        let header_vec: Vec<String> = {
            let p = block_on(GlobalRB::global().detail.progress());
            block_on(GlobalRB::global().chain.fetch_scan_header(p.timestamp, add))
        };

        if header_vec.len() == 0 {
            return Ok(());
        }

        let mut inventory_vec = vec![];
        for header in header_vec {
            let inventory = Inventory::new(InvType::FilteredBlock, header.as_str());
            inventory_vec.push(inventory);
        }
        error!("send getdata message");
        self.p2p
            .send_network(peer, NetworkMessage::GetData(inventory_vec));
        Ok(())
    }

    fn inv(&mut self, v: &Vec<Inventory>, peer: PeerId) -> Result<(), Error> {
        info!("received inv for peer={}", peer);
        for inventory in v {
            if inventory.inv_type == InvType::Transaction {
                self.get_data(peer, true, false)?;
            }
        }
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
        self.get_data(peer, true, false)?;
        Ok(())
    }

    // fn merkleblock2(&mut self, merkle: &MerkleBlockMessage, peer: PeerId) -> Result<(), Error>{
    //     info!("got 1 merkleblock {:#?}", merkle);
    //     self.get_data(peer, true, false)?;
    //     Ok(())
    // }

    // Handle tx return value
    fn tx(&mut self, tx: &Transaction, peer: PeerId) -> Result<(), Error> {
        info!("Tx {:#?}", tx.clone());
        let vouts = tx.clone().output;
        for (index, vout) in vouts.iter().enumerate() {
            let vout = vout.to_owned();
            let script = vout.script_pubkey;
            if script.is_p2pkh() {
                let asm = script.asm();
                let mut iter = asm.split_ascii_whitespace();
                iter.next();
                iter.next();
                iter.next();
                let current_hash_160 = iter.next().unwrap_or(" ");
                if current_hash_160.eq(&Verify::global().verify) {
                    let value = vout.value;
                    let btc_tx_hash = tx.bitcoin_hash().to_hex();
                    let btc_tx_hexbytes = btc_serialize(tx);
                    let btc_tx_hexbytes = vec_to_string(btc_tx_hexbytes);
                    block_on(GlobalRB::global().detail.save_btc_output_tx(
                        value,
                        script.asm(),
                        index as u32,
                        btc_tx_hash,
                        btc_tx_hexbytes,
                    ));
                }
            }
        }

        let vec = block_on(GlobalRB::global().detail.list_btc_output_tx());
        let mut output_map = HashMap::new();
        for output in vec {
            output_map.insert(output.btc_tx_hash, output.idx);
        }

        let inputs = tx.clone().input;
        for (index, txin) in inputs.iter().enumerate() {
            let txin = txin.to_owned();
            let outpoint = txin.previous_output;
            let tx_id = outpoint.txid.to_hex();
            let vout = outpoint.vout;

            match output_map.get(&tx_id) {
                Some(idx) if idx.to_owned() == vout => {
                    let sig_script = txin.script_sig.asm();
                    let sequence = txin.sequence;
                    let btc_tx_hash = tx.bitcoin_hash().to_hex();
                    let btc_tx_hexbytes = btc_serialize(tx);
                    let btc_tx_hexbytes = vec_to_string(btc_tx_hexbytes);
                    block_on(GlobalRB::global().detail.save_btc_input_tx(
                        tx_id,
                        vout,
                        sig_script,
                        sequence,
                        index as u32,
                        btc_tx_hash,
                        btc_tx_hexbytes,
                    ));
                }
                _ => {}
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