#![allow(non_snake_case)]
#![allow(non_upper_case_globals)]

use std::os::raw::{c_char, c_uint};

use futures::executor::block_on;

use mav::{AppPlatformType, ChainType, NetType};
use wallets::{Contexts, Wallets};
use wallets_types::{Context, Error};

use crate::kits::{to_c_char, to_str, CArray, CBool, CFalse, CStruct, CTrue, CR};
use crate::parameters::{CContext, CCreateWalletParameters, CDbName, CInitParameters, CWalletTokenStatus};
use crate::types::{CError, CTokenAddress, CWallet};

/// 生成数据库文件名，只有数据库文件名不存在（为null或“”）时才创建文件名
/// 如果成功返回 [wallets_types::Error::SUCCESS()]
#[no_mangle]
pub unsafe extern "C" fn Wallets_dbName(
    name: *mut CDbName,
    outName: *mut *mut CDbName,
) -> *const CError {
    log::debug!("enter Wallets_init");
    if name.is_null() || outName.is_null() {
        let err = Error::PARAMETER().append_message(" : name or outName is null");
        log::info!("{}", err);
        return CError::to_c_ptr(&err);
    }
    (*outName).free();

    let name = CDbName::ptr_rust(name);
    let out_name = Wallets::db_name(&name);
    *outName = CDbName::to_c_ptr(&out_name);

    let err = Error::SUCCESS();
    log::debug!("{}", err);
    CError::to_c_ptr(&err)
}

/// 如果成功返回 [wallets_types::Error::SUCCESS()]
#[no_mangle]
pub unsafe extern "C" fn Wallets_init(
    parameter: *mut CInitParameters,
    context: *mut *mut CContext,
) -> *const CError {
    log::debug!("enter Wallets_init");
    if context.is_null() || parameter.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx or parameter is null");
        log::info!("{}", err);
        return CError::to_c_ptr(&err);
    }
    (*context).free();

    let lock = Contexts::collection().lock();
    let mut contexts = lock.borrow_mut();
    let err = {
        let parameter = CInitParameters::ptr_rust(parameter);
        let new_ctx = Context::new(&parameter.context_note);
        if let Some(wallets) = contexts.new(new_ctx) {
            match block_on(wallets.init(&parameter)) {
                Err(err) => Error::from(err),
                Ok(ctx) => {
                    *context = CContext::to_c_ptr(ctx);
                    Error::SUCCESS()
                }
            }
        } else {
            Error::NONE().append_message(": can not create the context")
        }
    };
    log::debug!("{}", err);
    CError::to_c_ptr(&err)
}

/// 如果成功返回 [wallets_types::Error::SUCCESS()]
#[no_mangle]
pub unsafe extern "C" fn Wallets_uninit(ctx: *mut CContext) -> *const CError {
    log::debug!("enter Wallets_uninit");
    if ctx.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx is null");
        log::info!("{}", err);
        return CError::to_c_ptr(&err);
    }

    let lock = Contexts::collection().lock();
    let mut contexts = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        match contexts.remove(&ctx.id) {
            Some(mut wallets) => match block_on(wallets.uninit()) {
                Err(err) => Error::from(err),
                Ok(_) => Error::SUCCESS(),
            },
            None => Error::NONE().append_message(": can not find the context"),
        }
    };
    log::debug!("{}", err);
    CError::to_c_ptr(&err)
}

/// 返回所有的Context, 有可能是0个
/// 如果成功返回 [wallets_types::Error::SUCCESS()]
#[no_mangle]
pub unsafe extern "C" fn Wallets_Contexts(contexts: *mut *mut CArray<CContext>) -> *const CError {
    log::debug!("enter Wallets_Contexts");
    if contexts.is_null() {
        let err = Error::PARAMETER().append_message(" : contexts is null");
        log::info!("{}", err);
        return CError::to_c_ptr(&err);
    }
    (*contexts).free();
    let lock = Contexts::collection().lock();
    let r_contexts = lock.borrow();
    let err = {
        if let Some(ctxs) = r_contexts.contexts() {
            *contexts = CArray::to_c_ptr(&ctxs);
        }
        Error::SUCCESS()
    };
    log::debug!("{}", err);
    CError::to_c_ptr(&err)
}

