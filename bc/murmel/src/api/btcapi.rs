//! mod for btcapi use in macos windows or linux.
//! java native method def in  packages/wallet_manager/android/src/main/java/info/scry/wallet_manager/NativeLib.java

#![cfg(any(target_os = "linux", target_os = "windows", target_os = "macos"))]
#![allow(non_snake_case)]

use super::*;
use crate::constructor::Constructor;

use bitcoin::consensus::serialize;
use bitcoin::network::message_bloom_filter::FilterLoadMessage;
use bitcoin::util::psbt::serialize::Serialize;
use bitcoin::{Address, Network, OutPoint, Script, SigHashType, Transaction, TxIn, TxOut};
use bitcoin_hashes::hex::FromHex;
use bitcoin_hashes::sha256d;
use bitcoin_wallet::account::{Account, AccountAddressType, MasterAccount, Unlocker};
use bitcoin_wallet::mnemonic::Mnemonic;
use jni::objects::{JClass, JObject, JString, JValue};
use jni::sys::{jboolean, jbyteArray, jint, jstring};
use jni::JNIEnv;
use log::info;
use log::Level;

use crate::path::BTC_HAMMER_PATH;
use crate::db::fetch_scanned_height;
use crate::db::{RB_CHAIN, RB_DETAIL};
use std::net::{Ipv4Addr, SocketAddr, SocketAddrV4};
use std::path::Path;
use std::str::FromStr;
use std::time::SystemTime;

#[no_mangle]
#[allow(non_snake_case)]
pub extern "system" fn Java_JniApi_btcTxSign(
    env: JNIEnv<'_>,
    _class: JClass<'_>,
    from_address: JString<'_>,
    wallet_id: JString<'_>,
    to_address: JString<'_>,
    value: JString<'_>,
) -> jbyteArray {
    // TODO
    // use wallet_id to create master and calc public_key and sign Transaction
    // now just use mnemonic_str to sign it
    let from_address = env.get_string(from_address).unwrap();
    let _from_address = from_address.to_str().unwrap();
    let wallet_id = env.get_string(wallet_id).unwrap();
    let _wallet_id = wallet_id.to_str().unwrap();
    let to_address = env.get_string(to_address).unwrap();
    let _to_address = to_address.to_str().unwrap();
    let value = env.get_string(value).unwrap();
    let value = value.to_str().unwrap();
    let _value = value.parse::<u64>().unwrap();

    let words = "lawn duty beauty guilt sample fiction name zero demise disagree cram hand";
    let mnemonic = Mnemonic::from_str(&words).expect("don't have right mnemonic");
    let mut master =
        MasterAccount::from_mnemonic(&mnemonic, 0, Network::Testnet, PASSPHRASE, None).unwrap();
    let mut unlocker = Unlocker::new_for_master(&master, "").expect("don't have right unlocker");

    // path 0,0 => source(from address)
    let account = Account::new(&mut unlocker, AccountAddressType::P2PKH, 0, 0, 10).unwrap();
    master.add_account(account);
    let account = master.get_mut((0, 0)).unwrap();
    let instance_key = account.next_key().unwrap();
    let source = instance_key.address.clone();
    let public_key = instance_key.public.clone();
    let public_compressed = public_key.serialize();
    let public_compressed = hex::encode(public_compressed);
    info!("source {:?}", &source);
    info!("public_compressed {:?}", &public_compressed);

    // target(to address) must use to address
    let address =
        Address::from_str("n16VXpudZnHLFkkeWrwTc8tr2oG66nScMk").expect("don't have right address");
    let script_pubkey = address.script_pubkey();

    const RBF: u32 = 0xffffffff - 2;

    // TODO
    // must use sqlite and modify database table UTXO
    // just hard code  UTXO. must fix it in feature
    let mut spending = Transaction {
        input: vec![TxIn {
            previous_output: OutPoint {
                txid: sha256d::Hash::from_hex(
                    "d2730654899df6efb557e5cd99b00bcd42ad448d4334cafe88d3a7b9ce89b916",
                )
                .unwrap(),
                vout: 1,
            },
            sequence: RBF,
            witness: Vec::new(),
            script_sig: Script::new(),
        }],
        output: vec![TxOut {
            script_pubkey,
            value: 21000,
        }],
        lock_time: 0,
        version: 2,
    };

    // The script_sig input needs to be assembled
    // resolver -> UTXO output data
    // compare example in rust-wallet
    master
        .sign(
            &mut spending,
            SigHashType::All,
            &(|_| {
                Some(TxOut {
                    value: 22000,
                    script_pubkey: source.script_pubkey(),
                })
            }),
            &mut unlocker,
        )
        .expect("can not sign");
    println!("btcapi btc_sign_tx {:#?}", &spending);

    let byte_array = serialize(&spending);
    println!("btcapi byte_vec {:0?}", &byte_array);
    let byte_array = env.byte_array_from_slice(byte_array.as_slice()).unwrap();
    byte_array
}

