#![allow(non_snake_case)]

use wallets_macro::{DlCR, DlDefault, DlStruct};
use wallets_types::{EeeChain, EeeChainToken};

use crate::drop_ctype;
use crate::kits::{CArray, CR, CStruct};
use crate::types::{CAddress, CChainShared, CTokenShared};

#[repr(C)]
#[derive(Debug, Clone, DlStruct, DlDefault, DlCR)]
pub struct CEeeChainToken {
    pub tokenShared: *mut CTokenShared,
}

#[repr(C)]
#[derive(Debug, Clone, DlStruct, DlDefault, DlCR)]
pub struct CEeeChain {
    pub chainShared: *mut CChainShared,
    pub address: *mut CAddress,
    pub tokens: *mut CArray<CEeeChainToken>,
}
