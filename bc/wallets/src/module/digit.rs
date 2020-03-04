use super::*;

pub fn show_digit(walletid: &str, chainid: &str, digitid: &str) -> Result<bool, WalletError> {
    let mut instance = wallet_db::db_helper::DataServiceProvider::instance()?;
    instance.show_digit(walletid, chainid, digitid)
}

pub fn hide_digit(walletid: &str, chainid: &str, digitid: &str) -> Result<bool, WalletError> {
    let mut instance = wallet_db::db_helper::DataServiceProvider::instance()?;
    instance.hide_digit(walletid, chainid, digitid)
}
