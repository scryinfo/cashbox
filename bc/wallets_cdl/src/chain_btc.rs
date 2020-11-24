#![allow(non_snake_case)]

use crate::drop_ctype;
use crate::kits::{CArray, CStruct};
use crate::types::{ChainShared, TokenShared};

use wallets_macro::{DlStruct,DlDefault};

#[repr(C)]
#[derive(Debug, Clone,DlStruct,DlDefault)]
pub struct BtcChainToken {
    pub tokenShared: *mut TokenShared,
}

#[repr(C)]
#[derive(Debug, Clone,DlStruct,DlDefault)]
pub struct BtcChain {
    pub chainShared: *mut ChainShared,
    pub tokens: *mut CArray<BtcChainToken>,
}
