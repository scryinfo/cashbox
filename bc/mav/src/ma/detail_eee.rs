use rbatis::crud::CRUDEnable;
use rbatis_macro_driver::CRUDEnable;
use serde::Deserialize;
use serde::Serialize;

use wallets_macro::{db_append_shared, DbBeforeSave, DbBeforeUpdate};

use crate::kits;
use crate::ma::db::{self, Shared};
use crate::ma::TokenShared;

// eee
#[db_append_shared]
#[derive(Serialize, Deserialize, Clone, Debug, Default, CRUDEnable, DbBeforeSave, DbBeforeUpdate)]
pub struct EeeChainTokenShared {
    pub token_shared: TokenShared,
}

#[db_append_shared]
#[derive(Serialize, Deserialize, Clone, Debug, Default, CRUDEnable, DbBeforeSave, DbBeforeUpdate)]
pub struct EeeChainTokenAuth {
    /// [EeeChainTokenShared]
    pub chain_token_shared_id: String,
    /// 显示位置，以此从小到大排列
    pub position: i64,
}

/// DefaultToken must be a [EeeChainTokenAuth]
#[db_append_shared]
#[derive(Serialize, Deserialize, Clone, Debug, Default, CRUDEnable, DbBeforeSave, DbBeforeUpdate)]
pub struct EeeChainTokenDefault {
    /// [EeeChainTokenShared]
    pub chain_token_shared_id: String,

    /// 显示位置，以此从小到大排列
    pub position: i64,
}
// eee end