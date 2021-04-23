pub mod btcapi;
pub mod create_translation;

use crate::hooks::ApiMessage;
use bitcoin_hashes::Hash;
use once_cell::sync::Lazy;
use std::sync::mpsc::{sync_channel, Receiver, SyncSender};
use std::sync::{Arc, Mutex};

pub type SharedChannel = Arc<Mutex<(SyncSender<ApiMessage>, Receiver<ApiMessage>)>>;

const BACK_PRESSURE: usize = 10;
pub static SHARED_CHANNEL: Lazy<SharedChannel> = Lazy::new(|| {
    let channel = sync_channel::<ApiMessage>(BACK_PRESSURE);
    Arc::new(Mutex::new(channel))
});