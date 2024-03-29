#![allow(non_snake_case)]

use std::os::raw::c_char;

use wallets_macro::{DlCR, DlDefault, DlStruct};
use wallets_types::{AccountInfoSyncProg, EeeChain, EeeChainToken, EeeChainTokenAuth, EeeChainTokenDefault, EeeChainTokenShared, SubChainBasicInfo};

use crate::kits::{Assignment, CArray, CBool, CR, CStruct, to_c_char, to_str};
use crate::types::{CChainShared, CTokenShared};

#[repr(C)]
#[derive(Debug, DlStruct, DlDefault, DlCR)]
pub struct CEeeChainToken {
    pub show: CBool,
    pub chainTokenSharedId: *mut c_char,
    pub eeeChainTokenShared: *mut CEeeChainTokenShared,
}

#[repr(C)]
#[derive(Debug, DlStruct, DlDefault, DlCR)]
pub struct CEeeChainTokenShared {
    pub tokenShared: *mut CTokenShared,
    pub tokenType: *mut c_char,
    pub gasLimit: i64,
    pub gasPrice: *mut c_char,
    pub decimal: i32,
}

#[repr(C)]
#[derive(Debug, DlStruct, DlDefault, DlCR)]
pub struct CEeeChainTokenDefault {
    pub chainTokenSharedId: *mut c_char,
    pub netType: *mut c_char,
    pub position: i64,
    pub eeeChainTokenShared: *mut CEeeChainTokenShared,
}

#[repr(C)]
#[derive(Debug, DlStruct, DlDefault, DlCR)]
pub struct CEeeChainTokenAuth {
    pub chainTokenSharedId: *mut c_char,
    pub netType: *mut c_char,
    pub position: i64,
    pub eeeChainTokenShared: *mut CEeeChainTokenShared,
}

#[repr(C)]
#[derive(Debug, DlStruct, DlDefault, DlCR)]
pub struct CEeeChain {
    pub chainShared: *mut CChainShared,
    // pub address: *mut CAddress,
    pub tokens: *mut CArray<CEeeChainToken>,
}


#[repr(C)]
#[derive(Debug, DlStruct, DlDefault, DlCR)]
pub struct CAccountInfoSyncProg {
    pub account: *mut c_char,
    pub blockNo: *mut c_char,
    pub blockHash: *mut c_char,
}

#[repr(C)]
#[derive(Debug, DlStruct, DlDefault, DlCR)]
pub struct CSubChainBasicInfo {
    pub genesisHash: *mut c_char,
    pub metadata: *mut c_char,
    pub runtimeVersion: i32,
    pub txVersion: i32,
    pub ss58FormatPrefix: i32,
    pub tokenDecimals: i32,
    pub tokenSymbol: *mut c_char,
    pub isDefault: CBool,
}
