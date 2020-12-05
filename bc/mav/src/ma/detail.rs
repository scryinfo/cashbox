use rbatis::crud::CRUDEnable;
use rbatis_macro_driver::CRUDEnable;
use serde::Deserialize;
use serde::Serialize;

use wallets_macro::{db_append_shared, db_sub_struct, DbBeforeSave, DbBeforeUpdate};

use crate::kits;
use crate::ma::dao::{self, bool_from_int, Shared};

#[db_append_shared]
#[derive(Serialize, Deserialize, Clone, Debug, Default, CRUDEnable, DbBeforeSave, DbBeforeUpdate)]
pub struct Wallet {
    //下一个显示顺序的 wallet_id
    #[serde(default)]
    pub next_id: String,
    #[serde(default)]
    pub full_name: String,
    #[serde(default)]
    pub mnemonic_digest: String,
    #[serde(default)]
    pub mnemonic: String,
    /// [crate::WalletType]
    #[serde(default)]
    pub wallet_type: String,
    /// [crate::NetType]
    #[serde(default)]
    pub net_type: String,
}

//每一种链类型一条记录，
#[db_append_shared]
#[derive(Serialize, Deserialize, Clone, Debug, Default, CRUDEnable, DbBeforeSave, DbBeforeUpdate)]
pub struct ChainTypeMeta {
    /// [crate::ChainType]
    #[serde(default)]
    pub chain_type: String,
    #[serde(default)]
    pub short_name: String,
    #[serde(default)]
    pub full_name: String,
}

#[db_append_shared]
#[derive(Serialize, Deserialize, Clone, Debug, Default, CRUDEnable, DbBeforeSave, DbBeforeUpdate)]
pub struct Address {
    /// [Wallet]
    #[serde(default)]
    pub wallet_id: String,
    /// [crate::ChainType]
    #[serde(default)]
    pub chain_type: String,
    #[serde(default)]
    pub address: String,
    #[serde(default)]
    pub public_key: String,
    /// 是否为钱包地址
    #[serde(default, deserialize_with = "bool_from_int")]
    pub wallet_address: bool,
}

/// 动态库自己的配置，并不指app的配置
#[db_append_shared]
#[derive(Serialize, Deserialize, Clone, Debug, Default, CRUDEnable, DbBeforeSave, DbBeforeUpdate)]
pub struct Setting {
    #[serde(default)]
    pub key_str: String,
    /// 由于value可能会是数据库的关键字，所以加上str
    #[serde(default)]
    pub value_str: String,
}

#[db_sub_struct]
#[derive(Serialize, Deserialize, Clone, Debug, Default)]
pub struct TokenShared {
    /// [crate::ChainType]
    #[serde(default)]
    pub chain_type: String,
    #[serde(default)]
    pub name: String,
    #[serde(default)]
    pub symbol: String,
    #[serde(default)]
    pub logo_url: Option<String>,
    /// base 64编码
    #[serde(default)]
    pub logo_bytes: Option<String>,
    #[serde(default)]
    pub project: Option<String>,
    /// true为认证token
    #[serde(default, deserialize_with = "bool_from_int")]
    pub auth: bool,
}








