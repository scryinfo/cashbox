use serde::{Deserialize, Serialize};

use dao::Shared;
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

    // pub type RBatisExResult = std::result::Result<rbatis::rbdc::db::ExecResult, rbatis::rbdc::Error>;
    //
    // #[async_trait]
    // pub trait CrudC<T> {
    //     async fn insert(rb: &mut dyn rbatis::executor::Executor, m: &T) -> RBatisExResult;
    //     async fn insert_batch(rb: &mut dyn rbatis::executor::Executor, ms: &[T]) -> RBatisExResult;
    // }
}

mod kits {
    use rbatis::rbdc::uuid::Uuid;

    pub fn uuid() -> String {
        Uuid::new().to_string()
    }

    pub fn now_ts_seconds() -> i64 {
        chrono::offset::Utc::now().timestamp()
    }
}

//
#[db_append_shared()]
#[derive(Serialize, Deserialize, Debug, Default, Clone, DbBeforeSave, DbBeforeUpdate)]
pub struct Big {
    #[serde(default)]
    pub name: String,
    #[serde(flatten)]
    pub sub: Sub,
    #[serde(skip)]
    pub temp: i64,
}

#[db_sub_struct]
#[derive(Serialize, Deserialize, Debug, Default, Clone)]
pub struct Sub {
    #[serde(default)]
    pub count: u64,
}

rbatis::crud!(Big{});

#[test]
fn dl_default_test() {}