/// 返回最后的Context, 有可能是空值
/// 如果成功返回 [wallets_types::Error::SUCCESS()]
#[no_mangle]
pub unsafe extern "C" fn Wallets_lastContext(context: *mut *mut CContext) -> *const CError {
    log::debug!("enter Wallets_lastContext");
    if context.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx is null");
        log::info!("{}", err);
        return CError::to_c_ptr(&err);
    }
    (*context).free();
    let lock = Contexts::collection().lock();
    let contexts = lock.borrow();
    let err = {
        if let Some(ctx) = contexts.last_context() {
            *context = CContext::to_c_ptr(&ctx);
        }
        Error::SUCCESS()
    };
    log::debug!("{}", err);
    CError::to_c_ptr(&err)
}

/// 返回第一个Context, 有可能是空值
/// 如果成功返回 [wallets_types::Error::SUCCESS()]
#[no_mangle]
pub unsafe extern "C" fn Wallets_firstContext(context: *mut *mut CContext) -> *const CError {
    log::debug!("enter Wallets_firstContext");
    if context.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx is null");
        log::info!("{}", err);
        return CError::to_c_ptr(&err);
    }
    (*context).free();
    let lock = Contexts::collection().lock();
    let contexts = lock.borrow();
    let err = {
        if let Some(ctx) = contexts.first_context() {
            *context = CContext::to_c_ptr(&ctx);
        }
        Error::SUCCESS()
    };
    log::debug!("{}", err);
    CError::to_c_ptr(&err)
}

#[no_mangle]
pub unsafe extern "C" fn Wallets_lockRead(ctx: *mut CContext) -> *const CError {
    log::debug!("enter Wallets_lockRead");
    if ctx.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx is null");
        log::info!("{}", err);
        return CError::to_c_ptr(&err);
    }
    let lock = Contexts::collection().lock();
    let mut contexts = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        match contexts.get_mut(&ctx.id) {
            Some(wallets) => match wallets.lock_read() {
                true => Error::SUCCESS(),
                false => Error::FAIL(),
            },
            None => Error::NONE().append_message(": can not find the context"),
        }
    };
    log::debug!("{}", err);
    CError::to_c_ptr(&err)
}

#[no_mangle]
pub unsafe extern "C" fn Wallets_unlockRead(ctx: *mut CContext) -> *const CError {
    log::debug!("enter Wallets_unlockRead");
    if ctx.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx is null");
        log::info!("{}", err);
        return CError::to_c_ptr(&err);
    }
    let lock = Contexts::collection().lock();
    let mut contexts = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        match contexts.get_mut(&ctx.id) {
            Some(wallets) => match wallets.unlock_read() {
                true => Error::SUCCESS(),
                false => Error::FAIL(),
            },
            None => Error::NONE().append_message(": can not find the context"),
        }
    };
    log::debug!("{}", err);
    CError::to_c_ptr(&err)
}

#[no_mangle]
pub unsafe extern "C" fn Wallets_lockWrite(ctx: *mut CContext) -> *const CError {
    log::debug!("enter Wallets_lockWrite");
    if ctx.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx is null");
        log::info!("{}", err);
        return CError::to_c_ptr(&err);
    }
    let lock = Contexts::collection().lock();
    let mut contexts = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        match contexts.get_mut(&ctx.id) {
            Some(wallets) => match wallets.lock_write() {
                true => Error::SUCCESS(),
                false => Error::FAIL(),
            },
            None => Error::NONE().append_message(": can not find the context"),
        }
    };
    log::debug!("{}", err);
    CError::to_c_ptr(&err)
}

#[no_mangle]
pub unsafe extern "C" fn Wallets_unlockWrite(ctx: *mut CContext) -> *const CError {
    log::debug!("enter Wallets_unlockWrite");
    if ctx.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx is null");
        log::info!("{}", err);
        return CError::to_c_ptr(&err);
    }
    let lock = Contexts::collection().lock();
    let mut contexts = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        match contexts.get_mut(&ctx.id) {
            Some(wallets) => match wallets.unlock_write() {
                true => Error::SUCCESS(),
                false => Error::FAIL(),
            },
            None => Error::NONE().append_message(": can not find the context"),
        }
    };
    log::debug!("{}", err);
    CError::to_c_ptr(&err)
}

