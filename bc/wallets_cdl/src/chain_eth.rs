use crate::types::{TokenShared, ChainShared, CU64};

#[repr(C)]
#[derive(Debug, Copy, Clone)]
pub struct EthChainToken {
    pub tokenShared: *mut TokenShared,
}
#[repr(C)]
#[derive(Debug, Copy, Clone)]
pub struct EthChainTokenDefault {
    pub tokenShared: *mut TokenShared,
}
#[repr(C)]
#[derive(Debug, Copy, Clone)]
pub struct EthChainTokenAuth {
    pub tokenShared: *mut TokenShared,
}
#[repr(C)]
#[derive(Debug, Copy, Clone)]
pub struct EthChain {
    pub chain_shared: *mut ChainShared,
    pub tokens: *mut EthChainToken,
    pub tokens_length: CU64,
}
