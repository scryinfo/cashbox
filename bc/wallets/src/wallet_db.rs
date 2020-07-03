use super::*;

mod db_helper;

pub mod table_desc;
pub mod wallet;
pub mod chain;
pub mod digit;

pub use db_helper::DataServiceProvider;

//Create a database table. Import default data and other operations
pub fn init_wallet_database() -> WalletResult<()> {
    wallet_db::DataServiceProvider::init()?;
    let helper = wallet_db::DataServiceProvider::instance()?;
    helper.tx_begin()?;
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
    init_wallet_database();
}
