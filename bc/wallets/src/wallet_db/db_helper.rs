use std::{fs, path};
use sqlite::{Connection};


//const TB_WALLET: &'static str = r#"/data/data/com.example.app/files/cashbox_wallet.db"#;
//const TB_WALLET_DETAIL: &'static str = r#"/data/data/com.example.app/files/cashbox_wallet_detail.db"#;

const TB_WALLET: &'static str = r#"cashbox_wallet.db"#;
const TB_WALLET_DETAIL: &'static str = r#"cashbox_wallet_detail.db"#;

fn create_teble(table_name: &str, table_desc: &str) -> Result<(), String> {
    // TODO 检查参数是否合理
    //先创建对应的文件路径
    if !path::Path::new(table_name).exists() {
        let file_create = fs::File::create(table_name).map_err(|e| format!("{} create error:{}", table_name, e.to_string()));
        if file_create.is_err() {
            return Err(file_create.unwrap_err());
        }
    }

    match Connection::open(table_name) {
        Ok(connect) => {
            match connect.execute(table_desc) {
                Ok(_) => { Ok(()) }
                Err(e) => {
                    Err(format!("{} create error:{}", table_name, e.to_string()))
                }
            }
        }
        Err(e) => {
            Err(format!("create databse file {} error:{}", table_name, e.to_string()))
        }
    }
}

pub struct DataServiceProvider {
   pub db_hander: Connection,
}

impl Drop for DataServiceProvider {
    fn drop(&mut self) {
        let detach_sql = "DETACH DATABASE 'detail'";
        &self.db_hander.execute(detach_sql).expect("DETACH database error!");
    }
}

impl DataServiceProvider {

    pub fn instance() -> Result<Self, String> {
        //1、检查对应的数据库文件是否存在
        if fs::File::open(TB_WALLET_DETAIL).is_err() || fs::File::open(TB_WALLET).is_err() {
            //2、若是不存在则执行sql脚本文件创建数据库
            let mnemonic_sql = super::table_desc::get_cashbox_wallet_sql();
            let mn_database_hint = create_teble(TB_WALLET, mnemonic_sql.as_str());
            if mn_database_hint.is_err() {
                return Err(mn_database_hint.unwrap_err());
            }
            //create wallet table
            let wallet_sql = super::table_desc::get_cashbox_wallet_detail_sql();
            let crate_wallet_hint = create_teble(TB_WALLET_DETAIL, wallet_sql.as_str());
            if crate_wallet_hint.is_err() {
                return Err(crate_wallet_hint.unwrap_err());
            }
        }

        //start connect mnemonic database
        match Connection::open(TB_WALLET) {
            Ok(conn) => {
                let attach_sql = format!("ATTACH DATABASE \"{}\" AS detail;", TB_WALLET_DETAIL);
                match conn.execute(&attach_sql) {
                    Ok(_) => {
                        let provider = DataServiceProvider {
                            db_hander: conn,
                        };
                        Ok(provider)
                    }
                    Err(e) => {
                        Err(format!("ATTACH DATABASE error:{}", e.to_string()))
                    }
                }
            }
            Err(e) => {
                let hint = format!("open TB_MNEMONIC error:{}", e.to_string());
                Err(hint)
            }
        }
    }

    pub fn tx_begin(&mut self) -> Result<(), String> {
        self.db_hander.execute("begin;").map(|_| ()).map_err(|err| err.to_string())
    }

    pub fn tx_commint(&mut self) -> Result<(), String> {
        self.db_hander.execute("commit;").map(|_| ()).map_err(|err| err.to_string())
    }

   pub fn get_bool_value(value:&str)->bool{
        if value.eq("1") {
            true
        }else {
            false
        }
    }
}
