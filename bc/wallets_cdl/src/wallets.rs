#![allow(non_snake_case)]
#![allow(non_upper_case_globals)]

use std::os::raw::c_char;

use wallets::WalletsInstances;

use crate::kits::CArray;
use crate::parameters::{Context, InitParameters, UnInitParameters};
use crate::types::{CBool, CError, CFalse, CTrue, Wallet};

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
pub unsafe extern "C" fn Wallets_init(parameter: *mut InitParameters, ctx: *mut *mut Context) -> *const CError {
    let cerr = Box::new(CError::default());
    if parameter.is_null() || ctx.is_null() {
        //todo
    }
    let mut parameter = InitParameters::to_rust(parameter);
    let mut lock = WalletsInstances::instances().lock().expect("let &mut ws = WalletsInstances::instances().lock().");
    let ws = lock.new().expect("let mut ws = lock.new().");
    ws.init(&mut parameter);
    *ctx = Context::to_rust(&ws.ctx);

    Box::into_raw(cerr)
}

#[no_mangle]
pub unsafe extern "C" fn Wallets_uninit(ctx: *mut Context, parameter: *mut UnInitParameters) -> *const CError {
    let cerr = Box::new(CError::default());
    if parameter.is_null() || ctx.is_null() {
        //todo
    }
    let mut rp = wallets_types::UnInitParameters {};

    let mut lock = WalletsInstances::instances().lock().expect("let &mut ws = WalletsInstances::instances().lock().");
    let ws = lock.get(&Context::get_id(ctx)).expect("let mut ws = lock.new().");
    ws.uninit(&mut rp); //todo handle error
    Box::into_raw(cerr)
}

#[no_mangle]
pub unsafe extern "C" fn Wallets_lockRead(ctx: *mut Context) -> CBool {
    if ctx.is_null() {
        return CFalse;
    }
    let mut lock = WalletsInstances::instances().lock().expect("let &mut ws = WalletsInstances::instances().lock().");
    let ws = lock.get(&Context::get_id(ctx)).expect("let mut ws = lock.new().");
    if ws.lock_read() {
        CTrue
    } else {
        CFalse
    }
}

#[no_mangle]
pub unsafe extern "C" fn Wallets_unlockRead(ctx: *mut Context) -> CBool {
    if ctx.is_null() {
        return CFalse;
    }
    let mut lock = WalletsInstances::instances().lock().expect("let &mut ws = WalletsInstances::instances().lock().");
    let ws = lock.get(&Context::get_id(ctx)).expect("let mut ws = lock.new().");
    if ws.unlock_read() {
        CTrue
    } else {
        CFalse
    }
}

#[no_mangle]
pub unsafe extern "C" fn Wallets_lockWrite(ctx: *mut Context) -> CBool {
    if ctx.is_null() {
        return CFalse;
    }
    let mut lock = WalletsInstances::instances().lock().expect("let &mut ws = WalletsInstances::instances().lock().");
    let ws = lock.get(&Context::get_id(ctx)).expect("let mut ws = lock.new().");
    if ws.lock_write() {
        CTrue
    } else {
        CFalse
    }
}

#[no_mangle]
pub unsafe extern "C" fn Wallets_unlockWrite(ctx: *mut Context) -> CBool {
    if ctx.is_null() {
        return CFalse;
    }
    let mut lock = WalletsInstances::instances().lock().expect("let &mut ws = WalletsInstances::instances().lock().");
    let ws = lock.get(&Context::get_id(ctx)).expect("let mut ws = lock.new().");
    if ws.unlock_read() {
        CTrue
    } else {
        CFalse
    }
}

#[no_mangle]
pub unsafe extern "C" fn Wallets_all(ctx: *mut Context, arrayWallet: *mut CArray<Wallet>) -> *const CError {
    let cerr = Box::new(CError::default());

    if arrayWallet.is_null() {//todo 参数不正确

        return Box::into_raw(cerr);
    }

    let mut lock = WalletsInstances::instances().lock().expect("let &mut ws = WalletsInstances::instances().lock().");
    let ws = lock.get(&Context::get_id(ctx)).expect("let mut ws = lock.new().");

    let mut all = vec![];
    let _ = ws.all(&mut all);
    //todo 类型转换
    // let mut cws = all.iter().map(|rw| Wallet::to_c(&rw)).collect();

    let arrayWallet = Box::from_raw(arrayWallet);
    // cws.set(all);
    let _ = Box::into_raw(arrayWallet);//不要释放内存
    Box::into_raw(cerr)
}



