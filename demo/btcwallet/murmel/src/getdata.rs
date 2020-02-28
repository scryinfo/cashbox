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
                            // 根据bip37 发送filter 发送getdata 接受到merkleblock 和 tx 所以这里处理merkleblock 和 tx
                            NetworkMessage::MerkleBlock(ref merkleblock) => if self.is_serving_blocks(pid) { self.merkleblock(merkleblock, pid) } else { Ok(()) },
                            NetworkMessage::Tx(ref tx) => if self.is_serving_blocks(pid) { self.tx(tx, pid) } else { Ok(()) },
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
    // 先发送FilterLoad 然后发送get_data 才可以收获过滤后的数据
    // 批量发送 block_hash
    fn get_data(&mut self, peer: PeerId) -> Result<(), Error> {
        info!("发送getdata 消息");
        self.hash160("");
        // todo 现在插入测试块
        // let inventory = Inventory::new(InvType::FilteredBlock, "000000000001b31b8a35d9b7d2e3ad7909055683b82d4a7d4029386f7149ede8");
        let inventory = Inventory::new(InvType::FilteredBlock, "00000000000001a50f9fc434fa799b138cedc97389b074bdc598f9b097486135");
        self.p2p.send_network(peer, NetworkMessage::GetData(vec![inventory]));
        Ok(())
    }

    ///模仿的headerdownload里的逻辑
    fn merkleblock(&mut self, merkleblock: &MerkleBlockMessage, peer: PeerId) -> Result<(), Error> {
        self.timeout.lock().unwrap().received(peer, 1, ExpectedReply::MerkleBlock);
        info!("{:#?}", merkleblock);
        Ok(())
    }

    ///处理tx返回值
    fn tx(&mut self, tx: &Transaction, peer: PeerId) -> Result<(), Error> {
        info!("Tx {:#?}", tx.clone());
        let tx_hash = &tx.bitcoin_hash();
        info!("tx_hash {:#?}", &tx_hash);
        let vouts = tx.clone().output;
        for vout in vouts {
            let script = vout.script_pubkey;
            if script.is_p2sh() {
                let asm = script.asm();
                println!("tx script_pubkey asm {:?}", asm);
            }
        }
        Ok(())
    }

    ///计算hash160
    fn hash160(&self, public_key: &str) {
        // 公钥 66位
        let public_key = "0291EE52A0E0C22DB9772F237F4271EA6F9330D92B242FB3C621928774C560B699";
        let decode: Vec<u8> = FromHex::from_hex(public_key).expect("Invalid public key");
        let hash = hash160::Hash::hash(&decode[..]);
        warn!("hash 160{:?}", hash.to_hex());
    }
}