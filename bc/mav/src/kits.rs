use std::{fmt, fs, io, path};
use std::ops::Add;
use std::sync::Arc;

use rbatis::plugin::log::{LogPlugin, RbatisLogPlugin};
use rbatis::rbatis::{Rbatis, RbatisOption};
use uuid::Uuid;

#[derive(Debug, PartialEq, Clone, Default)]
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
    let url = "sqlite://".to_owned().add(db_file_name);
    rb.link(url.as_str()).await?;
    return Ok(rb);
}

pub async fn make_memory_rbatis() -> Result<Rbatis, Error> {
    let rb = {
        let op = RbatisOption {
            log_plugin: Arc::new(Box::new(RbatisLogPlugin {
                level_filter: log::max_level(),
            }) as Box<dyn LogPlugin>),
            ..RbatisOption::default()
        };
        Rbatis::new_with_opt(op)
    };
    let url = "sqlite://:memory:".to_owned();
    rb.link(&url).await?;
    return Ok(rb);
}

#[cfg(test)]
pub mod test {
    use futures::executor::block_on;
    use rbatis::rbatis::Rbatis;

    use crate::kits::make_memory_rbatis;
    use crate::ma::{Db, DbName};

    pub fn mock_memory_db() -> Db {
        let mut db = Db::default();
        let re = block_on(db.init_memory_sql(&DbName::new("", "")));
        assert_eq!(false, re.is_err(), "{:?}", re.unwrap_err());
        db
    }

    pub fn mock_files_db() -> Db {
        let mut db = Db::default();
        let re = block_on(db.connect(&DbName::new("test_", "./temp")));
        assert_eq!(false, re.is_err(), "{:?}", re);
        db
    }

    pub async fn make_memory_rbatis_test() -> Rbatis {
        struct SimpleLogger;

        impl log::Log for SimpleLogger {
            fn enabled(&self, _: &log::Metadata) -> bool {
                true
            }

            fn log(&self, record: &log::Record) {
                println!("{} - {}", record.level(), record.args());
            }

            fn flush(&self) {}
        }
        let _ = log::set_boxed_logger(Box::new(SimpleLogger));
        log::set_max_level(log::LevelFilter::Info);
        let re = make_memory_rbatis().await;
        re.unwrap()
    }
}

pub fn sql_left_join_get_b(a: &str, a_id: &str, b: &str, b_id: &str) -> String {
    let sql = {
        format!("select {}.* from {} left join {} on {}.{} = {}.{}",
                b, a, b, a, a_id, b, b_id
        )
    };
    sql
}

pub fn sql_left_join_get_a(a: &str, a_id: &str, b: &str, b_id: &str) -> String {
    let sql = {
        format!("select {}.* from {} left join {} on {}.{} = {}.{}",
                a, a, b, a, a_id, b, b_id
        )
    };
    sql
}