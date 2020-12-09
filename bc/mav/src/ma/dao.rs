use async_trait::async_trait;
use rbatis::core::db::DBExecResult;
use rbatis::core::Result;
use rbatis::crud::{CRUD, CRUDEnable};
use rbatis::plugin::page::{IPageRequest, Page};
use rbatis::rbatis::Rbatis;
use rbatis::wrapper::Wrapper;
use serde::{de, Deserialize, Deserializer};
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
}

pub trait BeforeSave {
    fn before_save(&mut self);
}

pub trait BeforeUpdate {
    fn before_update(&mut self);
}

#[async_trait]
pub trait Dao<T: CRUDEnable + Shared> {
    async fn save(&mut self, rb: &rbatis::rbatis::Rbatis, tx_id: &str) -> Result<DBExecResult>;
    async fn save_batch(rb: &rbatis::rbatis::Rbatis, tx_id: &str, ms: &mut [T]) -> Result<DBExecResult>;

    async fn remove_by_wrapper(rb: &rbatis::rbatis::Rbatis, tx_id: &str, w: &Wrapper) -> Result<u64> where T: 'async_trait;
    async fn remove_by_id(rb: &rbatis::rbatis::Rbatis, tx_id: &str, id: &T::IdType) -> Result<u64> where T: 'async_trait;
    async fn remove_batch_by_id(rb: &rbatis::rbatis::Rbatis, tx_id: &str, ids: &[T::IdType]) -> Result<u64> where T: 'async_trait;

    async fn update_by_wrapper(&mut self, rb: &rbatis::rbatis::Rbatis, tx_id: &str, w: &Wrapper, update_null_value: bool) -> Result<u64>;
    async fn update_by_id(&mut self, rb: &rbatis::rbatis::Rbatis, tx_id: &str) -> Result<u64>;
    async fn update_batch_by_id(rb: &rbatis::rbatis::Rbatis, tx_id: &str, ids: &mut [T]) -> Result<u64>;

    async fn fetch_by_wrapper(rb: &rbatis::rbatis::Rbatis, tx_id: &str, w: &Wrapper) -> Result<T> where T: 'async_trait;
    async fn fetch_by_id(rb: &rbatis::rbatis::Rbatis, tx_id: &str, id: &T::IdType) -> Result<T> where T: 'async_trait;
    async fn fetch_page_by_wrapper(rb: &rbatis::rbatis::Rbatis, tx_id: &str, w: &Wrapper, page: &dyn IPageRequest) -> Result<Page<T>> where T: 'async_trait;

    ///fetch all record
    async fn list(rb: &rbatis::rbatis::Rbatis, tx_id: &str) -> Result<Vec<T>> where T: 'async_trait;
    async fn list_by_wrapper(rb: &rbatis::rbatis::Rbatis, tx_id: &str, w: &Wrapper) -> Result<Vec<T>> where T: 'async_trait;
    async fn list_by_ids(rb: &rbatis::rbatis::Rbatis, tx_id: &str, ids: &[T::IdType]) -> Result<Vec<T>> where T: 'async_trait;
}

