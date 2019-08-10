use rusqlite::{Connection, OpenFlags, ErrorCode, Error};
use log::info;
use std::fs;
use scry_fs_util as fsutil;

const WALLET: [&'static str;2] = ["cashbox_wallet","cashbox_mnenonic"];

pub struct DataServiceProvider {
    db_hander: Connection,
}

impl DataServiceProvider {
    pub fn instance(db_path: &str) -> Result<Self, String> {

        //2、若是不存在则执行sql脚本文件创建数据库
        //3,返回实例

        //1、检查对应的数据库文件是否存在
        if (fs::File::open(WALLET[0]).is_ok() && fs::File::open(WALLET[1]).is_ok()) {
            //连接数据库
            let conn = Connection::open(WALLET[1]).unwrap();
            let provider = DataServiceProvider {
                db_hander: conn,
            };
            Ok(provider)
        } else {
            //创建数据库
            match fs::read_dir("../../sql") {
                Ok(dir) => {
                    let mut i = 0;
                    for entry in dir {
                        let dir = entry.expect("open database sql file fail!");
                        let db_name = dir.file_name();
                        println!("db name is:{:?}", db_name);
                        let sql_script = fsutil::load_file(dir.path().to_str().unwrap()).unwrap();
                        let connect = Connection::open(WALLET[i]).unwrap();
                        //使用脚本文件创建数据表
                        connect.execute_batch(&String::from_utf8(sql_script).unwrap());
                        i = i + 1;
                        connect.close();
                    }
                    let conn = Connection::open(WALLET[1]).unwrap();
                    let provider = DataServiceProvider {
                        db_hander: conn,
                    };
                    Ok(provider)
                },
                Err(error) => {
                    Err("create database sql file is not exist!".to_string())
                }
            }
        }
       /* match Connection::open_with_flags(db_path, OpenFlags::SQLITE_OPEN_READ_WRITE) {
            Ok(conn) => {
                let provider = DataServiceProvider {
                    db_hander: conn,
                };
                Ok(provider)
            }
            Err(err) => {

               match err {
                    Error::SqliteFailure(code, opt) => {
                        match code.code {
                            ErrorCode::CannotOpen => {
                                println!("can't find database file:{},will create it!",db_path);
                                let conncet = Connection::open(db_path).unwrap();
                                match fs::read_dir("../../sql"){
                                    Ok(dir)=>{
                                        for entry in dir{
                                            let dir = entry.expect("open database sql file fail!");
                                            let sql = fsutil::load_file(dir.path().to_str().unwrap());
                                        }
                                    },
                                    Err(error)=>{

                                    }
                                }
                                for i in fs::read_dir("../../sql"){

                                }
                                //create new database use default sql file;
                               // conncet.execute_batch()
                                let provider = DataServiceProvider {
                                    db_hander: conncet,
                                };
                                Ok(provider)
                            }
                            _ => {
                                Err(code.to_string())
                            }
                        }
                    }
                    _ => {
                        Err(err.to_string())
                    }
                }
            }*/
        /*}*/
    }
}
