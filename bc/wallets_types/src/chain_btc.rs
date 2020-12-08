use mav::ma::MBtcChainToken;

use crate::{ChainShared, deref_type, TokenShared};

#[derive(Debug, Default)]
pub struct BtcChainToken {
    pub m: MBtcChainToken,
    pub token_shared: TokenShared,
}
deref_type!(BtcChainToken,MBtcChainToken);

#[derive(Debug, Default)]
pub struct BtcChain {
    pub chain_shared: ChainShared,
    pub tokens: Vec<BtcChainToken>,
}
