//! mod for getutxo set
//! block_hash comes from the block_hash table
//! when sync blockheader I record the block
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


pub struct GetUXTOs {
    chaindb: SharedChainDB,
    //发送消息
    p2p: P2PControlSender<NetworkMessage>,
    timeout: SharedTimeout<NetworkMessage, ExpectedReply>,

}

impl GetUXTOs {
    pub fn new(chaindb: SharedChainDB, p2p: P2PControlSender<NetworkMessage>, timeout: SharedTimeout<NetworkMessage, ExpectedReply>) -> PeerMessageSender<NetworkMessage> {
        let (sender, receiver) = mpsc::sync_channel(p2p.back_pressure);

        let mut getdata = GetUXTOs { chaindb, p2p, timeout };

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
                            //发起请求 loadfilter
                            //这个地方应该不需要循环请求 但是先这样
                            self.get_headers(pid)
                        } else {
                            Ok(())
                        }
                    }
                    PeerMessage::Disconnected(_, _) => {
                        Ok(())
                    }
                    PeerMessage::Incoming(pid, msg) => {
                        match msg {
                            //  只处理merkerblock应该是可以的
                            //  INV消息必须处理 逻辑参照headerdownload
                            //  INV 中会返回最新的区块。需要处理
                            NetworkMessage::MerkleBlock(ref merkleblock) => if self.is_serving_blocks(pid) { self.headers(merkleblock, pid) } else { Ok(()) },
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


    /// 发送消息的地方
    /// 从这里开始扫描区块，获取相关的block
    fn get_headers(&mut self, peer: PeerId) -> Result<(), Error> {
        info!("发送getdata 消息");
        //这个消息应该提供一个外界传入tx的方法
        let inventory = Inventory::new(InvType::FilteredBlock, "000000000000b731f2eef9e8c63173adfb07e41bd53eb0ef0a6b720d6cb6dea4");
        self.p2p.send_network(peer, NetworkMessage::GetData(vec![inventory]));
        Ok(())
    }

    ///模仿的headerdownload里的逻辑
    fn headers(&mut self, merkleblock: &MerkleBlockMessage, peer: PeerId) -> Result<(), Error> {
        self.timeout.lock().unwrap().received(peer, 1, ExpectedReply::MerkleBlock);
        info!("{:#?}", merkleblock);
        Ok(())
    }

}