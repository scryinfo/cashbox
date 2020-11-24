#![allow(non_snake_case)]

use crate::drop_ctype;
use crate::kits::{CArray, CStruct};
use crate::types::{ChainShared, TokenShared};

use wallets_macro::{DlStruct,DlDefault};

#[repr(C)]
#[derive(Debug,DlStruct,DlDefault)]
pub struct EthChainToken {
    pub tokenShared: *mut TokenShared,
}

#[repr(C)]
#[derive(Debug,DlStruct,DlDefault)]
pub struct EthChainTokenDefault {
    pub tokenShared: *mut TokenShared,
}

#[repr(C)]
#[derive(Debug,DlStruct,DlDefault)]
pub struct EthChainTokenAuth {
    pub tokenShared: *mut TokenShared,
}

#[repr(C)]
#[derive(Debug,DlStruct,DlDefault)]
pub struct EthChain {
    pub chain_shared: *mut ChainShared,
    pub tokens: *mut CArray<EthChainToken>,
}
