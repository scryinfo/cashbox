#[macro_use]
extern crate diesel;

extern crate serde_derive;
extern crate serde_json;

pub mod models;
pub mod schema;

use diesel::prelude::*;
use std::os::raw::c_char;
use std::ops::Add;
use diesel::connection::SimpleConnection;
use diesel::insert_into;
use crate::models::Post;

pub fn establish_connection(db_url: &str) -> SqliteConnection {
    SqliteConnection::establish(db_url)
        .unwrap_or_else(|_| panic!("Error connecting to {}", db_url))
}

#[no_mangle]
pub extern "C" fn tryDiesel(name: *mut c_char) {
    use crate::schema::posts::dsl::posts;
    #[cfg(target_os = "android")]shared::init_logger_once();

    log::info!("tryDiesel");
    let db_name = shared::to_str(name);
    if std::fs::metadata(db_name).is_err() {
        let file = std::fs::File::create(db_name);
        if file.is_err() {
            log::info!("{:?}", file.err().unwrap());
        }
    }
    let db_url = "".to_owned().add(db_name);
    let db_url = db_url.as_str();

    let con = establish_connection(db_url);

    {
        let sql = "drop table posts";
        let _ = con.batch_execute(sql);
    }
    let create_sql = "CREATE TABLE posts (
  id INTEGER NOT NULL PRIMARY KEY,
  title VARCHAR NOT NULL,
  body TEXT NOT NULL,
  published BOOLEAN NOT NULL DEFAULT 0
)";
    let ret = con.batch_execute(create_sql);
    if ret.is_err() {
        log::info!("ret: {:?}", ret);
    }

    assert!(ret.is_ok());
    let ret = insert_into(posts).values(&Post {
        id: 1,
        title: "sdf".to_owned(),
        body: "d".to_owned(),
        published: false,
    }).execute(&con);
    if ret.is_err() {
        log::info!("ret: {:?}", ret);
    }
    let ret = posts.limit(1).load::<Post>(&con);
    if ret.is_err() {
        log::info!("ret: {:?}", ret);
    }
}

#[cfg(test)]
mod tests {
    use crate::tryDiesel;

    #[test]
    fn tryDiesel_test() {
        let url = shared::to_c_char("orm_diesel.db");
        tryDiesel(url);
        shared::Str_free(url);
    }
}

