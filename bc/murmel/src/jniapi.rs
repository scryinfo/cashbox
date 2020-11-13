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

#[cfg(target_os = "android")]
pub const BTC_CHAIN_PATH: &str = r#"/data/data/wallet.cashbox.scry.info/files/btc_chain.db"#;

#[cfg(any(target_os = "linux", target_os = "windows", target_os = "macos"))]
pub const BTC_CHAIN_PATH: &str = r#"btc_chain.db"#;