#[no_mangle]
pub unsafe extern "C" fn Wallets_all(ctx: *mut CContext, arrayWallet: *mut *mut CArray<CWallet>) -> *const CError {
    log::debug!("enter Wallets_all");
    if ctx.is_null() || arrayWallet.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx or arrayWallet is null");
        log::info!("{}", err);
        return CError::to_c_ptr(&err);
    }
    (*arrayWallet).free(); //如果数组的内存已经分配，释放它

    let lock = Contexts::collection().lock();
    let mut contexts = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        match contexts.get(&ctx.id) {
            Some(wallets) => match block_on(wallets.all()) {
                Ok(wallet_vec) => {
                    *arrayWallet = CArray::to_c_ptr(&wallet_vec);
                    Error::SUCCESS()
                }
                Err(err) => Error::from(err),
            },
            None => Error::NONE().append_message(": can not find the context"),
        }
    };

    log::debug!("{}", err);
    CError::to_c_ptr(&err)
}

#[no_mangle]
pub unsafe extern "C" fn Wallets_generateMnemonic(mnemonic_num: c_uint, mnemonic: *mut *mut c_char) -> *const CError {
    log::debug!("enter Wallets_generateMnemonic");
    if mnemonic.is_null() {
        let err = Error::PARAMETER().append_message(" : mnemonic is null");
        log::info!("{}", err);
        return CError::to_c_ptr(&err);
    }
    (*mnemonic).free(); //如果内存已存在，释放它

    let err = {
        let mn = Wallets::generate_mnemonic(mnemonic_num as u32);
        *mnemonic = to_c_char(&mn);
        Error::SUCCESS()
    };

    log::debug!("{}", err);
    CError::to_c_ptr(&err)
}

#[no_mangle]
pub unsafe extern "C" fn Wallets_createWallet( ctx: *mut CContext,parameters: *mut CCreateWalletParameters, wallet: *mut *mut CWallet) -> *const CError {
    log::debug!("enter Wallets_createWallet");
    if ctx.is_null() || parameters.is_null() || wallet.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx or parameters or wallet is null");
        log::info!("{}", err);
        return CError::to_c_ptr(&err);
    }
    (*wallet).free(); //如果内存已存在，释放它

    let lock = Contexts::collection().lock();
    let mut contexts = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        match contexts.get_mut(&ctx.id) {
            Some(wallets) => {
                match block_on(wallets.create_wallet(CCreateWalletParameters::ptr_rust(parameters)))
                {
                    Err(err) => Error::from(err),
                    Ok(w) => {
                        *wallet = CWallet::to_c_ptr(&w);
                        Error::SUCCESS()
                    }
                }
            }
            None => Error::NONE().append_message(": can not find the context"),
        }
    };

    log::debug!("{}", err);
    CError::to_c_ptr(&err)
}

#[no_mangle]
pub unsafe extern "C" fn Wallets_removeWallet(ctx: *mut CContext,walletId: *mut c_char,password: *mut c_char,) -> *const CError {
    log::debug!("enter Wallets_removeWallet");
    if ctx.is_null() || walletId.is_null() || password.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx, walletId,password cannot be null");
        log::info!("{}", err);
        return CError::to_c_ptr(&err);
    }

    let lock = Contexts::collection().lock();
    let mut contexts = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        match contexts.get_mut(&ctx.id) {
            Some(wallets) => {
                match block_on(wallets.remove_wallet(to_str(walletId), to_str(password))) {
                    Err(err) => Error::from(err),
                    Ok(_) => Error::SUCCESS(),
                }
            }
            None => Error::NONE().append_message(": can not find the context"),
        }
    };

    log::debug!("{}", err);
    CError::to_c_ptr(&err)
}

