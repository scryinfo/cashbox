#![allow(non_snake_case)]
#![allow(non_upper_case_globals)]

use std::os::raw::c_char;
use std::ptr::null_mut;

use wallets::WalletsInstances;
use wallets_types::UnInitParameters;

use crate::kits::{CArray, CR};
use crate::parameters::{CContext, CInitParameters, CUnInitParameters};
use crate::types::{CBool, CError, CFalse, CTrue, CWallet};

#[no_mangle]
pub extern "C" fn CChar_free(cs: *mut c_char) {
    unsafe {
        if !cs.is_null() {
            Box::from_raw(cs);
        }
    }
}

/// dart中不要复制Context的内存，会在调用 [Wallets_uninit] 释放内存
#[no_mangle]
pub unsafe extern "C" fn Wallets_init(parameter: *mut CInitParameters, ctx: *mut *mut CContext) -> *const CError {
    let cerr = Box::new(CError::default());
    if parameter.is_null() || ctx.is_null() {
        //todo
    }
    let mut parameter = CInitParameters::ptr_rust(parameter);
    let mut lock = WalletsInstances::instances().lock().expect("let &mut ws = WalletsInstances::instances().lock().");
    let ws = lock.new().expect("let mut ws = lock.new().");
    ws.init(&mut parameter);
    *ctx = CContext::to_c_ptr(&ws.ctx);

    Box::into_raw(cerr)
}

#[no_mangle]
pub unsafe extern "C" fn Wallets_uninit(ctx: *mut CContext, parameter: *mut CUnInitParameters) -> *const CError {
    let cerr = Box::new(CError::default());
    if parameter.is_null() || ctx.is_null() {
        //todo
    }
    let mut rp = UnInitParameters {};

    let mut lock = WalletsInstances::instances().lock().expect("let &mut ws = WalletsInstances::instances().lock().");
    let ws = lock.get(&CContext::get_id(ctx)).expect("let mut ws = lock.new().");
    ws.uninit(&mut rp); //todo handle error
    Box::into_raw(cerr)
}

#[no_mangle]
pub unsafe extern "C" fn Wallets_lockRead(ctx: *mut CContext) -> CBool {
    if ctx.is_null() {
        return CFalse;
    }
    let mut lock = WalletsInstances::instances().lock().expect("let &mut ws = WalletsInstances::instances().lock().");
    let ws = lock.get(&CContext::get_id(ctx)).expect("let mut ws = lock.new().");
    if ws.lock_read() {
        CTrue
    } else {
        CFalse
    }
}

#[no_mangle]
pub unsafe extern "C" fn Wallets_unlockRead(ctx: *mut CContext) -> CBool {
    if ctx.is_null() {
        return CFalse;
    }
    let mut lock = WalletsInstances::instances().lock().expect("let &mut ws = WalletsInstances::instances().lock().");
    let ws = lock.get(&CContext::get_id(ctx)).expect("let mut ws = lock.new().");
    if ws.unlock_read() {
        CTrue
    } else {
        CFalse
    }
}

#[no_mangle]
pub unsafe extern "C" fn Wallets_lockWrite(ctx: *mut CContext) -> CBool {
    if ctx.is_null() {
        return CFalse;
    }
    let mut lock = WalletsInstances::instances().lock().expect("let &mut ws = WalletsInstances::instances().lock().");
    let ws = lock.get(&CContext::get_id(ctx)).expect("let mut ws = lock.new().");
    if ws.lock_write() {
        CTrue
    } else {
        CFalse
    }
}

#[no_mangle]
pub unsafe extern "C" fn Wallets_unlockWrite(ctx: *mut CContext) -> CBool {
    if ctx.is_null() {
        return CFalse;
    }
    let mut lock = WalletsInstances::instances().lock().expect("let &mut ws = WalletsInstances::instances().lock().");
    let ws = lock.get(&CContext::get_id(ctx)).expect("let mut ws = lock.new().");
    if ws.unlock_read() {
        CTrue
    } else {
        CFalse
    }
}

#[no_mangle]
pub unsafe extern "C" fn Wallets_all(ctx: *mut CContext, arrayWallet: *mut *mut CArray<CWallet>) -> *const CError {
    let cerr = Box::new(CError::default());

    if arrayWallet.is_null() {//todo 参数不正确
        return Box::into_raw(cerr);
    }

    if !(*arrayWallet).is_null() { //如果数组的内存已经分配，释放它
        let _ = Box::from_raw(*arrayWallet);
        *arrayWallet = null_mut();
    }

    let mut lock = WalletsInstances::instances().lock().expect("let &mut ws = WalletsInstances::instances().lock().");
    let ws = lock.get(&CContext::get_id(ctx)).expect("let mut ws = lock.new().");

    let mut all = vec![];
    let _ = ws.all(&mut all);
    let cws = all.iter().map(|rw| CWallet::to_c(&rw)).collect();
    *arrayWallet = Box::into_raw(Box::new(CArray::<CWallet>::new(cws)));
    Box::into_raw(cerr)
}



