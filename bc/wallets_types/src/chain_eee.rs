use mav::ma::MEeeChainToken;

use crate::{Address, ChainShared, deref_type, TokenShared};

#[derive(Debug, Default)]
pub struct EeeChainToken {
    pub m: MEeeChainToken,
    pub token_shared: TokenShared,
}
deref_type!(EeeChainToken,MEeeChainToken);

#[derive(Debug, Default)]
pub struct EeeChain {
    pub chain_shared: ChainShared,
    pub address: Address,
    pub tokens: Vec<EeeChainToken>,
}