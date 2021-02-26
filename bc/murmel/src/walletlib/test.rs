use crate::walletlib::create_master;
use bitcoin::{Address, BitcoinHash, Network};
use bitcoin::consensus::serialize;
use std::str::FromStr;
use bitcoin_hashes::hex::ToHex;
use bitcoin_hashes::Hash;
use bitcoin_wallet::mnemonic::Mnemonic;
use bitcoin_wallet::account::{MasterAccount, Unlocker};

#[test]
pub fn fee_test() {
    let tx = create_master();
    let ser = serialize(&tx);
    println!("{:?}", ser.len());
    println!("{:#?}", tx.bitcoin_hash());
    println!("{:#?}", tx);

    let bytes: f32 = 1.0 * 148f32 + 34.0 * 1.0 + 10.0f32;
    let sto = bytes * 0.675;
    println!("{:?}", sto);

    let target = Address::from_str("n16VXpudZnHLFkkeWrwTc8tr2oG66nScMk").unwrap();
    println!("target {:?}", target);
}

#[test]
pub fn fake_sig_test() {
    let words = "lawn duty beauty guilt sample fiction name zero demise disagree cram hand";
    let mnemonic = Mnemonic::from_str(&words).expect("don't have right mnemonic");
    let mut master =
        MasterAccount::from_mnemonic(&mnemonic, 0, Network::Testnet, "", None).unwrap();
    let mut unlocker = Unlocker::new_for_master(&master, "").unwrap();

    let mut spending_transaction = Transaction {
        input: vec![TxIn {
            previous_output: OutPoint { txid, vout: 0 },
            sequence: (CSV - 1) as u32, // this one should not be able to spend
            witness: Vec::new(),
            script_sig: Script::new(),
        }],
        output: vec![TxOut {
            script_pubkey: target.script_pubkey(),
            value: 5000000000,
        }],
        lock_time: 0,
        version: 2,
    };
}