#[no_mangle]
pub unsafe extern "C" fn Wallets_exportWallet(ctx: *mut CContext, walletId: *mut c_char, password: *mut c_char, mnemonic: *mut *mut c_char, ) -> *const CError {
    log::debug!("enter Wallets_exportWallet");
    if ctx.is_null() || walletId.is_null() || password.is_null() || mnemonic.is_null() {
        let err =
            Error::PARAMETER().append_message(" : ctx ,walletId,password,mnemonic cannot be null");
        log::info!("{}", err);
        return CError::to_c_ptr(&err);
    }
    let lock = Contexts::collection().lock();
    let mut contexts = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        match contexts.get_mut(&ctx.id) {
            Some(wallets) => {
                match block_on(wallets.export_wallet(to_str(walletId), to_str(password))) {
                    Err(err) => Error::from(err),
                    Ok(words) =>{
                        *mnemonic=to_c_char(&words);
                        Error::SUCCESS()
                    }
                }
            }
            None => Error::NONE().append_message(": can not find the context"),
        }
    };
    log::debug!("{}", err);
    CError::to_c_ptr(&err)
}

#[no_mangle]
pub unsafe extern "C" fn Wallets_resetWalletPassword(ctx: *mut CContext,walletId: *mut c_char,oldPsd: *mut c_char,newPsd: *mut c_char, ) -> *const CError {
    log::debug!("enter Wallets_resetWalletPassword");
    if ctx.is_null() || walletId.is_null() || oldPsd.is_null() || newPsd.is_null() {
        let err =
            Error::PARAMETER().append_message(" : ctx ,walletId,oldPsd,newPsd cannot be null");
        log::info!("{}", err);
        return CError::to_c_ptr(&err);
    }
    let lock = Contexts::collection().lock();
    let mut contexts = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        match contexts.get_mut(&ctx.id) {
            Some(wallets) => match block_on(wallets.reset_wallet_password(
                to_str(walletId),
                to_str(oldPsd),
                to_str(newPsd),
            )) {
                Err(err) => Error::from(err),
                Ok(_) => Error::SUCCESS(),
            },
            None => Error::NONE().append_message(": can not find the context"),
        }
    };
    log::debug!("{}", err);
    CError::to_c_ptr(&err)
}

#[no_mangle]
pub unsafe extern "C" fn Wallets_renameWallet(ctx: *mut CContext,newName: *mut c_char,walletId: *mut c_char, ) -> *const CError {
    log::debug!("enter Wallets_renameWallet");
    if ctx.is_null() || newName.is_null() || walletId.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx or newName or walletId is null");
        log::info!("{}", err);
        return CError::to_c_ptr(&err);
    }
    let lock = Contexts::collection().lock();
    let mut contexts = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        match contexts.get_mut(&ctx.id) {
            Some(wallets) => {
                match block_on(wallets.rename_wallet(to_str(newName), to_str(walletId), "")) {
                    Err(err) => Error::from(err),
                    Ok(_) => Error::SUCCESS(),
                }
            }
            None => Error::NONE().append_message(": can not find the context"),
        }
    };

    log::debug!("{}", err);
    CError::to_c_ptr(&err)
}

/// 只有到CError为 Error::SUCCESS()时返值才有意义
/// 返回值 hasAny: true表示至少有一个; Fail: false，没有
#[no_mangle]
pub unsafe extern "C" fn Wallets_hasAny(ctx: *mut CContext, hasAny: *mut CBool) -> *const CError {
    log::debug!("enter Wallets_hasAny");
    if ctx.is_null() || hasAny.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx or hasAny is null");
        log::info!("{}", err);
        return CError::to_c_ptr(&err);
    }

    let lock = Contexts::collection().lock();
    let mut contexts = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        match contexts.get(&ctx.id) {
            Some(wallets) => match block_on(wallets.has_any()) {
                Err(err) => Error::from(err),
                Ok(true) => {
                    *hasAny = CTrue;
                    Error::SUCCESS()
                }
                Ok(false) => {
                    *hasAny = CFalse;
                    Error::SUCCESS()
                }
            },
            None => Error::NONE().append_message(": can not find the context"),
        }
    };

    log::debug!("{}", err);
    CError::to_c_ptr(&err)
}

