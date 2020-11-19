#![allow(non_snake_case)]

use crate::types::{TokenShared, ChainShared, CU64};
use crate::drop_ctype;
use crate::kits::CStruct;

#[repr(C)]
#[derive(Debug)]
pub struct EthChainToken {
    pub tokenShared: *mut TokenShared,
}

impl CStruct for EthChainToken {
    fn free(&mut self) {
        self.tokenShared.free();
    }
}

drop_ctype!(EthChainToken);

#[repr(C)]
#[derive(Debug)]
pub struct EthChainTokenDefault {
    pub tokenShared: *mut TokenShared,
}

#[repr(C)]
#[derive(Debug)]
pub struct EthChainTokenAuth {
    pub tokenShared: *mut TokenShared,
}

impl CStruct for EthChainTokenAuth {
    fn free(&mut self) {
        self.tokenShared.free();
    }
}

drop_ctype!(EthChainTokenAuth);
#[repr(C)]
#[derive(Debug)]
pub struct EthChain {
    pub chain_shared: *mut ChainShared,
    pub tokens: *mut EthChainToken,
    pub tokens_length: CU64,
}

impl CStruct for EthChain {
    fn free(&mut self) {
        self.chain_shared.free();
        self.tokens.free();
        self.tokens_length = 0;
    }
}

drop_ctype!(EthChain);
