
use rbatis::crud::CRUDEnable;
use serde::Deserialize;
use serde::Serialize;
use wallets_macro::{db_append_shared, DbBeforeSave, DbBeforeUpdate};

use crate::kits;
use crate::ma::db::{self, Shared};
use crate::ma::TxShared;

//eee
#[db_append_shared]
#[derive(Serialize, Deserialize, Clone, Debug, Default, CRUDEnable, DbBeforeSave, DbBeforeUpdate)]
pub struct EeeChainToken {
    pub next_id: String,
    /// 手动加入的token就没有token shared内容
    /// [crate::db::EeeChainTokenShared]
    pub chain_token_shared_id: Option<String>,

    /// [crate::db::Wallet]
    pub wallet_id: String,
    /// [crate::ChainType]
    pub chain_type: String,
    /// 是否显示
    pub show: bool,
    /// 糖度
    pub decimal: i32,
}

/// eee chain的交易
#[db_append_shared]
#[derive(Serialize, Deserialize, Clone, Debug, Default, CRUDEnable, DbBeforeSave, DbBeforeUpdate)]
pub struct EeeChainTx {
    pub tx_shared: TxShared,

    //from是数据库的关键字，所以加上 address
    pub from_address: String,
    pub to_address: String,
    pub value: String,

    // ....

    /// [crate::TxStatus]
    pub status: String,

    /// 扩展数据
    pub extension: String,
}

#[db_append_shared]
#[derive(Serialize, Deserialize, Clone, Debug, Default, CRUDEnable, DbBeforeSave, DbBeforeUpdate)]
pub struct EeeTokenxTx {
    pub tx_shared: TxShared,

    //from是数据库的关键字，所以加上 address
    pub from_address: String,
    pub to_address: String,
    pub value: String,

    // ....

    /// [crate::TxStatus]
    pub status: String,

    /// 扩展数据
    pub extension: String,
}

//eee end
