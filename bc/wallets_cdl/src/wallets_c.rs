#![allow(non_snake_case)]
#![allow(non_upper_case_globals)]

use std::os::raw::c_char;

use async_std::task::block_on;

use mav::ChainType;
use wallets::{Contexts, Wallets};
use wallets_types::{Context, Error};

use crate::kits::{CArray, CBool, CFalse, CR, CStruct, CTrue, d_ptr_alloc, d_ptr_free, to_c_char, to_str};
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
    let lock = Contexts::collection().lock();
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
            Error::NONE().append_message(": can not create the context")
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

    let lock = Contexts::collection().lock();
    let mut ins = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        if let Some(mut ws) = ins.remove(&ctx.id) {
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
    let lock = Contexts::collection().lock();
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
    let lock = Contexts::collection().lock();
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
    let lock = Contexts::collection().lock();
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
    let lock = Contexts::collection().lock();
    let mut ins = lock.borrow_mut();
    let ctx = CContext::ptr_rust(ctx);
    let err = if let Some(ws) = ins.get_mut(&ctx.id) {
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
    let lock = Contexts::collection().lock();
    let mut ins = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        if let Some(ws) = ins.get_mut(&ctx.id) {
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
    let lock = Contexts::collection().lock();
    let mut ins = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        if let Some(ws) = ins.get_mut(&ctx.id) {
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
    let lock = Contexts::collection().lock();
    let mut ins = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        if let Some(ws) = ins.get_mut(&ctx.id) {
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

    let lock = Contexts::collection().lock();
    let mut ins = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        if let Some(ws) = ins.get_mut(&ctx.id) {
            match block_on(ws.all()) {
                Ok(ms) => {
                    *arrayWallet = CArray::to_c_ptr(&ms);
                    Error::SUCCESS()
                }
                Err(err) => Error::from(err)
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

    let lock = Contexts::collection().lock();
    let mut ins = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        if let Some(ws) = ins.get_mut(&ctx.id) {
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
pub unsafe extern "C" fn Wallets_removeWallet(ctx: *mut CContext, walletId: *mut c_char) -> *const CError {
    log::debug!("enter Wallets_removeWallet");
    if ctx.is_null() || walletId.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx or walletId is null");
        log::info!("{}",err);
        return CError::to_c_ptr(&err);
    }

    let lock = Contexts::collection().lock();
    let mut ins = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        if let Some(ws) = ins.get_mut(&ctx.id) {
            match block_on(ws.remove_by_id(to_str(walletId), "")) {
                Err(err) => Error::from(err),
                Ok(_) => Error::SUCCESS()
            }
        } else {
            Error::NONE().append_message(": can not find the context")
        }
    };

    log::debug!("{}",err);
    CError::to_c_ptr(&err)
}

#[no_mangle]
pub unsafe extern "C" fn Wallets_reNameWallet(ctx: *mut CContext, name: *mut c_char, walletId: *mut c_char) -> *const CError {
    log::debug!("enter Wallets_reNameWallet");
    if ctx.is_null() || name.is_null() || walletId.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx or name or walletId is null");
        log::info!("{}",err);
        return CError::to_c_ptr(&err);
    }

    let lock = Contexts::collection().lock();
    let mut ins = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        if let Some(ws) = ins.get_mut(&ctx.id) {
            match block_on(ws.re_name_wallet(to_str(name), to_str(walletId), "")) {
                Err(err) => Error::from(err),
                Ok(_) => Error::SUCCESS()
            }
        } else {
            Error::NONE().append_message(": can not find the context")
        }
    };

    log::debug!("{}",err);
    CError::to_c_ptr(&err)
}

/// Success: true; Fail: false
#[no_mangle]
pub unsafe extern "C" fn Wallets_hasAny(ctx: *mut CContext, hasAny: *mut CBool) -> *const CError {
    log::debug!("enter Wallets_hasAny");
    if ctx.is_null() || hasAny.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx or hasAny is null");
        log::info!("{}",err);
        return CError::to_c_ptr(&err);
    }

    let lock = Contexts::collection().lock();
    let mut ins = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        if let Some(ws) = ins.get(&ctx.id) {
            match async_std::task::block_on(ws.has_any()) {
                Err(err) => Error::from(err),
                Ok(b) => {
                    if b {
                        *hasAny = CTrue;
                    } else {
                        *hasAny = CFalse;
                    }
                    Error::NOT_EXIST()
                }
            }
        } else {
            Error::NONE().append_message(": can not find the context")
        }
    };

    log::debug!("{}",err);
    CError::to_c_ptr(&err)
}

/// Success: true; Fail: false
#[no_mangle]
pub unsafe extern "C" fn Wallets_currentWalletChain(ctx: *mut CContext, walletId: *mut *mut c_char, chainType: *mut *mut c_char) -> *const CError {
    log::debug!("enter Wallets_currentWalletChain");
    if ctx.is_null() || walletId.is_null() || chainType.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx or walletId or chainType is null");
        log::info!("{}",err);
        return CError::to_c_ptr(&err);
    }
    (*walletId).free();
    (*chainType).free();

    let lock = Contexts::collection().lock();
    let mut ins = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        if let Some(ws) = ins.get_mut(&ctx.id) {
            match async_std::task::block_on(ws.current_wallet_chain()) {
                Err(err) => Error::from(err),
                Ok(Some((w, c))) => {
                    *walletId = to_c_char(w.as_str());
                    *chainType = to_c_char(&c.to_string());
                    Error::SUCCESS()
                }
                Ok(None) => {
                    Error::NOT_EXIST()
                }
            }
        } else {
            Error::NONE().append_message(": can not find the context")
        }
    };

    log::debug!("{}",err);
    CError::to_c_ptr(&err)
}

