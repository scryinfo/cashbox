use wallets::Wallets;
use crate::types::{InitParameters, UnInitParameters, CError, CBool, CTrue, CFalse};
use std::os::raw::c_char;

#[no_mangle]
pub extern "C" fn CChar_free(cs: *mut c_char) {
    unsafe {
        if !cs.is_null() {
            Box::from_raw(cs);
        }
    }
}

#[no_mangle]
pub extern "C" fn CError_free(error: *mut CError) {
    unsafe {
        if !error.is_null() {
            Box::from_raw(error);
        }
    }
}

#[no_mangle]
pub extern "C" fn Wallets_lockRead() -> CBool {
    if Wallets::lock_read() {
        CTrue
    } else {
        CFalse
    }
}

#[no_mangle]
pub extern "C" fn Wallets_unlockRead() -> CBool {
    if Wallets::unlock_read() {
        CTrue
    } else {
        CFalse
    }
}

#[no_mangle]
pub extern "C" fn Wallets_lockWrite() -> CBool {
    if Wallets::lock_write() {
        CTrue
    } else {
        CFalse
    }
}

#[no_mangle]
pub extern "C" fn Wallets_unlockWrite() -> CBool {
    if Wallets::unlock_read() {
        CTrue
    } else {
        CFalse
    }
}

#[no_mangle]
pub extern "C" fn Wallets_init(params: *mut InitParameters) -> *const CError {
    let err = Box::new(CError::default());
    Box::into_raw(err)
}

#[no_mangle]
pub extern "C" fn Wallets_uninit(params: *mut UnInitParameters) -> *const CError {
    let err = Box::new(CError::default());
    Box::into_raw(err)
}
