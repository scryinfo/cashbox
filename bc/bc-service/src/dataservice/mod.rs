use rusqlite::{Connection, NO_PARAMS};

use std::fs;
use scry_fs_util as fsutil;

use rusqlite::params;
use serde_rusqlite::{from_rows_ref, from_rows_with_columns, columns_from_statement};


const WALLET: [&'static str; 2] = ["cashbox_mnenonic.db","cashbox_wallet.db"];

#[derive(Default, Deserialize)]
pub struct TbMnemonic {
    pub  id: String,
    pub full_name: Option<String>,
    pub mnemonic: String,
    pub selected: bool,
    pub status: u8,
    pub create_time: String,
    pub update_time: String,
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

#[derive(Default, Deserialize)]
pub struct TbWallet{
    wallet_id:String,//助记词id
    wallet_name:String,
    selected:bool,
    chain_id:i32,
    address: String,
    digit_id:i32,
    contract_address:String,
    short_name:String,
    full_name:String,
    balance:String,
    isvisible:bool,
    decimals: i16,
    url_img:String
}

pub struct DataServiceProvider {
    //db_hander: Arc<Mutex<Connection>>,
    db_hander: Connection,
}
impl Drop for DataServiceProvider{
    fn drop(&mut self){
        let detach_sql = "DETACH DATABASE 'wallet'";
        &self.db_hander.execute(detach_sql,NO_PARAMS).expect("DETACH database error!");
    }
}
impl DataServiceProvider {

    pub fn instance() -> Result<Self, String> {

        //2、若是不存在则执行sql脚本文件创建数据库
        //3,返回实例

        //1、检查对应的数据库文件是否存在
        if fs::File::open(WALLET[0]).is_ok() && fs::File::open(WALLET[1]).is_ok() {
            //连接数据库
            let conn = Connection::open(WALLET[0]).unwrap();
            let attach_sql = format!("ATTACH DATABASE \"{}\" AS wallet;",WALLET[1]);
            conn.execute(&attach_sql,NO_PARAMS).expect("attach database error!");
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
                    let attach_sql = format!("ATTACH DATABASE \"{}\" AS wallet;",WALLET[1]);
                    conn.execute(&attach_sql,NO_PARAMS).expect("attach database error!");
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



    pub fn update_mnemonic(&self, mn: TbMnemonic) -> Result<usize,String>{
        let mn_sql = "update Mnemonic set mnemonic=?1 where id=?2;";
        self.db_hander.execute(mn_sql, params![mn.mnemonic,mn.id]).map_err(|err| {
            let error_hint = format!("save mnemonic error");
            err.to_string()
        })
    }

    pub fn save_mnemonic_address(&mut self, mn: TbMnemonic, addr: TbAddress) -> Result<(), String> {
        let mn_sql = "insert into Mnemonic(id,mnemonic) values(?1,?2)";
        let address_sql = "insert into wallet.Address(mnemonic_id,chain_id,address,puk_key,status) values(?1,?2,?3,?4,?5)";
        // TODO 增加事务的处理，这个的编码方式还需要修改 才能编译通过
        //let hander_tx = self.db_hander

        //  let mut tx = self.db_hander.transaction().unwrap();

            match self.db_hander.execute(mn_sql, params![mn.id,mn.mnemonic]) {
                Ok(_)=>{
                    match self.db_hander.execute(address_sql, params![addr.mnemonic_id,addr.chain_id,addr.address,addr.pub_key,addr.status]) {
                        Ok(_)=>{
                            Ok(())
                        },
                        Err(e)=>{
                            Err(e.to_string())
                        }
                    }
                },
                Err(e)=>{
                   Err(e.to_string())
                }
            }
    }
    //这个地方 定义成通用的对象查询功能
    pub fn query_by_mnemonic_id(&self, id: &str) -> Result<TbMnemonic, String> {
        let query_sql = "select * from Mnemonic where id = :?";
        self.db_hander.prepare(query_sql).map(|mut stmt| {
            let mut rows = stmt.query(&[id]).unwrap();
            {
                let mut res = from_rows_ref::<TbMnemonic>(&mut rows);
                let mnemonic = res.next().unwrap();
                mnemonic
            }
        }).map_err(|err| {
            println!("query error:{}", err.to_string());
            err.to_string()
        })
    }
    //考虑修改为查询所有指定条件的对象
    pub fn query_selected_mnemonic(&self)->Result<TbMnemonic, String>{
        //选中钱包 只有一个
        let sql ="select * from Mnemonic where selected=1;";
        self.db_hander.prepare(sql).map(|mut stmt| {
            let mut rows = stmt.query(NO_PARAMS).unwrap();
            {
                let mut res = from_rows_ref::<TbMnemonic>(&mut rows);
                let mnemonic = res.next().unwrap();
                mnemonic
            }
        }).map_err(|err| {
            println!("query error:{}", err.to_string());
            err.to_string()
        })
    }
    //当前该功能是返回所有的助记词
    pub fn get_mnemonics(&self)->Vec<TbMnemonic>{
        let sql ="select * from Mnemonic;";

        let mut statement = self.db_hander.prepare(sql).unwrap();
        let columns = columns_from_statement(&statement);
        let mut res = from_rows_with_columns::<TbMnemonic,_>(statement.query(NO_PARAMS).unwrap(),&columns);
        let mut vec = Vec::new();
        while let Some(mn)= res.next(){
            vec.push(mn)
        }
        vec
    }

    pub fn set_selected_mnemonic(&self,mn_id:&str)->Result<(),String>{
        //需要先查询出那些助记词是被设置为当前选中，将其设置为取消选中，再将指定的id 设置为选中状态
        let sql = "UPDATE Mnemonic set selected = 0 where id in (select id from Mnemonic WHERE selected=1);update Mnemonic set selected = 1 where id =:?;";
        self.db_hander.execute(sql,&[mn_id]).map(|_|()).map_err(|err|err.to_string())
    }
    pub fn del_mnemonic(&self,mn_id:&str)->Result<(),String>{
        let sql = "DELETE from Mnemonic WHERE id = :?; UPDATE Address set status = 0 WHERE mnemonic_id =:?;";
        self.db_hander.execute(sql,&[mn_id]).map(|_|()).map_err(|err|err.to_string())
    }
    pub fn rename_mnemonic(&self,mn_id:&str,mn_name:&str)->Result<(),String>{
        let sql = "UPDATE Mnemonic set fullname = :1 WHERE id=:2;";
        self.db_hander.execute(sql,params![mn_name,mn_id]).map(|_|()).map_err(|err|err.to_string())

    }

    pub fn display_mnemonic_list(&self)->Vec<TbWallet>{
        let all_mn = "select a.id as wallet_id,a.fullname as wallet_name,a.selected,b.id as chain_id,b.address,d.id as digit_id,d.contract_address,d.short_name,d.full_name,d.balance,d.selected as isvisible,d.decimals,d.url_img
 from Mnemonic a,wallet.Chain b,wallet.Address c,wallet.Digit d where a.id=c.mnemonic_id and c.chain_id = b.id and c.address=d.address and a.status =1 and c.status =1;";

        let mut statement = self.db_hander.prepare(all_mn).unwrap();
        let columns = columns_from_statement(&statement);
        let mut res = from_rows_with_columns::<TbWallet,_>(statement.query(NO_PARAMS).unwrap(),&columns);
        let mut vec = Vec::new();
        while let Some(mn)= res.next(){
            vec.push(mn)
        }
        vec

    }
}
