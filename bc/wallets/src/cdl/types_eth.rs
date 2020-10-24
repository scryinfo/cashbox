use crate::cdl::{ChainShared, TokenShared};

// eth
#[repr(C)]
#[derive(Clone, Default)]
pub struct EthChain {
    pub chain_shared: ChainShared,
    pub tokens: Vec<EthChainToken>,
}

#[repr(C)]
#[derive(Clone, Default)]
pub struct EthChainToken {
    pub token_shared: Option<TokenShared>,
}

#[repr(C)]
#[derive(Clone, Default)]
pub struct EthChainTokenDefault {
    pub token_shared: TokenShared,

}

#[repr(C)]
#[derive(Clone, Default)]
pub struct EthChainTokenAuth {
    pub token_shared: TokenShared,
}
// eth end