

// btc
#[repr(C)]
#[derive(Clone, Default)]
pub struct BtcChain {
    pub chain_shared: ChainShared,
    pub tokens: Vec<BtcToken>,
}

#[repr(C)]
#[derive(Clone, Default)]
pub struct BtcToken {
    pub token_shared: TokenShared,
}
// btc end