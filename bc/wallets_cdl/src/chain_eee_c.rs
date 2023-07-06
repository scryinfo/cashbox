#![allow(non_snake_case)]

use std::os::raw::{c_char, c_uint};

use futures::executor::block_on;

use mav::ma::EeeTokenType;
use wallets::Contexts;
use wallets_types::{AccountInfoSyncProg, ChainVersion, Error, WalletError};

use crate::chain_eee::{CAccountInfoSyncProg, CEeeChainTokenAuth, CEeeChainTokenDefault, CSubChainBasicInfo};

use super::kits::{CArray, CR, CStruct, to_c_char, to_str};
use super::parameters::{CAccountInfo, CChainVersion, CContext, CDecodeAccountInfoParameters, CEeeChainTx, CEeeTransferPayload, CExtrinsicContext, CRawTxParam, CStorageKeyParameters};
use super::types::CError;

#[no_mangle]
pub unsafe extern "C" fn ChainEee_updateSyncRecord(ctx: *mut CContext, syncRecord: *mut CAccountInfoSyncProg) -> *const CError {
    log::debug!("enter ChainEee updateSyncRecord");
    if ctx.is_null() || syncRecord.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx or netType or syncRecord is null");
        log::error!("{}", err);
        return CError::to_c_ptr(&err);
    }
    let lock = Contexts::collection().lock();
    let mut contexts = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        match contexts.get(&ctx.id) {
            Some(wallets) => {
                let eee_chain = wallets.eee_chain_instance();
                let sync_record = CAccountInfoSyncProg::ptr_rust(syncRecord);
                match block_on(eee_chain.update_sync_record(wallets, &wallets.net_type, &sync_record)) {
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
pub unsafe extern "C" fn ChainEee_getSyncRecord(ctx: *mut CContext, account: *mut c_char, syncRecord: *mut *mut CAccountInfoSyncProg) -> *const CError {
    log::debug!("enter ChainEee getSyncRecord");
    if ctx.is_null() || account.is_null() || syncRecord.is_null() {
        let err = Error::PARAMETER().append_message("  : ctx,account or syncRecord is null");
        log::error!("{}", err);
        return CError::to_c_ptr(&err);
    }
    (*syncRecord).free();//如果内存已存在，释放它
    let lock = Contexts::collection().lock();
    let mut contexts = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        match contexts.get(&ctx.id) {
            Some(wallets) => {
                let eee_chain = wallets.eee_chain_instance();
                match block_on(eee_chain.get_sync_record(wallets, &wallets.net_type, &to_str(account))) {
                    Ok(res) => {
                        *syncRecord = CAccountInfoSyncProg::to_c_ptr(&res);
                        Error::SUCCESS()
                    }
                    Err(WalletError::NotExist) => {
                        *syncRecord = CAccountInfoSyncProg::to_c_ptr(&AccountInfoSyncProg::default());
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
pub unsafe extern "C" fn ChainEee_decodeAccountInfo(ctx: *mut CContext, parameters: *mut CDecodeAccountInfoParameters, accountInfo: *mut *mut CAccountInfo) -> *const CError {
    log::debug!("enter ChainEee decodeAccountInfo");
    if ctx.is_null() || parameters.is_null() || accountInfo.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx，parameters or accountInfo is null");
        log::error!("{}", err);
        return CError::to_c_ptr(&err);
    }
    (*accountInfo).free();//如果内存已存在，释放它
    let lock = Contexts::collection().lock();
    let mut contexts = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        match contexts.get(&ctx.id) {
            Some(wallets) => {
                let eee_chain = wallets.eee_chain_instance();
                let parameters = CDecodeAccountInfoParameters::ptr_rust(parameters);
                match block_on(eee_chain.decode_account_info(wallets, &wallets.net_type, parameters)) {
                    Ok(res) => {
                        *accountInfo = CAccountInfo::to_c_ptr(&res);
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
pub unsafe extern "C" fn ChainEee_getStorageKey(ctx: *mut CContext, parameters: *mut CStorageKeyParameters, key: *mut *mut c_char) -> *const CError {
    log::debug!("enter ChainEee getStorageKey");
    if ctx.is_null() || parameters.is_null() || key.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx,key or parameters is null");
        log::error!("{}", err);
        return CError::to_c_ptr(&err);
    }
    (*key).free();
    let lock = Contexts::collection().lock();
    let mut contexts = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        match contexts.get(&ctx.id) {
            Some(wallets) => {
                let eee_chain = wallets.eee_chain_instance();
                let parameters = CStorageKeyParameters::ptr_rust(parameters);
                match block_on(eee_chain.get_storage_key(wallets, &wallets.net_type, parameters)) {
                    Ok(res) => {
                        *key = to_c_char(&res);
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
pub unsafe extern "C" fn ChainEee_eeeTransfer(ctx: *mut CContext, transferPayload: *mut CEeeTransferPayload, signedResult: *mut *mut c_char) -> *const CError {
    log::debug!("enter ChainEee eeeTransfer");
    if ctx.is_null() || signedResult.is_null() || transferPayload.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx,transferPayload or signedResult is null");
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
                let eee_chain = wallets.eee_chain_instance();
                let transferPayload = CEeeTransferPayload::ptr_rust(transferPayload);
                match block_on(eee_chain.eee_transfer(wallets, &wallets.net_type, &transferPayload)) {
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

#[no_mangle]
pub unsafe extern "C" fn ChainEee_tokenXTransfer(ctx: *mut CContext, transferPayload: *mut CEeeTransferPayload, signedResult: *mut *mut c_char) -> *const CError {
    log::debug!("enter ChainEee tokenXTransfer");
    if ctx.is_null() || signedResult.is_null() || transferPayload.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx,netType,signedResult,transferPayload tokenXTransfer is null");
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
                let eee_chain = wallets.eee_chain_instance();
                let transferPayload = CEeeTransferPayload::ptr_rust(transferPayload);
                match block_on(eee_chain.tokenx_transfer(wallets, &wallets.net_type, &transferPayload)) {
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

//signed result can be send to chain rpc service by json-rpc
#[no_mangle]
pub unsafe extern "C" fn ChainEee_txSubmittableSign(ctx: *mut CContext, rawTx: *mut CRawTxParam, signedResult: *mut *mut c_char) -> *const CError {
    log::debug!("enter ChainEee txSubmittableSign");
    if ctx.is_null() || rawTx.is_null() || signedResult.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx,rawTx signedResult is null");
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
                let eee_chain = wallets.eee_chain_instance();
                let raw_tx = CRawTxParam::ptr_rust(rawTx);
                match block_on(eee_chain.tx_sign(wallets, &wallets.net_type, &raw_tx, false)) {
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

//signed result only used for construct ExtrinsicPayload object in typescript
#[no_mangle]
pub unsafe extern "C" fn ChainEee_txSign(ctx: *mut CContext, rawTx: *mut CRawTxParam, signedResult: *mut *mut c_char) -> *const CError {
    log::debug!("enter ChainEee updateBasicInfo");
    if ctx.is_null() || rawTx.is_null() || signedResult.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx,rawTx or signedResult is null");
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
                let eee_chain = wallets.eee_chain_instance();
                let raw_tx = CRawTxParam::ptr_rust(rawTx);
                match block_on(eee_chain.tx_sign(wallets, &wallets.net_type, &raw_tx, true)) {
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

#[no_mangle]
pub unsafe extern "C" fn ChainEee_updateBasicInfo(ctx: *mut CContext, basicInfo: *mut CSubChainBasicInfo) -> *const CError {
    log::debug!("enter ChainEee updateBasicInfo");

    if ctx.is_null() || basicInfo.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx or basicInfo is null");
        log::error!("{}", err);
        return CError::to_c_ptr(&err);
    }
    let lock = Contexts::collection().lock();
    let mut contexts = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        match contexts.get(&ctx.id) {
            Some(wallets) => {
                let eee_chain = wallets.eee_chain_instance();
                let mut info = CSubChainBasicInfo::ptr_rust(basicInfo);
                match block_on(eee_chain.update_basic_info(wallets, &wallets.net_type, &mut info)) {
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
pub unsafe extern "C" fn ChainEee_getDefaultBasicInfo(ctx: *mut CContext, basicInfo: *mut *mut CSubChainBasicInfo) -> *const CError {
    log::debug!("enter ChainEee getDefaultBasicInfo");
    if ctx.is_null() || basicInfo.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx or basicInfo is null");
        log::error!("{}", err);
        return CError::to_c_ptr(&err);
    }
    (*basicInfo).free();
    let chain_version = ChainVersion::default();
    query_chain_version(ctx, chain_version, basicInfo)
}

#[no_mangle]
pub unsafe extern "C" fn ChainEee_getBasicInfo(ctx: *mut CContext, chainVersion: *mut CChainVersion, basicInfo: *mut *mut CSubChainBasicInfo) -> *const CError {
    log::debug!("enter ChainEee getBasicInfo");

    if ctx.is_null() || basicInfo.is_null() || chainVersion.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx or chainVersion is null");
        log::error!("{}", err);
        return CError::to_c_ptr(&err);
    }
    (*basicInfo).free();
    let chain_version = CChainVersion::ptr_rust(chainVersion);
    query_chain_version(ctx, chain_version, basicInfo)
}

unsafe fn query_chain_version(ctx: *mut CContext, chain_version: ChainVersion, basicInfo: *mut *mut CSubChainBasicInfo) -> *const CError {
    let lock = Contexts::collection().lock();
    let mut contexts = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        match contexts.get(&ctx.id) {
            Some(wallets) => {
                let eee_chain = wallets.eee_chain_instance();
                match block_on(eee_chain.get_basic_info(wallets, &wallets.net_type, &chain_version.genesis_hash, chain_version.runtime_version, chain_version.tx_version)) {
                    Ok(info) => {
                        *basicInfo = CSubChainBasicInfo::to_c_ptr(&info);
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
pub unsafe extern "C" fn ChainEee_saveExtrinsicDetail(ctx: *mut CContext, extrinsicCtx: *mut CExtrinsicContext) -> *const CError {
    log::debug!("enter ChainEee saveExtrinsicDetail");

    if ctx.is_null() || extrinsicCtx.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx,extrinsicCtx is null");
        log::error!("{}", err);
        return CError::to_c_ptr(&err);
    }
    let lock = Contexts::collection().lock();
    let mut contexts = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        match contexts.get(&ctx.id) {
            Some(wallets) => {
                let eee_chain = wallets.eee_chain_instance();
                let extrinsic_ctx = CExtrinsicContext::ptr_rust(extrinsicCtx);
                match block_on(eee_chain.save_tx_record(wallets, &wallets.net_type, &extrinsic_ctx)) {
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
pub unsafe extern "C" fn ChainEee_queryChainTxRecord(ctx: *mut CContext, account: *mut c_char, startItem: c_uint, pageSize: c_uint, records: *mut *mut CArray<CEeeChainTx>) -> *const CError {
    log::debug!("enter ChainEee queryChainTxRecord");

    if ctx.is_null() || records.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx or account cannot be null");
        log::error!("{}", err);
        return CError::to_c_ptr(&err);
    }
    (*records).free();
    let lock = Contexts::collection().lock();
    let mut contexts = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        match contexts.get(&ctx.id) {
            Some(wallets) => {
                let eee_chain = wallets.eee_chain_instance();
                let account = if to_str(account).is_empty() {
                    None
                } else { Some(to_str(account).to_string()) };
                match block_on(eee_chain.get_tx_record(wallets, &wallets.net_type, EeeTokenType::Eee, account, startItem as u64, pageSize as u64)) {
                    Ok(data) => {
                        *records = CArray::to_c_ptr(&data);
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
pub unsafe extern "C" fn ChainEee_queryTokenxTxRecord(ctx: *mut CContext, account: *mut c_char, startItem: c_uint, pageSize: c_uint, records: *mut *mut CArray<CEeeChainTx>) -> *const CError {
    log::debug!("enter ChainEee queryTokenxTxRecord");

    if ctx.is_null() || records.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx,account or records cannot be null");
        log::error!("{}", err);
        return CError::to_c_ptr(&err);
    }
    (*records).free();
    let lock = Contexts::collection().lock();
    let mut contexts = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        match contexts.get(&ctx.id) {
            Some(wallets) => {
                let eee_chain = wallets.eee_chain_instance();
                let account = if to_str(account).is_empty() {
                    None
                } else { Some(to_str(account).to_string()) };
                match block_on(eee_chain.get_tx_record(wallets, &wallets.net_type, EeeTokenType::TokenX, account, startItem as u64, pageSize as u64)) {
                    Ok(data) => {
                        *records = CArray::to_c_ptr(&data);
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
pub unsafe extern "C" fn ChainEee_updateAuthDigitList(ctx: *mut CContext, authTokens: *mut CArray<CEeeChainTokenAuth>) -> *const CError {
    log::debug!("enter ChainEee updateAuthDigitList");
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
                let eee_chain = wallets.eee_chain_instance();
                let default_token_list = CArray::<CEeeChainTokenAuth>::ptr_rust(authTokens);
                match block_on(eee_chain.update_auth_tokens(wallets, default_token_list)) {
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
pub unsafe extern "C" fn ChainEee_updateDefaultTokenList(ctx: *mut CContext, defaultTokens: *mut CArray<CEeeChainTokenDefault>) -> *const CError {
    log::debug!("enter ChainEee updateDefaultTokenList");

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
                let eee_chain = wallets.eee_chain_instance();
                let default_token_list = CArray::<CEeeChainTokenDefault>::ptr_rust(defaultTokens);
                match block_on(eee_chain.update_default_tokens(wallets, default_token_list)) {
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
pub unsafe extern "C" fn ChainEee_getAuthTokenList(ctx: *mut CContext, startItem: c_uint, pageSize: c_uint, tokens: *mut *mut CArray<CEeeChainTokenAuth>) -> *const CError {
    log::debug!("enter ChainEee getAuthTokenList");

    if ctx.is_null() || tokens.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx,tokens cannot be null");
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
                let eee_chain = wallets.eee_chain_instance();
                match block_on(eee_chain.get_auth_tokens(wallets, &wallets.net_type, startItem as u64, pageSize as u64)) {
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
pub unsafe extern "C" fn ChainEee_getDefaultTokenList(ctx: *mut CContext, tokens: *mut *mut CArray<CEeeChainTokenDefault>) -> *const CError {
    log::debug!("enter ChainEee getDefaultTokenList");

    if ctx.is_null() || tokens.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx or tokens cannot be null");
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
                let eee_chain = wallets.eee_chain_instance();
                match block_on(eee_chain.get_default_tokens(wallets, &wallets.net_type)) {
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
