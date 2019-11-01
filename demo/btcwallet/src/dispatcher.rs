//!
//! # Message dispatcher
//!  消息分发
//!

use std::{
    thread,
    sync::{Arc, Mutex},
};
use crate::p2p::{PeerMessageSender, PeerMessageReceiver};

/// Dispatcher of incoming messages
pub struct Dispatcher<Message: Send + Sync + Clone> {
    listener: Arc<Mutex<Vec<PeerMessageSender<Message>>>>
}

impl<Message: Send + Sync + Clone + 'static> Dispatcher<Message> {
    pub fn new(incoming: PeerMessageReceiver<Message>) -> Dispatcher<Message> {
        let listener = Arc::new(Mutex::new(Vec::new()));
        let l2 = listener.clone();
        thread::Builder::new().name("dispatcher".to_string()).spawn(move || { Self::incoming_messages_loop(incoming, l2) }).unwrap();
        Dispatcher { listener }
    }

    pub fn add_listener(&mut self, listener: PeerMessageSender<Message>) {
        let mut list = self.listener.lock().unwrap();
        list.push(listener);
    }

    fn incoming_messages_loop(incoming: PeerMessageReceiver<Message>, listener: Arc<Mutex<Vec<PeerMessageSender<Message>>>>) {
        while let Ok(pm) = incoming.recv() {
            let list = listener.lock().unwrap();
            for listener in list.iter() {
                listener.send(pm.clone());
            }
        }
        panic!("dispatcher failed");
    }
}