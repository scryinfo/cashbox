#![allow(non_snake_case)]
#![allow(non_upper_case_globals)]

use std::os::raw::c_char;

use wallets_macro::{DlCR, DlDefault, DlStruct};
use wallets_types::{Context, DbName, InitParameters, UnInitParameters};

use crate::kits::{CR, CStruct, pointer_alloc, pointer_free, to_c_char, to_str};

#[repr(C)]
#[derive(Debug, Clone, DlStruct, DlDefault, DlCR)]
pub struct CInitParameters {
    pub dbName: *mut CDbName,
}

#[repr(C)]
#[derive(Debug, Clone, DlStruct, DlDefault, DlCR)]
pub struct CDbName {
    pub cashboxWallets: *mut c_char,
    pub cashboxMnemonic: *mut c_char,
    pub walletMainnet: *mut c_char,
    pub walletPrivate: *mut c_char,
    pub walletTestnet: *mut c_char,
    pub walletTestnetPrivate: *mut c_char,
}

#[repr(C)]
#[derive(Debug, Clone, DlStruct, DlDefault, DlCR)]
pub struct CUnInitParameters {}

#[repr(C)]
#[derive(Debug, Clone, DlStruct, DlDefault, DlCR)]
pub struct CContext {
    pub id: *mut c_char, //上下文的唯一标识
}

impl CContext {
    pub fn get_id(ctx: *mut CContext) -> String {
        if ctx.is_null() {
            panic!("ptr is null in get_id ");
        }
        let c = unsafe { Box::from_raw(ctx) };
        let id = to_str(c.id);
        Box::into_raw(c);
        id.to_owned()
    }
    pub fn get_id_d(ctx: *mut *mut CContext) -> String {
        unsafe {
            if ctx.is_null() || !(*ctx).is_null() {
                panic!("ptr is null in get_id_d ");
            }
        }
        let c = unsafe { Box::from_raw(*ctx) };
        let id = to_str(c.id);
        Box::into_raw(c);
        id.to_owned()
    }
}

#[no_mangle]
pub extern "C" fn Context_dAlloc() -> *mut *mut CContext {
    pointer_alloc()
}

#[no_mangle]
pub unsafe extern "C" fn Context_dFree(dPtr: *mut *mut CContext) {
    pointer_free(dPtr)
}


