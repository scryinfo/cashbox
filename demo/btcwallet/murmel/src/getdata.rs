//! after send loadfilter message in bloomfilter mod we can get merkleblock in this mod and get
//! loadfilter message do not get any response.
//! we get response here
use bitcoin::network::message::NetworkMessage;
use p2p::{P2PControlSender, PeerMessageSender, PeerMessageReceiver, PeerMessage, PeerId, SERVICE_BLOCKS, P2PControl};
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


pub struct GetData {
    chaindb: SharedChainDB,
    //发送消息
    p2p: P2PControlSender<NetworkMessage>,
    timeout: SharedTimeout<NetworkMessage, ExpectedReply>,
    sqlite: SharedSQLite,
}

impl GetData {
    pub fn new(sqlite: SharedSQLite, chaindb: SharedChainDB, p2p: P2PControlSender<NetworkMessage>, timeout: SharedTimeout<NetworkMessage, ExpectedReply>) -> PeerMessageSender<NetworkMessage> {
        let (sender, receiver) = mpsc::sync_channel(p2p.back_pressure);

        let mut getdata = GetData { chaindb, p2p, timeout, sqlite };

        thread::Builder::new().name("GetData".to_string()).spawn(move || { getdata.run(receiver) }).unwrap();

        PeerMessageSender::new(sender)
    }

    //循环处理消息
    fn run(&mut self, receiver: PeerMessageReceiver<NetworkMessage>) {
        let hash160 = self.hash160("");
        loop {
            //这个方法是消息接收端，也就是channel的一个出口，Message的一个消耗端
            while let Ok(msg) = receiver.recv_timeout(Duration::from_millis(1000)) {
                if let Err(e) = match msg {
                    PeerMessage::Connected(pid, _) => {
                        if self.is_serving_blocks(pid) {
                            trace!("serving blocks peer={}", pid);
                            //发起请求 GetData
                            //这个地方应该不需要循环请求 但是先这样
                            self.get_data(pid)
                        } else {
                            Ok(())
                        }
                    }
                    PeerMessage::Disconnected(_, _) => {
                        Ok(())
                    }
                    PeerMessage::Incoming(pid, msg) => {
                        match msg {
                            // 接受数据的地方
                            NetworkMessage::Headers(ref headers) => { //
                                //hooks
                                self.get_data(pid).expect("get_data failed");
                                Ok(())
                            }
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
            self.timeout.lock().unwrap().check(vec!(ExpectedReply::MerkleBlock));
        }
    }

    fn is_serving_blocks(&self, peer: PeerId) -> bool {
        if let Some(peer_version) = self.p2p.peer_version(peer) {
            return peer_version.services & SERVICE_BLOCKS != 0;
        }
        false
    }

    // 获取数据
    // 批量发送 block_hash
    fn get_data(&mut self, peer: PeerId) -> Result<(), Error> {
        let sqlite = self.sqlite.lock().expect("sqlite open error");
        let (block_hash, timestamp) = sqlite.init();
        let block_hashes = sqlite.query_header(timestamp);
        if block_hashes.len() == 0 {
            return Ok(());
        }
        let mut inventory_vec = vec![];
        for block_hash in block_hashes {
            let inventory = Inventory::new(InvType::FilteredBlock, block_hash.as_str());
            inventory_vec.push(inventory);
        }
        // let inventory = Inventory::new(InvType::FilteredBlock, "000000000001b31b8a35d9b7d2e3ad7909055683b82d4a7d4029386f7149ede8");
        self.p2p.send_network(peer, NetworkMessage::GetData(inventory_vec));
        Ok(())
    }

    fn merkleblock(&mut self, merkleblock: &MerkleBlockMessage, peer: PeerId) -> Result<(), Error> {
        self.timeout.lock().unwrap().received(peer, 1, ExpectedReply::MerkleBlock);
        let block_hash = merkleblock.prev_block.to_hex();
        let timestamp = merkleblock.timestamp;

        println!("got merkleblock {:?}", merkleblock);
        {
            let sqlite = self.sqlite.lock().expect("open connection error!");
            sqlite.update_newest_header(block_hash, timestamp.to_string());
        }
        self.get_data(peer)?;
        Ok(())
    }

    ///处理tx返回值
    fn tx(&mut self, tx: &Transaction, peer: PeerId, hash160: String) -> Result<(), Error> {
        let sqlite = self.sqlite.lock().expect("open connection error!");
        println!("Tx {:#?}", tx.clone());
        let tx_hash = &tx.bitcoin_hash();
        let vouts = tx.clone().output;
        let mut index = 0;
        for vout in vouts {
            index += 1;
            let script = vout.script_pubkey;
            if script.is_p2sh() {
                let asm = script.asm();
                let mut iter = asm.split_ascii_whitespace();
                iter.next();
                iter.next();
                let current_hash = iter.next().unwrap_or(" ");
                if current_hash.eq(hash160.as_str()) {
                    sqlite.insert_utxo(tx_hash.to_hex(), asm.clone(), vout.value.to_string(), index);
                }
            }
        }
        Ok(())
    }

    ///计算hash160
    fn hash160(&self, public_key: &str) -> String {
        // 公钥 66位
        let public_key = "0291EE52A0E0C22DB9772F237F4271EA6F9330D92B242FB3C621928774C560B699";
        let decode: Vec<u8> = FromHex::from_hex(public_key).expect("Invalid public key");
        let hash = hash160::Hash::hash(&decode[..]);
        warn!("HASH160 {:?}", hash.to_hex());
        hash.to_hex()
    }
}