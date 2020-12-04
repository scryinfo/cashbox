use super::*;

use std::{fs, path};
use sqlite::Connection;

#[cfg(target_os = "android")]
const TB_WALLET: &str = r#"/data/data/wallet.cashbox.scry.info/files/cashbox_wallet.db"#;
#[cfg(target_os = "android")]
const TB_WALLET_DETAIL: &str = r#"/data/data/wallet.cashbox.scry.info/files/cashbox_wallet_detail.db"#;

#[cfg(any(target_os = "linux", target_os = "windows"))]
const TB_WALLET: &str = r#"cashbox_wallet.db"#;
#[cfg(any(target_os = "linux", target_os = "windows"))]
const TB_WALLET_DETAIL: &str = r#"cashbox_wallet_detail.db"#;

const CURRENT_DATABASE_VERSION: &str = r#"current_db_version"#;

fn create_teble(table_name: &str, table_desc: &str) -> WalletResult<()> {
    //First create the corresponding file path
    if !path::Path::new(table_name).exists() {
        fs::File::create(table_name)?;
    }
    let connect = Connection::open(table_name)?;
    // An error occurred during the execution of the database table creation process, the corresponding file needs to be deleted
    if let Err(e) = connect.execute(table_desc) {
        if let Err(msg) = fs::remove_file(table_name) {
            log::error!("create table:{}",msg.to_string());
        }
        Err(e.into())
    } else {
        Ok(())
    }
}

pub struct DataServiceProvider {
    pub db_hander: Connection,
}

impl Drop for DataServiceProvider {
    fn drop(&mut self) {
        let detach_sql = "DETACH DATABASE 'detail'";
        self.db_hander.execute(detach_sql).expect("DETACH database error!");
    }
}

impl DataServiceProvider {
    pub fn init() -> WalletResult<()> {
        if fs::File::open(TB_WALLET_DETAIL).is_err() || fs::File::open(TB_WALLET).is_err() {
            //create wallet table
            let mnemonic_sql = super::table_desc::get_cashbox_wallet_sql();
            create_teble(TB_WALLET, mnemonic_sql)?;
            //create wallet detail table
            let wallet_sql = super::table_desc::get_cashbox_wallet_detail_sql();
            create_teble(TB_WALLET_DETAIL, wallet_sql)?;
            Ok(())
        } else {
            Err(WalletError::Custom("Database file has created".to_string()))
        }
    }
    pub fn instance() -> WalletResult<Self> {
        //check database file is exist
        if fs::File::open(TB_WALLET_DETAIL).is_err() || fs::File::open(TB_WALLET).is_err() {
            return Err(WalletError::Custom("Database file not exist,please run init() method first!".to_string()));
        }
        let conn = Connection::open(TB_WALLET)?;
        //attach wallet detail
        let attach_sql = format!("ATTACH DATABASE \"{}\" AS detail;", TB_WALLET_DETAIL);
        conn.execute(&attach_sql).map(|_| DataServiceProvider {
            db_hander: conn,
        }).map_err(|err| err.into())
    }

    pub fn tx_begin(&self) -> WalletResult<()> {
        self.db_hander.execute("begin;").map(|_| ()).map_err(|err| err.into())
    }

    pub fn tx_commint(&self) -> WalletResult<()> {
        self.db_hander.execute("commit;").map(|_| ()).map_err(|err| err.into())
    }

    pub fn exec_db_update(&self, pre_version: Version, latest_version: Version) -> WalletResult<()> {
        let mut current_version = Version {
            major: 1,
            minor: 0,
            patch: 0,
            pre: vec!(),
            build: vec!(),
        };

        let mut try_minor = pre_version.minor + 1;
        //this place should save old data,
        for major in pre_version.major..=latest_version.major {
            current_version.major = major;
            loop {
                current_version.minor = try_minor;
                log::info!("update database version {}",current_version.to_string());
                // minor num must continuous
                if let Some(sql) = super::table_desc::get_update_table_sql(&current_version.to_string()) {
                    log::info!("update database sql {}",sql);
                    self.db_hander.execute(sql)?;
                    try_minor += 1;
                } else {
                    try_minor = 0;
                    break;
                }
            }
        }
        //update current database version
        let update_db_version_sql = "update detail.LibHelperInfo set value = ? where name = ?;";
        let mut statement = self.db_hander.prepare(update_db_version_sql)?;
        statement.bind(1, latest_version.to_string().as_str())?;
        statement.bind(2, CURRENT_DATABASE_VERSION)?;
        statement.next().map(|_| ()).map_err(|err| err.into())

    }

    pub fn get_current_db_version(&self) -> WalletResult<String> {
        let query_info_sql = "select value from detail.LibHelperInfo where name = ?;";
        if let Ok(mut statement) = self.db_hander.prepare(query_info_sql) {
            statement.bind(1, CURRENT_DATABASE_VERSION)?;
            statement.next()?;
            Ok(statement.read::<String>(0).unwrap())
        } else {
            log::info!("table LibHelperInfo not exist,will use default version value");
            Ok("1.0.0".to_string())
        }
    }

    pub fn tx_rollback(&self) -> WalletResult<()> {
        self.db_hander.execute("rollback;").map(|_| ()).map_err(|err| err.into())
    }

    pub fn get_bool_value(value: &str) -> bool {
        value.eq("1")
    }
}
