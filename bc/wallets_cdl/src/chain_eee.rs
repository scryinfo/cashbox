#![allow(non_snake_case)]

use wallets_macro::{DlDefault, DlStruct};

use crate::drop_ctype;
use crate::kits::{CArray, CStruct};
use crate::types::{Address, ChainShared, TokenShared};

#[repr(C)]
#[derive(Debug, Clone, DlStruct, DlDefault)]
pub struct EeeChainToken {
    pub tokenShared: *mut TokenShared,
}

#[repr(C)]
#[derive(Debug, Clone, DlStruct, DlDefault)]
pub struct EeeChain {
    pub chainShared: *mut ChainShared,
    pub address: *mut Address,
    pub tokens: *mut CArray<EeeChainToken>,
}
