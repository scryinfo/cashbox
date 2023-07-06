//! mod for rust-wallet

use bitcoin_hashes::sha256d;
use bitcoin_wallet::account::{Account, AccountAddressType, MasterAccount, Unlocker};
use bitcoin_wallet::mnemonic::Mnemonic;
use hex::decode as hex_decode;
use log::error;

use bitcoin::{Network, OutPoint, Script, SigHashType, Transaction, TxIn, TxOut};
use bitcoin::blockdata::opcodes;
use bitcoin::blockdata::script::Builder;
use bitcoin::hashes::hex::FromHex;
use bitcoin::util::psbt::serialize::Serialize;

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

// create mnemonic from bc/wallet
// the function is generate_mnemonic
// pub fn generate_mnemonic() {
//     let mnemonic = wallets::Wallets::generate_mnemonic(12);
//     println!("{}", mnemonic);
// }

#[cfg(test)]
mod test {
    use std::collections::HashMap;
    use std::fmt::Write;
    use std::str::FromStr;

    use bitcoin_hashes::Hash;
    use bitcoin_hashes::hex::ToHex;
    use bitcoin_wallet::account::{Account, AccountAddressType, MasterAccount, Unlocker};
    use bitcoin_wallet::mnemonic::Mnemonic;
    use futures::executor::block_on;

    use bitcoin::{
        Address, BitcoinHash, Network, OutPoint, Script, SigHashType, Transaction, TxIn, TxOut,
    };
    use bitcoin::consensus::{deserialize, serialize};
    use bitcoin::consensus::serialize as btc_serialize;
    use bitcoin::hashes::sha256d;
    use bitcoin::util::misc::hex_bytes;
    use mav::{CTrue, kits, NetType, WalletType};

    use crate::db::{GLOBAL_RB, GlobalRB};
    use crate::kit::vec_to_string;
    use crate::path::PATH;
    use crate::walletlib::create_master;

    #[test]
    pub fn bitcoin_hash_test() {
        let tx = create_master();
        let ser = serialize(&tx);
        let hash = tx.bitcoin_hash().to_hex();

        println!("tx {:#?}", &tx);
        println!("hash {:#?}", &hash);
        println!("hex_bytes {:0x?}", &ser);
        let hex_tx = hex_bytes(&vec_to_string(ser)).unwrap();
        let tx_deser: Result<Transaction, _> = deserialize(&hex_tx);
        assert_eq!(tx, tx_deser.unwrap());
    }

    #[test]
    pub fn test_create_master() {
        let tx = create_master();
        let vouts = tx.output;
        for (index, vout) in vouts.iter().enumerate() {
            let vout = vout.to_owned();
            let script = vout.script_pubkey;
            if script.is_p2pkh() {
                let asm = script.asm();
                let mut iter = asm.split_ascii_whitespace();
                let a = iter.next();
                println!("1  {}", a.unwrap());
                let a = iter.next();
                println!("2  {}", a.unwrap());
                let a = iter.next();
                println!("3  {}", a.unwrap());
                let a = iter.next();
                println!("4  {}", a.unwrap());
            }
        }
    }

    #[test]
    pub fn bitcoin_txinput_test() {
        let tx = create_master();
        println!("{:#?}", tx);

        let global_rb = GlobalRB::from(PATH, Network::Testnet).unwrap();
        GLOBAL_RB.set(global_rb).unwrap();
        let vec = block_on(GlobalRB::global().detail.list_btc_output_tx());
        let mut output_map = HashMap::new();
        for output in vec {
            output_map.insert(output.btc_tx_hash, output.idx);
        }
        println!("output_map {:#?}", &output_map);

        let inputs = tx.clone().input;
        for (index, txin) in inputs.iter().enumerate() {
            let txin = txin.to_owned();
            let outpoint = txin.previous_output;
            let tx_id = outpoint.txid.to_hex();
            let vout = outpoint.vout;

            match output_map.get(&tx_id) {
                Some(idx) if idx.to_owned() == vout => {
                    let sig_script = txin.script_sig.asm();
                    let sequence = txin.sequence;
                    let btc_tx_hash = tx.bitcoin_hash().to_hex();
                    let btc_tx_hexbytes = btc_serialize(&tx);
                    let btc_tx_hexbytes = vec_to_string(btc_tx_hexbytes);

                    println!("txid {:#?}", tx_id);
                    println!("vout {:#?}", vout);
                    println!("sig_script {:#?}", sig_script);
                    println!("sequence {:#?}", sequence);
                    println!("btc_tx_hash {:#?}", btc_tx_hash);
                    println!("btc_tx_hexbytes {:#?}", btc_tx_hexbytes);
                    println!("idx {:#?}", index);
                }
                _ => {}
            }
        }
    }