#[no_mangle]
pub unsafe extern "C" fn Wallets_findById( ctx: *mut CContext,walletId: *mut c_char,wallet: *mut *mut CWallet,) -> *const CError {
    log::debug!("enter Wallets_findById");
    if ctx.is_null() || wallet.is_null() || walletId.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx or wallet or walletId is null");
        log::info!("{}", err);
        return CError::to_c_ptr(&err);
    }
    (*wallet).free();

    let lock = Contexts::collection().lock();
    let mut contexts = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        match contexts.get(&ctx.id) {
            Some(wallets) => match block_on(wallets.find_by_id(to_str(walletId))) {
                Err(err) => Error::from(err),
                Ok(Some(w)) => {
                    *wallet = CWallet::to_c_ptr(&w);
                    Error::SUCCESS()
                }
                Ok(None) => Error::NoRecord(),
            },
            None => Error::NONE().append_message(": can not find the context"),
        }
    };

    log::debug!("{}", err);
    CError::to_c_ptr(&err)
}

///注：只加载了wallet的id name等直接的基本数据，子对象（如链）的数据没有加载
#[no_mangle]
pub unsafe extern "C" fn Wallets_findWalletBaseByName(ctx: *mut CContext, name: *mut c_char, walletArray: *mut *mut CArray<CWallet>) -> *const CError {
    log::debug!("enter Wallets_findWalletBaseByName");
    if ctx.is_null() || name.is_null() || walletArray.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx or name or arrayWallet is null");
        log::info!("{}", err);
        return CError::to_c_ptr(&err);
    }
    (*walletArray).free(); //如果内存已存在，释放它

    let lock = Contexts::collection().lock();
    let mut contexts = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        match contexts.get(&ctx.id) {
            Some(wallets) => match block_on(wallets.find_wallet_base_by_name(to_str(name))) {
                Ok(wallet_vec) => {
                    *walletArray = CArray::to_c_ptr(&wallet_vec);
                    Error::SUCCESS()
                }
                Err(err) => Error::from(err),
            },
            None => Error::NONE().append_message(": can not find the context"),
        }
    };

    log::debug!("{}", err);
    CError::to_c_ptr(&err)
}

/// 查询当前wallet 与 chain
#[no_mangle]
pub unsafe extern "C" fn Wallets_currentWalletChain(ctx: *mut CContext, walletId: *mut *mut c_char, chainType: *mut *mut c_char) -> *const CError {
    log::debug!("enter Wallets_currentWalletChain");
    if ctx.is_null() || walletId.is_null() || chainType.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx or walletId or chainType is null");
        log::info!("{}", err);
        return CError::to_c_ptr(&err);
    }
    (*walletId).free();
    (*chainType).free();

    let lock = Contexts::collection().lock();
    let mut contexts = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        match contexts.get(&ctx.id) {
            Some(wallets) => match block_on(wallets.current_wallet_chain()) {
                Err(err) => Error::from(err),
                Ok(Some((wallet_id, chain_type))) => {
                    *walletId = to_c_char(wallet_id.as_str());
                    *chainType = to_c_char(&chain_type.to_string());
                    Error::SUCCESS()
                }
                Ok(None) => Error::NOT_EXIST(),
            },
            None => Error::NONE().append_message(": can not find the context"),
        }
    };

    log::debug!("{}", err);
    CError::to_c_ptr(&err)
}

