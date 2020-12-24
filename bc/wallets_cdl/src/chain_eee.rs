#![allow(non_snake_case)]

use std::os::raw::c_char;

use wallets_macro::{DlCR, DlDefault, DlStruct};
use wallets_types::{EeeChain, EeeChainToken, EeeChainTokenShared, SubChainBasicInfo, SyncRecordDetail};

use crate::kits::{CArray, CMark, CR, CStruct, to_c_char, to_str};
use crate::types::{CAddress, CChainShared, CTokenShared};

#[repr(C)]
#[derive(Debug, Clone, DlStruct, DlDefault, DlCR)]
pub struct CEeeChainToken {
    pub eeeChainTokenShared: *mut CEeeChainTokenShared,
}

#[repr(C)]
#[derive(Debug, Clone, DlStruct, DlDefault, DlCR)]
pub struct CEeeChainTokenShared {
    pub tokenShared: *mut CTokenShared,
}

#[repr(C)]
#[derive(Debug, Clone, DlStruct, DlDefault, DlCR)]
pub struct CEeeChain {
    pub chainShared: *mut CChainShared,
    pub address: *mut CAddress,
    pub tokens: *mut CArray<CEeeChainToken>,
}


#[repr(C)]
#[derive(Debug, Clone, DlStruct, DlDefault, DlCR)]
pub struct CSyncRecordDetail {
    pub account: *mut c_char,
    pub blockNo: *mut c_char,
    pub blockHash: *mut c_char,
}

#[repr(C)]
#[derive(Debug, Clone, DlStruct, DlDefault, DlCR)]
pub struct CSubChainBasicInfo {
    pub infoId: *mut c_char,
    pub genesisHash: *mut c_char,
    pub metadata: *mut c_char,
    pub runtimeVersion: u32,
    pub txVersion: u32,
    pub ss58Format: u32,
    pub tokenDecimals: u32,
    pub tokenSymbol: *mut c_char,
}
