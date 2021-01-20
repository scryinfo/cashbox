#![allow(non_snake_case)]

use futures::executor::block_on;
use wallets_types::Error;
use wallets::Contexts;
use super::types::CError;
use super::kits::{CR,CArray};

use crate::types::{CBtcChainTokenDefault, CBtcChainTokenAuth};
use crate::parameters::CContext;


#[no_mangle]
pub unsafe extern "C" fn ChainBtc_updateDefaultTokenList(ctx: *mut CContext, defaultTokens: *mut CArray<CBtcChainTokenDefault>) -> *const CError {
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
pub unsafe extern "C" fn ChainBtc_updateAuthDigitList(ctx: *mut CContext,authTokens: *mut CArray<CBtcChainTokenAuth>) -> *const CError {
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