///保存当前wallet 与 chain
#[no_mangle]
pub unsafe extern "C" fn Wallets_saveCurrentWalletChain( ctx: *mut CContext,walletId: *mut c_char, chainType: *mut c_char,) -> *const CError {
    log::debug!("enter Wallets_saveCurrentWalletChain");
    if ctx.is_null() || walletId.is_null() || chainType.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx or walletId or chainType is null");
        log::info!("{}", err);
        return CError::to_c_ptr(&err);
    }
    let chain_type = match ChainType::from(to_str(chainType)) {
        Err(err) => {
            let err = Error::PARAMETER().append_message(err.to_string().as_str());
            log::info!("{}", err);
            return CError::to_c_ptr(&err);
        }
        Ok(chain_type) => chain_type,
    };
    let lock = Contexts::collection().lock();
    let mut ins = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        match ins.get_mut(&ctx.id) {
            Some(ws) => {
                match block_on(ws.save_current_wallet_chain(to_str(walletId), &chain_type)) {
                    Err(err) => Error::from(err),
                    Ok(_) => Error::SUCCESS(),
                }
            }
            None => Error::NONE().append_message(": can not find the context"),
        }
    };

    log::debug!("{}", err);
    CError::to_c_ptr(&err)
}
build_const::build_const!("constants");
#[no_mangle]
pub unsafe extern "C" fn Wallets_appPlatformType() -> *const c_char {
    log::debug!("enter Wallets_appPlatformType");
    let plat = CARGO_BUILD_TARGET.replace("-", "_");
    let platType = {
        match AppPlatformType::from(&plat) {
            Ok(t) => t,
            Err(_) => {
                log::error!("AppPlatformType is not support");
                AppPlatformType::any
            }
        }
    };
    log::debug!("AppPlatformType: {}", platType.to_string());
    to_c_char(&platType.to_string())
}

#[no_mangle]
pub unsafe extern "C" fn Wallets_queryBalance(ctx: *mut CContext, netType: *mut c_char, walletId: *mut c_char, tokenAddress: *mut *mut CArray<CTokenAddress>) -> *const CError {
    if ctx.is_null() || tokenAddress.is_null() || netType.is_null() || walletId.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx,updateBalance is null");
        log::error!("{}", err);
        return CError::to_c_ptr(&err);
    }
    (*tokenAddress).free();
    let lock = Contexts::collection().lock();
    let mut contexts = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        match contexts.get(&ctx.id) {
            Some(wallets) => {
                let net_type = NetType::from(to_str(netType));
                match block_on(wallets.query_address_balance(&net_type, &to_str(walletId))) {
                    Ok(tokens) => {
                        *tokenAddress = CArray::to_c_ptr(&tokens);
                        Error::SUCCESS()
                    }
                    Err(err) => Error::from(err),
                }
            }
            None => Error::NONE().append_message(": can not find the context"),
        }
    };
    log::debug!("{}", err);
    CError::to_c_ptr(&err)
}

#[no_mangle]
pub unsafe extern "C" fn Wallets_updateBalance(ctx: *mut CContext, netType: *mut c_char, tokenAddress: *mut CTokenAddress) -> *const CError {
    if ctx.is_null() || tokenAddress.is_null() || netType.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx,updateBalance is null");
        log::error!("{}", err);
        return CError::to_c_ptr(&err);
    }
    let lock = Contexts::collection().lock();
    let mut contexts = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        match contexts.get(&ctx.id) {
            Some(wallets) => {
                let net_type = NetType::from(to_str(netType));
                let token_address = CTokenAddress::ptr_rust(tokenAddress);
                match block_on(wallets.update_address_balance(&net_type, &token_address)) {
                    Ok(_res) => Error::SUCCESS(),
                    Err(err) => Error::from(err),
                }
            }
            None => Error::NONE().append_message(": can not find the context"),
        }
    };
    log::debug!("{}", err);
    CError::to_c_ptr(&err)
}

#[no_mangle]
pub unsafe extern "C" fn Wallets_changeTokenShowState(ctx: *mut CContext, netType: *mut c_char, tokenStatus: *mut CWalletTokenStatus) -> *const CError {
    if ctx.is_null() || tokenStatus.is_null() || netType.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx,hideTokenAddress is null");
        log::error!("{}", err);
        return CError::to_c_ptr(&err);
    }
    let lock = Contexts::collection().lock();
    let mut contexts = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        match contexts.get(&ctx.id) {
            Some(wallets) => {
                let net_type = NetType::from(to_str(netType));
                let token_address = CWalletTokenStatus::ptr_rust(tokenStatus);
                match block_on(wallets.change_wallet_token_show_status(&net_type, &token_address)) {
                    Ok(_res) => Error::SUCCESS(),
                    Err(err) => Error::from(err),
                }
            }
            None => Error::NONE().append_message(": can not find the context"),
        }
    };
    log::debug!("{}", err);
    CError::to_c_ptr(&err)
}
