//! after send loadfilter message in bloomfilter mod we can get merkleblock in this mod and get
//! loadfilter message do not get any response.
//! we get response here
use bitcoin::network::message::NetworkMessage;
use p2p::{P2PControlSender, PeerMessageSender, PeerMessageReceiver, PeerMessage, PeerId, SERVICE_BLOCKS, P2PControl, SERVICE_BLOOM};
use timeout::{ExpectedReply, SharedTimeout};
use std::sync::mpsc;
use std::thread;
use std::time::Duration;
use error::Error;
use std::collections::VecDeque;
use bitcoin::network::message_blockdata::{InvType, Inventory, GetBlocksMessage};
use bitcoin::{BlockHeader, BitcoinHash, Transaction};
use bitcoin::network::message_bloom_filter::{FilterLoadMessage, MerkleBlockMessage};
use chaindb::SharedChainDB;
use bitcoin::network::message::NetworkMessage::GetBlocks;
use bitcoin_hashes::sha256d::Hash as Sha256dHash;
use db::SharedSQLite;
use bitcoin_hashes::hex::FromHex;
use bitcoin_hashes::hex::ToHex;
use bitcoin_hashes::hash160;
use bitcoin_hashes::Hash;
use hooks::HooksMessage;

const PUBLIC_KEY: &str = "0291ee52a0e0c22db9772f237f4271ea6f9330d92b242fb3c621928774c560b699";

pub struct GetData {
    chaindb: SharedChainDB,
    //发送消息
    p2p: P2PControlSender<NetworkMessage>,
    timeout: SharedTimeout<NetworkMessage, ExpectedReply>,
    sqlite: SharedSQLite,
    hook_receiver: mpsc::Receiver<HooksMessage>,
}

impl GetData {
    pub fn new(sqlite: SharedSQLite, chaindb: SharedChainDB, p2p: P2PControlSender<NetworkMessage>, timeout: SharedTimeout<NetworkMessage, ExpectedReply>, hook_receiver: mpsc::Receiver<HooksMessage>) -> PeerMessageSender<NetworkMessage> {
        let (sender, receiver) = mpsc::sync_channel(p2p.back_pressure);

        let mut getdata = GetData { chaindb, p2p, timeout, sqlite, hook_receiver };

        thread::Builder::new().name("GetData".to_string()).spawn(move || { getdata.run(receiver) }).unwrap();

        PeerMessageSender::new(sender)
    }

    //循环处理消息
    fn run(&mut self, receiver: PeerMessageReceiver<NetworkMessage>) {
        let hash160 = self.hash160("");
        //let mut merkle_vec = vec![];
        loop {
            //这个方法是消息接收端，也就是channel的一个出口，Message的一个消耗端
            while let Ok(msg) = receiver.recv_timeout(Duration::from_millis(3000)) {
                if let Err(e) = match msg {
                    PeerMessage::Connected(pid, _) => {
                        if self.is_serving_blocks(pid) {
                            trace!("serving blocks peer={}", pid);
                            //发起请求 GetData
                            self.get_data(pid, false)
                        } else {
                            Ok(())
                        }
                    }
                    PeerMessage::Disconnected(_, _) => {
                        Ok(())
                    }
                    PeerMessage::Incoming(pid, msg) => {
                        match msg {
                            // NetworkMessage::MerkleBlock(ref merkleblock) => {
                            //     if self.is_serving_blocks(pid) {
                            //         {
                            //             let block_hash = merkleblock.prev_block.to_hex();
                            //             let timestamp = merkleblock.timestamp;
                            //             let sqlite = self.sqlite.lock().expect("open connection error!");
                            //             sqlite.update_newest_header(block_hash, timestamp.to_string());
                            //         }
                            //         if merkle_vec.len() <= 100 {
                            //             merkle_vec.push(merkleblock.clone());
                            //         } else {
                            //             self.merkleblock(&merkle_vec, pid).expect("merkle block vector failed");
                            //             merkle_vec.clear();
                            //         }
                            //         Ok(())
                            //     } else {
                            //         Ok(())
                            //     }
                            // }
                            NetworkMessage::MerkleBlock(ref merkleblock) => if self.is_serving_blocks(pid) { self.merkleblock(merkleblock, pid) } else { Ok(()) },
                            NetworkMessage::Tx(ref tx) => if self.is_serving_blocks(pid) { self.tx(tx, pid, hash160.clone()) } else { Ok(()) },
                            NetworkMessage::Ping(_) => { Ok(()) }
                            _ => { Ok(()) }
                        }
                    }
                    _ => { Ok(()) }
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
                    HooksMessage::Others => {
                        ()
                    }
                }
            }
            self.timeout.lock().unwrap().check(vec!(ExpectedReply::MerkleBlock));
        }
    }

    fn is_serving_blocks(&self, peer: PeerId) -> bool {
        if let Some(peer_version) = self.p2p.peer_version(peer) {
            return peer_version.services & SERVICE_BLOOM != 0;
        }
        false
    }

    // 获取数据
    fn get_data(&mut self, peer: PeerId, add: bool) -> Result<(), Error> {
        // if self.timeout.lock().unwrap().is_busy_with(peer, ExpectedReply::MerkleBlock) {
        //     return Ok(());
        // }
        // let sqlite = self.sqlite.lock().expect("sqlite open error");
        // let (_block_hash, timestamp) = sqlite.init();
        // let block_hashes = sqlite.query_header(timestamp, add);
        // if block_hashes.len() == 0 { return Ok(()); }
        //
        // let mut inventory_vec = vec![];
        // for block_hash in block_hashes {
        //     let inventory = Inventory::new(InvType::FilteredBlock, block_hash.as_str());
        //     inventory_vec.push(inventory);
        // }
        // self.p2p.send_network(peer, NetworkMessage::GetData(inventory_vec));
        // Ok(())

        let inventory = Inventory::new(InvType::FilteredBlock, "0000000000123ac6e7e450436958701cefba061662ea3e80f33cfc846637bb34");
        self.p2p.send_network(peer, NetworkMessage::GetData(vec![inventory]));
        Ok(())
    }

    // fn merkleblock(&mut self, merkle_vec: &Vec<MerkleBlockMessage>, peer: PeerId) -> Result<(), Error> {
    //     self.timeout.lock().unwrap().received(peer, 1, ExpectedReply::MerkleBlock);
    //     warn!("got a vec of 100 merkleblock");
    //     let merkleblock = merkle_vec.last().unwrap();
    //     println!("got 100 merkleblock {:#?}", merkleblock);
    //     self.get_data(peer, true)?;
    //     Ok(())
    // }

    ///模仿的headerdownload里的逻辑
    fn merkleblock(&mut self, merkleblock: &MerkleBlockMessage, peer: PeerId) -> Result<(), Error> {
        self.timeout.lock().unwrap().received(peer, 1, ExpectedReply::MerkleBlock);
        info!("{:#?}", merkleblock);
        Ok(())
    }

    ///处理tx返回值
    fn tx(&mut self, tx: &Transaction, _peer: PeerId, hash160: String) -> Result<(), Error> {
        let sqlite = self.sqlite.lock().expect("open connection error!");
        println!("Tx {:#?}", tx.clone());
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

    ///计算hash160
    fn hash160(&self, public_key: &str) -> String {
        let decode: Vec<u8> = FromHex::from_hex(PUBLIC_KEY).expect("Invalid public key");
        let hash = hash160::Hash::hash(&decode[..]);
        warn!("HASH160 {:?}", hash.to_hex());
        hash.to_hex()
    }
}