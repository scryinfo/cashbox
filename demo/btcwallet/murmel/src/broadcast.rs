//! mod for broadcast TX

use p2p::{P2PControlSender, PeerMessageSender, PeerMessageReceiver, PeerMessage, PeerId, SERVICE_BLOCKS};
use timeout::{SharedTimeout, ExpectedReply};
use bitcoin::network::message::NetworkMessage;
use std::sync::mpsc;
use std::thread;
use bitcoin::network::message_bloom_filter::FilterLoadMessage;
use std::time::Duration;
use error::Error;
use bitcoin::Transaction;
use walletlib;

pub struct Broadcast {
    //发送消息的
    p2p: P2PControlSender<NetworkMessage>,
    timeout: SharedTimeout<NetworkMessage, ExpectedReply>,
}

impl Broadcast {
    pub fn new(p2p: P2PControlSender<NetworkMessage>, timeout: SharedTimeout<NetworkMessage, ExpectedReply>) -> PeerMessageSender<NetworkMessage> {
        let (sender, receiver) = mpsc::sync_channel(p2p.back_pressure);
        let mut broadcast = Broadcast { p2p, timeout };

        thread::Builder::new().name("Broadcast TX".to_string()).spawn(move || { broadcast.run(receiver) }).unwrap();
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
                            self.broadcast_tx(pid)
                        } else {
                            Ok(())
                        }
                    }
                    PeerMessage::Disconnected(_, _) => {
                        Ok(())
                    }
                    PeerMessage::Incoming(pid, msg) => {
                        match msg {
                            NetworkMessage::Ping(_) => { Ok(()) }
                            _ => { Ok(()) }
                        }
                    }
                    _ => { Ok(()) }
                } {
                    error!("Error processing headers: {}", e);
                }
            }
            self.timeout.lock().unwrap().check(vec!(ExpectedReply::Nonce));
        }
    }

    //也许不需要这个
    fn is_serving_blocks(&self, peer: PeerId) -> bool {
        if let Some(peer_version) = self.p2p.peer_version(peer) {
            return peer_version.services & SERVICE_BLOCKS != 0;
        }
        false
    }


    /// 广播节点
    fn broadcast_tx(&mut self, peer: PeerId) -> Result<(), Error> {
        info!("Broadcast tx message");
        let tx = walletlib::create_master();
        self.p2p.send_network(peer, NetworkMessage::Tx(tx));
        Ok(())
    }
}
