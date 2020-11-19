#![allow(non_snake_case)]

use crate::types::{TokenShared, ChainShared, CU64};
use crate::drop_ctype;
use crate::kits::CStruct;

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
    pub tokens: *mut BtcChainToken,
    pub tokensLength: CU64,
}

impl CStruct for BtcChain {
    fn free(&mut self) {
        self.chainShared.free();
        self.tokens.free();
        self.tokensLength = 0;
    }
}

drop_ctype!(BtcChain);