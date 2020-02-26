//! This mod is about bloomfilter
use bitcoin::network::message::NetworkMessage;
use p2p::{P2PControlSender, PeerMessageSender, PeerMessageReceiver, PeerMessage, PeerId, SERVICE_BLOCKS, P2PControl};
use timeout::{ExpectedReply, SharedTimeout};
use std::sync::mpsc;
use std::thread;
use std::time::Duration;
use error::Error;
use std::collections::VecDeque;
use bitcoin::network::message_blockdata::{InvType, Inventory};
use bitcoin::{BlockHeader, BitcoinHash};
use bitcoin::network::message_bloom_filter::FilterLoadMessage;
use db::SharedSQLite;


pub struct BloomFilter {
    //发送消息的
    p2p: P2PControlSender<NetworkMessage>,
    timeout: SharedTimeout<NetworkMessage, ExpectedReply>,
}

impl BloomFilter {
    pub fn new(p2p: P2PControlSender<NetworkMessage>, timeout: SharedTimeout<NetworkMessage, ExpectedReply>) -> PeerMessageSender<NetworkMessage> {
        let (sender, receiver) = mpsc::sync_channel(p2p.back_pressure);
        //提前运算
        let filter = calculate_filter();
        let mut bloomfilter = BloomFilter { p2p, timeout };

        thread::Builder::new().name("Bloom filter".to_string()).spawn(move || { bloomfilter.run(receiver, filter) }).unwrap();

        PeerMessageSender::new(sender)
    }

    //循环处理消息
    fn run(&mut self, receiver: PeerMessageReceiver<NetworkMessage>, filter: FilterLoadMessage) {
        loop {
            //这个方法是消息接收端，也就是channel的一个出口，Message的一个消耗端
            while let Ok(msg) = receiver.recv_timeout(Duration::from_millis(1000)) {
                if let Err(e) = match msg {
                    PeerMessage::Connected(pid, _) => {
                        if self.is_serving_blocks(pid) {
                            trace!("serving blocks peer={}", pid);
                            //发起请求 loadfilter
                            self.send_filter(pid, &filter)
                        } else {
                            Ok(())
                        }
                    }
                    PeerMessage::Disconnected(_, _) => {
                        Ok(())
                    }
                    PeerMessage::Incoming(pid, msg) => {
//                        info!("消息在我这里回来了，filterload。 待处理");
                        match msg {
                            //  和比特币网络协议相关的处理方法，要针对发送FilterLoad做相应的修改
                            //  有个处理inv的分支，暂时不需要这个
                            //  Ping中的处理也证明了我不需要处理和我无关的信息
                            //  我只处理merkerblock应该是可以的
                            //  这里不改可能会处理两次
                            //  NetworkMessage::Headers(ref headers) => if self.is_serving_blocks(pid) { self.headers(headers, pid) } else { Ok(()) },
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

    //也许不需要这个
    fn is_serving_blocks(&self, peer: PeerId) -> bool {
        if let Some(peer_version) = self.p2p.peer_version(peer) {
            return peer_version.services & SERVICE_BLOCKS != 0;
        }
        false
    }


    /// get headers this peer is ahead of us
    /// 发送消息的地方，这里需要自己组装自己关心的filterload
    /// 改过，不行的话害的还得回去对照
    /// 第一句或许需要改
    /// 经过试验，不可以直接跟在后面发，需要像目前这样，搞一个单独的发送机制。
    fn send_filter(&mut self, peer: PeerId, filter: &FilterLoadMessage) -> Result<(), Error> {
//        if self.timeout.lock().unwrap().is_busy_with(peer, ExpectedReply::Headers) {
//            return Ok(());
//        }

        info!("发送filterload消息");
        self.p2p.send_network(peer, NetworkMessage::FilterLoad(filter.to_owned()));
        Ok(())
    }

    ///模仿的headerdownload里的逻辑
    ///数据应该是从run中的 Incoming中获取的,（这个Incoming是Reciver获取的结果）
    ///原来的header获取的是下载头 这边其实需要的是MerkerBlock或者是TX (这两后续可能还是需要在rust-bitcoin中添加)
    /// 逻辑需要修改
    fn headers(&mut self, headers: &Vec<BlockHeader>, peer: PeerId) -> Result<(), Error> {
        self.timeout.lock().unwrap().received(peer, 1, ExpectedReply::MerkleBlock);
        Ok(())
    }
}

fn calculate_filter() -> FilterLoadMessage {
//        let filterload = FilterLoadMessage {
//            filter: vec![0xb5, 0x0f],
//            n_hash_functions: 11,
//            n_tweak: 0,
//            n_flags: false,
//        }
    // 公钥 66位
    FilterLoadMessage::calculate_filter("0291EE52A0E0C22DB9772F237F4271EA6F9330D92B242FB3C621928774C560B699")
}