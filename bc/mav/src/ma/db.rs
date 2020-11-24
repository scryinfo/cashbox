use async_trait::async_trait;
use rbatis::core::db_adapter::DBExecResult;
use rbatis::core::Result;
use rbatis::crud::{CRUD, CRUDEnable};
use rbatis::rbatis::Rbatis;
use rbatis::wrapper::Wrapper;

pub use crate::ma::data::{TokenAddress, TxShared};
pub use crate::ma::data_eth::{EthChainToken, EthChainTx, EthErc20Face, EthErc20Tx};
pub use crate::ma::detail::{TokenShared, Wallet};
pub use crate::ma::detail_eth::{EthChainTokenAuth, EthChainTokenDefault};
pub use crate::ma::mnemonic::Mnemonic;

// pub mod db_shared;

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
}
