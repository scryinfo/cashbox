pub mod android_btcapi;
pub mod btcapi;
pub mod create_translation;

use crate::hooks::ApiMessage;
use crate::Error;
use bitcoin::network::message_bloom_filter::FilterLoadMessage;
use bitcoin::util::psbt::serialize::Serialize;
use bitcoin::{Address, Network};
use bitcoin_hashes::hash160;
use bitcoin_hashes::hex::FromHex;
use bitcoin_hashes::hex::ToHex;
use bitcoin_hashes::Hash;
use bitcoin_wallet::account::{Account, AccountAddressType, MasterAccount, Unlocker};
use bitcoin_wallet::mnemonic::Mnemonic;
use once_cell::sync::Lazy;
use std::sync::mpsc::{sync_channel, Receiver, SyncSender};
use std::sync::{Arc, Mutex};

pub type SharedChannel = Arc<Mutex<(SyncSender<ApiMessage>, Receiver<ApiMessage>)>>;

const BACK_PRESSURE: usize = 10;
pub static SHARED_CHANNEL: Lazy<SharedChannel> = Lazy::new(|| {
    let channel = sync_channel::<ApiMessage>(BACK_PRESSURE);
    Arc::new(Mutex::new(channel))
});

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

// calc verify_sig form compressed_pub_key us hash160
pub fn calc_hash160(str: &str) -> String {
    let decode: Vec<u8> = FromHex::from_hex(str).expect("Invalid public key");
    let hash = hash160::Hash::hash(&decode[..]);
    hash.to_hex()
}