use super::*;
use crate::model::DigitItem;
use crate::wallet_db::table_desc::DigitExport;

pub fn show_digit(walletid: &str, chainid: &str, digitid: &str) -> Result<bool, WalletError> {
    let instance = wallet_db::db_helper::DataServiceProvider::instance()?;
    instance.show_digit(walletid, chainid, digitid)
}

pub fn hide_digit(walletid: &str, chainid: &str, digitid: &str) -> Result<bool, WalletError> {
    let instance = wallet_db::db_helper::DataServiceProvider::instance()?;
    instance.hide_digit(walletid, chainid, digitid)
}

pub fn update_balance(address: &str, digit_id: &str,balance:&str)-> Result<bool, WalletError>{
    let  instance = wallet_db::db_helper::DataServiceProvider::instance()?;
    instance.update_digit_balance(address,digit_id,balance)
}

// addDigit(String walletId, String chainId, String fullName, String shortName, String contractAddress, int decimal);

pub fn add_wallet_digit(wallet_id:&str,chain_id:&str,digit:DigitExport)-> Result<(), WalletError>{
    let  mut instance = wallet_db::db_helper::DataServiceProvider::instance()?;
    instance.add_digit(wallet_id,chain_id,digit)
}
