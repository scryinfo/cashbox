//! mod for rust-wallet

use bitcoin::blockdata::opcodes;
use bitcoin::blockdata::script::Builder;

use bitcoin::hashes::hex::FromHex;
use bitcoin::util::psbt::serialize::Serialize;
use bitcoin::{Network, OutPoint, Script, SigHashType, Transaction, TxIn, TxOut};
use bitcoin_hashes::sha256d;
use bitcoin_wallet::account::{Account, AccountAddressType, MasterAccount, Unlocker};
use bitcoin_wallet::mnemonic::Mnemonic;
use hex::decode as hex_decode;
use log::error;

const PASSPHRASE: &str = "";

pub fn create_master() -> Transaction {
    let words = "lawn duty beauty guilt sample fiction name zero demise disagree cram hand";
    let mnemonic = Mnemonic::from_str(&words).expect("don't have right mnemonic");
    let mut master =
        MasterAccount::from_mnemonic(&mnemonic, 0, Network::Testnet, PASSPHRASE, None).unwrap();
    let mut unlocker = Unlocker::new_for_master(&master, PASSPHRASE).unwrap();
    let account = Account::new(&mut unlocker, AccountAddressType::P2PKH, 0, 0, 10).unwrap();
    master.add_account(account);

    let account = master.get_mut((0, 0)).unwrap();
    let instance_key = account.next_key().unwrap();
    let source = instance_key.address.clone();
    let public_key = instance_key.public.clone();
    let public_compressed = public_key.serialize();
    let public_compressed = hex::encode(public_compressed);
    error!("source {}", &source);
    error!("public_compressed {:#?}", &public_compressed);

    let account = Account::new(&mut unlocker, AccountAddressType::P2PKH, 0, 1, 10).unwrap();
    master.add_account(account);
    let account = master.get_mut((0, 1)).unwrap();
    let instance_key = account.next_key().unwrap();
    let target = instance_key.address.clone();
    let public_key = instance_key.public.clone();
    let public_compressed = public_key.serialize();
    let public_compressed = hex::encode(public_compressed);
    error!("target {:?}", &target);
    error!("public_compressed {:?}", &public_compressed);

    const RBF: u32 = 0xffffffff - 2;
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

    let script = Builder::new()
        .push_opcode(opcodes::all::OP_DUP)
        .push_opcode(opcodes::all::OP_HASH160)
        .push_slice(&hex_decode("44af04fb17f6d79b93513e49c79c15ca29d56290").unwrap())
        .push_opcode(opcodes::all::OP_EQUALVERIFY)
        .push_opcode(opcodes::all::OP_CHECKSIG)
        .into_script();

    master
        .sign(
            &mut spending_transaction,
            SigHashType::All,
            &(|_| {
                Some(TxOut {
                    value: 21000,
                    script_pubkey: script.clone(),
                })
            }),
            &mut unlocker,
        )
        .expect("can not sign");

    error!("tx {:#?}", &spending_transaction);
    spending_transaction
}

mod test {

    // #[test]
    // pub fn fee_test() {
    //     let tx = create_master();
    //     let ser = serialize(&tx);
    //     println!("{:?}", ser.len());
    //     println!("{:#?}", tx);
    //
    //     let bytes: f32 = 1.0 * 148f32 + 34.0 * 1.0 + 10.0f32;
    //     let sto = bytes * 0.675;
    //     println!("{:?}", sto);
    //
    //     let target = Address::from_str("n16VXpudZnHLFkkeWrwTc8tr2oG66nScMk").unwrap();
    //     println!("target {:?}", target);
    // }
}