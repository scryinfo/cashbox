use crate::cdl::{ChainShared, TokenShared, Address};

// eee
#[repr(C)]
#[derive(Clone, Default)]
pub struct EeeChain {
    pub chain_shared: ChainShared,
    pub address: Address,
    pub tokens: Vec<EeeChainToken>,
}

#[repr(C)]
#[derive(Clone, Default)]
pub struct EeeChainToken {
    pub token_shared: TokenShared,
}

// eee end