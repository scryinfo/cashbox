#![allow(non_snake_case)]

use wallets_macro::{DlCR, DlDefault, DlStruct};
use wallets_types::{EthChain, EthChainToken, EthChainTokenAuth, EthChainTokenDefault, EthChainTokenNonAuth,EthChainTokenShared};

use crate::kits::{CArray, CBool,CR, CStruct,to_str,to_c_char,Assignment};
use crate::types::{CChainShared, CTokenShared};
use std::os::raw::c_char;

#[repr(C)]
#[derive(Debug, DlStruct, DlDefault, DlCR)]
pub struct CEthChainToken {
    pub chainTokenSharedId:*mut c_char,
    pub show:CBool,
    pub contractAddress:*mut c_char,
    pub ethChainTokenShared: *mut CEthChainTokenShared,
}

#[repr(C)]
#[derive(Debug, DlStruct, DlDefault, DlCR)]
pub struct CEthChainTokenShared {
    pub tokenShared: *mut CTokenShared,
    pub tokenType: *mut c_char,
    pub gasLimit: i64,
    pub gasPrice: *mut c_char,
    pub decimal: i32,
}

#[repr(C)]
#[derive(Debug, DlStruct, DlDefault, DlCR)]
pub struct CEthChainTokenDefault {
    pub chainTokenSharedId: *mut c_char,
    pub netType: *mut c_char,
    pub position: i64,
    pub contractAddress: *mut c_char,
    pub ethChainTokenShared: *mut CEthChainTokenShared,
}

#[repr(C)]
#[derive(Debug, DlStruct, DlDefault, DlCR)]
pub struct CEthChainTokenAuth {
    pub chainTokenSharedId: *mut c_char,
    pub netType: *mut c_char,
    pub position: i64,
    pub contractAddress: *mut c_char,
    pub ethChainTokenShared: *mut CEthChainTokenShared,
}

#[repr(C)]
#[derive(Debug, DlStruct, DlDefault, DlCR)]
pub struct CEthChainTokenNonAuth {
    pub chainTokenSharedId: *mut c_char,
    pub netType: *mut c_char,
    pub position: i64,
    pub contractAddress: *mut c_char,
    pub ethChainTokenShared: *mut CEthChainTokenShared,
}

#[repr(C)]
#[derive(Debug, DlStruct, DlDefault, DlCR)]
pub struct CEthChain {
    pub chainShared: *mut CChainShared,
    pub tokens: *mut CArray<CEthChainToken>,
}
