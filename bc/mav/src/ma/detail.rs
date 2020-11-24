use rbatis::crud::CRUDEnable;
use serde::Deserialize;
use serde::Serialize;
use wallets_macro::{db_append_shared, DbBeforeSave, DbBeforeUpdate};

use crate::kits;
use crate::ma::db::{self, Shared};

#[db_append_shared]
#[derive(Serialize, Deserialize, Clone, Debug, Default, CRUDEnable, DbBeforeSave, DbBeforeUpdate)]
pub struct Wallet {
    //下一个显示顺序的 wallet_id
    pub next_id: String,
    pub full_name: String,
    pub mnemonic_digest: String,
    pub mnemonic: String,
    /// [crate::WalletType]
    pub wallet_type: String,
    /// [crate::NetType]
    pub net_type: String,
}

//每一种链类型一条记录，
#[db_append_shared]
#[derive(Serialize, Deserialize, Clone, Debug, Default, CRUDEnable, DbBeforeSave, DbBeforeUpdate)]
pub struct ChainTypeMeta {
    /// [crate::ChainType]
    pub chain_type: String,
    pub short_name: String,
    pub full_name: String,
}

#[db_append_shared]
#[derive(Serialize, Deserialize, Clone, Debug, Default, CRUDEnable, DbBeforeSave, DbBeforeUpdate)]
pub struct Address {
    /// [Wallet]
    pub wallet_id: String,
    /// [crate::ChainType]
    pub chain_type: String,
    pub address: String,
    pub public_key: String,
    /// 是否为钱包地址
    pub wallet_address: bool,
}

/// 动态库自己的配置，并不指app的配置
/// todo app的配置是否要放到这里？
#[db_append_shared]
#[derive(Serialize, Deserialize, Clone, Debug, Default, CRUDEnable, DbBeforeSave, DbBeforeUpdate)]
pub struct Setting {
    /// 由于value可能会是数据库的关键字，所以加上str
    pub value_str: String,
}

/// 没有对应的数据库表
#[derive(Serialize, Deserialize, Clone, Debug, Default)]
pub struct TokenShared {
    /// [crate::ChainType]
    pub chain_type: String,

    pub name: String,
    pub symbol: String,
    pub logo_url: Option<String>,
    /// base 64编码
    pub logo_bytes: Option<String>,
    pub project: Option<String>,

    /// true为认证token
    pub auth: bool,

    /// 数据库中的创建时间
    pub create_time: i64,
    /// 数据库中的更新时间
    pub update_time: i64,
}








