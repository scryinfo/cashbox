//! mod for btcapi
//! java native methood def in  packages/wallet_manager/android/src/main/java/info/scry/wallet_manager/NativeLib.java

use jni::JNIEnv;
use jni::objects::{JClass, JString};
use jni::sys::{jbyteArray, jint, jlong, jstring, jboolean};
use bitcoin_wallet::mnemonic::Mnemonic;
use bitcoin_wallet::account::{MasterAccount, Unlocker, Account, AccountAddressType};
use bitcoin::{Network, Address, Transaction, TxIn, OutPoint, Script, TxOut, SigHashType};
use bitcoin::util::psbt::serialize::Serialize;
use std::str::FromStr;
use bitcoin::consensus::serialize;
use bitcoin_hashes::sha256d;
use bitcoin_hashes::hex::FromHex;


const PASSPHRASE: &str = "";

#[no_mangle]
#[allow(non_snake_case)]
pub extern "system" fn Java_JniApi_btcTxSign(
    env: JNIEnv,
    class: JClass,
    from_address: JString,
    wallet_id: JString,
    to_address: JString,
    value: JString,
) -> jbyteArray {
    // TODO
    // use wallet_id to create master and calc public_key and sign Transaction
    // now just use mnemonic_str to sign it

    let words = "lawn duty beauty guilt sample fiction name zero demise disagree cram hand";
    let mnemonic = Mnemonic::from_str(&words).expect("don't have right mnemonic");
    let mut master = MasterAccount::from_mnemonic(
        &mnemonic,
        0,
        Network::Testnet,
        PASSPHRASE,
        None,
    ).unwrap();
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
    println!("source {:?}", &source);
    println!("public_compressed {:?}", &public_compressed);

    // target(to address) must use to address
    let address = Address::from_str("n16VXpudZnHLFkkeWrwTc8tr2oG66nScMk").expect("don't have right address");
    let script_pubkey = address.script_pubkey();

    const RBF: u32 = 0xffffffff - 2;

    //TODO
    // must use sqlite and modify database table UTXO
    // just hard code  UTXO. must fix it in master
    let mut spending = Transaction {
        input: vec![
            TxIn {
                previous_output: OutPoint {
                    txid: sha256d::Hash::from_hex("d2730654899df6efb557e5cd99b00bcd42ad448d4334cafe88d3a7b9ce89b916").unwrap(),
                    vout: 1,
                },
                sequence: RBF,
                witness: Vec::new(),
                script_sig: Script::new(),
            }
        ],
        output: vec![
            TxOut {
                script_pubkey,
                value: 21000,
            },
        ],
        lock_time: 0,
        version: 2,
    };

    // The script_sig input needs to be assembled
    // resolver -> OTXO output data
    // compare example in rust-wallet
    master.sign(&mut spending, SigHashType::All,
                &(|_| Some(
                    TxOut {
                        value: 22000,
                        script_pubkey: source.script_pubkey(),
                    }
                )),
                &mut unlocker).expect("can not sign");
    println!("btcapi btc_sign_tx {:#?}", &spending);

    let byte_array = serialize(&spending);
    println!("btcapi byte_vec {:0x?}", &byte_array);
    let byte_array = env.byte_array_from_slice(byte_array.as_slice()).unwrap();
    byte_array
}

#[no_mangle]
#[allow(non_snake_case)]
pub extern "system" fn Java_JniApi_btcTxSignAndBroadcast(
    env: JNIEnv,
    class: JClass,
    from_address: JString,
    wallet_id: JString,
    to: JString,
    value: JString,
) -> jboolean {
    unimplemented!()
}

#[no_mangle]
#[allow(non_snake_case)]
pub extern "system" fn Java_JniApi_btcLoadBalance(
    env: JNIEnv,
    class: JClass,
    address: JString,
) -> jstring {
    unimplemented!()
}

#[no_mangle]
#[allow(non_snake_case)]
pub extern "system" fn Java_JniApi_btcLoadMaxBlockNumber(
    env: JNIEnv,
    class: JClass,
) {
    unimplemented!()
}

#[no_mangle]
#[allow(non_snake_case)]
pub extern "system" fn Java_JniApi_btcLoadNowBlockNumber(
    env: JNIEnv,
    class: JClass,
) -> jstring {
    unimplemented!()
}

#[no_mangle]
#[allow(non_snake_case)]
pub extern "system" fn Java_JniApi_btcIsSyncDataOk(
    env: JNIEnv,
    class: JClass,
) -> jboolean {
    unimplemented!()
}

#[no_mangle]
#[allow(non_snake_case)]
pub extern "system" fn Java_JniApi_btcLoadTxHistory(
    env: JNIEnv,
    class: JClass,
    address: JString,
    startIndex: jint,
    offset: JString,
) -> jboolean {
    unimplemented!()
}


