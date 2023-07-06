#![allow(non_snake_case)]

use std::os::raw::c_char;

use wallets_macro::{DlCR, DlDefault, DlStruct};
use wallets_types::{BtcChain, BtcChainToken, BtcChainTokenAuth, BtcChainTokenDefault, BtcChainTokenShared};

use crate::kits::{Assignment, CArray, CBool, CR, CStruct, to_c_char, to_str};
use crate::types::{CChainShared, CTokenShared};

#[repr(C)]
#[derive(Debug, DlStruct, DlDefault, DlCR)]
pub struct CBtcChainToken {
    pub show: CBool,
    pub chainTokenSharedId: *mut c_char,
    pub btcChainTokenShared: *mut CBtcChainTokenShared,
}

#[repr(C)]
#[derive(Debug, DlStruct, DlDefault, DlCR)]
pub struct CBtcChainTokenShared {
    pub tokenShared: *mut CTokenShared,
    pub tokenType: *mut c_char,
    pub fee_per_byte: i64,
    pub decimal: i32,
}


#[repr(C)]
#[derive(Debug, DlStruct, DlDefault, DlCR)]
pub struct CBtcChainTokenDefault {
    pub chainTokenSharedId: *mut c_char,
    pub netType: *mut c_char,
    pub position: i64,
    pub btcChainTokenShared: *mut CBtcChainTokenShared,
}

#[repr(C)]
#[derive(Debug, DlStruct, DlDefault, DlCR)]
pub struct CBtcChainTokenAuth {
    pub chainTokenSharedId: *mut c_char,
    pub netType: *mut c_char,
    pub position: i64,
    pub btcChainTokenShared: *mut CBtcChainTokenShared,
}

#[repr(C)]
#[derive(Debug, DlStruct, DlDefault, DlCR)]
pub struct CBtcChain {
    pub chainShared: *mut CChainShared,
    pub tokens: *mut CArray<CBtcChainToken>,
}