#![allow(non_snake_case)]

use crate::types::{TokenShared, ChainShared, Address, CU64};
use crate::drop_ctype;
use crate::kits::CStruct;

#[repr(C)]
#[derive(Debug, Clone)]
pub struct EeeChainToken {
    pub tokenShared: *mut TokenShared,
}

impl CStruct for EeeChainToken {
    fn free(&mut self) {
        self.tokenShared.free();
    }
}

drop_ctype!(EeeChainToken);
#[repr(C)]
#[derive(Debug, Clone)]
pub struct EeeChain {
    pub chainShared: *mut ChainShared,
    pub address: *mut Address,
    pub tokens: *mut EeeChainToken,
    pub tokensLength: CU64,
}

impl CStruct for EeeChain {
    fn free(&mut self) {
        self.chainShared.free();
        self.address.free();
        self.tokens.free();
        self.tokensLength = 0;
    }
}

drop_ctype!(EeeChain);