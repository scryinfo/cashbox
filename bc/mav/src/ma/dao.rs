use serde::{de, Deserialize, Deserializer, Serializer};
use serde::de::Unexpected;

pub use crate::ma::data::{MTokenAddress, TxShared};
pub use crate::ma::data_eth::{EthErc20Face, MEthChainToken, MEthChainTx, MEthErc20Tx};
pub use crate::ma::detail::{MTokenShared, MWallet};
pub use crate::ma::detail_eth::{MEthChainTokenAuth, MEthChainTokenDefault};
pub use crate::ma::mnemonic::MMnemonic;

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

pub type RBatisExResult = std::result::Result<rbatis::rbdc::db::ExecResult, rbatis::rbdc::Error>;

// #[async_trait]
// pub trait CrudC<T> {
//     async fn insert(rb: &mut dyn rbatis::executor::Executor, m: &T) -> RBatisExResult;
//     async fn insert_batch(rb: &mut dyn rbatis::executor::Executor, ms: &[T], batch_size: u64) -> RBatisExResult;
// }

// #[async_trait]
// pub trait Dao<T: Shared + CrudC<T>> {
//     /// 调用 before_save 然后 insert 到数据 database,
//     async fn save(&mut self, rb: &mut dyn rbatis::executor::Executor) -> RBatisExResult;
//     /// 调用 before_save 然后 insert 到数据 database,
//     async fn save_batch(rb: &mut dyn rbatis::executor::Executor, ms: &mut [T]) -> RBatisExResult;
//     /// 如果id为空，调用save，
//     /// 如果id不为空，调用update_by_id, 且 last_insert_id为none
//     async fn save_update(&mut self, rb: &RBatis, tx_id: &str) -> rbatis::Result<ExecResult>;
//
//     async fn remove_by_wrapper(rb: &RBatis, tx_id: &str, w: &Wrapper) -> Result<u64> where T: 'async_trait;
//     async fn remove_by_id(rb: &RBatis, tx_id: &str, id: &T::IdType) -> Result<u64> where T: 'async_trait;
//     async fn remove_batch_by_id(rb: &RBatis, tx_id: &str, ids: &[T::IdType]) -> Result<u64> where T: 'async_trait;
//
//     /// 调用 before_update 然后 update 到数据 database,
//     async fn update_by_wrapper(&mut self, rb: &RBatis, tx_id: &str, w: &Wrapper, update_null_value: bool) -> Result<u64>;
//     /// 调用 before_update 然后 update 到数据 database,
//     async fn update_by_id(&mut self, rb: &RBatis, tx_id: &str) -> Result<u64>;
//     /// 调用 before_update 然后 update 到数据 database,
//     async fn update_batch_by_id(rb: &RBatis, tx_id: &str, ids: &mut [T]) -> Result<u64>;
//
//     /// 查询唯一的一条记录，如果记录大于1条或没有，都会报错
//     async fn fetch_by_wrapper(rb: &RBatis, tx_id: &str, w: &Wrapper) -> Result<Option<T>> where T: 'async_trait;
//     /// 查询唯一的一条记录，如果记录大于1条或没有，都会报错
//     async fn fetch_by_id(rb: &RBatis, tx_id: &str, id: &T::IdType) -> Result<Option<T>> where T: 'async_trait;
//     async fn fetch_page_by_wrapper(rb: &RBatis, tx_id: &str, w: &Wrapper, page: &dyn IPageRequest) -> Result<Page<T>> where T: 'async_trait;
//
//     ///fetch all record
//     async fn list(rb: &RBatis, tx_id: &str) -> Result<Vec<T>> where T: 'async_trait;
//     async fn list_by_wrapper(rb: &RBatis, tx_id: &str, w: &Wrapper) -> Result<Vec<T>> where T: 'async_trait;
//     async fn list_by_ids(rb: &RBatis, tx_id: &str, ids: &[T::IdType]) -> Result<Vec<T>> where T: 'async_trait;
//
//     ///使用 exist检查是否有数据
//     async fn exist_by_wrapper(rb: &RBatis, tx_id: &str, w: &Wrapper) -> Result<bool> where T: 'async_trait;
//     ///使用count计算数据的条数
//     async fn count_by_wrapper(rb: &RBatis, tx_id: &str, w: &Wrapper) -> Result<i64> where T: 'async_trait;
// }

