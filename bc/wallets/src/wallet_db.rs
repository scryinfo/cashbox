use super::*;

use semver::Version;

mod db_helper;

pub mod table_desc;
pub mod wallet;
pub mod chain;
pub mod digit;

pub use db_helper::DataServiceProvider;

//Create a database table. Import default data and other operations
pub fn init_wallet_database() -> WalletResult<()> {
    #[cfg(target_os="android")]crate::init_logger_once();
    //create database struct
    wallet_db::DataServiceProvider::init()?;
    let helper = wallet_db::DataServiceProvider::instance()?;
    helper.tx_begin()?;
    //write basic digit info
    match helper.init_basic_digit() {
        Ok(_) => helper.tx_commint(),
        Err(err) => {
            helper.tx_rollback()?;
            Err(err)
        }
    }
}

pub fn update_db_version(pre_version:&str,latest_version:&str)->WalletResult<()>{
    let mut pre = Version::parse(pre_version)?;
    let  latest = Version::parse(latest_version)?;

    let helper = wallet_db::DataServiceProvider::instance()?;
    helper.tx_begin()?;
    match helper.exec_db_update(pre,latest) {
        Ok(_) => helper.tx_commint(),
        Err(err) => {
            helper.tx_rollback()?;
            println!("err detail is:{:?}",err);
            Err(err)
        }
    }
}

#[test]
fn init_database_test() {
    let ret = init_wallet_database();
    assert_eq!(ret.is_ok(),true);
}

#[test]
fn update_db_version_test(){
    let ret = update_db_version("1.0.0","1.1.0");
    assert_eq!(ret.is_ok(),true);
}
