
use wallets::Wallets;
use crate::wallets_c::{CError,CBool,CFalse,CTrue};


#[no_mangle]
pub extern "C" fn Error_free(error: *mut CError){
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