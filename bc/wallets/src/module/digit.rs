use super::*;

pub fn show_digit(walletid: &str, chainid: &str, digitid: &str) -> Result<bool, WalletError> {
    let mut instance = wallet_db::db_helper::DataServiceProvider::instance()?;
    instance.show_digit(walletid, chainid, digitid)
}

pub fn hide_digit(walletid: &str, chainid: &str, digitid: &str) -> Result<bool, WalletError> {
    let mut instance = wallet_db::db_helper::DataServiceProvider::instance()?;
    instance.hide_digit(walletid, chainid, digitid)
}

pub fn update_balance(address: &str, digit_id: &str,balance:&str)-> Result<bool, WalletError>{
    let  instance = wallet_db::db_helper::DataServiceProvider::instance()?;
    instance.update_digit_balance(address,digit_id,balance)
}

/*
pub fn update_digit_balance(address: &str, digit_id: &str, balance: &str) -> Result<bool, WalletError> {
    let mut instance = wallet_db::db_helper::DataServiceProvider::instance()?;
    instance.update_balance(address, digit_id, balance)
}*/
