use serde::{Deserialize, Serialize};

use wallets_macro::{db_append_shared, db_sub_struct, DbBeforeSave, DbBeforeUpdate};

mod dao {
    pub trait Shared {
        fn get_id(&self) -> String;
        fn set_id(&mut self, id: String);
        fn get_create_time(&self) -> i64;
        fn set_create_time(&mut self, create_time: i64);
        fn get_update_time(&self) -> i64;
        fn set_update_time(&mut self, update_time: i64);

        fn table_name() -> String;
    }

    pub trait BeforeSave {
        fn before_save(&mut self);
    }

    pub trait BeforeUpdate {
        fn before_update(&mut self);
    }
}

use dao::{Shared};
// use kits;
// , DbBeforeSave, DbBeforeUpdate
#[db_append_shared()]
#[derive(Serialize, Deserialize, Debug, Default)]
struct Big {
    #[serde(default)]
    pub name: String,
    #[serde(flatten)]
    pub sub: Sub,
}

#[db_sub_struct]
#[derive(Serialize, Deserialize, Debug, Default)]
struct Sub {
    #[serde(default)]
    pub count: u64,
}

#[test]
fn dl_default_test() {}