#[no_mangle]
#[allow(non_snake_case)]
pub extern "system" fn Java_JniApi_btcTxSignAndBroadcast(
    env: JNIEnv<'_>,
    _class: JClass<'_>,
    _from_address: JString<'_>,
    _to_address: JString<'_>,
    _wallet_id: JString<'_>,
    _to: JString<'_>,
    _value: JString<'_>,
) -> jboolean {
    // let _from_address = env.get_string(_from_address).unwrap();
    // let _from_address = _from_address.to_str().unwrap();
    // let _wallet_id = env.get_string(_wallet_id).unwrap();
    // let _wallet_id = _wallet_id.to_str().unwrap();
    // let _to_address = env.get_string(_to_address).unwrap();
    // let _to_address = _to_address.to_str().unwrap();
    // let _value = env.get_string(_value).unwrap();
    // let _value = _value.to_str().unwrap();
    // let _value = _value.parse::<u64>().unwrap();

    unimplemented!()
}

#[no_mangle]
#[allow(non_snake_case)]
pub extern "system" fn Java_JniApi_btcLoadBalance(
    _env: JNIEnv<'_>,
    _class: JClass<'_>,
    _address: JString<'_>,
) -> jstring {
    unimplemented!()
}

#[no_mangle]
#[allow(non_snake_case)]
pub extern "system" fn Java_JniApi_btcLoadMaxBlockNumber(
    env: JNIEnv<'_>,
    _class: JClass<'_>,
) -> jstring {
    let h = RB_CHAIN.fetch_height();
    let h = env
        .new_string(h.to_string())
        .expect("Could not create java string!");
    h.into_inner()
}

#[no_mangle]
#[allow(non_snake_case)]
pub extern "system" fn Java_JniApi_btcLoadNowBlockNumber(
    env: JNIEnv<'_>,
    _class: JClass<'_>,
) -> jstring {
    let height = fetch_scanned_height();
    let max_block_number = env
        .new_string(height.to_string())
        .expect("Could not create java string!");
    max_block_number.into_inner()
}

#[no_mangle]
#[allow(non_snake_case)]
pub extern "system" fn Java_JniApi_btcIsSyncDataOk(
    _env: JNIEnv<'_>,
    _class: JClass<'_>,
) -> jboolean {
    unimplemented!()
}

#[no_mangle]
#[allow(non_snake_case)]
pub extern "system" fn Java_JniApi_btcLoadTxHistory(
    _env: JNIEnv<'_>,
    _class: JClass<'_>,
    _address: JString<'_>,
    _startIndex: jint,
    _offset: JString<'_>,
) -> jboolean {
    unimplemented!()
}

// this function don't have any return value。because it will run spv node
#[no_mangle]
#[allow(non_snake_case)]
pub extern "system" fn Java_JniApi_btcStart(
    env: JNIEnv<'_>,
    _class: JClass<'_>,
    network: JString<'_>,
) {
    // TODO
    // use testnet for test and default
    // must change it in future
    // should def it by network parameter，maybe you should give a wallet id
    // connections = 1,
    // peers birth listen all default value
    // open db and sqlite in default name
    // use simple_logger in Debug Level
    simple_logger::init_with_level(Level::Debug).unwrap();
    let network_str = env.get_string(network).unwrap();
    let network_str = network_str.to_str().unwrap();
    let mut network = Network::Testnet;

    match network_str {
        "Testnet" => {
            network = Network::Testnet;
            info!("Start with testnet")
        }
        "Bitcoin" => {
            network = Network::Bitcoin;
            info!("Start with Bitcoin")
        }
        _ => {
            network = Network::Testnet;
            info!("Start with testnet")
        }
    }

    let mut peers: Vec<SocketAddr> = Vec::new();
    peers.push(SocketAddr::from(SocketAddrV4::new(
        Ipv4Addr::new(127, 0, 0, 1),
        8333,
    )));

    let connections = 1;
    let listen: Vec<SocketAddr> = Vec::new();
    let birth: u64 = SystemTime::now()
        .duration_since(SystemTime::UNIX_EPOCH)
        .unwrap()
        .as_secs();
    let chaindb = Constructor::open_db(Some(&Path::new(BTC_HAMMER_PATH)), network, birth).unwrap();

    // todo
    // use mnemonic generate publc address and store it in database
    let mut filter_message: Option<FilterLoadMessage> = None;
    {
        let m_address = RB_DETAIL.fetch_user_address();
        if let Some(m_address) = m_address {
            info!("Calc bloomfilter via pubkey {:?}", &m_address);
            let filter_load_message =
                FilterLoadMessage::calculate_filter(m_address.compressed_pub_key.as_str());
            filter_message = Some(filter_load_message)
        } else {
            info!("Did not have default pubkey in database yet");
            let default_address = calc_default_address();
            let address = default_address.to_string();
            let default_pubkey = calc_pubkey();
            RB_DETAIL.save_user_address(address, default_pubkey.clone());
            let filter_load_message = FilterLoadMessage::calculate_filter(default_pubkey.as_str());
            filter_message = Some(filter_load_message)
        }
    }

    let mut spv = Constructor::new(network, listen, chaindb, filter_message).unwrap();
    spv.run(network, peers, connections)
        .expect("can not start node");
}

mod test {
    use crate::jniapi::{calc_bloomfilter, calc_default_address, calc_pubkey};

    #[test]
    pub fn test_calc_pubkey() {
        let pubkey = calc_pubkey();
        println!("calc_pubkey {:?}", pubkey);
    }

    #[test]
    pub fn test_calc_bloomfilter() {
        let filter = calc_bloomfilter();
        println!("calc_bloomfilter {:#0x?}", filter);
    }

    #[test]
    pub fn test_calc_defalut_address() {
        let address = calc_default_address();
        println!("address {:?}", address.to_string());
    }
}
