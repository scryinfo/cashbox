use super::*;

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


#[test]
fn init_database_test() {

    let ret = init_wallet_database();
    assert_eq!(ret.is_ok(),true);
}
