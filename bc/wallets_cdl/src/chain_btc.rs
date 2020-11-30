#![allow(non_snake_case)]

use wallets_macro::{DlDefault, DlStruct};

use crate::drop_ctype;
use crate::kits::{CArray, CStruct};
use crate::types::{ChainShared, TokenShared};

#[repr(C)]
#[derive(Debug, Clone, DlStruct, DlDefault)]
pub struct BtcChainToken {
    pub tokenShared: *mut TokenShared,
}

#[repr(C)]
#[derive(Debug, Clone, DlStruct, DlDefault)]
pub struct BtcChain {
    pub chainShared: *mut ChainShared,
    pub tokens: *mut CArray<BtcChainToken>,
}
