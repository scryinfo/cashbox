use crate::cdl::{TokenShared, ChainShared};

// btc
#[repr(C)]
#[derive(Clone, Default)]
pub struct BtcChain {
    pub chain_shared: ChainShared,
    pub tokens: Vec<BtcChainToken>,
}

#[repr(C)]
#[derive(Clone, Default)]
pub struct BtcChainToken {
    pub token_shared: TokenShared,
}
// btc end