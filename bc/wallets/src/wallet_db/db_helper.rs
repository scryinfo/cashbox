use super::*;

use std::{fs, path};
use sqlite::Connection;

#[cfg(target_os="android")]
const TB_WALLET: &'static str = r#"/data/data/com.example.app/files/cashbox_wallet.db"#;
#[cfg(target_os="android")]
const TB_WALLET_DETAIL: &'static str = r#"/data/data/com.example.app/files/cashbox_wallet_detail.db"#;

#[cfg(any(target_os="linux",target_os="windows"))]
const TB_WALLET: &'static str = r#"cashbox_wallet.db"#;
#[cfg(any(target_os="linux",target_os="windows"))]
const TB_WALLET_DETAIL: &'static str = r#"cashbox_wallet_detail.db"#;

fn create_teble(table_name: &str, table_desc: &str) -> WalletResult<()> {
    // TODO 检查参数是否合理
    //先创建对应的文件路径
    if !path::Path::new(table_name).exists() {
        fs::File::create(table_name)?;
    }
    let connect = Connection::open(table_name)?;
    connect.execute(table_desc).map_err(|e| e.into())
}



/*//导入代币基础数据 目前默认是在创建数据库的时候调用
fn init_digit_base_data(table_name: &str) -> WalletResult<()> {
    let digit_base_insert_sql = "insert into DigitBase('contract_address','type','short_name','full_name','decimals','group_name','url_img','is_visible') values(?,?,?,?,?,?,?,?); ";
    let bytecode = include_bytes!("res/chainEthFile.json");
    //todo 错误处理
    let digits = serde_json::from_slice::<Vec<super::table_desc::DigitExport>>(&bytecode[..])?;
   let connect =  Connection::open(table_name)?;
    connect.execute("begin;")?;
    let mut state = connect.prepare(digit_base_insert_sql)?;
    for digit in digits {
        state.bind(1, digit.address.as_str())?;

        let digit_type = if digit.digit_type.eq("default") {1 }else { 0 };
        state.bind(2, digit_type as i64)?;
        //设置短名称
        state.bind(3, digit.symbol.as_str())?;
        //设置长名称 这里由于数据不足，短名称和长名称相同
        state.bind(4, digit.symbol.as_str())?;
        state.bind(5, digit.decimal)?;
        state.bind(6, "ETH")?;

        match digit.url_img {
            Some(url)=> state.bind(7,url.as_str())?,
            None=> state.bind(7,"")?,
        };
        state.bind(8, 0 as i64)?;
        state.next()?;
        state.reset()?;
    }
    //设置默认代币状态
    let update_digit_status = "update DigitBase set status =1,is_visible =1 where full_name like 'DDD';";
    connect.execute(update_digit_status)?;
    connect.execute("commit;")?;
    Ok(())
}*/
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
   pub fn init()->WalletResult<()> {
        if fs::File::open(TB_WALLET_DETAIL).is_err() || fs::File::open(TB_WALLET).is_err() {
            //2、若是不存在则执行sql脚本文件创建数据库
            let mnemonic_sql = super::table_desc::get_cashbox_wallet_sql();
            create_teble(TB_WALLET, mnemonic_sql.as_str())?;
            //create wallet table
            let wallet_sql = super::table_desc::get_cashbox_wallet_detail_sql();
            create_teble(TB_WALLET_DETAIL, wallet_sql.as_str())?;
            Ok(())
        }else {
           Err(WalletError::Custom("Database file has created".to_string()))
        }
    }
    pub fn instance() -> WalletResult<Self> {
        //1、检查对应的数据库文件是否存在
        if fs::File::open(TB_WALLET_DETAIL).is_err() || fs::File::open(TB_WALLET).is_err() {
          return Err(WalletError::Custom("Database file not exist,please run init() method first!".to_string()));
        }
        let conn = Connection::open(TB_WALLET)?;
        let attach_sql = format!("ATTACH DATABASE \"{}\" AS detail;", TB_WALLET_DETAIL);
        conn.execute(&attach_sql).map(|_|DataServiceProvider{
            db_hander:conn,
        }).map_err(|err|err.into())
    }

    pub fn tx_begin(&self) -> WalletResult<()> {
        self.db_hander.execute("begin;").map(|_| ()).map_err(|err| err.into())
    }

    pub fn tx_commint(&self) -> WalletResult<()> {
        self.db_hander.execute("commit;").map(|_| ()).map_err(|err| err.into())
    }

    pub fn tx_rollback(&self) -> WalletResult<()> {
        self.db_hander.execute("rollback;").map(|_| ()).map_err(|err| err.into())
    }

    pub fn get_bool_value(value: &str) -> bool {
        if value.eq("1") {
            true
        } else {
            false
        }
    }
}
