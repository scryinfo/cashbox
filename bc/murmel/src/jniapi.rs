pub mod create_translation;
pub mod btcapi;
pub mod android_btcapi;

use std::sync::{Arc, Mutex};
use std::sync::mpsc::{sync_channel, Receiver, SyncSender};
use crate::hooks::ApiMessage;
use once_cell::sync::Lazy;
use crate::db::SharedSQLite;
use crate::db::SQLite;
use bitcoin::{Network, Address};
use bitcoin_wallet::mnemonic::Mnemonic;
use bitcoin_wallet::account::{MasterAccount, Unlocker, AccountAddressType, Account};
use bitcoin::network::message_bloom_filter::FilterLoadMessage;
use bitcoin::consensus::serialize;
use bitcoin::util::psbt::serialize::Serialize;

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

#[cfg(target_os = "android")]
pub const BTC_DETAIL_PATH: &str = r#"/data/data/wallet.cashbox.scry.info/files/btc_detail.sqlite"#;

#[cfg(any(target_os = "linux", target_os = "windows", target_os = "macos"))]
pub const BTC_DETAIL_PATH: &str = r#"btc_detail.sqlite"#;

pub const PASSPHRASE: &str = "";

// calc default address in path (0,0) maybe modfiy in future
pub fn calc_default_address() -> Address {
    let words = "lawn duty beauty guilt sample fiction name zero demise disagree cram hand";
    let mnemonic = Mnemonic::from_str(words).unwrap();
    let mut master =
        MasterAccount::from_mnemonic(&mnemonic, 0, Network::Testnet, PASSPHRASE, None).unwrap();
    let mut unlocker = Unlocker::new_for_master(&master, "").expect("don't have right unlocker");

    // path 0,0 => source(from address)
    let account = Account::new(&mut unlocker, AccountAddressType::P2PKH, 0, 0, 10).unwrap();
    master.add_account(account);
    let account = master.get_mut((0, 0)).unwrap();
    let instance_key = account.next_key().unwrap();
    instance_key.address.clone()
}

// cala bloom filter
pub fn calc_bloomfilter() -> FilterLoadMessage {
    //todo must use stored mnemonic
    let words = "lawn duty beauty guilt sample fiction name zero demise disagree cram hand";
    let mnemonic = Mnemonic::from_str(words).unwrap();
    let mut master =
        MasterAccount::from_mnemonic(&mnemonic, 0, Network::Testnet, PASSPHRASE, None).unwrap();
    let mut unlocker = Unlocker::new_for_master(&master, "").expect("don't have right unlocker");

    // path 0,0 => source(from address)
    let account = Account::new(&mut unlocker, AccountAddressType::P2PKH, 0, 0, 10).unwrap();
    master.add_account(account);
    let account = master.get_mut((0, 0)).unwrap();
    let instance_key = account.next_key().unwrap();
    let _source = instance_key.address.clone();
    let public_key = instance_key.public.clone();
    let public_compressed = public_key.serialize();
    let public_compressed = hex::encode(public_compressed);
    let bloom_filter = FilterLoadMessage::calculate_filter(public_compressed.as_ref());
    bloom_filter
}

// calc pubkey
pub fn calc_pubkey() -> String {
    let words = "lawn duty beauty guilt sample fiction name zero demise disagree cram hand";
    let mnemonic = Mnemonic::from_str(words).unwrap();
    let mut master =
        MasterAccount::from_mnemonic(&mnemonic, 0, Network::Testnet, PASSPHRASE, None).unwrap();
    let mut unlocker = Unlocker::new_for_master(&master, "").expect("don't have right unlocker");

    // path 0,0 => source(from address)
    let account = Account::new(&mut unlocker, AccountAddressType::P2PKH, 0, 0, 10).unwrap();
    master.add_account(account);
    let account = master.get_mut((0, 0)).unwrap();
    let instance_key = account.next_key().unwrap();
    let _source = instance_key.address.clone();
    let public_key = instance_key.public.clone();
    let public_compressed = public_key.serialize();
    hex::encode(public_compressed)
}