    #[test]
    pub fn bitcoin_txinput_test2() {
        // hex_bytes 0200000001b0fe49e44033e7365afc43bc5006d0595b4c1ba184729c7d0e367358ce4194920100000017160014486ae1596ec04a653cdc9339701b61617b4b2b43feffffff02b839c9040000000017a91498aba35aedc2d3468bffc1c3ddcd5c387fb1e3e387f0550000000000001976a91444af04fb17f6d79b93513e49c79c15ca29d5629088ac817d1900
        // tx_id = d2730654899df6efb557e5cd99b00bcd42ad448d4334cafe88d3a7b9ce89b916
        let hex_tx = hex_bytes("0200000001b0fe49e44033e7365afc43bc5006d0595b4c1ba184729c7d0e367358ce4194920100000017160014486ae1596ec04a653cdc9339701b61617b4b2b43feffffff02b839c9040000000017a91498aba35aedc2d3468bffc1c3ddcd5c387fb1e3e387f0550000000000001976a91444af04fb17f6d79b93513e49c79c15ca29d5629088ac817d1900").unwrap();
        let tx: Result<Transaction, _> = deserialize(&hex_tx);
        let tx = tx.unwrap();
        println!("{:#?}", tx);
    }

    // #[test]
    // pub fn mnemonic_test() {
    //     generate_mnemonic();
    // }
    //
    // pub fn init_parameters() -> InitParameters {
    //     let mut p = InitParameters::default();
    //     // p.is_memory_db = CTrue;
    //     p.net_type = NetType::Test.to_string();
    //     p.db_name.0 = mav::ma::DbName::new("test_", "");
    //     p.context_note = format!("test_{}", "murmel");
    //     p
    // }
    //
    // pub fn create_wallet_parameters() -> CreateWalletParameters {
    //     let words = "lawn duty beauty guilt sample fiction name zero demise disagree cram hand";
    //     CreateWalletParameters {
    //         name: "murmel".to_string(),
    //         password: "".to_string(),
    //         mnemonic: words.to_string(),
    //         // wallet_type 依然有特定的字符串 Test 和 Normal
    //         wallet_type: WalletType::Test.to_string(),
    //     }
    // }
    //
    // #[test]
    // pub fn create_wallet_try() {
    //     let i = init_parameters();
    //     let c = create_wallet_parameters();
    //     let mut wallets = Wallets::default();
    //     block_on(async {
    //         // must init wallet before create wallet
    //         let ctx = wallets.init(&i).await;
    //         ctx.map_or_else(
    //             |e| {
    //                 println!("init failed {:?}", e);
    //             },
    //             |c| println!("init succeeded context {:?}", c),
    //         );
    //         let w = wallets.create_wallet(c).await;
    //         match w {
    //             Ok(w) => { println!("{:#?}", w); }
    //             Err(e) => { println!("{}",e); }
    //         }
    //     })
    // }
    //
    // #[test]
    // // get_mnemonic_context
    // // get_private_key_from_address
    // pub fn get_mnemonic_from_address_try() {
    //     let i = init_parameters();
    //     let c = create_wallet_parameters();
    //     let mut wallets = Wallets::default();
    //     block_on(async {
    //         // must init wallet before create wallet
    //         let ctx = wallets.init(&i).await;
    //         ctx.map_or_else(
    //             |e| {
    //                 println!("init failed {:?}", e);
    //             },
    //             |c| println!("init succeeded context {:?}", c),
    //         );
    //         let r = wallets.create_wallet(c).await;
    //         r.map_or_else(
    //             |e| println!("create failed {:?}", e),
    //             |w| {
    //                 let mnemonic = eee::Sr25519::get_mnemonic_context(&w.mnemonic, "".as_bytes());
    //                 println!(
    //                     "mnemonic {:#?}",
    //                     String::from_utf8(mnemonic.unwrap()).unwrap()
    //                 );
    //             },
    //         );
    //     })
    // }
    //
    // #[test]
    // pub fn contexts_try() {
    //     let ip = init_parameters();
    //     let cp = create_wallet_parameters();
    //     block_on(async {
    //         let lock = Contexts::collection().lock();
    //         let mut contexts = lock.borrow_mut();
    //         let new_ctx = Context::new(&ip.context_note);
    //         let wallets = contexts.new(new_ctx, NetType::Test);
    //         if let Some(wallets) = wallets {
    //             let _ = wallets.init(&ip).await.unwrap();
    //             let w = wallets.create_wallet(cp).await;
    //             w.map_or_else(
    //                 |e| println!("create failed {:?}", e),
    //                 |w| {
    //                     println!("contexts {:#?}", contexts.contexts());
    //                 },
    //             );
    //             // println!("{:#?}", w);
    //         }
    //     });
    // }
}