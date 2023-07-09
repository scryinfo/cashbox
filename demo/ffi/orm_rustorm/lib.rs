use std::ops::Add;
use std::os::raw::c_char;

// use chrono::{
//     offset::Utc,
//     DateTime,
//     NaiveDate,
// };
use rustorm::{DbError, FromDao, Pool, rustorm_dao, ToColumnNames, ToDao, ToTableName, Value};

#[no_mangle]
pub extern "C" fn tryRustOrm(name: *mut c_char) {
    #[cfg(target_os = "android")]shared::init_logger_once();
    mod for_insert {
        use super::*;

        #[derive(Debug, PartialEq, ToDao, ToColumnNames, ToTableName)]
        pub struct Actor {
            pub first_name: String,
            pub last_name: String,
        }
    }

    mod for_retrieve {
        use chrono::NaiveDateTime;

        use super::*;

        #[derive(Debug, FromDao, ToColumnNames, ToTableName)]
        pub struct Actor {
            pub actor_id: i64,
            pub first_name: String,
            pub last_name: String,
            pub last_update: NaiveDateTime,
        }
    }

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

    let mut pool = Pool::new();
    let mut em = pool.em(db_url).unwrap();

    {
        let sql = "drop table actor";
        let _ = em.db().execute_sql_with_return(sql, &[]);
    }
    let create_sql = "CREATE TABLE actor(
                actor_id integer PRIMARY KEY AUTOINCREMENT,
                first_name text,
                last_name text,
                last_update timestamp DEFAULT current_timestamp
        )";
    let ret = em.db().execute_sql_with_return(create_sql, &[]);
    if ret.is_err() {
        log::info!("ret: {:?}", ret);
    }

    assert!(ret.is_ok());
    let tom_cruise = for_insert::Actor {
        first_name: "TOM".into(),
        last_name: "CRUISE".to_string(),
    };
    let tom_hanks = for_insert::Actor {
        first_name: "TOM".into(),
        last_name: "HANKS".to_string(),
    };
    log::info!("tom_cruise: {:#?}", tom_cruise);
    log::info!("tom_hanks: {:#?}", tom_hanks);

    let actors = vec![tom_cruise, tom_hanks];

    for actor in actors {
        let first_name: Value = actor.first_name.into();
        let last_name: Value = actor.last_name.into();
        let ret = em.db().execute_sql_with_return(
            "INSERT INTO actor(first_name, last_name)
            VALUES ($1, $2)",
            &[&first_name, &last_name],
        );
        assert!(ret.is_ok());
    }

    let actors: Result<Vec<for_retrieve::Actor>, DbError> =
        em.execute_sql_with_return("SELECT * from actor", &[]);
    log::info!("Actor: {:#?}", actors);
    assert!(actors.is_ok());
}


#[cfg(test)]
mod tests {
    use crate::tryRustOrm;

    #[test]
    fn try_rustorm_test() {
        let url = shared::to_c_char("orm_rustorm.db");
        tryRustOrm(url);
        shared::Str_free(url);
    }
}
