#[derive(Default, Clone)]
pub struct Wallet {
    //primary key
    pub id: String,
    //下一个显示顺序的 wallet_id
    pub next_id: String,
    pub full_name: String,
    pub mnemonic_digest: String,
    pub mnemonic: String,
    /// [crate::WalletType]
    pub wallet_type: String,
    /// [crate::NetType]
    pub net_type: String,
    /// 数据库中的创建时间
    pub create_time: i64,
    /// 数据库中的更新时间
    pub update_time: i64,
}

//每一种链类型一条记录，
#[derive(Default, Clone)]
pub struct ChainTypeMeta {
    //primary key
    pub id: String,
    /// [crate::ChainType]
    pub chain_type: String,
    pub short_name: String,
    pub full_name: String,
    /// 数据库中的创建时间
    pub create_time: i64,
    /// 数据库中的更新时间
    pub update_time: i64,
}

#[derive(Default, Clone)]
pub struct Address {
    //primary key
    pub id: String,
    /// [Wallet]
    pub wallet_id: String,
    /// [crate::ChainType]
    pub chain_type: String,
    pub address: String,
    pub public_key: String,
    /// 是否为钱包地址
    pub wallet_address: bool,

    /// 数据库中的创建时间
    pub create_time: i64,
    /// 数据库中的更新时间
    pub update_time: i64,
}

/// 没有对应的数据库表
#[derive(Default, Clone)]
pub struct TokenShared {
    /// [crate::ChainType]
    pub chain_type: String,

    pub name: String,
    pub symbol: String,
    pub logo_url: Option<String>,
    /// base 64编码
    pub logo_bytes: Option<String>,
    pub project: Option<String>,

    /// true为认证token
    pub auth: bool,

    /// 数据库中的创建时间
    pub create_time: i64,
    /// 数据库中的更新时间
    pub update_time: i64,
}








