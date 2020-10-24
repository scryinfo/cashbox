use crate::db::{TxShared};

//btc
#[derive(Default, Clone)]
pub struct BtcChainToken {
    //primary key
    pub id: String,
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

#[derive(Default, Clone)]
pub struct BtcChainTx {
    pub tx_shared: TxShared,

    pub total_input: String,
    pub total_output: String,
    pub fees: String,
    /// 如果包含 OP_RETURN
    pub op_return: Option<String>,
    // ...
}

#[derive(Default, Clone)]
pub struct BtcInputTx {
    pub id: String,
    pub btc_chain_tx_id: String,

    pub index: i64,
    pub address: String,
    pub pk_script: String,
    pub sig_script: String,
    pub value: String,
    // ...
}

#[derive(Default, Clone)]
pub struct BtcOutputTx {
    pub id: String,
    pub btc_chain_tx_id: String,
    pub index: i64,
    pub address: String,
    pub pk_script: String,
    pub value: String,

    // ...
}

//btc end
