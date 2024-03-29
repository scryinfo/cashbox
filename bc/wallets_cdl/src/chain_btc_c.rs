#![allow(non_snake_case)]

use std::os::raw::{c_char, c_uint};

use futures::executor::block_on;

use wallets::{Contexts, Wallets};
use wallets_types::Error;

use crate::{to_c_char, to_str};
use crate::parameters::{CBtcBalance, CBtcNowLoadBlock, CBtcTxParam, CContext};
use crate::types::{CBtcChainTokenAuth, CBtcChainTokenDefault, CError};

use super::kits::{CArray, CR, CStruct};

#[no_mangle]
pub unsafe extern "C" fn ChainBtc_updateDefaultTokenList(
    ctx: *mut CContext,
    defaultTokens: *mut CArray<CBtcChainTokenDefault>,
) -> *const CError {
    log::debug!("enter ChainEth updateDefaultTokenLis");

    if ctx.is_null() || defaultTokens.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx,defaultTokens is null");
        log::error!("{}", err);
        return CError::to_c_ptr(&err);
    }
    let lock = Contexts::collection().lock();
    let mut contexts = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        match contexts.get(&ctx.id) {
            Some(wallets) => {
                let btc_chain = wallets.btc_chain_instance();
                let default_token_list = CArray::<CBtcChainTokenDefault>::ptr_rust(defaultTokens);
                match block_on(btc_chain.update_default_tokens(wallets, default_token_list)) {
                    Ok(_) => Error::SUCCESS(),
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
pub unsafe extern "C" fn ChainBtc_updateAuthDigitList(
    ctx: *mut CContext,
    authTokens: *mut CArray<CBtcChainTokenAuth>,
) -> *const CError {
    log::debug!("enter ChainBtc updateDefaultTokenLis");

    if ctx.is_null() || authTokens.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx,authTokens is null");
        log::error!("{}", err);
        return CError::to_c_ptr(&err);
    }
    let lock = Contexts::collection().lock();
    let mut contexts = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        match contexts.get(&ctx.id) {
            Some(wallets) => {
                let btc_chain = wallets.btc_chain_instance();
                let default_token_list = CArray::<CBtcChainTokenAuth>::ptr_rust(authTokens);
                match block_on(btc_chain.update_auth_tokens(wallets, default_token_list)) {
                    Ok(_) => Error::SUCCESS(),
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
pub unsafe extern "C" fn ChainBtc_getAuthTokenList(
    ctx: *mut CContext,
    startItem: c_uint,
    pageSize: c_uint,
    tokens: *mut *mut CArray<CBtcChainTokenAuth>,
) -> *const CError {
    log::debug!("enter ChainEth getDigitList");

    if ctx.is_null() || tokens.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx or tokens is null");
        log::error!("{}", err);
        return CError::to_c_ptr(&err);
    }
    (*tokens).free();
    let lock = Contexts::collection().lock();
    let mut contexts = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        match contexts.get(&ctx.id) {
            Some(wallets) => {
                let btc_chain = wallets.btc_chain_instance();
                match block_on(btc_chain.get_auth_tokens(
                    wallets,
                    &wallets.net_type,
                    startItem as u64,
                    pageSize as u64,
                )) {
                    Ok(data) => {
                        *tokens = CArray::to_c_ptr(&data);
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
pub unsafe extern "C" fn ChainBtc_getDefaultTokenList(
    ctx: *mut CContext,
    tokens: *mut *mut CArray<CBtcChainTokenDefault>,
) -> *const CError {
    log::debug!("enter ChainEth getDigitList");

    if ctx.is_null() || tokens.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx or tokens is null");
        log::error!("{}", err);
        return CError::to_c_ptr(&err);
    }
    (*tokens).free();
    let lock = Contexts::collection().lock();
    let mut contexts = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        match contexts.get(&ctx.id) {
            Some(wallets) => {
                let btc_chain = wallets.btc_chain_instance();
                match block_on(btc_chain.get_default_tokens(wallets, &wallets.net_type)) {
                    Ok(data) => {
                        *tokens = CArray::to_c_ptr(&data);
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
pub unsafe extern "C" fn ChainBtc_start(
    ctx: *mut CContext,
    walletId: *mut c_char,
) -> *const CError {
    log::debug!("enter ChainBtc start");
    if ctx.is_null() || walletId.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx or walletId is cannot be null");
        log::error!("{}", err);
        return CError::to_c_ptr(&err);
    }

    let lock = Contexts::collection().lock();
    let mut contexts = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        match contexts.get(&ctx.id) {
            Some(wallets) => {
                let btc_chain = wallets.btc_chain_instance();
                let r = btc_chain.start_murmel(wallets, to_str(walletId), &wallets.net_type);
                match r {
                    Ok(_) => Error::SUCCESS(),
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
pub unsafe extern "C" fn ChainBtc_loadNowBlockNumber(
    ctx: *mut CContext,
    block: *mut *mut CBtcNowLoadBlock,
) -> *const CError {
    log::debug!("enter ChainBtc_loadBalance");
    if ctx.is_null() || block.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx or block is cannot be null");
        log::error!("{}", err);
        return CError::to_c_ptr(&err);
    }
    (*block).free();
    let lock = Contexts::collection().lock();
    let mut contexts = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        match contexts.get(&ctx.id) {
            Some(wallets) => {
                let btc_chain = wallets.btc_chain_instance();
                let r = block_on(btc_chain.load_now_blocknumber(wallets, &wallets.net_type));
                match r {
                    Ok(r) => {
                        *block = CBtcNowLoadBlock::to_c_ptr(&r);
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
pub unsafe extern "C" fn ChainBtc_loadBalance(
    ctx: *mut CContext,
    balance: *mut *mut CBtcBalance,
) -> *const CError {
    log::debug!("enter ChainBtc_loadBalance");
    if ctx.is_null() || balance.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx or balance is cannot be null");
        log::error!("{}", err);
        return CError::to_c_ptr(&err);
    }
    (*balance).free();
    let lock = Contexts::collection().lock();
    let mut contexts = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        match contexts.get(&ctx.id) {
            Some(wallets) => {
                let btc_chain = wallets.btc_chain_instance();
                let r = block_on(btc_chain.load_balance(wallets, &wallets.net_type));
                match r {
                    Ok(r) => {
                        *balance = CBtcBalance::to_c_ptr(&r);
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
pub unsafe extern "C" fn ChainBtc_txSign(
    ctx: *mut CContext,
    param: *mut CBtcTxParam,
    signedResult: *mut *mut c_char,
) -> *const CError {
    log::debug!("enter ChainBtc_txSign");
    if ctx.is_null() || param.is_null() || signedResult.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx,param or signedResult is null");
        log::error!("{}", err);
        return CError::to_c_ptr(&err);
    }
    (*signedResult).free();
    let lock = Contexts::collection().lock();
    let mut contexts = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        match contexts.get(&ctx.id) {
            Some(wallets) => {
                let btc_chain = wallets.btc_chain_instance();
                let param = CBtcTxParam::ptr_rust(param);
                match block_on(btc_chain.tx_sign(wallets, &wallets.net_type, &param)) {
                    Ok(res) => {
                        *signedResult = to_c_char(&res);
                        Error::SUCCESS()
                    }
                    Err(err) => Error::from(err)
                }
            }
            None => Error::NONE().append_message(": can not find the context")
        }
    };
    log::debug!("{}", err);
    CError::to_c_ptr(&err)
}