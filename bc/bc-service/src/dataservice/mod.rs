use rusqlite::{Connection, NO_PARAMS, Row, Error, RowIndex};

use std::fs;
use scry_fs_util as fsutil;

use rusqlite::params;
//use serde_rusqlite::{from_rows_ref, from_rows_with_columns, columns_from_statement, from_row, from_rows, from_rows_ref_with_columns};
use rusqlite::types::{Type, FromSql};


const WALLET: [&'static str; 2] = ["cashbox_mnenonic.db", "cashbox_wallet.db"];

#[derive(Default, Deserialize)]
pub struct TbMnemonic {
    pub  id: Option<String>,
    pub full_name: Option<String>,
    pub mnemonic: Option<String>,
    pub selected: Option<bool>,
    pub status: Option<i64>,
    pub create_time: Option<String>,
    pub update_time: Option<String>,
}

#[derive(Default)]
pub struct TbAddress {
    pub  id: i32,
    pub  mnemonic_id: String,
    pub  chain_id: i16,
    pub  address: String,
    pub  pub_key: String,
    pub  status: i8,
    pub create_time: String,
    pub update_time: String,
}

#[derive(Default)]
struct TbChain {
    id: i32,
    chain_type: i16,
    short_name: String,
    full_name: String,
    address: String,
    group_name: String,
    next_id: i32,
    selected: bool,
    more_property: bool,
    create_time: String,
    update_time: String,
}

#[derive(Serialize, Deserialize, Debug, PartialEq)]
pub struct TbWallet {
    pub wallet_id: Option<String>,
    //助记词id
    pub wallet_name: Option<String>,
    pub selected: Option<bool>,
    pub chain_id: Option<i64>,
    pub address: Option<String>,
    pub digit_id: Option<i64>,
    pub chain_type: Option<i64>,
    pub chain_address: Option<String>,
    pub contract_address: Option<String>,
    pub short_name: Option<String>,
    pub full_name: Option<String>,
    pub balance: Option<String>,
    pub isvisible: Option<bool>,
    pub decimals: Option<i64>,
    pub url_img: Option<String>,
}

#[derive(Serialize, Deserialize, Debug, PartialEq)]
pub struct TestWallet {
    pub wallet_id: Option<String>,
    //助记词id
    pub chain_id: Option<String>,
    pub address: Option<String>,
    pub chain_address: Option<String>,
}

pub struct DataServiceProvider {
    db_hander: Connection,
}

impl Drop for DataServiceProvider {
    fn drop(&mut self) {
        let detach_sql = "DETACH DATABASE 'wallet'";
        &self.db_hander.execute(detach_sql, NO_PARAMS).expect("DETACH database error!");
    }
}

impl DataServiceProvider {
    fn get_row_data<index: RowIndex, T: FromSql>(row: &Row, index: index) -> Option<T> {
        match row.get(index) {
            Ok(data) => {
                let col_value: T = data;
                Some(col_value)
            }
            Err(e) => {
                match e {
                    Error::InvalidColumnType(index, col, value) => None,
                    _ => {
                        None
                    }
                }
            }
        }
    }

    fn get_tbmnemonic_from_rows(row: Option<&Row>) -> Option<TbMnemonic> {
        if row.is_some() {
            let row_data = row.unwrap();
            let mnemonic = TbMnemonic {
                id: Self::get_row_data::<usize, String>(&row_data, 0),
                full_name: Self::get_row_data::<usize, String>(&row_data, 1),
                mnemonic: Self::get_row_data::<usize, String>(&row_data, 2),
                selected: Self::get_row_data::<usize, bool>(&row_data, 3),
                status: Self::get_row_data::<usize, i64>(&row_data, 4),
                create_time: Self::get_row_data::<usize, String>(&row_data, 5),
                update_time: Self::get_row_data::<usize, String>(&row_data, 6),
            };
            Some(mnemonic)
        } else {
            None
        }
    }

    pub fn instance() -> Result<Self, String> {

        //2、若是不存在则执行sql脚本文件创建数据库
        //3,返回实例

        //1、检查对应的数据库文件是否存在
        if fs::File::open(WALLET[0]).is_ok() && fs::File::open(WALLET[1]).is_ok() {
            //连接数据库
            let conn = Connection::open(WALLET[0]).unwrap();
            let attach_sql = format!("ATTACH DATABASE \"{}\" AS wallet;", WALLET[1]);
            conn.execute(&attach_sql, NO_PARAMS).expect("attach database error!");
            let provider = DataServiceProvider {
                db_hander: conn,
            };
            Ok(provider)
        } else {
            //创建数据库

            // TODO这个地方需要在程序运行指定创建sql 脚本所在的目录，这一步需要到时根据运行环境指定
            match fs::read_dir("sql") {
                Ok(dir) => {
                    let mut i = 0;
                    // TODO 优化数据库初始化逻辑
                    for entry in dir {
                        let dir = entry.expect("open database sql file fail!");
                        let db_name = dir.file_name();
                        // println!("db name is:{:?},dir.path is:{}", db_name,dir.path().to_str().unwrap());
                        let sql_script = fsutil::load_file(dir.path().to_str().unwrap()).expect("sql file not found");

                        let connect = Connection::open(WALLET[i]).unwrap();

                        //使用脚本文件创建数据表
                        connect.execute_batch(&String::from_utf8(sql_script).unwrap()).expect("execute sql script is error");
                        i = i + 1;
                        if connect.close().is_err() {
                            println!("connect close is error");
                        }
                    }

                    let conn = Connection::open(WALLET[0]).unwrap();
                    let attach_sql = format!("ATTACH DATABASE \"{}\" AS wallet;", WALLET[1]);
                    conn.execute(&attach_sql, NO_PARAMS).expect("attach database error!");
                    let provider = DataServiceProvider {
                        db_hander: conn,
                    };
                    // TODO 在连接到助记词库 还需要 attach database  "钱包库"
                    Ok(provider)
                }
                Err(error) => {
                    let msg = format!("create database sql error:{}!", error.to_string());
                    Err(msg)
                }
            }
        }
    }

    pub fn tx_begin(&mut self) -> Result<(), String> {
        self.db_hander.transaction().map(|_| ()).map_err(|err| err.to_string())
    }


    pub fn update_mnemonic(&self, mn: TbMnemonic) -> Result<usize, String> {
        let mn_sql = "update Mnemonic set mnemonic=?1 where id=?2;";
        self.db_hander.execute(mn_sql, params![mn.mnemonic,mn.id]).map_err(|err| {
            let error_hint = format!("save mnemonic error");
            err.to_string()
        })
    }

    pub fn save_mnemonic_address(&mut self, mn: TbMnemonic, addr: TbAddress) -> Result<(), String> {
        let mn_sql = "insert into Mnemonic(id,mnemonic) values(?1,?2);";
        let address_sql = "insert into wallet.Address(mnemonic_id,chain_id,address,puk_key,status) values(?1,?2,?3,?4,?5);";
        let digit_account_sql = "insert into wallet.Digit(address) values(?1);";
        // TODO 增加事务的处理，这个的编码方式还需要修改 才能编译通过
        //let hander_tx = self.db_hander
        // TODO 根据链的地址种类 对应的填写代币账户信息

        //  let mut tx = self.db_hander.transaction().unwrap();
        //在保存地址的时候
        match self.db_hander.execute(mn_sql, params![mn.id,mn.mnemonic]) {
            Ok(_) => {
                match self.db_hander.execute(address_sql, params![addr.mnemonic_id,addr.chain_id,addr.address,addr.pub_key,addr.status]) {
                    Ok(_) => {
                        match self.db_hander.execute(digit_account_sql, params![addr.address]) {
                            Ok(_) => Ok(()),
                            Err(e) => Err(e.to_string())
                        }
                    }
                    Err(e) => {
                        Err(e.to_string())
                    }
                }
            }
            Err(e) => {
                Err(e.to_string())
            }
        }
    }

    //这个地方 定义成通用的对象查询功能
    pub fn query_by_mnemonic_id(&self, id: &str) -> Result<Option<TbMnemonic>, String> {
        let query_sql = "select * from Mnemonic where id = :1";
        let mut statement = self.db_hander.prepare(query_sql).unwrap();
        let mut rows = statement.query(params![id]).unwrap();
        match rows.next() {
            Ok(row) => {
                let ret =Self::get_tbmnemonic_from_rows(row);
                Ok(ret)
            }
            Err(err) => {
                Err(err.to_string())
            }
        }
    }

//考虑修改为查询所有指定条件的对象
pub fn query_selected_mnemonic(&self) -> Result<TbMnemonic, String> {
    //选中钱包 只有一个
    let sql = "select * from Mnemonic where selected=1;";
    self.db_hander.prepare(sql).map(|mut stmt| {
        let mut rows = stmt.query(NO_PARAMS).unwrap();
        let row = rows.next().unwrap(); //必须存在一个指定的钱包

        let ret =Self::get_tbmnemonic_from_rows(row);
        ret.unwrap()
    }).map_err(|err| {
        println!("query error:{}", err.to_string());
        err.to_string()
    })
}

//当前该功能是返回所有的助记词
pub fn get_mnemonics(&self) -> Vec<TbMnemonic> {
    let sql = "select * from Mnemonic WHERE status = 1;";

    let mut statement = self.db_hander.prepare(sql).unwrap();
    let mut rows = statement.query(NO_PARAMS).unwrap();

    let mut vec = Vec::new();
    while let mn = rows.next().unwrap() {
        let mn = Self::get_tbmnemonic_from_rows(mn);
        if mn.is_some() {
            vec.push(mn.unwrap())
        }
    }
    vec
}

pub fn set_selected_mnemonic(&self, mn_id: &str) -> Result<(), String> {
    //需要先查询出那些助记词是被设置为当前选中，将其设置为取消选中，再将指定的id 设置为选中状态
    let sql = "UPDATE Mnemonic set selected = 0 where id in (select id from Mnemonic WHERE selected=1);";
    self.db_hander.execute(sql, NO_PARAMS).expect("exec sql is error!");
    let set_select_sql = "update Mnemonic set selected = 1 where id =:1;";
    self.db_hander.execute(set_select_sql, &[mn_id]).map(|_| ()).map_err(|err| err.to_string())
}

pub fn del_mnemonic(&self, mn_id: &str) -> Result<(), String> {
    let sql = "DELETE from Mnemonic WHERE id = :1; ";
    self.db_hander.execute(sql, &[mn_id]).expect("exec sql is error");
    let update_address = "UPDATE Address set status = 0 WHERE mnemonic_id =:2;";
    self.db_hander.execute(update_address, &[mn_id]).map(|_| ()).map_err(|err| err.to_string())
}

pub fn rename_mnemonic(&self, mn_id: &str, mn_name: &str) -> Result<(), String> {
    let sql = "UPDATE Mnemonic set fullname = :1 WHERE id=:2;";
    self.db_hander.execute(sql, params![mn_name,mn_id]).map(|_| ()).map_err(|err| err.to_string())
}

pub fn display_mnemonic_list(&self) -> Result<Vec<TbWallet>, String> {
    let all_mn = "select a.id as wallet_id,a.fullname as wallet_name,b.id as chain_id,d.address,b.address as chain_address,a.selected,b.type as chian_type,d.id as digit_id,d.contract_address,d.short_name,d.full_name,d.balance,d.selected as isvisible,d.decimals,d.url_img
 from Mnemonic a,wallet.Chain b,wallet.Address c,wallet.Digit d where a.id=c.mnemonic_id and c.chain_id = b.id and c.address=d.address and a.status =1 and c.status =1;";

    let mut statement = self.db_hander.prepare(all_mn).unwrap();
    // let columns = columns_from_statement(&statement);

    let mut rows = statement.query(NO_PARAMS).unwrap();

    let mut tbwallets = Vec::new();
    while let Some(row) = rows.next().unwrap() {
        let tbwallet = TbWallet {
            wallet_id: Self::get_row_data::<usize, String>(&row, 0),
            wallet_name: Self::get_row_data::<usize, String>(&row, 1),
            chain_id: Self::get_row_data::<usize, i64>(&row, 2),
            address: Self::get_row_data::<usize, String>(&row, 3),
            chain_address: Self::get_row_data::<usize, String>(&row, 4),
            selected: Self::get_row_data::<usize, bool>(&row, 5),
            chain_type: Self::get_row_data::<usize, i64>(&row, 6),
            digit_id: Self::get_row_data::<usize, i64>(&row, 7),
            contract_address: Self::get_row_data::<usize, String>(&row, 8),
            short_name: Self::get_row_data::<usize, String>(&row, 9),
            full_name: Self::get_row_data::<usize, String>(&row, 10),
            balance: Self::get_row_data::<usize, String>(&row, 11),
            isvisible: Self::get_row_data::<usize, bool>(&row, 12),
            decimals: Self::get_row_data::<usize, i64>(&row, 13),
            url_img: Self::get_row_data::<usize, String>(&row, 14),
        };
        tbwallets.push(tbwallet);
    }
    Ok(tbwallets)
}
}
