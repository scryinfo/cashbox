use crate::{ChainShared, TokenShared};

#[derive(Debug, Default)]
pub struct BtcChainToken {
    pub token_shared: TokenShared,
}

#[derive(Debug, Default)]
pub struct BtcChain {
    pub chain_shared: ChainShared,
    pub tokens: Vec<BtcChainToken>,
}
