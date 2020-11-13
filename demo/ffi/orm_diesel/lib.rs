
use std::os::raw::c_char;
use chrono::{
    offset::Utc,
    DateTime,
    NaiveDate,
};

use diesel::{SqliteConnection, Connection, insert_into};
use chrono::NaiveDateTime;
use diesel::prelude::*;
use diesel::sqlite::Sqlite;
use serde_derive::Deserialize;
use std::error::Error;

#[derive(Queryable)]
pub struct Post {
    pub id: i32,
    pub title: String,
    pub body: String,
    pub published: bool,
}

diesel::table! {
    posts (id) {
        id -> Integer,
        title -> Text,
        body -> Text,
        published -> Bool,
    }
}

#[no_mangle]
pub extern "C" fn tryDiesel(name: *mut c_char) {
    #[cfg(target_os = "android")]shared::init_logger_once();
    log::info!("tryRustOrm");
    let db_name = shared::to_str(name);
    if std::fs::metadata(db_name).is_err() {
        let file = std::fs::File::create(db_name);
        if file.is_err() {
            log::info!("{:?}",file.err().unwrap());
        }
    }
    let db_url = "sqlite://".to_owned().add(db_name);
    let db_url = db_url.as_str();

    let mut con = SqliteConnection::establish(&db_url).unwrap_or_else(|_| log::info!("Error connecting to {}", db_url));
    {
        let sql = "drop table posts";
        con.batch_execute(sql);
    }
    let create_sql = "CREATE TABLE posts (
  id INTEGER NOT NULL PRIMARY KEY,
  title VARCHAR NOT NULL,
  body TEXT NOT NULL,
  published BOOLEAN NOT NULL DEFAULT 0 )";
    let ret = con.batch_execute(create_sql);
    if ret.is_err() {
        log::info!("ret: {:?}", ret);
    }

    let ret = insert_into(posts::dsl::posts).values(&Post{
        id:1,
        title:"title".to_owned(),
        body:"body".to_owned(),
        published: false,

    }).execute(&con);

    if ret.is_err() {
        log::info!("ret: {:?}", ret);
    }
}


#[cfg(test)]
mod tests {
    use crate::tryRustOrm;

    #[test]
    fn try_rustorm_test() {
        let url = shared::to_c_char("rustorm_db");
        tryRustOrm(url);
        shared::Str_free(url);

    }
}
