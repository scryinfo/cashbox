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

//接收客户端传递过来的认证代币列表,将数据更新到认证代币列表中
//todo 根据传递进来的代币属于测试链还是主链分别处理
pub fn update_auth_digit(digits:Vec<model::AuthDigit>)->WalletResult<()>{
    let instance = wallet_db::DataServiceProvider::instance()?;
    instance.tx_begin()?;
    //当前采用全量更新手段，直接删除存在的代币,更新新的代币
    match instance.update_certification_digit(digits) {
        Ok(())=>instance.tx_commint(),
        Err(e)=>instance.tx_rollback(),
    }
}


