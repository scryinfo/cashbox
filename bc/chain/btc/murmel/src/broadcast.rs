//! mod for broadcast TX

use crate::constructor::CondvarPair;
use crate::error::Error;
use crate::hooks::ShowCondition;
use crate::p2p::{
    P2PControlSender, PeerId, PeerMessage, PeerMessageReceiver, PeerMessageSender, SERVICE_BLOCKS,
};
use crate::timeout::{ExpectedReply, SharedTimeout};
use crate::walletlib;
use bitcoin::network::message::NetworkMessage;
use log::{error, info, trace};
use std::ops::Deref;
use std::sync::{mpsc, Arc};
use std::thread;
use std::time::Duration;

pub struct Broadcast<T> {
    //used for Send message
    p2p: P2PControlSender<NetworkMessage>,
    timeout: SharedTimeout<NetworkMessage, ExpectedReply>,
    condvar_pair: CondvarPair<T>,
}

impl<T: Send + 'static + ShowCondition> Broadcast<T> {
    pub fn new(
        p2p: P2PControlSender<NetworkMessage>,
        timeout: SharedTimeout<NetworkMessage, ExpectedReply>,
        condvar_pair: CondvarPair<T>,
    ) -> PeerMessageSender<NetworkMessage> {
        let (sender, receiver) = mpsc::sync_channel(p2p.back_pressure);
        let mut broadcast = Broadcast {
            p2p,
            timeout,
            condvar_pair,
        };

        thread::Builder::new()
            .name("Broadcast TX".to_string())
            .spawn(move || broadcast.run(receiver))
            .unwrap();
        PeerMessageSender::new(sender)
    }

    //Loop through messages
    fn run(&mut self, receiver: PeerMessageReceiver<NetworkMessage>) {
        {
            let ref pair = self.condvar_pair;
            let &(ref lock, ref cvar) = Arc::deref(pair);
            let mut condition = lock.lock();
            while !(*condition).get_header() {
                cvar.wait(&mut condition);
            }
        }

        loop {
            //This method is the message receiving end, that is, an outlet of the channel, a consumption end of the Message
            while let Ok(msg) = receiver.recv_timeout(Duration::from_millis(1000)) {
                if let Err(e) = match msg {
                    PeerMessage::Connected(pid, _) => {
                        if self.is_serving_blocks(pid) {
                            trace!("serving broadcast peer={}", pid);
                            self.broadcast_tx(pid)
                        } else {
                            Ok(())
                        }
                    }
                    PeerMessage::Disconnected(_, _) => Ok(()),
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

    // broadcast tx to bitcoin network
    fn broadcast_tx(&mut self, peer: PeerId) -> Result<(), Error> {
        info!("Broadcast tx message");
        let tx = walletlib::create_master();
        self.p2p.send_network(peer, NetworkMessage::Tx(tx));
        Ok(())
    }
}