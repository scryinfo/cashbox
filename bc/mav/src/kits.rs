use std::{fmt, fs, io, path};
use std::ops::Add;

use rbatis::rbatis::Rbatis;
use uuid::Uuid;

#[derive(Debug, PartialEq, Clone)]
pub struct Error {
    pub err: String,
}


impl fmt::Display for Error {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "Db Error: {}", self.err)
    }
}

impl From<rbatis_core::Error> for Error {
    fn from(e: rbatis_core::Error) -> Self { Error::from(e.to_string().as_str()) }
}

impl From<&str> for Error {
    fn from(e: &str) -> Self { Self { err: e.to_owned() } }
}

impl From<io::Error> for Error {
    fn from(err: io::Error) -> Self { Error::from(err.to_string().as_str()) }
}

pub fn uuid() -> String {
    Uuid::new_v4().to_string()
}

pub fn now_ts_seconds() -> i64 {
    chrono::offset::Utc::now().timestamp()
}

/// 如果数据库文件不存在，则创建它
/// 如果连接出错直接panic
pub async fn make_rbatis(db_file_name: &str) -> Result<Rbatis, Error> {
    if fs::metadata(db_file_name).is_err() {
        let file = path::Path::new(db_file_name);
        let dir = file.parent();
        if dir.is_none() {
            return Err(Error::from(db_file_name));
        }
        let dir = dir.unwrap();
        fs::create_dir_all(dir)?;
        fs::File::create(db_file_name)?;
    }
    let rb = Rbatis::new();
    let url = "sqlite://".to_owned().add(db_file_name.clone());
    rb.link(url.as_str()).await?;
    return Ok(rb);
}
