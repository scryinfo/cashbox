#![allow(non_snake_case)]

use std::os::raw::c_char;

use super::chain_eee::{CSubChainBasicInfo,CSyncRecordDetail};
use super::parameters::{CContext,CTransferPayload,CRawTxParam,CAccountInfo};
use super::types::CError;
use crate::kits::{CBool,CU32};

#[no_mangle]
pub unsafe extern "C" fn ChainEee_updateSyncRecord(ctx: *mut CContext, syncRecord: *mut CSyncRecordDetail) -> *const CError {
    unimplemented!()
}

#[no_mangle]
pub unsafe extern "C" fn ChainEee_getSyncRecord(ctx: *mut CContext, syncRecord: *mut *mut CSyncRecordDetail) -> *const CError {
    unimplemented!()
}

#[no_mangle]
pub unsafe extern "C" fn ChainEee_decodeAccountInfo(ctx: *mut CContext,encodeData:*mut c_char, accountInfo: *mut *mut CAccountInfo) -> *const CError {
   unimplemented!()
}
#[no_mangle]
pub unsafe extern "C" fn ChainEee_getStorageKey(ctx: *mut CContext,module: *mut c_char,storageItem:*mut c_char,pubKey:*mut c_char, accountInfo: *mut *mut c_char) -> *const CError {
    unimplemented!()
}

#[no_mangle]
pub unsafe extern "C" fn ChainEee_eeeTransfer(ctx: *mut CContext,transferPayload:*mut CTransferPayload, signedResult: *mut *mut c_char) -> *const CError {
    unimplemented!()
}

#[no_mangle]
pub unsafe extern "C" fn ChainEee_tokenXTransfer(ctx: *mut CContext,transferPayload:*mut CTransferPayload, signedResult: *mut *mut c_char) -> *const CError {
    unimplemented!()
}
//signed result can be send to chain rpc service by json-rpc
#[no_mangle]
pub unsafe extern "C" fn ChainEee_txSubmittableSign(ctx: *mut CContext,rawTx: *mut CRawTxParam, signedResult: *mut *mut c_char) -> *const CError {
    unimplemented!()
}
//signed result only used for construct ExtrinsicPayload object in typescript
#[no_mangle]
pub unsafe extern "C" fn ChainEee_txSign(ctx: *mut CContext,rawTx: *mut CRawTxParam, signedResult: *mut *mut c_char) -> *const CError {
    unimplemented!()
}

#[no_mangle]
pub unsafe extern "C" fn ChainEee_updateBasicInfo(ctx: *mut CContext,basicInfo: *mut CSubChainBasicInfo, isDefault: *mut CBool) -> *const CError {
    unimplemented!()
}

#[no_mangle]
pub unsafe extern "C" fn ChainEee_getBasicInfo(ctx: *mut CContext,genesisHash: *mut c_char,specVersion:*mut CU32,txVersion:*mut CU32,basicInfo: *mut *mut CSubChainBasicInfo) -> *const CError {
    unimplemented!()
}
