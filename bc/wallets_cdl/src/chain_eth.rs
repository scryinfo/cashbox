#![allow(non_snake_case)]

use wallets_macro::{DlCR, DlDefault, DlStruct};
use wallets_types::{EthChain, EthChainToken, EthChainTokenAuth, EthChainTokenDefault};

use crate::kits::{CArray, CR, CStruct};
use crate::types::{CChainShared, CTokenShared};

#[repr(C)]
#[derive(Debug, DlStruct, DlDefault, DlCR)]
pub struct CEthChainToken {
    pub tokenShared: *mut CTokenShared,
}

#[repr(C)]
#[derive(Debug, DlStruct, DlDefault, DlCR)]
pub struct CEthChainTokenDefault {
    pub tokenShared: *mut CTokenShared,
}

#[repr(C)]
#[derive(Debug, DlStruct, DlDefault, DlCR)]
pub struct CEthChainTokenAuth {
    pub tokenShared: *mut CTokenShared,
}

#[repr(C)]
#[derive(Debug, DlStruct, DlDefault, DlCR)]
pub struct CEthChain {
    pub chainShared: *mut CChainShared,
    pub tokens: *mut CArray<CEthChainToken>,
}
