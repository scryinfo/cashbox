use rbatis::crud::CRUDEnable;
use rbatis_macro_driver::CRUDEnable;
use serde::Deserialize;
use serde::Serialize;

use wallets_macro::{db_append_shared, DbBeforeSave, DbBeforeUpdate};

use crate::kits;
use crate::ma::dao::{self, Shared};
use crate::ma::MTokenShared;

//btc
#[db_append_shared(CRUDEnable)]
#[derive(Serialize, Deserialize, Clone, Debug, Default, DbBeforeSave, DbBeforeUpdate)]
pub struct MBtcChainTokenShared {
    #[serde(flatten)]
    pub token_shared: MTokenShared,
}

impl MBtcChainTokenShared {
    pub const fn create_table_script() -> &'static str {
        std::include_str!("../../../sql/m_btc_chain_token_shared.sql")
    }
}

#[db_append_shared]
#[derive(Serialize, Deserialize, Clone, Debug, Default, CRUDEnable, DbBeforeSave, DbBeforeUpdate)]
pub struct MBtcChainTokenAuth {
    /// [BtcChainTokenShared]
    #[serde(default)]
    pub chain_token_shared_id: String,
    /// 显示位置，以此从小到大排列
    #[serde(default)]
    pub position: i64,
}

impl MBtcChainTokenAuth {
    pub const fn create_table_script() -> &'static str {
        std::include_str!("../../../sql/m_btc_chain_token_auth.sql")
    }
}

/// DefaultToken must be a [BtcChainTokenAuth]
#[db_append_shared]
#[derive(Serialize, Deserialize, Clone, Debug, Default, CRUDEnable, DbBeforeSave, DbBeforeUpdate)]
pub struct MBtcChainTokenDefault {
    /// [BtcChainTokenShared]
    #[serde(default)]
    pub chain_token_shared_id: String,
    /// 显示位置，以此从小到大排列
    #[serde(default)]
    pub position: i64,
}

impl MBtcChainTokenDefault {
    pub const fn create_table_script() -> &'static str {
        std::include_str!("../../../sql/m_btc_chain_token_default.sql")
    }
}
//btc end
