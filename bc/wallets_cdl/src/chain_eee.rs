use crate::types::{TokenShared, ChainShared, Address, CU64};

#[repr(C)]
#[derive(Debug, Copy, Clone)]
pub struct EeeChainToken {
    pub tokenShared: *mut TokenShared,
}
#[repr(C)]
#[derive(Debug, Copy, Clone)]
pub struct EeeChain {
    pub chainShared: *mut ChainShared,
    pub address: *mut Address,
    pub tokens: *mut EeeChainToken,
    pub tokensLength: CU64,
}