#[async_trait]
impl<T> Dao<T> for T where
    T: CRUDEnable + Shared + BeforeSave + BeforeUpdate,
{
    async fn save(&mut self, rb: &Rbatis, tx_id: &str) -> Result<DBExecResult> {
        self.before_save();
        rb.save(tx_id, self).await
    }

    async fn save_batch(rb: &Rbatis, tx_id: &str, ms: &mut [T]) -> Result<DBExecResult> {
        for it in ms.into_iter() {
            it.before_save();
        }
        rb.save_batch(tx_id, ms).await
    }

    async fn remove_by_wrapper(rb: &Rbatis, tx_id: &str, w: &Wrapper) -> Result<u64> where T: 'async_trait {
        // self.set_update_time(kits::now_ts_seconds());
        rb.remove_by_wrapper::<T>(tx_id, w).await
    }

    async fn remove_by_id(rb: &Rbatis, tx_id: &str, id: &T::IdType) -> Result<u64> where T: 'async_trait {
        rb.remove_by_id::<T>(tx_id, id).await
    }

    async fn remove_batch_by_id(rb: &Rbatis, tx_id: &str, ids: &[T::IdType]) -> Result<u64> where T: 'async_trait {
        rb.remove_batch_by_id::<T>(tx_id, ids).await
    }

    async fn update_by_wrapper(&mut self, rb: &Rbatis, tx_id: &str, w: &Wrapper, update_null_value: bool) -> Result<u64> {
        self.before_update();
        rb.update_by_wrapper(tx_id, self, w, update_null_value).await
    }

    async fn update_by_id(&mut self, rb: &Rbatis, tx_id: &str) -> Result<u64> {
        self.before_update();
        rb.update_by_id(tx_id, self).await
    }

    async fn update_batch_by_id(rb: &Rbatis, tx_id: &str, ids: &mut [T]) -> Result<u64> {
        for it in ids.iter_mut() {
            it.before_update();
        }
        rb.update_batch_by_id(tx_id, ids).await
    }

    async fn fetch_by_wrapper(rb: &Rbatis, tx_id: &str, w: &Wrapper) -> Result<T> where T: 'async_trait {
        rb.fetch_by_wrapper(tx_id, w).await
    }

    async fn fetch_by_id(rb: &Rbatis, tx_id: &str, id: &T::IdType) -> Result<T> where T: 'async_trait {
        rb.fetch_by_id(tx_id, id).await
    }

    async fn fetch_page_by_wrapper(rb: &Rbatis, tx_id: &str, w: &Wrapper, page: &dyn IPageRequest) -> Result<Page<T>> where T: 'async_trait {
        rb.fetch_page_by_wrapper(tx_id, w, page).await
    }

    async fn list(rb: &Rbatis, tx_id: &str) -> Result<Vec<T>> where T: 'async_trait {
        rb.list(tx_id).await
    }

    async fn list_by_wrapper(rb: &Rbatis, tx_id: &str, w: &Wrapper) -> Result<Vec<T>> where T: 'async_trait {
        rb.list_by_wrapper(tx_id, w).await
    }

    async fn list_by_ids(rb: &Rbatis, tx_id: &str, ids: &[T::IdType]) -> Result<Vec<T>> where T: 'async_trait {
        rb.list_by_ids(tx_id, ids).await
    }
}

pub fn bool_from_int<'de, D>(deserializer: D) -> std::result::Result<bool, D::Error>
    where
        D: Deserializer<'de>,
{
    match i32::deserialize(deserializer)? {
        0 => Ok(false),
        1 => Ok(true),
        other => Err(de::Error::invalid_value(
            Unexpected::Unsigned(other as u64),
            &"zero or one",
        )),
    }
}

#[cfg(test)]
pub mod test {
    use std::fs;
    use std::ops::Add;

    use rbatis::rbatis::Rbatis;

    #[allow(dead_code)]
    pub async fn init_memory(sql: Option<&str>) -> Rbatis {
        let rb = Rbatis::new();
        let url = "sqlite://:memory:";
        let r = rb.link(url).await;
        assert_eq!(false, r.is_err(), "{:?}", r);
        if sql.is_some() {
            let r = rb.exec("", sql.unwrap()).await;
            assert_eq!(false, r.is_err(), "{:?}", r);
        }
        return rb;
    }

    #[allow(dead_code)]
    pub async fn init_rbatis(db_file_name: Option<&str>, sql: Option<&str>) -> Rbatis {
        let db_file_name = db_file_name.unwrap_or("wallets_ma.db");
        if fs::metadata(db_file_name).is_err() {
            let file = std::fs::File::create(db_file_name);
            if file.is_err() {
                log::info!("{:?}", file.err().unwrap());
            }
        }
        let rb = Rbatis::new();
        let url = "sqlite://".to_owned().add(db_file_name);
        let r = rb.link(url.as_str()).await;
        assert_eq!(false, r.is_err());

        if sql.is_some() {
            let r = rb.exec("", sql.unwrap()).await;
            assert_eq!(false, r.is_err());
        }
        return rb;
    }
}
