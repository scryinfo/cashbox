pub mod btcapi;
pub mod create_translation;
pub mod api;

use crate::hooks::ApiMessage;
use once_cell::sync::Lazy;
use std::sync::mpsc::{sync_channel, Receiver, SyncSender};
use std::sync::{Arc, Mutex};

pub use api::start;
pub use api::btc_load_now_blocknumber;

pub type SharedChannel = Arc<Mutex<(SyncSender<ApiMessage>, Receiver<ApiMessage>)>>;

const BACK_PRESSURE: usize = 10;
pub static SHARED_CHANNEL: Lazy<SharedChannel> = Lazy::new(|| {
    let channel = sync_channel::<ApiMessage>(BACK_PRESSURE);
    Arc::new(Mutex::new(channel))
});