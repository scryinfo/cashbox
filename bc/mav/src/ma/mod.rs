#![feature(unboxed_closures)]

mod mnemonic;
mod detail;
mod detail_eth;
mod detail_eee;
mod detail_btc;
mod data;
mod data_eth;
mod data_eee;
mod data_btc;

// pub mod db_shared;

pub use crate::ma::mnemonic::{Mnemonic};

pub use crate::ma::detail::{Wallet, TokenShared};
pub use crate::ma::detail_eth::{EthChainTokenAuth, EthChainTokenDefault};

pub use crate::ma::data::{TokenAddress, TxShared};
pub use crate::ma::data_eth::{EthErc20Face, EthChainToken, EthErc20Tx, EthChainTx};

use rbatis::rbatis::Rbatis;
use rbatis::crud::{CRUDEnable, CRUD};
use rbatis::core::db_adapter::DBExecResult;
use rbatis::wrapper::Wrapper;
use rbatis::core::Result;
use async_trait::async_trait;
use crate::kits;
use std::future::Future;

pub trait  DbBase {
    fn get_id(&self)->String;
    fn set_id(&mut self, id: String);
    fn get_create_time(&self) ->i64;
    fn set_create_time(&mut self, createTime: i64) ;
    fn get_update_time(&self) ->i64;
    fn set_update_time(&mut self, updateTime: i64);
}

#[async_trait]
pub trait DbModel<T: CRUDEnable + DbBase>{
    async fn save(&mut self, rb: &rbatis::rbatis::Rbatis, tx_id: &str) -> Result<DBExecResult> ;
    async fn save_batch(rb: &rbatis::rbatis::Rbatis, tx_id: &str, entity: &mut [T]) -> Result<DBExecResult> ;

    async fn remove_by_wrapper(rb: &rbatis::rbatis::Rbatis, tx_id: &str, w: &Wrapper) -> Result<u64> where T: 'async_trait;
    async fn remove_by_id(rb: &rbatis::rbatis::Rbatis, tx_id: &str, id: &T::IdType) -> Result<u64>  where T: 'async_trait;
    async fn remove_batch_by_id(rb: &rbatis::rbatis::Rbatis, tx_id: &str, ids: &[T::IdType]) -> Result<u64> where T: 'async_trait;

    async fn update_by_wrapper(&mut self, rb: &rbatis::rbatis::Rbatis, tx_id: &str, w: &Wrapper, update_null_value: bool) -> Result<u64>;
    async fn update_by_id(&mut self, rb: &rbatis::rbatis::Rbatis, tx_id: &str) -> Result<u64> ;
    async fn update_batch_by_id(rb: &rbatis::rbatis::Rbatis, tx_id: &str, ids: &mut [T]) -> Result<u64> ;
}

#[async_trait]
impl<T> DbModel<T> for T where
    T: CRUDEnable + DbBase,
{

    async fn save(&mut self, rb: &Rbatis, tx_id: &str) -> Result<DBExecResult> {
        if self.get_id().is_empty() {
            self.set_id(kits::uuid());
            self.set_update_time(kits::now_ts_seconds());
            self.set_create_time(self.get_update_time());
        }else{
            self.set_update_time(kits::now_ts_seconds());
        }
        rb.save(tx_id, self).await
    }

    async fn save_batch(rb: &Rbatis, tx_id: &str, entity: &mut [T]) -> Result<DBExecResult>  {
        for it in entity.into_iter() {
            if it.get_id().is_empty() {
                it.set_id(kits::uuid());
                it.set_update_time(kits::now_ts_seconds());
                it.set_create_time(it.get_update_time());
            }else{
                it.set_update_time(kits::now_ts_seconds());
            }
        }
        rb.save_batch(tx_id, entity).await
    }

    async fn remove_by_wrapper(rb: &Rbatis, tx_id: &str, w: &Wrapper) -> Result<u64> where T: 'async_trait {
        // self.set_update_time(kits::now_ts_seconds());
        // rb.remove_by_wrapper::<T>::(tx_id,w).await
        // rb.remove_by_wrapper::<T>::(tx_id,w).await
        unimplemented!()
    }

    async fn remove_by_id(rb: &Rbatis, tx_id: &str, id: &T::IdType) -> Result<u64>  where T: 'async_trait {
        unimplemented!()
    }

    async fn remove_batch_by_id(rb: &Rbatis, tx_id: &str, ids: &[T::IdType]) -> Result<u64> where T: 'async_trait {
        unimplemented!()
    }

    async fn update_by_wrapper(&mut self, rb: &Rbatis, tx_id: &str,w: &Wrapper, update_null_value: bool) -> Result<u64>  {
        rb.update_by_wrapper(tx_id,self, w,update_null_value).await
    }

    async fn update_by_id(&mut self, rb: &Rbatis, tx_id: &str) -> Result<u64>  {
        rb.update_by_id(tx_id,self).await
    }

    async fn update_batch_by_id(rb: &Rbatis, tx_id: &str, ids: &mut [T]) -> Result<u64>  {
        rb.update_batch_by_id(tx_id, ids).await
    }
}
