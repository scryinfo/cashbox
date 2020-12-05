use uuid::Uuid;
use rbatis::rbatis::Rbatis;
use std::{fs, path};
use std::ops::Add;

use wallets_types::WalletError;

pub fn uuid() -> String {
    Uuid::new_v4().to_string()
}

pub fn now_ts_seconds() -> i64 {
    chrono::offset::Utc::now().timestamp()
}

/// 如果数据库文件不存在，则创建它
/// 如果连接出错直接panic
pub async fn make_rbatis(db_file_name: &str) -> Result<Rbatis,WalletError> {
    if fs::metadata(db_file_name).is_err() {
        let file = path::Path::new(db_file_name);
        let dir = file.parent();
        if dir.is_none() {
            return Err(WalletError::NoneError(db_file_name.to_owned()));
        }
        let dir = dir.unwrap();
        fs::create_dir_all(dir)?;
        fs::File::create(db_file_name)?;
    }
    let rb = Rbatis::new();
    let url = "sqlite://".to_owned().add(db_file_name);
    rb.link(url.as_str()).await?;
    return Ok(rb);
}
