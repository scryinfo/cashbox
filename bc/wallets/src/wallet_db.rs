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

pub fn update_db_version(latest_version:&str)->WalletResult<()>{

    let helper = wallet_db::DataServiceProvider::instance()?;
    let pre_version = helper.get_current_db_version()?;
    log::info!("current database version is {}",pre_version);
    let  pre = Version::parse(pre_version.as_str())?;
    let  latest = Version::parse(latest_version)?;
    if pre<latest {
        helper.tx_begin()?;
        let ret = match helper.exec_db_update(pre,latest) {
            Ok(_) => helper.tx_commint(),
            Err(err) => {
                helper.tx_rollback()?;
                println!("{:?}",err);
                log::error!("{:?}",err);
                Err(err)
            }
        };
        ret
    }else if pre>latest{
      Err(WalletError::Custom("pre_version is bigger than latest version,please reinstall this application".to_string()))
    }else {
        Ok(())
    }

}

#[test]
fn init_database_test() {
    assert_eq!(init_wallet_database().is_ok(),true);
}

#[test]
fn update_db_version_test(){
    match update_db_version("1.1.0") {
        Ok(_)=>println!("database update successful"),
        Err(e)=>println!("database update error:{}",e.to_string()),
    }
}
