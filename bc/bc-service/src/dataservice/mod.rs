use rusqlite::{Connection, OpenFlags,ErrorCode,Error};
use log::info;

pub struct DataServiceProvider {
    db_hander: Connection,
}

impl DataServiceProvider {
    pub fn instance(db_path: &str) -> Result<Self,String> {
        match Connection::open_with_flags(db_path, OpenFlags::SQLITE_OPEN_READ_WRITE) {
            Ok(conn) => {
                let provider = DataServiceProvider {
                    db_hander: conn,
                };
                Ok(provider)
            },
            Err(err) => {
                match err {
                    Error::SqliteFailure(code,opt)=>{
                        match code.code{
                            ErrorCode::CannotOpen=>{
                                let conncet = Connection::open(db_path).unwrap();

                                let provider = DataServiceProvider {
                                    db_hander: conncet,
                                };
                                Ok(provider)
                            }
                            _=>{
                                Err(code.to_string())
                            }
                        }
                    },
                    _=>{
                        Err(err.to_string())
                    },
                }
            },
        }

    }
}
