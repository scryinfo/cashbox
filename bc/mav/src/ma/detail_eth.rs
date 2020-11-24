
use rbatis::crud::CRUDEnable;
use serde::Deserialize;
use serde::Serialize;
use wallets_macro::{db_append_shared, DbBeforeSave, DbBeforeUpdate};

use crate::kits;
use crate::ma::db::{self, Shared};
use crate::ma::TokenShared;

//eth
#[db_append_shared]
#[derive(Serialize, Deserialize, Clone, Debug, Default, CRUDEnable, DbBeforeSave, DbBeforeUpdate)]
pub struct EthChainTokenShared {
    pub token_shared: TokenShared,
}

#[db_append_shared]
#[derive(Serialize, Deserialize, Clone, Debug, Default, CRUDEnable, DbBeforeSave, DbBeforeUpdate)]
pub struct EthChainTokenAuth {
    /// [EthChainTokenShared]
    pub chain_token_shared_id: String,
    /// 显示位置，以此从小到大排列
    pub position: i64,
}

/// DefaultToken must be a [EthChainTokenAuth]
#[db_append_shared]
#[derive(Serialize, Deserialize, Clone, Debug, Default, CRUDEnable, DbBeforeSave, DbBeforeUpdate)]
pub struct EthChainTokenDefault {
    /// [crate::db::TokenShared]
    pub chain_token_shared_id: String,

    /// 显示位置，以此从小到大排列
    pub position: i64,
}
//eth end