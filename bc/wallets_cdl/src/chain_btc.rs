#![allow(non_snake_case)]

use wallets_macro::{DlCR, DlDefault, DlStruct};
use wallets_types::{BtcChain, BtcChainToken, BtcChainTokenShared};

use crate::kits::{CArray, CR, CStruct};
use crate::types::{CChainShared, CTokenShared};

#[repr(C)]
#[derive(Debug, Clone, DlStruct, DlDefault, DlCR)]
pub struct CBtcChainToken {
    pub btcChainTokenShared: *mut CBtcChainTokenShared,
}

#[repr(C)]
#[derive(Debug, Clone, DlStruct, DlDefault, DlCR)]
pub struct CBtcChainTokenShared {
    pub tokenShared: *mut CTokenShared,
}

#[repr(C)]
#[derive(Debug, Clone, DlStruct, DlDefault, DlCR)]
pub struct CBtcChain {
    pub chainShared: *mut CChainShared,
    pub tokens: *mut CArray<CBtcChainToken>,
}
