#![allow(non_snake_case)]
#![allow(non_upper_case_globals)]

use std::os::raw::c_char;

use wallets_macro::{DlCR, DlDefault, DlStruct};
use wallets_types::{Context, CreateWalletParameters, DbName, InitParameters};

use crate::kits::{CMark, CR, CStruct, to_c_char, to_str};

#[repr(C)]
#[derive(Debug, Clone, DlStruct, DlDefault, DlCR)]
pub struct CInitParameters {
    pub dbName: *mut CDbName,
    pub contextNote: *mut c_char,
}

#[repr(C)]
#[derive(Debug, Clone, DlStruct, DlDefault, DlCR)]
pub struct CDbName {
    pub path: *mut c_char,
    pub prefix: *mut c_char,
    pub cashbox_wallets: *mut c_char,
    pub cashbox_mnemonic: *mut c_char,
    pub wallet_mainnet: *mut c_char,
    pub wallet_private: *mut c_char,
    pub wallet_testnet: *mut c_char,
    pub wallet_testnet_private: *mut c_char,
}

// #[repr(C)]
// #[derive(Debug, Clone, DlStruct, DlDefault, DlCR)]
// pub struct CUnInitParameters {}

#[repr(C)]
#[derive(Debug, Clone, DlStruct, DlDefault, DlCR)]
pub struct CCreateWalletParameters {
    pub name: *mut c_char,
    pub password: *mut c_char,
    pub mnemonic: *mut c_char,
    pub walletType: *mut c_char,
}

#[repr(C)]
#[derive(Debug, Clone, DlStruct, DlDefault, DlCR)]
pub struct CContext {
    pub id: *mut c_char,
    //上下文的唯一标识
    pub contextNote: *mut c_char,
}


