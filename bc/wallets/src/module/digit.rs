use super::*;
use wallet_db::DigitExport;

pub fn show_digit(walletid: &str, chainid: &str, digitid: &str) -> WalletResult<bool> {
    let instance = wallet_db::DataServiceProvider::instance()?;
    instance.show_digit(walletid, chainid, digitid)
}

pub fn hide_digit(walletid: &str, chainid: &str, digitid: &str) -> WalletResult<bool> {
    let instance = wallet_db::DataServiceProvider::instance()?;
    instance.hide_digit(walletid, chainid, digitid)
}

pub fn update_balance(address: &str, digit_id: &str,balance:&str)-> WalletResult<bool>{
    let  instance = wallet_db::DataServiceProvider::instance()?;
    instance.update_digit_balance(address,digit_id,balance)
}

pub fn add_wallet_digit(wallet_id:&str,chain_id:&str,digit:DigitExport)-> WalletResult<()>{
    let instance = wallet_db::DataServiceProvider::instance()?;
    instance.tx_begin()?;
    match instance.add_digit(wallet_id,chain_id,digit){
        Ok(_)=>instance.tx_commint(),
        Err(err)=>{
            instance.tx_rollback()?;
            Err(err)
        }
    }

}
