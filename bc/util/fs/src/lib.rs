#[macro_use]
extern crate serde_derive;
use log::debug;
use std::error::Error;
use std::fs::{File, DirBuilder};
use std::io::prelude::*;
use std::path::Path;
use std::time::{SystemTime, UNIX_EPOCH};

//计算输入的hash值，返回结果为hex方式编码的值
pub fn sha256(input: &[u8]) -> String {
    let mut sha256 = [0u8; 32];
    let mut keccak = tiny_keccak::Keccak::new_keccak256();
    keccak.update(input);
    keccak.finalize(&mut sha256);
    hex::encode(sha256)
}

//检测文件是否存在
pub fn check_file_exist(filename: &str) -> Option<File> {
    let file = File::open(filename);
    match file {
        Ok(file) => Some(file),
        Err(e) => {
            debug!("check file error:{}",e.to_string());
            None
        },
    }
}

//将数据写入在指定的文件中
pub fn write_file(filename: &str, data: &[u8]) -> Result<bool, String> {
    let path = Path::new(&filename);
    let display = path.display();
    // TODO 流程上需要检查该路径对应的目录是否存在,但是目前没有找到对应的简单方法来检查，暂时重新创建该目录，创建好目录后 再创建对应的文件
    let parent = path.parent().unwrap();
    if !parent.to_str().eq(&Some("")) {
        DirBuilder::new().recursive(true).create(parent).unwrap();
    }
    let mut file = match File::create(&path) {
        Err(why) => {
            // TODO 针对文件创建失败的处理方法，还需要再完善
            panic!("couldn't create {}: {}", display, why.description());
        }
        Ok(file) => file,
    };
    match file.write(data) {
        Ok(_) => match file.flush() {
            Ok(_) => Ok(true),
            Err(e) => Err(e.to_string()),
        },
        Err(e) => Err(e.to_string()),
    }
}

//根据路径，加载对应的文件数据
pub fn load_file(filename: &str) -> Result<Vec<u8>, String> {
    if filename.trim().eq("") {
        return Err("input path isn't correct ".to_string());
    }
    let path = Path::new(filename);
    if path.is_dir() {
        return Err("input path Is a directory".to_string());
    }

    let file = File::open(filename);
    let mut result = Vec::new();

    if file.is_ok() {
        let mut file = file.unwrap();

        file.read_to_end(&mut result).unwrap();
        Ok(result)
    } else {
        Err("file is not exist!".to_string())
    }
}

#[derive(Debug, Clone, Deserialize)]
pub struct Config {
    pub server: Option<ServerConfig>,
    pub database: Option<DatabaseConfig>,
}

#[derive(Debug, Clone, Deserialize)]
pub struct ServerConfig {
    pub addr: Option<Vec<String>>,
    pub port: Option<Vec<u16>>,
}

#[derive(Debug, Clone, Deserialize)]
pub struct DatabaseConfig {
    pub db_type: Option<String>,
    pub name: Option<String>,
    pub path: Option<String>,
}

//将指定路径的文件 转化为指定的toml格式数据进行解析
pub fn parse_config(path: &str) -> Result<Config, String> {
    if path.trim().eq("") {
        return Err("input path isn't correct ".to_string());
    }
    //"../Config.toml"
    let config_vec = load_file(path);
    config_vec.map(|data| {
        let config_data: Config = toml::from_slice(&data[..]).unwrap();
        config_data
    }).map_err(|e| e)
}

//获取当前时间的时间戳
pub fn get_time_ms() -> u64 {
    let time_now = SystemTime::now().duration_since(UNIX_EPOCH).unwrap();
    let time_now_ms = time_now.as_secs() * 1000 + time_now.subsec_nanos() as u64 / 1000_000;
    time_now_ms
}

#[cfg(test)]
mod tests {
    #[test]
    fn config_load() {
        super::parse_config("../Config.toml");
        assert_eq!(2, 4);
    }
}