/// Success: true; Fail: false
#[no_mangle]
pub unsafe extern "C" fn Wallets_saveCurrentWalletChain(ctx: *mut CContext, walletId: *mut c_char, chainType: *mut c_char) -> *const CError {
    log::debug!("enter Wallets_saveCurrentWalletChain");
    if ctx.is_null() || walletId.is_null() || chainType.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx or walletId or chainType is null");
        log::info!("{}",err);
        return CError::to_c_ptr(&err);
    }
    let chain_type = match ChainType::from(to_str(chainType)) {
        Err(err) => {
            let err = Error::PARAMETER().append_message(err.to_string().as_str());
            log::info!("{}",err);
            return CError::to_c_ptr(&err);
        }
        Ok(chain_type) => chain_type,
    };

    let wallet_id = {
        to_str(walletId)
    };

    let lock = Contexts::collection().lock();
    let mut ins = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        if let Some(ws) = ins.get_mut(&ctx.id) {
            match async_std::task::block_on(ws.save_current_wallet_chain(wallet_id, &chain_type)) {
                Err(err) => Error::from(err),
                Ok(_) => {
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
pub unsafe extern "C" fn Wallets_findById(ctx: *mut CContext, walletId: *mut c_char, wallet: *mut *mut CWallet) -> *const CError {
    log::debug!("enter Wallets_findById");
    if ctx.is_null() || wallet.is_null() || walletId.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx or wallet or walletId is null");
        log::info!("{}",err);
        return CError::to_c_ptr(&err);
    }
    (*wallet).free();

    let lock = Contexts::collection().lock();
    let mut ins = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        if let Some(ws) = ins.get(&ctx.id) {
            match block_on(ws.find_by_id(to_str(walletId))) {
                Err(err) => Error::from(err),
                Ok(Some(w)) => {
                    *wallet = CWallet::to_c_ptr(&w);
                    Error::SUCCESS()
                }
                Ok(None) => Error::NoRecord()
            }
        } else {
            Error::NONE().append_message(": can not find the context")
        }
    };

    log::debug!("{}",err);
    CError::to_c_ptr(&err)
}

///注：只加载了wallet的id name等直接的基本数据，链数据没有加载
#[no_mangle]
pub unsafe extern "C" fn Wallets_findWalletBaseByName(ctx: *mut CContext, name: *mut c_char, walletArray: *mut *mut CArray<CWallet>) -> *const CError {
    log::debug!("enter Wallets_findWalletBaseByName");
    if ctx.is_null() || name.is_null() || walletArray.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx or name or arrayWallet is null");
        log::info!("{}",err);
        return CError::to_c_ptr(&err);
    }
    (*walletArray).free();//如果内存已存在，释放它

    let lock = Contexts::collection().lock();
    let mut ins = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        if let Some(ws) = ins.get(&ctx.id) {
            match block_on(ws.find_wallet_base_by_name(to_str(name))) {
                Ok(ms) => {
                    *walletArray = CArray::to_c_ptr(&ms);
                    Error::SUCCESS()
                }
                Err(err) => Error::from(err)
            }
        } else {
            Error::NONE().append_message(": can not find the context")
        }
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

// alloc free end
