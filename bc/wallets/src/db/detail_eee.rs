use crate::db::TokenShared;

// eee
#[derive(Default, Clone)]
pub struct EeeChainTokenShared {
    //primary key
    pub id: String,
    pub token_shared: TokenShared,
}

#[derive(Default, Clone)]
pub struct EeeChainTokenAuth {
    //primary key
    pub id: String,
    /// [EeeChainTokenShared]
    pub chain_token_shared_id: String,
    /// 显示位置，以此从小到大排列
    pub position: i64,
}

/// DefaultToken must be a [EeeChainTokenAuth]
#[derive(Default, Clone)]
pub struct EeeChainTokenDefault {
    //primary key
    pub id: String,
    /// [EeeChainTokenShared]
    pub chain_token_shared_id: String,

    /// 显示位置，以此从小到大排列
    pub position: i64,
}
// eee end