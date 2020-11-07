pub mod launch;
pub mod create_translation;
pub mod btcapi;
pub mod android_btcapi;

use std::sync::{Arc, Mutex};
use std::sync::mpsc::{sync_channel, Receiver, SyncSender};
use crate::hooks::ApiMessage;
use once_cell::sync::Lazy;
use crate::db::SharedSQLite;
use crate::db::SQLite;
use bitcoin::Network;

pub type SharedChannel = Arc<Mutex<(SyncSender<ApiMessage>, Receiver<ApiMessage>)>>;

// use sqlite as global
pub static SHARED_SQLITE: Lazy<SharedSQLite> = Lazy::new(|| {
    let sqlite = SQLite::open_db(Network::Testnet);
    Arc::new(Mutex::new(sqlite))
});

const BACK_PRESSURE: usize = 10;
pub static SHARED_CHANNEL: Lazy<SharedChannel> = Lazy::new(|| {
    let channel = sync_channel::<ApiMessage>(BACK_PRESSURE);
    Arc::new(Mutex::new(channel))
});