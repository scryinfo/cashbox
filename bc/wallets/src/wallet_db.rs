use super::*;

mod db_helper;
pub mod table_desc;
pub mod wallet;
pub mod chain;
pub mod digit;

pub use db_helper::DataServiceProvider;
pub use wallet_db::table_desc::DigitExport;

//创建数据库表。导入默认数据等操作
pub fn init_wallet_database()->WalletResult<()>{
    wallet_db::DataServiceProvider::init()?;
    let helper = wallet_db::DataServiceProvider::instance()?;
    helper.tx_begin()?;
  match helper.init_basic_digit(){
      Ok(_)=> helper.tx_commint(),
      Err(err)=>{
          helper.tx_rollback()?;
          Err(err)
      }
  }
}

#[test]
fn init_database_test() {
    init_wallet_database();
}



