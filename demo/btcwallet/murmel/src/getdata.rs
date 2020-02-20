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

        let mut getdata = GetData { chaindb, p2p, timeout ,sqlite };

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
    fn get_data(&mut self, peer: PeerId) -> Result<(), Error> {
        info!("发送getdata 消息");
        //这个消息应该提供一个外界传入块的方法
        //
        //let inventory = Inventory::new(InvType::FilteredBlock, "000000000000b731f2eef9e8c63173adfb07e41bd53eb0ef0a6b720d6cb6dea4");
        // todo 现在插入测试块
        // let inventory = Inventory::new(InvType::FilteredBlock, "000000000001b31b8a35d9b7d2e3ad7909055683b82d4a7d4029386f7149ede8");
        // 插入随便一个块
        let inventory = Inventory::new(InvType::FilteredBlock, "000000000001b31b8a35d9b7d2e3ad7909055683b82d4a7d4029386f7149ede8");
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
        info!("{:#?}", tx);
        Ok(())
    }
}