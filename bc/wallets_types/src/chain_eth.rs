use crate::{ChainShared, TokenShared};

#[derive(Debug, Default)]
pub struct EthChainToken {
    pub token_shared: TokenShared,
}

#[derive(Debug, Default)]
pub struct EthChainTokenDefault {
    pub token_shared: TokenShared,
}

#[derive(Debug, Default)]
pub struct EthChainTokenAuth {
    pub token_shared: TokenShared,
}

#[derive(Debug, Default)]
pub struct EthChain {
    pub chain_shared: ChainShared,
    pub tokens: Vec<EthChainToken>,
}
