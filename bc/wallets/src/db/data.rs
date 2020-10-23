
#[derive(Default, Clone)]
pub struct Token {
    //primary key
    pub id: String,
    pub next_id: String,
    /// [detail::Wallet]
    pub wallet_id: String,
    /// [detail::Chain]
    pub chain_id: String,
    /// [DigitShared]
    pub digit_shared_id: Option<String>,

    pub create_time: i64,
    pub update_time: i64,
}

#[derive(Default, Clone)]
pub struct TokenAddress {
    //primary key
    pub id: String,
    pub digit_id: String,
    pub address_id: String,
    pub balance: String, //如果支持decimal类型，改

    pub create_time: i64,
    pub update_time: i64,
}