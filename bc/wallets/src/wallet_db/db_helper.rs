use std::{fs, path};
use sqlite::Connection;


const TB_WALLET: &'static str = r#"/data/data/com.example.app/files/cashbox_wallet.db"#;
const TB_WALLET_DETAIL: &'static str = r#"/data/data/com.example.app/files/cashbox_wallet_detail.db"#;

//const TB_WALLET: &'static str = r#"cashbox_wallet.db"#;
//const TB_WALLET_DETAIL: &'static str = r#"cashbox_wallet_detail.db"#;

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

//导入代币基础数据 目前默认是在创建数据库的时候调用
fn init_digit_base_data(table_name: &str) -> Result<(), String> {
    let digit_base_insert_sql = "insert into DigitBase('contract_address','type','short_name','full_name','decimals','group_name','url_img','is_visible') values(?,?,?,?,?,?,?,?); ";
    let bytecode = include_bytes!("res/chainEthFile.json");
    //todo 错误处理
    let mut index =0;
    let digits = serde_json::from_slice::<Vec<super::table_desc::DigitExport>>(&bytecode[..]).expect("get digit list");
    match Connection::open(table_name) {
        Ok(connect) => {
            connect.execute("begin;");
            let mut state = connect.prepare(digit_base_insert_sql).expect("preaper sql");
           // println!("digits:{:?}",digits);
            for digit in digits {
                state.bind(1, digit.address.as_str()).map_err(|e| format!("set digit address,{}", e.to_string()));
                state.bind(2, digit.digit_type.as_str()).map_err(|e| format!("set digit address,{}", e.to_string()));
                //设置短名称
                state.bind(3, digit.symbol.as_str()).map_err(|e| format!("set digit symbol,{}", e.to_string()));
                //设置长名称 这里由于数据不足，短名称和长名称相同
                state.bind(4, digit.symbol.as_str()).map_err(|e| format!("set digit symbol,{}", e.to_string()));
                state.bind(5, digit.decimal).map_err(|e| format!("set digit decimal,{}", e.to_string()));
                state.bind(6, "ETH").map_err(|e| format!("set digit group name,{}", e.to_string()));


                match digit.url_img {
                    Some(url)=> state.bind(7,url.as_str()),
                    None=> state.bind(7,""),
                };
                state.bind(8, 0 as i64).map_err(|e| format!("set digit is visible,{}", e.to_string()));
                state.next();
                state.reset();
            }
            connect.execute("commit;");
            Ok(())
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
            //加载基础数据
          let init_digit =  init_digit_base_data(TB_WALLET_DETAIL);
            if init_digit.is_err() {
                return Err(init_digit.unwrap_err());
            }
            println!("init digit is over!");
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

    pub fn get_bool_value(value: &str) -> bool {
        if value.eq("1") {
            true
        } else {
            false
        }
    }
}
