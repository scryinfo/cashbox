#[macro_use]
extern crate rbatis_macro_driver;

use std::os::raw::c_char;
use async_std::task::block_on;
use rbatis::rbatis::Rbatis;
use rbatis::crud::{CRUD, CRUDTable};
use chrono::NaiveDateTime;
use rbatis_core::value::DateTimeNow;
use std::ops::Add;
use serde::{Deserialize, Serialize};
use shared::to_str;

#[derive(CRUDTable, Serialize, Deserialize, Clone, Debug)]
pub struct BizActivity {
    pub id: Option<String>,
    pub name: Option<String>,
    pub pc_link: Option<String>,
    pub h5_link: Option<String>,
    pub pc_banner_img: Option<String>,
    pub h5_banner_img: Option<String>,
    pub sort: Option<String>,
    pub status: Option<i32>,
    pub remark: Option<String>,
    pub create_time: Option<NaiveDateTime>,
    pub version: Option<i32>,
    pub delete_flag: Option<i32>,
}

async fn init_rbatis(db_file_name: &str) -> Rbatis {
    log::info!("init_rbatis");
    if std::fs::metadata(db_file_name).is_err() {
        let file = std::fs::File::create(db_file_name);
        if file.is_err() {
            log::info!("{:?}",file.err().unwrap());
        }
    }
    let rb = Rbatis::new();
    let url = "sqlite://".to_owned().add(db_file_name);
    log::info!("{:?}",url);
    let r = rb.link(url.as_str()).await;
    if r.is_err() {
        log::info!("{:?}",r.err().unwrap());
    }

    return rb;
}

#[no_mangle]
pub extern "C" fn tryRbatis(name: *mut c_char) {
    #[cfg(target_os = "android")]shared::init_logger_once();
    log::info!("start");

    let rb = block_on(init_rbatis(to_str(name)));
    let sql = "\
        CREATE TABLE `biz_activity` (
                                `id` varchar(50) NOT NULL DEFAULT '',
                                `name` varchar(255) NOT NULL,
                                `pc_link` varchar(255) DEFAULT NULL,
                                `h5_link` varchar(255) DEFAULT NULL,
                                `sort` varchar(255) NOT NULL ,
                                `status` int(11) NOT NULL ,
                                `version` int(11) NOT NULL,
                                `remark` varchar(255) DEFAULT NULL,
                                `create_time` datetime NOT NULL,
                                `delete_flag` int(1) NOT NULL,
                                `pc_banner_img` varchar(255) DEFAULT NULL,
                                `h5_banner_img` varchar(255) DEFAULT NULL,
                                PRIMARY KEY (`id`) ) ;";
    let r = block_on(rb.exec("", sql));
    if r.is_err() {
        log::info!("{:?}",r.err().unwrap());
    }
    let activity = BizActivity {
        id: Some("12312".to_string()),
        name: Some("123".to_string()),
        pc_link: None,
        h5_link: None,
        pc_banner_img: None,
        h5_banner_img: None,
        sort: Some("1".to_string()),
        status: Some(1),
        remark: None,
        create_time: Some(NaiveDateTime::now()),
        version: Some(1),
        delete_flag: Some(1),
    };
    let r = block_on(rb.save("", &activity));
    if r.is_err() {
        log::info!("{:?}",r.err().unwrap());
    }
    let sql = "select count(*) from biz_activity";
    let r = block_on(rb.exec("", sql));
    match r {
        Ok(a) => {
            log::info!("{:?}",a);
        }
        Err(e) => {
            log::info!("{:?}",e);
        }
    }
}


#[cfg(test)]
mod tests {
    use crate::tryRbatis;

    #[test]
    fn rbatis_test() {
        let url = shared::to_c_char("orm_rbatis.db");
        tryRbatis(url);
        shared::Str_free(url);
    }
}
