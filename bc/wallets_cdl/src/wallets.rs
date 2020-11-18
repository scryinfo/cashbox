
use wallets::Wallets;
use crate::{CU64, CBool, CTrue, CFalse};
use crate::types::{InitParameters, UnInitParameters, CError, CBool, CTrue, CFalse};
use std::fs::read_to_string;

#[no_mangle]
pub extern "C" fn CError_free(error: *mut CError){
    unsafe {
        Box::from_raw(error);
    }
}

#[no_mangle]
pub extern "C" fn Wallets_lockRead() -> CBool{
    if Wallets::lock_read() {
        CTrue
    }else{
        CFalse
    }
}
#[no_mangle]
pub extern "C"  fn Wallets_unlockRead() -> CBool{
    if Wallets::unlock_read() {
        CTrue
    }else{
        CFalse
    }
}
#[no_mangle]
pub extern "C"  fn Wallets_lockWrite() -> CBool {
    if Wallets::lock_write() {
        CTrue
    }else{
        CFalse
    }
}
#[no_mangle]
pub extern "C"  fn Wallets_unlockWrite() -> CBool{
    if Wallets::unlock_read() {
        CTrue
    }else{
        CFalse
    }
}

#[no_mangle]
pub extern "C" fn Wallets_init(params: *mut InitParameters) -> *const CError{
    let err = Box::new(CError);
    Box::into_raw(err)
}
#[no_mangle]
pub extern "C" fn Wallets_uninit(params: *mut UnInitParameters) -> *const CError{
    let err = Box::new(CError);
    Box::into_raw(err)
}
