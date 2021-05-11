#![allow(non_snake_case)]

use std::os::raw::{c_char, c_uint};
use futures::executor::block_on;
use wallets_types::{Error};
use wallets::Contexts;
use super::types::CError;
use super::kits::{CR,CArray, to_c_char, to_str};

use crate::parameters::{CContext, CEthTransferPayload, CEthRawTxPayload};
use crate::CStruct;
use crate::chain_eth::{CEthChainTokenAuth, CEthChainTokenDefault, CEthChainTokenNonAuth};

#[no_mangle]
pub unsafe extern "C" fn ChainEth_decodeAdditionData(ctx: *mut CContext, encodeData: *mut c_char, additionData: *mut *mut c_char) -> *const CError {
    log::debug!("enter ChainEee ChainEth decodeAdditionData");

    if ctx.is_null() || encodeData.is_null() || additionData.is_null() {
        let err = Error::PARAMETER().append_message(" : encodeData or additionData is null");
        log::error!("{}", err);
        return CError::to_c_ptr(&err);
    }
    (*additionData).free();//如果内存已存在，释放它
    let lock = Contexts::collection().lock();
    let mut contexts = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        match contexts.get(&ctx.id) {
            Some(wallets) => {
                let eth_chain = wallets.eth_chain_instance();
                match block_on(eth_chain.decode_addition_data(to_str(encodeData))) {
                    Ok(res) => {
                        *additionData = to_c_char(&res);
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

#[no_mangle]
pub unsafe extern "C" fn ChainEth_txSign(ctx: *mut CContext, txPayload: *mut CEthTransferPayload, password: *mut c_char, signResult: *mut *mut c_char) -> *const CError {
    log::debug!("enter ChainEee ChainEth txSign");

    if ctx.is_null() || txPayload.is_null() || password.is_null() || signResult.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx,netType,txPayload,password or signResult is null");
        log::error!("{}", err);
        return CError::to_c_ptr(&err);
    }
    (*signResult).free();//如果内存已存在，释放它
    let lock = Contexts::collection().lock();
    let mut contexts = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        match contexts.get(&ctx.id) {
            Some(wallets) => {
                let eth_chain = wallets.eth_chain_instance();
                let transfer_payload = CEthTransferPayload::ptr_rust(txPayload);
                match block_on(eth_chain.tx_sign(wallets, &wallets.net_type, &transfer_payload, to_str(password))) {
                    Ok(res) => {
                        *signResult = to_c_char(&res);
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

#[no_mangle]
pub unsafe extern "C" fn ChainEth_rawTxSign(ctx: *mut CContext, rawTxPayload: *mut CEthRawTxPayload, password: *mut c_char, signResult: *mut *mut c_char) -> *const CError {
    log::debug!("enter ChainEee ChainEth rawTxSign");

    if ctx.is_null() || rawTxPayload.is_null() || password.is_null() || signResult.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx,rawTxPayload,password or signResult is null");
        log::error!("{}", err);
        return CError::to_c_ptr(&err);
    }
    (*signResult).free();//如果内存已存在，释放它
    let lock = Contexts::collection().lock();
    let mut contexts = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        match contexts.get(&ctx.id) {
            Some(wallets) => {
                let eth_chain = wallets.eth_chain_instance();
                let raw_tx_payload = CEthRawTxPayload::ptr_rust(rawTxPayload);
                match block_on(eth_chain.raw_tx_sign(wallets, &wallets.net_type, &raw_tx_payload, to_str(password))) {
                    Ok(res) => {
                        *signResult = to_c_char(&res);
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

#[no_mangle]
pub unsafe extern "C" fn ChainEth_updateAuthTokenList(ctx: *mut CContext, authTokens: *mut CArray<CEthChainTokenAuth>) -> *const CError {
    log::debug!("enter ChainEth updateAuthTokenList");

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
                let eth_chain = wallets.eth_chain_instance();
                let auth_tokens = CArray::<CEthChainTokenAuth>::ptr_rust(authTokens);
                match block_on(eth_chain.update_auth_tokens(wallets, auth_tokens)) {
                    Ok(_) => {
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

#[no_mangle]
pub unsafe extern "C" fn ChainEth_getAuthTokenList(ctx: *mut CContext, startItem: c_uint, pageSize: c_uint, tokens: *mut *mut CArray<CEthChainTokenAuth>) -> *const CError {
    log::debug!("enter ChainEth getDigitList");
    if ctx.is_null() || tokens.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx,tokens,netType is null");
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
                let eth_chain = wallets.eth_chain_instance();
                match block_on(eth_chain.get_auth_tokens(wallets, &wallets.net_type, startItem as u64, pageSize as u64)) {
                    Ok(data) => {
                        *tokens = CArray::to_c_ptr(&data);
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

#[no_mangle]
pub unsafe extern "C" fn ChainEth_updateDefaultTokenList(ctx: *mut CContext, defaultTokens: *mut CArray<CEthChainTokenDefault>) -> *const CError {
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
                let eth_chain = wallets.eth_chain_instance();
                let default_token_list = CArray::<CEthChainTokenDefault>::ptr_rust(defaultTokens);
                match block_on(eth_chain.update_default_tokens(wallets, default_token_list)) {
                    Ok(_) => {
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

#[no_mangle]
pub unsafe extern "C" fn ChainEth_getDefaultTokenList(ctx: *mut CContext, tokens: *mut *mut CArray<CEthChainTokenDefault>) -> *const CError {
    log::debug!("enter ChainEth getDigitList");
    if ctx.is_null() || tokens.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx,tokens,netType is null");
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
                let eth_chain = wallets.eth_chain_instance();
                match block_on(eth_chain.get_default_tokens(wallets, &wallets.net_type)) {
                    Ok(data) => {
                        *tokens = CArray::to_c_ptr(&data);
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

//support non auth digit?
#[no_mangle]
pub unsafe extern "C" fn ChainEth_updateNonAuthTokenList(ctx: *mut CContext, tokens: *mut CArray<CEthChainTokenNonAuth>) -> *const CError {
    log::debug!("enter ChainEth addNonAuthDigit");
    if ctx.is_null() || tokens.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx,tokens is null");
        log::error!("{}", err);
        return CError::to_c_ptr(&err);
    }
    let lock = Contexts::collection().lock();
    let mut contexts = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        match contexts.get(&ctx.id) {
            Some(wallets) => {
                let eth_chain = wallets.eth_chain_instance();
                let non_auth_tokens = CArray::<CEthChainTokenNonAuth>::ptr_rust(tokens);
                match block_on(eth_chain.update_non_auth_tokens(wallets, non_auth_tokens)) {
                    Ok(_) => {
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


#[no_mangle]
pub unsafe extern "C" fn ChainEth_getNonAuthTokenList(ctx: *mut CContext, tokens: *mut *mut CArray<CEthChainTokenNonAuth>) -> *const CError {
    log::debug!("enter ChainEth getNonAuthTokenList");

    if ctx.is_null() || tokens.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx,tokens is null");
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
                let eth_chain = wallets.eth_chain_instance();
                match block_on(eth_chain.get_non_auth_tokens(wallets, &wallets.net_type)) {
                    Ok(data) => {
                        *tokens = CArray::to_c_ptr(&data);
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
#[no_mangle]
pub unsafe extern "C" fn ChainEth_queryAuthTokenList(ctx: *mut CContext,tokenName: *mut c_char,contract: *mut c_char, startItem: c_uint, pageSize: c_uint,  tokens: *mut *mut CArray<CEthChainTokenAuth>) -> *const CError {
    log::debug!("enter ChainEth getNonAuthTokenList");

    if ctx.is_null() || tokens.is_null() || tokenName.is_null()|| contract.is_null(){
        let err = Error::PARAMETER().append_message(" : ctx,tokens is null");
        log::error!("{}", err);
        return CError::to_c_ptr(&err);
    }
    (*tokens).free();
    let token_name = to_str(tokenName);
    let query_name = if token_name.is_empty(){
        None
    }else { Some(token_name.to_string()) };

    let contract = to_str(contract);
    let query_contract = if contract.is_empty(){
        None
    }else { Some(contract.to_string()) };

    let lock = Contexts::collection().lock();
    let mut contexts = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        match contexts.get(&ctx.id) {
            Some(wallets) => {

                let eth_chain = wallets.eth_chain_instance();
                match block_on(eth_chain.query_auth_tokens(wallets, &wallets.net_type,query_name,query_contract,startItem as u64,pageSize as u64)) {
                    Ok(data) => {
                        *tokens = CArray::to_c_ptr(&data);
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
