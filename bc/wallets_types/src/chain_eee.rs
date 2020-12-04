use crate::{Address, ChainShared, TokenShared};

#[derive(Debug, Default)]
pub struct EeeChainToken {
    pub token_shared: TokenShared,
}

#[repr(C)]
#[derive(Debug, Default)]
pub struct EeeChain {
    pub chain_shared: ChainShared,
    pub address: Address,
    pub tokens: Vec<EeeChainToken>,
}