//
// #[async_trait]
// impl<T> Dao<T> for T where
//     T: Shared + BeforeSave + BeforeUpdate + CrudC<T>,
// {
//     async fn save(&mut self, rb: &mut dyn rbatis::executor::Executor) -> RBatisExResult {
//         self.before_save();
//         T::insert(rb, &self).await
//     }
//
//     async fn save_batch(rb: &mut dyn rbatis::executor::Executor, ms: &mut [T]) -> RBatisExResult {
//         for it in ms.iter_mut() {
//             it.before_save();
//         }
//         T::insert_batch(rb, ms).await
//     }
//
//     async fn save_update(&mut self, rb: &RBatis, tx_id: &str) -> Result<DBExecResult> {
//         if Shared::get_id(self).is_empty() {
//             self.save(rb, tx_id).await
//         } else {
//             let r = self.update_by_id(rb, tx_id).await?;
//             Ok(DBExecResult {
//                 rows_affected: r,
//                 last_insert_id: None,
//             })
//         }
//     }
//
//     async fn remove_by_wrapper(rb: &RBatis, tx_id: &str, w: &Wrapper) -> Result<u64> where T: 'async_trait {
//         // self.set_update_time(kits::now_ts_seconds());
//         rb.remove_by_wrapper::<T>(tx_id, w).await
//     }
//
//     async fn remove_by_id(rb: &RBatis, tx_id: &str, id: &T::IdType) -> Result<u64> where T: 'async_trait {
//         rb.remove_by_id::<T>(tx_id, id).await
//     }
//
//     async fn remove_batch_by_id(rb: &RBatis, tx_id: &str, ids: &[T::IdType]) -> Result<u64> where T: 'async_trait {
//         rb.remove_batch_by_id::<T>(tx_id, ids).await
//     }
//
//     async fn update_by_wrapper(&mut self, rb: &RBatis, tx_id: &str, w: &Wrapper, update_null_value: bool) -> Result<u64> {
//         self.before_update();
//         rb.update_by_wrapper(tx_id, self, w, update_null_value).await
//     }
//
//     async fn update_by_id(&mut self, rb: &RBatis, tx_id: &str) -> Result<u64> {
//         self.before_update();
//         rb.update_by_id(tx_id, self).await
//     }
//
//     async fn update_batch_by_id(rb: &RBatis, tx_id: &str, ids: &mut [T]) -> Result<u64> {
//         for it in ids.iter_mut() {
//             it.before_update();
//         }
//         rb.update_batch_by_id(tx_id, ids).await
//     }
//
//     async fn fetch_by_wrapper(rb: &RBatis, tx_id: &str, w: &Wrapper) -> Result<Option<T>> where T: 'async_trait {
//         rb.fetch_by_wrapper(tx_id, w).await
//     }
//
//     async fn fetch_by_id(rb: &RBatis, tx_id: &str, id: &T::IdType) -> Result<Option<T>> where T: 'async_trait {
//         rb.fetch_by_id(tx_id, id).await
//     }
//
//     async fn fetch_page_by_wrapper(rb: &RBatis, tx_id: &str, w: &Wrapper, page: &dyn IPageRequest) -> Result<Page<T>> where T: 'async_trait {
//         rb.fetch_page_by_wrapper(tx_id, w, page).await
//     }
//
//     async fn list(rb: &RBatis, tx_id: &str) -> Result<Vec<T>> where T: 'async_trait {
//         rb.fetch_list(tx_id).await
//         // rb.list(tx_id).await
//     }
//
//     async fn list_by_wrapper(rb: &RBatis, tx_id: &str, w: &Wrapper) -> Result<Vec<T>> where T: 'async_trait {
//         rb.fetch_list_by_wrapper(tx_id, w).await
//     }
//
//     async fn list_by_ids(rb: &RBatis, tx_id: &str, ids: &[T::IdType]) -> Result<Vec<T>> where T: 'async_trait {
//         rb.fetch_list_by_ids(tx_id, ids).await
//     }
//
//     async fn exist_by_wrapper(rb: &RBatis, tx_id: &str, w: &Wrapper) -> Result<bool> where T: 'async_trait {
//         let w = w.clone();
//         let sql = {
//             if w.sql.is_empty() {
//                 format!("SELECT EXISTS ( SELECT 1 FROM {} )", T::table_name())
//             } else {
//                 format!("SELECT EXISTS ( SELECT 1 FROM {} WHERE {} )", T::table_name(), w.sql)
//             }
//         };
//         let re: i32 = rb.fetch_prepare(tx_id, &sql, &w.args).await?;
//         Ok(re != 0)
//     }
//     async fn count_by_wrapper(rb: &RBatis, tx_id: &str, w: &Wrapper) -> Result<i64> where T: 'async_trait {
//         let w = w.clone();
//         let sql = {
//             if w.sql.is_empty() {
//                 format!("SELECT COUNT(*) FROM {} ", T::table_name())
//             } else {
//                 format!("SELECT COUNT(*) FROM {} WHERE {} ", T::table_name(), w.sql)
//             }
//         };
//         let re: i64 = rb.fetch_prepare(tx_id, &sql, &w.args).await?;
//         Ok(re)
//     }
// }

pub fn bool_from_u32<'de, D>(deserializer: D) -> std::result::Result<bool, D::Error>
    where D: Deserializer<'de>,
{
    match u32::deserialize(deserializer)? {
        crate::CFalse => Ok(false),
        crate::CTrue => Ok(true),
        other => Err(de::Error::invalid_value(
            Unexpected::Unsigned(other as u64),
            &"zero or one",
        )),
    }
}

pub fn bool_to_u32<S>(x: &bool, s: S) -> std::result::Result<S::Ok, S::Error>
    where S: Serializer,
{
    let b = {
        if *x {
            crate::CTrue
        } else {
            crate::CFalse
        }
    };
    s.serialize_u32(b)
}