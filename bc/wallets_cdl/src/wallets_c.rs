#![allow(non_snake_case)]
#![allow(non_upper_case_globals)]

use std::os::raw::c_char;

use async_std::task::block_on;

use wallets::{Wallets, WalletsCollection};
use wallets_types::{Context, Error};

use crate::kits::{CArray, CR, CStruct, d_ptr_alloc, d_ptr_free, to_c_char};
use crate::parameters::{CContext, CCreateWalletParameters, CInitParameters};
use crate::types::{CError, CWallet};

/// dart中不要复制Context的内存，在调用 [Wallets_uninit] 后，调用Context的内存函数释放它
#[no_mangle]
pub unsafe extern "C" fn Wallets_init(parameter: *mut CInitParameters, context: *mut *mut CContext) -> *const CError {
    log::debug!("enter Wallets_init");
    if context.is_null() || parameter.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx or parameter is null");
        log::info!("{}",err);
        return CError::to_c_ptr(&err);
    }
    (*context).free();

    let mut parameter = CInitParameters::ptr_rust(parameter);
    let lock = WalletsCollection::collection().lock();
    let mut ins = lock.borrow_mut();

    let err = {
        let new_ctx = Context::new(&parameter.context_note);
        if let Some(ws) = ins.new(new_ctx) {
            if let Err(e) = block_on(ws.init(&mut parameter)) {
                Error::from(e)
            } else {
                *context = CContext::to_c_ptr(&ws.ctx);
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
pub unsafe extern "C" fn Wallets_uninit(ctx: *mut CContext) -> *const CError {
    log::debug!("enter Wallets_uninit");
    if ctx.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx is null");
        log::info!("{}",err);
        return CError::to_c_ptr(&err);
    }

    let lock = WalletsCollection::collection().lock();
    let mut ins = lock.borrow_mut();
    let err = {
        if let Some(mut ws) = ins.remove(&CContext::get_id(ctx)) {
            if let Err(e) = block_on(ws.uninit()) {
                Error::from(e)
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

/// 返回所有的Context,如果没有返回空，且Error::SUCCESS()
#[no_mangle]
pub unsafe extern "C" fn Wallets_Contexts(contexts: *mut *mut CArray<CContext>) -> *const CError {
    log::debug!("enter Wallets_Contexts");
    if contexts.is_null() {
        let err = Error::PARAMETER().append_message(" : contexts is null");
        log::info!("{}",err);
        return CError::to_c_ptr(&err);
    }
    (*contexts).free();
    let lock = WalletsCollection::collection().lock();
    let ins = lock.borrow();
    let err = {
        if let Some(ctxs) = ins.contexts() {
            let ctxs = ctxs.iter().map(|c| CContext::to_c(&c)).rev().collect();
            *contexts = Box::into_raw(Box::new(CArray::new(ctxs)));
        }
        Error::SUCCESS()
    };
    log::debug!("{}",err);
    CError::to_c_ptr(&err)
}

/// 返回最后的Context,如果没有返回空，且Error::SUCCESS()
#[no_mangle]
pub unsafe extern "C" fn Wallets_lastContext(context: *mut *mut CContext) -> *const CError {
    log::debug!("enter Wallets_lastContext");
    if context.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx is null");
        log::info!("{}",err);
        return CError::to_c_ptr(&err);
    }
    (*context).free();
    let lock = WalletsCollection::collection().lock();
    let ins = lock.borrow();
    let err = {
        if let Some(ctx) = ins.last_context() {
            *context = CContext::to_c_ptr(&ctx);
        }
        Error::SUCCESS()
    };
    log::debug!("{}",err);
    CError::to_c_ptr(&err)
}

/// 返回最后的Context,如果没有返回空，且Error::SUCCESS()
#[no_mangle]
pub unsafe extern "C" fn Wallets_firstContext(context: *mut *mut CContext) -> *const CError {
    log::debug!("enter Wallets_firstContext");
    if context.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx is null");
        log::info!("{}",err);
        return CError::to_c_ptr(&err);
    }
    (*context).free();
    let lock = WalletsCollection::collection().lock();
    let ins = lock.borrow();
    let err = {
        if let Some(ctx) = ins.first_context() {
            *context = CContext::to_c_ptr(&ctx);
        }
        Error::SUCCESS()
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
    (*arrayWallet).free();//如果数组的内存已经分配，释放它

    let lock = WalletsCollection::collection().lock();
    let mut ins = lock.borrow_mut();
    let err = {
        if let Some(ws) = ins.get_mut(&CContext::get_id(ctx)) {
            let mut all = vec![];
            if let Err(e) = async_std::task::block_on(ws.all(&mut all)) {
                Error::from(e)
            } else {
                let cws = all.iter().map(|rw| CWallet::to_c(&rw)).rev().collect();
                *arrayWallet = Box::into_raw(Box::new(CArray::new(cws)));
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
pub unsafe extern "C" fn Wallets_generateMnemonic(mnemonic: *mut *mut c_char) -> *const CError {
    log::debug!("enter Wallets_generateMnemonic");
    if mnemonic.is_null() {
        let err = Error::PARAMETER().append_message(" : mnemonic is null");
        log::info!("{}",err);
        return CError::to_c_ptr(&err);
    }
    (*mnemonic).free();//如果内存已存在，释放它

    let err = {
        let mn = Wallets::generate_mnemonic();
        *mnemonic = to_c_char(&mn);
        Error::SUCCESS()
    };

    log::debug!("{}",err);
    CError::to_c_ptr(&err)
}

#[no_mangle]
pub unsafe extern "C" fn Wallets_createWallet(ctx: *mut CContext, parameters: *mut CCreateWalletParameters, wallet: *mut *mut CWallet) -> *const CError {
    log::debug!("enter Wallets_createWallet");
    if ctx.is_null() || parameters.is_null() || wallet.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx or parameters or wallet is null");
        log::info!("{}",err);
        return CError::to_c_ptr(&err);
    }
    (*wallet).free();//如果内存已存在，释放它

    let lock = WalletsCollection::collection().lock();
    let mut ins = lock.borrow_mut();
    let err = {
        if let Some(ws) = ins.get_mut(&CContext::get_id(ctx)) {
            let parameters = CCreateWalletParameters::ptr_rust(parameters);
            match async_std::task::block_on(ws.create_wallet(parameters)) {
                Err(e) => Error::from(e),
                Ok(w) => {
                    *wallet = CWallet::to_c_ptr(&w);
                    Error::SUCCESS()
                }
            }
        } else {
            Error::NONE().append_message(": can not find the context")
        }
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
    (*wallet).free();//如果内存已存在，释放它

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
    (*arrayWallet).free();//如果内存已存在，释放它

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
