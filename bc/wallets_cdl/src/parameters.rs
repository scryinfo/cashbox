#![allow(non_snake_case)]
#![allow(non_upper_case_globals)]

use std::os::raw::c_char;

use wallets_macro::{DlDefault, DlStruct};

use crate::drop_ctype;
use crate::kits::{to_c_char, to_str};
use crate::kits::{CStruct, pointer_alloc, pointer_free};

#[repr(C)]
#[derive(Debug, Clone, DlStruct, DlDefault)]
pub struct InitParameters {
    pub dbName: *mut DbName,
}

impl InitParameters {
    pub fn to_rust(c_parameters: *mut InitParameters) -> wallets_types::InitParameters {
        let r_parameters = wallets_types::InitParameters::default();
        //todo
        r_parameters
    }
}

#[repr(C)]
#[derive(Debug, Clone, DlStruct, DlDefault)]
pub struct DbName {
    pub cashboxWallets: *mut c_char,
    pub cashboxMnemonic: *mut c_char,
    pub walletMainnet: *mut c_char,
    pub walletPrivate: *mut c_char,
    pub walletTestnet: *mut c_char,
    pub walletTestnetPrivate: *mut c_char,
}

impl DbName {
    pub fn to_rust(c_parameters: *mut DbName) -> wallets_types::DbName {
        let r_parameters = wallets_types::DbName::default();
        //todo
        r_parameters
    }
}

#[repr(C)]
#[derive(Debug, Clone, DlStruct, DlDefault)]
pub struct UnInitParameters {}

impl UnInitParameters {
    pub fn to_rust(c_parameters: *mut UnInitParameters) -> wallets_types::UnInitParameters {
        let r_paremeters = wallets_types::UnInitParameters::default();
        r_paremeters
    }
}

#[repr(C)]
#[derive(Debug, Clone, DlStruct, DlDefault)]
pub struct Context {
    pub id: *mut c_char, //上下文的唯一标识
}

impl Context {
    pub fn get_id(ctx: *mut Context) -> String {
        if ctx.is_null() {
            panic!("ptr is null in get_id ");
        }
        let c = unsafe { Box::from_raw(ctx) };
        let id = to_str(c.id);
        Box::into_raw(c);
        id.to_owned()
    }
    pub fn get_id_d(ctx: *mut *mut Context) -> String {
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
    pub fn to_rust(ctx: &wallets_types::Context) -> *mut Context {
        let mut temp = Box::new(Context::default());
        temp.id = to_c_char(&ctx.id);
        Box::into_raw(temp)
    }
}

#[no_mangle]
pub extern "C" fn Context_dAlloc() -> *mut *mut Context {
    pointer_alloc()
}

#[no_mangle]
pub unsafe extern "C" fn Context_dFree(dPtr: *mut *mut Context) {
    pointer_free(dPtr)
}


