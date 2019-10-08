use super::*;

pub fn show_digit(walletid: &str, chainid: &str, digitid: &str) -> Result<bool, String> {
    let mut instance = wallet_db::db_helper::DataServiceProvider::instance().unwrap();
    match instance.show_digit(walletid, chainid, digitid) {
        Ok(_) => Ok(true),
        Err(error) => Err(error.to_string())
    }
}

pub fn hide_digit(walletid: &str, chainid: &str, digitid: &str) -> Result<bool, String> {
    let mut instance = wallet_db::db_helper::DataServiceProvider::instance().unwrap();
    match instance.hide_digit(walletid, chainid, digitid) {
        Ok(_) => Ok(true),
        Err(error) => Err(error.to_string())
    }
}
