/// 地址与token对应的balance
#[derive(Default, Clone)]
pub struct TokenAddress {
    //primary key
    pub id: String,
    pub wallet_id: String,
    /// [crate::ChainType]
    pub chain_type: String,
    pub token_id: String,
    pub address_id: String,

    pub balance: String,

    /// 数据库中的创建时间
    pub create_time: i64,
    /// 数据库中的更新时间
    pub update_time: i64,
}

/// 没有对应的数据库表
#[derive(Default, Clone)]
pub struct TxShared {
    //primary key
    pub id: String,
    pub tx_hash: String,
    pub block_hash: String,
    pub block_number: String,
    /// 交易的byte数据，不同链格式不一样
    pub tx_bytes: String,

    /// 数据库中的创建时间
    pub create_time: i64,
    /// 数据库中的更新时间
    pub update_time: i64,
}

