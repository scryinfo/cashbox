use rbatis::crud::CRUDEnable;
use rbatis_macro_driver::CRUDEnable;
use serde::Deserialize;
use serde::Serialize;

use wallets_macro::{db_append_shared, DbBeforeSave, DbBeforeUpdate};

use crate::kits;
use crate::ma::db::{self, Shared};

/// 地址与token对应的balance
#[db_append_shared]
#[derive(Serialize, Deserialize, Clone, Debug, Default, CRUDEnable, DbBeforeSave, DbBeforeUpdate)]
pub struct TokenAddress {
    pub wallet_id: String,
    /// [crate::ChainType]
    pub chain_type: String,
    pub token_id: String,
    pub address_id: String,

    pub balance: String,
}

/// 没有对应的数据库表
#[derive(Serialize, Deserialize, Clone, Debug, Default)]
pub struct TxShared {
    pub tx_hash: String,
    pub block_hash: String,
    pub block_number: String,
    /// 交易的byte数据，不同链格式不一样
    pub tx_bytes: String,
}

