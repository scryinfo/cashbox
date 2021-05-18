//! This mod is about bloomfilter sender
use crate::constructor::CondvarPair;
use crate::error::Error;
use crate::p2p::{
    P2PControlSender, PeerId, PeerMessage, PeerMessageReceiver, PeerMessageSender, SERVICE_BLOCKS,
};
use crate::timeout::{ExpectedReply, SharedTimeout};
use bitcoin::network::message::NetworkMessage;
use bitcoin::network::message_bloom_filter::FilterLoadMessage;
use log::{error, trace};
use std::ops::Deref;
use std::sync::{mpsc, Arc};
use std::thread;
use std::time::Duration;

pub struct BloomFilter {
    // send message
    p2p: P2PControlSender<NetworkMessage>,
    timeout: SharedTimeout<NetworkMessage, ExpectedReply>,
    filter_load: FilterLoadMessage,
    condvar_pair: CondvarPair<bool>,
}

impl BloomFilter {
    pub fn new(
        p2p: P2PControlSender<NetworkMessage>,
        timeout: SharedTimeout<NetworkMessage, ExpectedReply>,
        filter_load: FilterLoadMessage,
        condvar_pair: CondvarPair<bool>,
    ) -> PeerMessageSender<NetworkMessage> {
        let (sender, receiver) = mpsc::sync_channel(p2p.back_pressure);
        let mut bloomfilter = BloomFilter {
            p2p,
            timeout,
            filter_load,
            condvar_pair,
        };

        thread::Builder::new()
            .name("Bloom filter".to_string())
            .spawn(move || bloomfilter.run(receiver))
            .unwrap();

        PeerMessageSender::new(sender)
    }

    //Loop through messages
    fn run(&mut self, receiver: PeerMessageReceiver<NetworkMessage>) {
        loop {
            //This method is the message receiving end, that is, an outlet of the channel, a consumption end of the Message
            while let Ok(msg) = receiver.recv_timeout(Duration::from_millis(4000)) {
                if let Err(e) = match msg {
                    PeerMessage::Connected(pid, _) => {
                        if self.is_serving_blocks(pid) {
                            trace!("serving blocks peer={}", pid);
                            // Initiate request loadfilter
                            self.send_filter(pid)
                        } else {
                            Ok(())
                        }
                    }
                    // PeerMessage::Disconnected(_, _) => self.reset_filter_condition(),
                    PeerMessage::Incoming(_pid, msg) => match msg {
                        NetworkMessage::Ping(_) => Ok(()),
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

    // Each node needs to send a filter load message
    fn send_filter(&mut self, peer: PeerId) -> Result<(), Error> {
        self.p2p
            .send_network(peer, NetworkMessage::FilterLoad(self.filter_load.clone()));

        let ref pair = self.condvar_pair;
        let &(ref lock, ref cvar) = Arc::deref(pair);
        let mut condition = lock.lock();
        *condition = true;
        cvar.notify_all();
        Ok(())
    }

    // when disconnect, reset condition variable （fillter_ready）
    // fn reset_filter_condition(&self) -> Result<(), Error> {
    //     let ref pair = self.condvar_pair;
    //     let &(ref lock, ref cvar) = Arc::deref(pair);
    //     let mut condition = lock.lock();
    //     (*condition).set_filter(false);
    //     cvar.notify_all();
    //     Ok(())
    // }
}