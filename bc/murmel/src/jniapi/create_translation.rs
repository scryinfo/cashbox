// mod for creating transaction

use bitcoin::blockdata::opcodes;
use bitcoin::blockdata::script::Builder;
use bitcoin::{
    Address, Network, OutPoint, PublicKey, Script, SigHashType, Transaction, TxIn, TxOut,
};
use bitcoin_hashes::hash160;
use bitcoin_hashes::hex::FromHex;
use bitcoin_hashes::hex::ToHex;
use bitcoin_hashes::sha256d;
use bitcoin_hashes::Hash;
use bitcoin_wallet::account::{Account, AccountAddressType, MasterAccount, Unlocker};
use bitcoin_wallet::error::Error;
use bitcoin_wallet::mnemonic::Mnemonic;
use jni::objects::{JClass, JObject, JString, JValue};
use jni::sys::{jdouble, jobject};
use jni::JNIEnv;
use log::{error, warn};
use std::str::FromStr;

const PASSPHRASE: &str = "";
const RBF: u32 = 0xffffffff - 2;

// mnemonic words
pub fn create_master_by_mnemonic(
    mnemonic_str: &str,
    network: Network,
) -> Result<MasterAccount, Error> {
    let mnemonic = Mnemonic::from_str(mnemonic_str).expect("don't have right mnemonic");
    MasterAccount::from_mnemonic(&mnemonic, 0, network, PASSPHRASE, None)
}

// add account to master
// create address by default  path（0，0）；
// default PASSPHRASE = ""
// default AccountAddressType = p2pkh
pub fn add_account(master: &mut MasterAccount, path: (u32, u32)) {
    let (account_number, sub_account_number) = path;
    let mut unlocker = Unlocker::new_for_master(master, PASSPHRASE).unwrap();
    let account = Account::new(
        &mut unlocker,
        AccountAddressType::P2PKH,
        account_number,
        sub_account_number,
        10,
    )
    .unwrap();
    master.add_account(account);
}

//create transaction
//value : the bitcoin value you want to spend  the unit is "Satoshi"
//     1 bitcoin == 100 million satoshi  100 000 000
//target： is the target address string ,means the address you wanna to spend for the transaction
pub fn create_translation(
    value: u64,
    target: &str,
    master: &mut MasterAccount,
    path: (u32, u32),
) -> Transaction {
    //  Compare the difference between utxo and value
    //  If not enough, consider reporting an error
    //  Construct the transaction information of the call fee The first hard-coded txid stands for utxo
    //  This transaction does not carry a signature
    let mut unlocker = Unlocker::new_for_master(&master, PASSPHRASE).unwrap();
    let source = master
        .get_mut((0, 0))
        .unwrap()
        .next_key()
        .unwrap()
        .address
        .clone();
    let target = Address::from_str(target).unwrap();

    //a transaction that spend spend spend source to target
    let mut spending_transaction = Transaction {
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
            script_pubkey: target.script_pubkey(),
            value: 21000,
        }],
        lock_time: 0,
        version: 2,
    };

    // The script_sig input needs to be assembled
    master
        .sign(
            &mut spending_transaction,
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

    spending_transaction
}

///Calculation hash160
pub fn hash160(public_key: &str) -> String {
    let decode: Vec<u8> = FromHex::from_hex(public_key).expect("Invalid public key");
    let hash = hash160::Hash::hash(&decode[..]);
    warn!("HASH160 {:?}", hash.to_hex());
    hash.to_hex()
}

#[no_mangle]
#[allow(non_snake_case)]
pub extern "system" fn Java_JniApi_creat_1master(
    env: JNIEnv,
    _: JClass,
    mnemonic_str: JString,
) -> jobject {
    let mnemonic_str = env.get_string(mnemonic_str).unwrap();

    let message_class = env
        .find_class("JniApi$StatusMessage")
        .expect("can't find class JniApi$StatusCode");
    let message_obj = env
        .alloc_object(message_class)
        .expect("create message instance error");

    env.set_field(message_obj, "code", "I", JValue::Int(200))
        .expect("set code error");
    env.set_field(
        message_obj,
        "message",
        "Ljava/lang/String;",
        JValue::Object(JObject::from(env.new_string("Rust".to_string()).unwrap())),
    )
    .expect("set error msg value is error!");

    message_obj.into_inner()
}

#[no_mangle]
#[allow(non_snake_case)]
pub extern "system" fn Java_JniApi_creat_1transaction(
    env: JNIEnv,
    _: JClass,
    mnemonic_str: JString,
    value: jdouble,
) -> jobject {
    let mnemonic_str = env.get_string(mnemonic_str).unwrap();
    let mnemonic_str = mnemonic_str.to_str().unwrap();
    let master = create_master_by_mnemonic(mnemonic_str, Network::Testnet);

    let message_class = env
        .find_class("JniApi$StatusMessage")
        .expect("can't find class JniApi$StatusCode");
    let message_obj = env
        .alloc_object(message_class)
        .expect("create message instance error");
    match master.unwrap() {
        ref mut master => {
            add_account(master, (0, 0));
            let tx = create_translation(
                value as u64,
                "n16VXpudZnHLFkkeWrwTc8tr2oG66nScMk",
                master,
                (0, 0),
            );
            println!("tx {:#?}", tx);
            env.set_field(message_obj, "code", "I", JValue::Int(200))
                .expect("set code error");
            env.set_field(
                message_obj,
                "message",
                "Ljava/lang/String;",
                JValue::Object(JObject::from(
                    env.new_string("Build Transaction success".to_string())
                        .unwrap(),
                )),
            )
            .expect("set error msg value is error!");
        }
        _ => {
            env.set_field(message_obj, "code", "I", JValue::Int(102))
                .expect("set code error");
            env.set_field(
                message_obj,
                "message",
                "Ljava/lang/String;",
                JValue::Object(JObject::from(
                    env.new_string("Build Transaction failure".to_string())
                        .unwrap(),
                )),
            )
            .expect("set error msg value is error!");
        }
    }

    message_obj.into_inner()
}

mod test {
    use crate::jniapi::create_translation::{
        add_account, create_master_by_mnemonic, create_translation, hash160,
    };
    use crate::walletlib::create_master;
    use bitcoin::consensus::serialize;
    use bitcoin::{Address, Network};
    use std::str::FromStr;

    #[test]
    pub fn tx() {
        let words = "lawn duty beauty guilt sample fiction name zero demise disagree cram hand";
        let master = create_master_by_mnemonic(words, Network::Testnet);

        add_account(&mut master.unwrap(), (0, 0));
        // let tx = create_translation(
        //     21000,
        //     "n16VXpudZnHLFkkeWrwTc8tr2oG66nScMk",
        //      &mut master.unwrap(),
        //     (0, 0),
        // );
        // println!("tx {:#?}", tx);
    }
}
