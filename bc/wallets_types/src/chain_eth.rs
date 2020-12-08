use mav::ma::{MEthChainToken, MEthChainTokenAuth, MEthChainTokenDefault};

use crate::{ChainShared, deref_type, TokenShared};

#[derive(Debug, Default)]
pub struct EthChainToken {
    pub m: MEthChainToken,
    pub token_shared: TokenShared,
}
deref_type!(EthChainToken,MEthChainToken);

#[derive(Debug, Default)]
pub struct EthChainTokenDefault {
    pub m: MEthChainTokenDefault,
    pub token_shared: TokenShared,
}
deref_type!(EthChainTokenDefault,MEthChainTokenDefault);

#[derive(Debug, Default)]
pub struct EthChainTokenAuth {
    pub m: MEthChainTokenAuth,
    pub token_shared: TokenShared,
}
deref_type!(EthChainTokenAuth,MEthChainTokenAuth);

#[derive(Debug, Default)]
pub struct EthChain {
    pub chain_shared: ChainShared,
    pub tokens: Vec<EthChainToken>,
}
