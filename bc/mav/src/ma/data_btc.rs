
use rbatis::crud::CRUDEnable;
use serde::Deserialize;
use serde::Serialize;
use wallets_macro::{db_append_shared, DbBeforeSave, DbBeforeUpdate};

use crate::kits;
use crate::ma::db::{self, Shared};
use crate::ma::TxShared;

//btc
#[db_append_shared]
#[derive(Serialize, Deserialize, Clone, Debug, Default, CRUDEnable, DbBeforeSave, DbBeforeUpdate)]
pub struct BtcChainToken {
    pub next_id: String,
    /// 手动加入的token就没有token shared内容
    /// [crate::db::BtcChainTokenShared]
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

#[db_append_shared]
#[derive(Serialize, Deserialize, Clone, Debug, Default, CRUDEnable, DbBeforeSave, DbBeforeUpdate)]
pub struct BtcChainTx {
    pub tx_shared: TxShared,
    pub total_input: String,
    pub total_output: String,
    pub fees: String,
    /// 如果包含 OP_RETURN
    pub op_return: Option<String>,
    // ...
}

#[db_append_shared]
#[derive(Serialize, Deserialize, Clone, Debug, Default, CRUDEnable, DbBeforeSave, DbBeforeUpdate)]
pub struct BtcInputTx {
    pub btc_chain_tx_id: String,

    pub index: i64,
    pub address: String,
    pub pk_script: String,
    pub sig_script: String,
    pub value: String,
    // ...
}

#[db_append_shared]
#[derive(Serialize, Deserialize, Clone, Debug, Default, CRUDEnable, DbBeforeSave, DbBeforeUpdate)]
pub struct BtcOutputTx {
    pub btc_chain_tx_id: String,
    pub index: i64,
    pub address: String,
    pub pk_script: String,
    pub value: String,
    // ...
}

//btc end
