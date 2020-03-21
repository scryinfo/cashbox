//! mod for rust-wallet

use bitcoin_wallet::account::{MasterAccount, MasterKeyEntropy, Unlocker, Account, AccountAddressType};
use bitcoin::{Network, Transaction, TxIn, Script, TxOut, OutPoint, SigHashType};
use bitcoin_wallet::mnemonic::Mnemonic;
use bitcoin_hashes::sha256d;
use std::collections::HashMap;

const PASSPHRASE: &str = "correct horse battery staple";


mod tests {
    use bitcoin_wallet::account::{MasterAccount, MasterKeyEntropy, Account, AccountAddressType, Unlocker};
    use bitcoin::{Network, Transaction, TxIn, OutPoint, Script, TxOut, SigHashType};
    use bitcoin_wallet::mnemonic::Mnemonic;
    use bitcoin::hashes::sha256d;
    use bitcoin::hashes::hex::FromHex;
    use std::collections::HashMap;
    use bitcoin::blockdata::script::Builder;
    use bitcoin::blockdata::opcodes;
    use bitcoin_hashes::hex::ToHex;
    use hex::decode as hex_decode;

    const PASSPHRASE: &str = "";

    #[test]
    fn create_master() {
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
        // get next legacy receiver address
        let source = master.get_mut((0, 0)).unwrap().next_key().unwrap().address.clone();
        let public_key = master.get_mut((0, 0)).unwrap().next_key().unwrap().public.clone();
        println!("{:?}", source);
        println!("{:?}", public_key);

        let account = Account::new(&mut unlocker, AccountAddressType::P2PKH, 0, 1, 10).unwrap();
        master.add_account(account);
        // get next legacy receiver address
        let target = master.get_mut((0, 1)).unwrap().next_key().unwrap().address.clone();
        println!("{:?}", target);

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
                    value: 22000,
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
                            value: 22000,
                            script_pubkey: script.clone(),
                        }
                    )),
                    &mut unlocker).expect("can not sign");

        println!("tx {:?}", spending_transaction);
    }
}


