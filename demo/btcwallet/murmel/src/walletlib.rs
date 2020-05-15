//! mod for rust-wallet

use bitcoin_wallet::mnemonic::Mnemonic;
use bitcoin_wallet::account::{MasterAccount, Unlocker, Account, AccountAddressType};
use bitcoin::{Network, Transaction, TxIn, OutPoint, Script, TxOut, SigHashType};
use bitcoin::blockdata::opcodes;
use bitcoin::blockdata::script::Builder;
use bitcoin_hashes::sha256d;
use bitcoin::hashes::hex::FromHex;
use hex::decode as hex_decode;
use bitcoin::consensus::serialize;

const PASSPHRASE: &str = "";

pub fn create_master() -> Transaction {
    let words = "lawn duty beauty guilt sample fiction name zero demise disagree cram hand";
    let mnemonic = Mnemonic::from_str(&words).expect("don't have right mnemonic");
    let mut master = MasterAccount::from_mnemonic(
        &mnemonic,
        0,
        Network::Testnet,
        PASSPHRASE,
        None,
    ).unwrap();
    let mut unlocker = Unlocker::new_for_master(&master, PASSPHRASE).unwrap();
    let account = Account::new(&mut unlocker, AccountAddressType::P2PKH, 0, 0, 10).unwrap();
    master.add_account(account);

    let source = master.get_mut((0, 0)).unwrap().next_key().unwrap().address.clone();
    let public_key = master.get_mut((0, 0)).unwrap().next_key().unwrap().public.clone();
    println!("source {:?}", &source);
    println!("public_key {:?}", public_key);
    println!("script_pubkey {:?}", source.script_pubkey());

    let account = Account::new(&mut unlocker, AccountAddressType::P2PKH, 0, 1, 10).unwrap();
    master.add_account(account);
    // get next legacy receiver address
    let target = master.get_mut((0, 1)).unwrap().next_key().unwrap().address.clone();
    let target_pubkey = master.get_mut((0, 0)).unwrap().next_key().unwrap().public.clone();
    println!("target address {:?}", target);
    println!("target pub key {:?}", target_pubkey);

    const RBF: u32 = 0xffffffff - 2;

    //a transaction that spend spend spend source to target
    let mut spending_transaction = Transaction {
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
                script_pubkey: target.script_pubkey(),
                value: 21000,
            },
        ],
        lock_time: 0,
        version: 2,
    };

    let script = Builder::new().push_opcode(opcodes::all::OP_DUP)
                               .push_opcode(opcodes::all::OP_HASH160)
                               .push_slice(&hex_decode("44af04fb17f6d79b93513e49c79c15ca29d56290").unwrap())
                               .push_opcode(opcodes::all::OP_EQUALVERIFY)
                               .push_opcode(opcodes::all::OP_CHECKSIG)
                               .into_script();

    master.sign(&mut spending_transaction, SigHashType::All,
                &(|_| Some(
                    TxOut {
                        value: 21000,
                        script_pubkey: script.clone(),
                    }
                )),
                &mut unlocker).expect("can not sign");

    println!("tx {:?}", &spending_transaction);
    spending_transaction
}


mod test {
    use walletlib::create_master;
    use bitcoin::consensus::serialize;
    use jniapi::create_translation::hash160;
    use bitcoin::Address;
    use std::str::FromStr;

    #[test]
    pub fn fee_test() {
        let tx = create_master();
        let ser = serialize(&tx);
        println!("{:?}", ser.len());

        let bytes: f32 = 1.0 * 148f32 + 34.0 * 1.0 + 10.0f32;
        let sto = bytes * 0.675;
        println!("{:?}", sto);

        let target = Address::from_str("n16VXpudZnHLFkkeWrwTc8tr2oG66nScMk").unwrap();
        println!("target {:?}", target);
    }
}


