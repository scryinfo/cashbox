#![allow(non_snake_case)]

use crate::drop_ctype;
use crate::kits::{CArray, CStruct};
use crate::types::{Address, ChainShared, TokenShared};

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
    pub tokens: *mut CArray<EeeChainToken>,
}

impl CStruct for EeeChain {
    fn free(&mut self) {
        self.chainShared.free();
        self.address.free();
        self.tokens.free();
    }
}

drop_ctype!(EeeChain);