use std::os::raw::c_char;

use crate::kits::{CArray};
use crate::types::{CBool, CError, CFalse, CTrue, InitParameters, UnInitParameters, Wallet, Context};

static mut WALLETS: wallets::Wallets = wallets::Wallets{};

#[no_mangle]
pub extern "C" fn CChar_free(cs: *mut c_char) {
    unsafe {
        if !cs.is_null() {
            Box::from_raw(cs);
        }
    }
}

#[no_mangle]
pub unsafe extern "C" fn Wallets_lockRead() -> CBool {
    if WALLETS.lock_read() {
        CTrue
    } else {
        CFalse
    }
}

#[no_mangle]
pub unsafe extern "C" fn Wallets_unlockRead() -> CBool {
    if WALLETS.unlock_read() {
        CTrue
    } else {
        CFalse
    }
}

#[no_mangle]
pub unsafe extern "C" fn Wallets_lockWrite() -> CBool {
    if WALLETS.lock_write() {
        CTrue
    } else {
        CFalse
    }
}

#[no_mangle]
pub unsafe extern "C" fn Wallets_unlockWrite() -> CBool {
    if WALLETS.unlock_read() {
        CTrue
    } else {
        CFalse
    }
}

#[no_mangle]
pub unsafe extern "C" fn Wallets_init(params: *mut InitParameters) -> *const CError {
    let cerr = Box::new(CError::default());
    let mut p = wallets_types::InitParameters {};
    let err = WALLETS.init(&mut p);

    Box::into_raw(cerr)
}

#[no_mangle]
pub unsafe extern "C" fn Wallets_uninit(params: *mut UnInitParameters) -> *const CError {
    let cerr = Box::new(CError::default());
    let mut p = wallets_types::UnInitParameters {};
    let err = WALLETS.uninit(&mut p);

    Box::into_raw(cerr)
}

#[no_mangle]
pub unsafe extern "C" fn Wallets_all(ctx: *mut Context, ptr: *mut CArray<Wallet>) -> *const CError {
    let cerr = Box::new(CError::default());

    if ptr.is_null() {//todo 参数不正确
        // err.code ==
        return Box::into_raw(cerr);
    }

    let mut tctx = wallets_types::WalletsContext {};
    let mut ws = vec![];
    let _ = WALLETS.all(&mut tctx, &mut ws);
    //todo 类型转换
    let ws = ws.iter().map(|_| Wallet::default()).collect();

    let mut cws = Box::from_raw(ptr);
    cws.set(ws);
    let _ = Box::into_raw(cws);//不要释放内存
    Box::into_raw(cerr)
}



