use crate::ma::TokenShared;

//eth
#[derive(Default, Clone)]
pub struct EthChainTokenShared {
    //primary key
    pub id: String,
    pub token_shared: TokenShared,
}

#[derive(Default, Clone)]
pub struct EthChainTokenAuth {
    //primary key
    pub id: String,
    /// [EthChainTokenShared]
    pub chain_token_shared_id: String,
    /// 显示位置，以此从小到大排列
    pub position: i64,
}

/// DefaultToken must be a [EthChainTokenAuth]
#[derive(Default, Clone)]
pub struct EthChainTokenDefault {
    //primary key
    pub id: String,
    /// [crate::db::TokenShared]
    pub chain_token_shared_id: String,

    /// 显示位置，以此从小到大排列
    pub position: i64,
}
//eth end