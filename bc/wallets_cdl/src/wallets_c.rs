#![allow(non_snake_case)]
#![allow(non_upper_case_globals)]

use std::os::raw::c_char;
use std::ptr::null_mut;
use async_std::task::block_on;

use wallets::WalletsCollection;
use wallets_types::{Error, UnInitParameters};

use crate::kits::{CArray, CR};
use crate::parameters::{CContext, CInitParameters, CUnInitParameters};
use crate::types::{CError, CWallet};

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
    log::debug!("enter Wallets_init");
    if ctx.is_null() || parameter.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx or parameter is null");
        log::info!("{}",err);
        return CError::to_c_ptr(&err);
    }
    let mut parameter = CInitParameters::ptr_rust(parameter);
    let lock = WalletsCollection::collection().lock();
    let mut ins = lock.borrow_mut();

    let err = {
        if let Some(ws) = ins.new() {
            if let Err(e) = block_on(ws.init(&mut parameter)) {
                e
            } else {
                *ctx = CContext::to_c_ptr(&ws.ctx);
                Error::SUCCESS()
            }
        } else {
            Error::NONE().append_message(": can not find the context")
        }
    };
    log::info!("{}",err);
    CError::to_c_ptr(&err)
}

#[no_mangle]
pub unsafe extern "C" fn Wallets_uninit(ctx: *mut CContext, parameter: *mut CUnInitParameters) -> *const CError {
    log::debug!("enter Wallets_uninit");
    if ctx.is_null() || parameter.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx or parameter is null");
        log::info!("{}",err);
        return CError::to_c_ptr(&err);
    }
    let mut rp = UnInitParameters {};

    let lock = WalletsCollection::collection().lock();
    let mut ins = lock.borrow_mut();
    let err = {
        if let Some(mut ws) = ins.remove(&CContext::get_id(ctx)) {
            if let Err(e) = ws.uninit(&mut rp) {
                e
            } else {
                Error::SUCCESS()
            }
        } else {
            Error::NONE().append_message(": can not find the context")
        }
    };
    log::info!("{}",err);
    CError::to_c_ptr(&err)
}

#[no_mangle]
pub unsafe extern "C" fn Wallets_lockRead(ctx: *mut CContext) -> *const CError {
    log::debug!("enter Wallets_lockRead");
    if ctx.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx is null");
        log::info!("{}",err);
        return CError::to_c_ptr(&err);
    }
    let lock = WalletsCollection::collection().lock();
    let mut ins = lock.borrow_mut();
    let err = if let Some(ws) = ins.get_mut(&CContext::get_id(ctx)) {
        if ws.lock_read() {
            Error::SUCCESS()
        } else {
            Error::FAIL()
        }
    } else {
        Error::NONE().append_message(": can not find the context")
    };
    log::info!("{}",err);
    CError::to_c_ptr(&err)
}

#[no_mangle]
pub unsafe extern "C" fn Wallets_unlockRead(ctx: *mut CContext) -> *const CError {
    log::debug!("enter Wallets_unlockRead");
    if ctx.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx is null");
        log::info!("{}",err);
        return CError::to_c_ptr(&err);
    }
    let lock = WalletsCollection::collection().lock();
    let mut ins = lock.borrow_mut();
    let err = {
        if let Some(ws) = ins.get_mut(&CContext::get_id(ctx)) {
            if ws.unlock_read() {
                Error::SUCCESS()
            } else {
                Error::FAIL()
            }
        } else {
            Error::NONE().append_message(": can not find the context")
        }
    };
    log::info!("{}",err);
    CError::to_c_ptr(&err)
}

#[no_mangle]
pub unsafe extern "C" fn Wallets_lockWrite(ctx: *mut CContext) -> *const CError {
    log::debug!("enter Wallets_lockWrite");
    if ctx.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx is null");
        log::info!("{}",err);
        return CError::to_c_ptr(&err);
    }
    let lock = WalletsCollection::collection().lock();
    let mut ins = lock.borrow_mut();
    let err = {
        if let Some(ws) = ins.get_mut(&CContext::get_id(ctx)) {
            if ws.lock_write() {
                Error::SUCCESS()
            } else {
                Error::FAIL()
            }
        } else {
            Error::NONE().append_message(": can not find the context")
        }
    };
    log::info!("{}",err);
    CError::to_c_ptr(&err)
}

#[no_mangle]
pub unsafe extern "C" fn Wallets_unlockWrite(ctx: *mut CContext) -> *const CError {
    log::debug!("enter Wallets_unlockWrite");
    if ctx.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx is null");
        log::info!("{}",err);
        return CError::to_c_ptr(&err);
    }
    let lock = WalletsCollection::collection().lock();
    let mut ins = lock.borrow_mut();
    let err = {
        if let Some(ws) = ins.get_mut(&CContext::get_id(ctx)) {
            if ws.unlock_write() {
                Error::SUCCESS()
            } else {
                Error::FAIL()
            }
        } else {
            Error::NONE().append_message(": can not find the context")
        }
    };
    log::info!("{}",err);
    CError::to_c_ptr(&err)
}

#[no_mangle]
pub unsafe extern "C" fn Wallets_all(ctx: *mut CContext, arrayWallet: *mut *mut CArray<CWallet>) -> *const CError {
    log::debug!("enter Wallets_all");
    if ctx.is_null() || arrayWallet.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx or arrayWallet is null");
        log::info!("{}",err);
        return CError::to_c_ptr(&err);
    }

    if !(*arrayWallet).is_null() { //如果数组的内存已经分配，释放它
        let _ = Box::from_raw(*arrayWallet);
        *arrayWallet = null_mut();
    }

    let lock = WalletsCollection::collection().lock();
    let mut ins = lock.borrow_mut();
    let ws = ins.get_mut(&CContext::get_id(ctx)).expect("let ws = ins.get_mut(&CContext::get_id(ctx))");

    let mut all = vec![];
    let _ = async_std::task::block_on(ws.all(&mut all));
    let cws = all.iter().map(|rw| CWallet::to_c(&rw)).rev().collect();
    *arrayWallet = Box::into_raw(Box::new(CArray::<CWallet>::new(cws)));
    let err = Error::SUCCESS();
    log::info!("{}",err);
    CError::to_c_ptr(&err)
}



