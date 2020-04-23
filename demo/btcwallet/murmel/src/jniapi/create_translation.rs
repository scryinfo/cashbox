// mod for creating transaction

use bitcoin_wallet::account::{MasterAccount, Account, AccountAddressType, Unlocker};
use bitcoin_wallet::mnemonic::Mnemonic;
use bitcoin::{Network, PublicKey, Address};


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

//  create address by default  path（0，0）；
// default PASSPHRASE = ""
// default AccountAddressType = p2pkh
pub fn create_address_by_path(master: &mut MasterAccount, path: (u32, u32)) -> (PublicKey, Address) {
    let path_clone = path.clone();
    let (account_number, sub_account_number) = path_clone;
    let mut unlocker = Unlocker::new_for_master(master, PASSPHRASE).unwrap();
    let account = Account::new(&mut unlocker, AccountAddressType::P2PKH, account_number, sub_account_number, 10).unwrap();
    master.add_account(account);
    let source = master.get_mut(path).unwrap().next_key().unwrap().address.clone();
    let public_key = master.get_mut(path).unwrap().next_key().unwrap().public.clone();
    (public_key, source)
}