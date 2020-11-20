#![allow(non_snake_case)]

use crate::drop_ctype;
use crate::kits::{CArray, CStruct};
use crate::types::{ChainShared, TokenShared};

#[repr(C)]
#[derive(Debug, Clone)]
pub struct BtcChainToken {
    pub tokenShared: *mut TokenShared,
}

impl CStruct for BtcChainToken {
    fn free(&mut self) {
        self.tokenShared.free();
    }
}

drop_ctype!(BtcChainToken);

#[repr(C)]
#[derive(Debug, Clone)]
pub struct BtcChain {
    pub chainShared: *mut ChainShared,
    pub tokens: *mut CArray<BtcChainToken>,
}

impl CStruct for BtcChain {
    fn free(&mut self) {
        self.chainShared.free();
        self.tokens.free();
    }
}

drop_ctype!(BtcChain);