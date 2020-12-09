#![allow(non_snake_case)]

use wallets_macro::{DlCR, DlDefault, DlStruct};
use wallets_types::{EthChain, EthChainToken, EthChainTokenAuth, EthChainTokenDefault, EthChainTokenShared};

use crate::kits::{CArray, CR, CStruct};
use crate::types::{CChainShared, CTokenShared};

#[repr(C)]
#[derive(Debug, DlStruct, DlDefault, DlCR)]
pub struct CEthChainToken {
    pub ethChainTokenShared: *mut CEthChainTokenShared,
}

#[repr(C)]
#[derive(Debug, DlStruct, DlDefault, DlCR)]
pub struct CEthChainTokenShared {
    pub tokenShared: *mut CTokenShared,
}

#[repr(C)]
#[derive(Debug, DlStruct, DlDefault, DlCR)]
pub struct CEthChainTokenDefault {
    pub ethChainTokenShared: *mut CEthChainTokenShared,
}

#[repr(C)]
#[derive(Debug, DlStruct, DlDefault, DlCR)]
pub struct CEthChainTokenAuth {
    pub ethChainTokenShared: *mut CEthChainTokenShared,
}

#[repr(C)]
#[derive(Debug, DlStruct, DlDefault, DlCR)]
pub struct CEthChain {
    pub chainShared: *mut CChainShared,
    pub tokens: *mut CArray<CEthChainToken>,
}
