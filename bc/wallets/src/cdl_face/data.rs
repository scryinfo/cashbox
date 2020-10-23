
#[repr(C)]
#[derive(Clone, Default)]
pub struct Wallet{
    pub id: String,
    pub next_id: String,

    pub eth_chains: Option<EthChain>,
    pub eee_chains: Option<EeeChain>,
    pub btc_chains: Option<BtcChain>,
}

#[repr(C)]
#[derive(Clone, Default)]
pub struct Address{
    pub address: String,
    pub public_key: String,
}

#[repr(C)]
#[derive(Clone, Default)]
pub struct TokenShared{
    pub id: String,
    pub name: String,
    pub symbol: String,
}

#[repr(C)]
#[derive(Clone, Default)]
pub struct ChainShared{
    pub id: String,
    pub wallet_id: String,
    pub chain_id: String,
    pub chain_type: String,
    /// 钱包地址
    pub wallet_address: Address,
    /// 多个地址，这是预留字段，在v2.3版本中不会使用它
    pub addresses: Vec<Address>,
}

