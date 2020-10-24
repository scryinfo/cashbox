use crate::db::TokenShared;

//btc
#[derive(Default, Clone)]
pub struct BtcChainTokenShared {
    //primary key
    pub id: String,
    pub token_shared: TokenShared,
}

#[derive(Default, Clone)]
pub struct BtcChainTokenAuth {
    //primary key
    pub id: String,
    /// [BtcChainTokenShared]
    pub chain_token_shared_id: String,
    /// 显示位置，以此从小到大排列
    pub position: i64,
}

/// DefaultToken must be a [BtcChainTokenAuth]
#[derive(Default, Clone)]
pub struct BtcChainTokenDefault {
    //primary key
    pub id: String,
    /// [BtcChainTokenShared]
    pub chain_token_shared_id: String,

    /// 显示位置，以此从小到大排列
    pub position: i64,
}
//btc end
