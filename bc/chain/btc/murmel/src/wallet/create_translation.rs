// mod for creating transaction

#![allow(non_snake_case)]
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

//create transaction
//value : the bitcoin value you want to spend  the unit is "Satoshi"
//     1 bitcoin == 100 million satoshi  100 000 000
//target： is the target address string ,means the address you wanna to spend for the transaction
// pub fn create_translation(
//     value: u64,
//     target: &str,
//     master: &mut MasterAccount,
//     path: (u32, u32),
// ) -> Transaction {
//     //  Compare the difference between utxo and value
//     //  If not enough, consider reporting an error
//     //  Construct the transaction information of the call fee The first hard-coded txid stands for utxo
//     //  This transaction does not carry a signature
//     let mut unlocker = Unlocker::new_for_master(&master, PASSPHRASE).unwrap();
//     let source = master
//         .get_mut((0, 0))
//         .unwrap()
//         .next_key()
//         .unwrap()
//         .address
//         .clone();
//     let target = Address::from_str(target).unwrap();
//
//     //a transaction that spend spend spend source to target
//     let mut spending_transaction = Transaction {
//         input: vec![TxIn {
//             previous_output: OutPoint {
//                 txid: sha256d::Hash::from_hex(
//                     "d2730654899df6efb557e5cd99b00bcd42ad448d4334cafe88d3a7b9ce89b916",
//                 )
//                 .unwrap(),
//                 vout: 1,
//             },
//             sequence: RBF,
//             witness: Vec::new(),
//             script_sig: Script::new(),
//         }],
//         output: vec![TxOut {
//             script_pubkey: target.script_pubkey(),
//             value: 21000,
//         }],
//         lock_time: 0,
//         version: 2,
//     };
//
//     // The script_sig input needs to be assembled
//     master
//         .sign(
//             &mut spending_transaction,
//             SigHashType::All,
//             &(|_| {
//                 Some(TxOut {
//                     value: 22000,
//                     script_pubkey: source.script_pubkey(),
//                 })
//             }),
//             &mut unlocker,
//         )
//         .expect("can not sign");
//
//     spending_transaction
// }