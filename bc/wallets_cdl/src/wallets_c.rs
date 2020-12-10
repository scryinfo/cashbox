#![allow(non_snake_case)]
#![allow(non_upper_case_globals)]

use std::os::raw::c_char;
use std::ptr::null_mut;

use async_std::task::block_on;

use wallets::WalletsCollection;
use wallets_types::{Error, UnInitParameters};

use crate::kits::{CArray, CR, CStruct, d_ptr_alloc, d_ptr_free, d_str_free};
use crate::parameters::{CContext, CCreateWalletParameters, CInitParameters, CUnInitParameters};
use crate::types::{CError, CWallet};

/// dart中不要复制Context的内存，会在调用 [Wallets_uninit] 释放内存
#[no_mangle]
pub unsafe extern "C" fn Wallets_init(parameter: *mut CInitParameters, ctx: *mut *mut CContext) -> *const CError {
    log::debug!("enter Wallets_init");
    if ctx.is_null() || parameter.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx or parameter is null");
        log::info!("{}",err);
        return CError::to_c_ptr(&err);
    }
    if !(*ctx).is_null() {
        (*ctx).free();
        *ctx = null_mut();
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
    log::debug!("{}",err);
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
            if let Err(e) = block_on(ws.uninit(&mut rp)) {
                e
            } else {
                Error::SUCCESS()
            }
        } else {
            Error::NONE().append_message(": can not find the context")
        }
    };
    log::debug!("{}",err);
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
    log::debug!("{}",err);
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
    log::debug!("{}",err);
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
    log::debug!("{}",err);
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
    log::debug!("{}",err);
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
        (*arrayWallet).free();
        *arrayWallet = null_mut();
    }

    let lock = WalletsCollection::collection().lock();
    let mut ins = lock.borrow_mut();
    let err = {
        if let Some(ws) = ins.get_mut(&CContext::get_id(ctx)) {
            let mut all = vec![];
            if let Err(e) = async_std::task::block_on(ws.all(&mut all)) {
                e
            } else {
                let cws = all.iter().map(|rw| CWallet::to_c(&rw)).rev().collect();
                *arrayWallet = Box::into_raw(Box::new(CArray::<CWallet>::new(cws)));
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
pub unsafe extern "C" fn Wallets_generateMnemonic(mnemonic: *mut *mut c_char) -> *const CError {
    log::debug!("enter Wallets_generateMnemonic");
    if mnemonic.is_null() {
        let err = Error::PARAMETER().append_message(" : mnemonic is null");
        log::info!("{}",err);
        return CError::to_c_ptr(&err);
    }

    if !(*mnemonic).is_null() { //如果内存已存在，释放它
        (*mnemonic).free();
        *mnemonic = null_mut();
    }

    let err = {
        //todo
        Error::SUCCESS()
    };

    log::debug!("{}",err);
    CError::to_c_ptr(&err)
}

#[no_mangle]
pub unsafe extern "C" fn Wallets_createWallet(ctx: *mut CContext, parameters: *mut CCreateWalletParameters, walletId: *mut *mut c_char) -> *const CError {
    log::debug!("enter Wallets_createWallet");
    if ctx.is_null() || parameters.is_null() || walletId.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx or parameters or walletId is null");
        log::info!("{}",err);
        return CError::to_c_ptr(&err);
    }

    if !(*walletId).is_null() { //如果内存已存在，释放它
        (*walletId).free();
        *walletId = null_mut();
    }

    let err = {
        //todo
        Error::SUCCESS()
    };

    log::debug!("{}",err);
    CError::to_c_ptr(&err)
}

#[no_mangle]
pub unsafe extern "C" fn Wallets_deleteWallet(ctx: *mut CContext, walletId: *mut c_char) -> *const CError {
    log::debug!("enter Wallets_deleteWallet");
    if ctx.is_null() || walletId.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx or walletId is null");
        log::info!("{}",err);
        return CError::to_c_ptr(&err);
    }

    let err = {
        //todo
        Error::SUCCESS()
    };

    log::debug!("{}",err);
    CError::to_c_ptr(&err)
}

/// Success: true; Fail: false
#[no_mangle]
pub unsafe extern "C" fn Wallets_hasOne(ctx: *mut CContext) -> *const CError {
    log::debug!("enter Wallets_hasOne");
    if ctx.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx is null");
        log::info!("{}",err);
        return CError::to_c_ptr(&err);
    }

    let err = {
        //todo
        Error::SUCCESS()
    };

    log::debug!("{}",err);
    CError::to_c_ptr(&err)
}

#[no_mangle]
pub unsafe extern "C" fn Wallets_findById(ctx: *mut CContext, walletId: *mut c_char, wallet: *mut *mut CWallet) -> *const CError {
    log::debug!("enter Wallets_findById");
    if ctx.is_null() || walletId.is_null() || wallet.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx or walletId or wallet is null");
        log::info!("{}",err);
        return CError::to_c_ptr(&err);
    }

    if !(*wallet).is_null() { //如果内存已存在，释放它
        (*wallet).free();
        *wallet = null_mut();
    }

    let err = {
        //todo
        Error::SUCCESS()
    };

    log::debug!("{}",err);
    CError::to_c_ptr(&err)
}

#[no_mangle]
pub unsafe extern "C" fn Wallets_findByName(ctx: *mut CContext, name: *mut c_char, arrayWallet: *mut *mut CArray<CWallet>) -> *const CError {
    log::debug!("enter Wallets_findById");
    if ctx.is_null() || name.is_null() || arrayWallet.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx or name or arrayWallet is null");
        log::info!("{}",err);
        return CError::to_c_ptr(&err);
    }

    if !(*arrayWallet).is_null() { //如果内存已存在，释放它
        (*arrayWallet).free();
        *arrayWallet = null_mut();
    }

    let err = {
        //todo
        Error::SUCCESS()
    };

    log::debug!("{}",err);
    CError::to_c_ptr(&err)
}

// alloc free start
#[no_mangle]
pub extern "C" fn CContext_dAlloc() -> *mut *mut CContext {
    d_ptr_alloc()
}

#[no_mangle]
pub unsafe extern "C" fn CContext_dFree(dPtr: *mut *mut CContext) {
    let mut dPtr = dPtr;
    d_ptr_free(&mut dPtr);
}

#[no_mangle]
pub unsafe extern "C" fn CStr_dFree(dcs: *mut *mut c_char) {
    let mut dcs = dcs;
    d_str_free(&mut dcs);
}

#[no_mangle]
pub unsafe extern "C" fn CStr_dAlloc() -> *mut *mut c_char {
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

// alloc free end
