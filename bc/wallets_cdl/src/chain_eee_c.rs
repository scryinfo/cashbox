#![allow(non_snake_case)]

use std::os::raw::c_char;

use futures::executor::block_on;

use mav::NetType;
use wallets::Contexts;
use wallets_types::Error;

use crate::kits::CStruct;
use crate::parameters::CChainVersion;

use super::chain_eee::{CAccountInfoSyncProg, CSubChainBasicInfo};
use super::kits::{CR, to_c_char, to_str};
use super::parameters::{CAccountInfo, CContext, CDecodeAccountInfoParameters, CRawTxParam, CStorageKeyParameters, CEeeTransferPayload};
use super::types::CError;

#[no_mangle]
pub unsafe extern "C" fn ChainEee_updateSyncRecord(ctx: *mut CContext, netType: *mut c_char, syncRecord: *mut CAccountInfoSyncProg) -> *const CError {
    log::debug!("enter ChainEee updateSyncRecord");
    if ctx.is_null() || netType.is_null() || syncRecord.is_null() {
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
                let net_type = NetType::from(to_str(netType));
                let sync_record = CAccountInfoSyncProg::ptr_rust(syncRecord);
                match block_on(eee_chain.update_sync_record(wallets, &net_type, &sync_record)) {
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
pub unsafe extern "C" fn ChainEee_getSyncRecord(ctx: *mut CContext, netType: *mut c_char, account: *mut c_char, syncRecord: *mut *mut CAccountInfoSyncProg) -> *const CError {
    log::debug!("enter ChainEee getSyncRecord");
    if ctx.is_null() || netType.is_null() || syncRecord.is_null() {
        let err = Error::PARAMETER().append_message("  : ctx or netType or syncRecord is null");
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
                let net_type = NetType::from(to_str(netType));
                match block_on(eee_chain.get_sync_record(wallets, &net_type, &to_str(account))) {
                    Ok(res) => {
                        *syncRecord = CAccountInfoSyncProg::to_c_ptr(&res);
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
pub unsafe extern "C" fn ChainEee_decodeAccountInfo(ctx: *mut CContext, netType: *mut c_char, parameters: *mut CDecodeAccountInfoParameters, accountInfo: *mut *mut CAccountInfo) -> *const CError {
    log::debug!("enter ChainEee decodeAccountInfo");
    if ctx.is_null() || netType.is_null() || parameters.is_null() || accountInfo.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx or decodeAccountInfo is null");
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
                let net_type = NetType::from(to_str(netType));
                let parameters = CDecodeAccountInfoParameters::ptr_rust(parameters);
                match block_on(eee_chain.decode_account_info(wallets, &net_type, parameters)) {
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
pub unsafe extern "C" fn ChainEee_getStorageKey(ctx: *mut CContext, netType: *mut c_char, parameters: *mut CStorageKeyParameters, key: *mut *mut c_char) -> *const CError {
    log::debug!("enter ChainEee getStorageKey");

    if ctx.is_null() || netType.is_null() || parameters.is_null() || key.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx or parameters is null");
        log::error!("{}", err);
        return CError::to_c_ptr(&err);
    }
    (*key).free();//如果内存已存在，释放它
    let lock = Contexts::collection().lock();
    let mut contexts = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        match contexts.get(&ctx.id) {
            Some(wallets) => {
                let eee_chain = wallets.eee_chain_instance();
                let net_type = NetType::from(to_str(netType));
                let parameters = CStorageKeyParameters::ptr_rust(parameters);
                match block_on(eee_chain.get_storage_key(wallets, &net_type, parameters)) {
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
pub unsafe extern "C" fn ChainEee_eeeTransfer(ctx: *mut CContext, netType: *mut c_char, transferPayload: *mut CEeeTransferPayload, signedResult: *mut *mut c_char) -> *const CError {
    log::debug!("enter ChainEee updateBasicInfo");
    if ctx.is_null() || netType.is_null() || signedResult.is_null() || transferPayload.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx or eeeTransfer is null");
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
                let net_type = NetType::from(to_str(netType));
                let transferPayload = CEeeTransferPayload::ptr_rust(transferPayload);
                match block_on(eee_chain.eee_transfer(wallets, &net_type, &transferPayload)) {
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
pub unsafe extern "C" fn ChainEee_tokenXTransfer(ctx: *mut CContext, netType: *mut c_char, transferPayload: *mut CEeeTransferPayload, signedResult: *mut *mut c_char) -> *const CError {
    log::debug!("enter ChainEee updateBasicInfo");
    if ctx.is_null() || netType.is_null() || signedResult.is_null() || transferPayload.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx or transferPayload is null");
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
                let net_type = NetType::from(to_str(netType));
                let transferPayload = CEeeTransferPayload::ptr_rust(transferPayload);
                match block_on(eee_chain.tokenx_transfer(wallets, &net_type, &transferPayload)) {
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
pub unsafe extern "C" fn ChainEee_txSubmittableSign(ctx: *mut CContext, netType: *mut c_char, rawTx: *mut CRawTxParam, signedResult: *mut *mut c_char) -> *const CError {
    log::debug!("enter ChainEee updateBasicInfo");
    if ctx.is_null() || netType.is_null() || rawTx.is_null() || signedResult.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx or txSubmittableSign is null");
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
                let net_type = NetType::from(to_str(netType));
                let raw_tx = CRawTxParam::ptr_rust(rawTx);
                match block_on(eee_chain.tx_sign(wallets, &net_type, &raw_tx, false)) {
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
pub unsafe extern "C" fn ChainEee_txSign(ctx: *mut CContext, netType: *mut c_char, rawTx: *mut CRawTxParam, signedResult: *mut *mut c_char) -> *const CError {
    log::debug!("enter ChainEee updateBasicInfo");
    if ctx.is_null() || netType.is_null() || rawTx.is_null() || signedResult.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx or txSign is null");
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
                let net_type = NetType::from(to_str(netType));
                let raw_tx = CRawTxParam::ptr_rust(rawTx);
                match block_on(eee_chain.tx_sign(wallets, &net_type, &raw_tx, true)) {
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
pub unsafe extern "C" fn ChainEee_updateBasicInfo(ctx: *mut CContext, netType: *mut c_char, basicInfo: *mut CSubChainBasicInfo) -> *const CError {
    log::debug!("enter ChainEee updateBasicInfo");

    if ctx.is_null() || basicInfo.is_null() || netType.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx,basicInfo or netType is null");
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
                let net_type = NetType::from(to_str(netType));
                let mut info = CSubChainBasicInfo::ptr_rust(basicInfo);
                match block_on(eee_chain.update_basic_info(wallets, &net_type, &mut info)) {
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
pub unsafe extern "C" fn ChainEee_getBasicInfo(ctx: *mut CContext, netType: *mut c_char, chainVersion: *mut CChainVersion, basicInfo: *mut *mut CSubChainBasicInfo) -> *const CError {
    log::debug!("enter ChainEee getBasicInfo");

    if ctx.is_null() || basicInfo.is_null() || netType.is_null() || chainVersion.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx or chainVersion or netType is null");
        log::error!("{}", err);
        return CError::to_c_ptr(&err);
    }
    (*basicInfo).free();
    let lock = Contexts::collection().lock();
    let mut contexts = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        match contexts.get(&ctx.id) {
            Some(wallets) => {
                let eee_chain = wallets.eee_chain_instance();
                let net_type = NetType::from(to_str(netType));
                let chain_version = CChainVersion::ptr_rust(chainVersion);
                match block_on(eee_chain.get_basic_info(wallets, &net_type, &chain_version.genesis_hash, chain_version.runtime_version, chain_version.tx_version)) {
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
