// mod for creating transaction

use bitcoin_wallet::account::{MasterAccount, Account, AccountAddressType, Unlocker};
use bitcoin_wallet::mnemonic::Mnemonic;
use bitcoin::{Network, PublicKey, Address, Transaction, TxIn, OutPoint, Script, TxOut, SigHashType};


const PASSPHRASE: &str = "";

// mnemonic words
pub fn create_master_by_mnemonic(mnemonic_str: &str, network: Network) -> MasterAccount {
    let mnemonic = Mnemonic::from_str(mnemonic_str).expect("don't have right mnemonic");
    let master = MasterAccount::from_mnemonic(
        &mnemonic,
        0,
        network,
        PASSPHRASE,
        None,
    ).expect("Did not create master correctly");
    master
}

// create address by default  path（0，0）；
// default PASSPHRASE = ""
// default AccountAddressType = p2pkh
pub fn create_address(master: &mut MasterAccount, path: (u32, u32)) -> (PublicKey, Address) {
    let path_clone = path.clone();
    let (account_number, sub_account_number) = path_clone;
    let mut unlocker = Unlocker::new_for_master(master, PASSPHRASE).unwrap();
    let account = Account::new(&mut unlocker, AccountAddressType::P2PKH, account_number, sub_account_number, 10).unwrap();
    master.add_account(account);
    let source = master.get_mut(path).unwrap().next_key().unwrap().address.clone();
    let public_key = master.get_mut(path).unwrap().next_key().unwrap().public.clone();
    (public_key, source)
}

// create transaction
// value : the bitcoin value you want to spend  the unit is "Satoshi"
//      1 bitcoin = 100 million satoshi  100 000 000
// address_str： is the target address string ,means the address you wanna to spend for the transaction
pub fn create_translation(value: u64, address_str: &str, master: MasterAccount) -> Transaction {
    //  todo 查询utxo
    //  对比utxo 和 value的差值
    //  如果不够,考虑报错
    //  构建话费的交易信息 第一段硬编码的txid代表 utxo
    //  本次交易不带签名
    //  out 中的script_pubkey 代表目标地址的公钥 todo
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

    // 需要拼装输入的script_sig
    master.sign(&mut spending_transaction, SigHashType::All,
                &(|_| Some(input_transaction.output[0].clone())),
                &mut unlocker).expect("can not sign");

    spending_transaction
}

// todo calculate tx fee