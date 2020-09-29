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

    pub fn exec_db_update(&self,pre_version:Version,latest_version:Version)->WalletResult<()>{
        let mut current_version = Version {
            major: 1,
            minor: 0,
            patch: 0,
            pre: vec!(),
            build: vec!(),
        };

        let mut try_minor = pre_version.minor;
        //this place should save old data,
        for major in pre_version.major..=latest_version.major{
            current_version.major = major;
            loop {
                try_minor = try_minor+1;
                current_version.minor = try_minor;
                // minor num must continuous
                if let Some(sql) = super::table_desc::get_update_table_sql(&current_version.to_string()){
                    self.db_hander.execute(sql)?;
                }else {
                    break;
                }
            }
            try_minor = 0;
        }
        Ok(())
    }

    pub fn tx_rollback(&self) -> WalletResult<()> {
        self.db_hander.execute("rollback;").map(|_| ()).map_err(|err| err.into())
    }

    pub fn get_bool_value(value: &str) -> bool {
        value.eq("1")
    }
}
