use crate::types::{TokenShared, ChainShared, CU64};

#[repr(C)]
#[derive(Debug, Copy, Clone)]
pub struct BtcChainToken {
    pub tokenShared: *mut TokenShared,
}
#[repr(C)]
#[derive(Debug, Copy, Clone)]
pub struct BtcChain {
    pub chainShared: *mut ChainShared,
    pub tokens: *mut BtcChainToken,
    pub tokensLength: CU64,
}