#![allow(non_snake_case)]

use std::os::raw::c_char;
use futures::executor::block_on;

use super::chain_eee::{CSubChainBasicInfo, CAccountInfoSyncProg};
use super::parameters::{CContext, CTransferPayload, CRawTxParam, CAccountInfo, CStorageKeyParameters, CDecodeAccountInfoParameters};
use super::types::CError;
use super::kits::{CBool, CU32, CR, to_c_char, to_str};

use wallets_types::{Context, Error, ContextTrait};
use wallets::{Contexts};
use mav::NetType;
use log::kv::Source;

#[no_mangle]
pub unsafe extern "C" fn ChainEee_updateSyncRecord(ctx: *mut CContext, walletId: *mut c_char, syncRecord: *mut CAccountInfoSyncProg) -> *const CError {
    unimplemented!()
}

#[no_mangle]
pub unsafe extern "C" fn ChainEee_getSyncRecord(ctx: *mut CContext, walletId: *mut c_char, syncRecord: *mut *mut CAccountInfoSyncProg) -> *const CError {
    unimplemented!()
}

#[no_mangle]
pub unsafe extern "C" fn ChainEee_decodeAccountInfo(ctx: *mut CContext, parameters: *mut CDecodeAccountInfoParameters, accountInfo: *mut *mut CAccountInfo) -> *const CError {
    unimplemented!()
}

#[no_mangle]
pub unsafe extern "C" fn ChainEee_getStorageKey(ctx: *mut CContext, parameters: *mut CStorageKeyParameters, accountInfo: *mut *mut c_char) -> *const CError {
    unimplemented!()
}

#[no_mangle]
pub unsafe extern "C" fn ChainEee_eeeTransfer(ctx: *mut CContext, transferPayload: *mut CTransferPayload, signedResult: *mut *mut c_char) -> *const CError {
    unimplemented!()
}

#[no_mangle]
pub unsafe extern "C" fn ChainEee_tokenXTransfer(ctx: *mut CContext, transferPayload: *mut CTransferPayload, signedResult: *mut *mut c_char) -> *const CError {
    unimplemented!()
}

//signed result can be send to chain rpc service by json-rpc
#[no_mangle]
pub unsafe extern "C" fn ChainEee_txSubmittableSign(ctx: *mut CContext, rawTx: *mut CRawTxParam, signedResult: *mut *mut c_char) -> *const CError {
    unimplemented!()
}

//signed result only used for construct ExtrinsicPayload object in typescript
#[no_mangle]
pub unsafe extern "C" fn ChainEee_txSign(ctx: *mut CContext, rawTx: *mut CRawTxParam, signedResult: *mut *mut c_char) -> *const CError {
    unimplemented!()
}

#[no_mangle]
pub unsafe extern "C" fn ChainEee_updateBasicInfo(ctx: *mut CContext, netType: *mut c_char, basicInfo: *mut CSubChainBasicInfo) -> *const CError {
    unimplemented!()
}

#[no_mangle]
pub unsafe extern "C" fn ChainEee_getBasicInfo(ctx: *mut CContext, netType: *mut c_char, basicInfo: *mut *mut CSubChainBasicInfo) -> *const CError {
    unimplemented!()
}
