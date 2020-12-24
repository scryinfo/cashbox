use rbatis_macro_driver::CRUDEnable;
use serde::Deserialize;
use serde::Serialize;

use wallets_macro::{db_append_shared, db_sub_struct, DbBeforeSave, DbBeforeUpdate};

use crate::kits;
use crate::ma::dao::{self, bool_from_int, Shared};

#[db_append_shared]
#[derive(Serialize, Deserialize, Clone, Debug, Default, CRUDEnable, DbBeforeSave, DbBeforeUpdate)]
pub struct MWallet {
    //下一个显示顺序的 wallet_id
    #[serde(default)]
    pub next_id: String,
    #[serde(default)]
    pub name: String,
    //由助记词生成的唯一摘要，用于检测是否有重复的助记词
    #[serde(default)]
    pub mnemonic_digest: String,
    //加密后的助记词
    #[serde(default)]
    pub mnemonic: String,
    /// [crate::WalletType]
    #[serde(default)]
    pub wallet_type: String,
    /// [crate::NetType]
    #[serde(default)]
    pub net_type: String,
}

impl MWallet {
    pub const fn create_table_script() -> &'static str {
        std::include_str!("../../../sql/m_wallet.sql")
    }
}

//每一种链类型一条记录，实现时可以不写入数据库
#[db_append_shared]
#[derive(Serialize, Deserialize, Clone, Debug, Default, CRUDEnable, DbBeforeSave, DbBeforeUpdate)]
pub struct MChainTypeMeta {
    /// [crate::ChainType]
    #[serde(default)]
    pub chain_type: String,
    #[serde(default)]
    pub short_name: String,
    #[serde(default)]
    pub full_name: String,
}

impl MChainTypeMeta {
    pub const fn create_table_script() -> &'static str {
        std::include_str!("../../../sql/m_chain_type_meta.sql")
    }
}

#[db_append_shared]
#[derive(Serialize, Deserialize, Clone, Debug, Default, CRUDEnable, DbBeforeSave, DbBeforeUpdate)]
pub struct MAddress {
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

impl MAddress {
    pub const fn create_table_script() -> &'static str {
        std::include_str!("../../../sql/m_address.sql")
    }
}

#[db_sub_struct]
#[derive(Serialize, Deserialize, Clone, Debug, Default)]
pub struct MTokenShared {
    #[serde(default)]
    pub name: String,
    #[serde(default)]
    pub symbol: String,
    #[serde(default)]
    pub logo_url: String,
    /// base 64编码
    #[serde(default)]
    pub logo_bytes: String,
    #[serde(default)]
    pub project_name: String,
    #[serde(default)]
    pub project_home: String,
    #[serde(default)]
    pub project_note: String,
}

#[db_sub_struct]
#[derive(Serialize, Deserialize, Clone, Debug, Default)]
pub struct MChainShared {
    pub wallet_id: String,
    pub chain_type: String,
    /// 钱包地址
    pub address_id: String,
}








