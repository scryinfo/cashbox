//! This mod is about bloomfilter sender
use crate::constructor::CondvarPair;
use crate::error::Error;
use crate::p2p::{
    P2PControlSender, PeerId, PeerMessage, PeerMessageReceiver, PeerMessageSender, SERVICE_BLOCKS,
};
use crate::timeout::{ExpectedReply, SharedTimeout};
use bitcoin::network::message::NetworkMessage;
use bitcoin::network::message_bloom_filter::FilterLoadMessage;
use log::{error, info, trace};
use std::sync::mpsc;
use std::thread;
use std::time::Duration;

pub struct BloomFilter<T> {
    // send message
    p2p: P2PControlSender<NetworkMessage>,
    timeout: SharedTimeout<NetworkMessage, ExpectedReply>,
    filter_load_message: Option<FilterLoadMessage>,
    condvar_pair: CondvarPair<T>,
}

impl<T: std::marker::Send + 'static> BloomFilter<T> {
    pub fn new(
        p2p: P2PControlSender<NetworkMessage>,
        timeout: SharedTimeout<NetworkMessage, ExpectedReply>,
        filter_load_message: Option<FilterLoadMessage>,
        condvar_pair: CondvarPair<T>,
    ) -> PeerMessageSender<NetworkMessage> {
        let (sender, receiver) = mpsc::sync_channel(p2p.back_pressure);
        let mut bloomfilter = BloomFilter {
            p2p,
            timeout,
            filter_load_message,
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
            while let Ok(msg) = receiver.recv_timeout(Duration::from_millis(1000)) {
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
                    PeerMessage::Disconnected(_, _) => Ok(()),
                    PeerMessage::Incoming(_pid, msg) => {
                        match msg {
                            //  The processing methods related to the Bitcoin network protocol must be modified accordingly to send FilterLoad
                            //  There is a branch dealing with inv, this is not needed for the time being
                            //  The processing in Ping also proves that I do not need to process information that is not relevant to me
                            //  I should only deal with merkerblock should be ok
                            //  May be processed twice
                            //  NetworkMessage::Headers(ref headers) => if self.is_serving_blocks(pid) { self.headers(headers, pid) } else { Ok(()) },
                            NetworkMessage::Ping(_) => Ok(()),
                            _ => Ok(()),
                        }
                    }
                    _ => Ok(()),
                } {
                    error!("Error processing headers: {}", e);
                }
            }
            self.timeout
                .lock()
                .unwrap()
                .check(vec![ExpectedReply::Nonce]);
        }
    }

    // Maybe this is not needed
    fn is_serving_blocks(&self, peer: PeerId) -> bool {
        if let Some(peer_version) = self.p2p.peer_version(peer) {
            return peer_version.services & SERVICE_BLOCKS != 0;
        }
        false
    }

    /// Each node needs to send a filter load message
    fn send_filter(&mut self, peer: PeerId) -> Result<(), Error> {
        if let Some(filter_load_message) = &self.filter_load_message {
            info!("send filter loaded message");
            self.p2p.send_network(
                peer,
                NetworkMessage::FilterLoad(filter_load_message.to_owned()),
            );
        }
        Ok(())
    }
}

//todo fix
fn calculate_filter() -> FilterLoadMessage {
    // Public key 66（compressed）
    FilterLoadMessage::calculate_filter(
        "02a485e265a661def2d9db1f5880fb07e96ffc0ffcec0f403d61a08aa21b1bdeb4",
    )
}
