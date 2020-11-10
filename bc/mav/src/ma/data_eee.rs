use crate::ma::{TxShared};

//eee
#[derive(Default, Clone)]
pub struct EeeChainToken {
    //primary key
    pub id: String,
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
#[derive(Default, Clone)]
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

#[derive(Default, Clone)]
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
