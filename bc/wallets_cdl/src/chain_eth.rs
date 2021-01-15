#![allow(non_snake_case)]

use wallets_macro::{DlCR, DlDefault, DlStruct};
use wallets_types::{EthChain, EthChainToken, EthChainTokenAuth, EthChainTokenDefault, EthChainTokenShared};

use crate::kits::{CArray, CMark, CR, CStruct,to_str,to_c_char};
use crate::types::{CChainShared, CTokenShared};
use std::os::raw::c_char;

#[repr(C)]
#[derive(Debug, DlStruct, DlDefault, DlCR)]
pub struct CEthChainToken {
    pub ethChainTokenShared: *mut CEthChainTokenShared,
}

#[repr(C)]
#[derive(Debug, DlStruct, DlDefault, DlCR)]
pub struct CEthChainTokenShared {
    pub tokenShared: *mut CTokenShared,
    pub tokenType: *mut c_char,
}

#[repr(C)]
#[derive(Debug, DlStruct, DlDefault, DlCR)]
pub struct CEthChainTokenDefault {
    pub chainTokenSharedId: *mut c_char,
    pub netType: *mut c_char,
    pub position: i64,
    pub contractAddress: *mut c_char,
    pub gasLimit: i64,
    pub gasPrice: *mut c_char,
    pub decimal: i32,
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
