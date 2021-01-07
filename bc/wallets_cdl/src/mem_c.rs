#![allow(non_snake_case)]
#![allow(non_upper_case_globals)]

use std::os::raw::c_char;

use crate::kits::{CArray, CBool, CStruct, d_ptr_alloc, d_ptr_free};
use crate::parameters::{CContext, CDbName};
use crate::types::{CError, CWallet};

/// alloc ** [parameters::CContext]
#[no_mangle]
pub extern "C" fn CContext_dAlloc() -> *mut *mut CContext {
    d_ptr_alloc()
}

/// free ** [parameters::CContext]
#[no_mangle]
pub unsafe extern "C" fn CContext_dFree(dPtr: *mut *mut CContext) {
    let mut dPtr = dPtr;
    d_ptr_free(&mut dPtr);
}

/// alloc ** [CArray]
#[no_mangle]
pub extern "C" fn CArrayCContext_dAlloc() -> *mut *mut CArray<CContext> {
    d_ptr_alloc()
}

#[no_mangle]
pub unsafe extern "C" fn CArrayCContext_dFree(dPtr: *mut *mut CArray<CContext>) {
    let mut dPtr = dPtr;
    d_ptr_free(&mut dPtr);
}

#[no_mangle]
pub unsafe extern "C" fn CStr_dFree(dcs: *mut *mut c_char) {
    let mut dcs = dcs;
    d_ptr_free(&mut dcs);
}

#[no_mangle]
pub unsafe extern "C" fn CStr_dAlloc() -> *mut *mut c_char {
    return d_ptr_alloc();
}

#[no_mangle]
pub unsafe extern "C" fn CBool_dFree(dcs: *mut *mut CBool) {
    let mut dcs = dcs;
    d_ptr_free(&mut dcs);
}

#[no_mangle]
pub unsafe extern "C" fn CBool_dAlloc() -> *mut *mut CBool {
    return d_ptr_alloc();
}


#[no_mangle]
pub unsafe extern "C" fn CError_free(error: *mut CError) {
    let mut error = error;
    error.free();
}

#[no_mangle]
pub extern "C" fn CWallet_dAlloc() -> *mut *mut CWallet {
    d_ptr_alloc()
}

#[no_mangle]
pub unsafe extern "C" fn CWallet_dFree(dPtr: *mut *mut CWallet) {
    let mut dPtr = dPtr;
    d_ptr_free(&mut dPtr);
}

#[no_mangle]
pub extern "C" fn CArrayCWallet_dAlloc() -> *mut *mut CArray<CWallet> {
    d_ptr_alloc()
}

#[no_mangle]
pub unsafe extern "C" fn CArrayCWallet_dFree(dPtr: *mut *mut CArray<CWallet>) {
    let mut dPtr = dPtr;
    d_ptr_free(&mut dPtr);
}

#[no_mangle]
pub extern "C" fn CDbName_dAlloc() -> *mut *mut CDbName {
    d_ptr_alloc()
}

#[no_mangle]
pub unsafe extern "C" fn CDbName_dFree(dPtr: *mut *mut CDbName) {
    let mut dPtr = dPtr;
    d_ptr_free(&mut dPtr);
}

#[no_mangle]
pub extern "C" fn CArrayInt64_dAlloc() -> *mut *mut CArray<i64> {
    d_ptr_alloc()
}

#[no_mangle]
pub unsafe extern "C" fn CArrayInt64_dFree(dPtr: *mut *mut CArray<i64>) {
    let mut dPtr = dPtr;
    d_ptr_free(&mut dPtr);
}
// alloc free end