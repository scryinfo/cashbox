#![allow(non_snake_case)]
#![allow(non_upper_case_globals)]

use std::os::raw::c_char;

use crate::kits::{d_ptr_alloc, d_ptr_free, CArray, CBool, CStruct};
use crate::parameters::{CAccountInfo, CContext, CDbName, CExtrinsicContext, CEeeChainTx, CWalletTokenStatus, CBtcNowLoadBlock};

use crate::types::{CAccountInfoSyncProg, CError, CSubChainBasicInfo, CWallet,
                   CEthChainTokenDefault, CTokenAddress, CEthChainTokenAuth, CEeeChainTokenAuth, CBtcChainTokenAuth,
                   CEeeChainTokenDefault, CBtcChainTokenDefault};
use crate::chain_eth::CEthChainTokenNonAuth;


/// alloc ** [parameters::CContext]
#[no_mangle]
pub extern "C" fn CContext_dAlloc() -> *mut *mut CContext {
    d_ptr_alloc()
}

/// free ** [parameters::CContext]
#[no_mangle]
pub unsafe extern "C" fn CContext_dFree(dPtr: *mut *mut CContext) {
    let mut dPtr = dPtr;
    d_ptr_free(&mut dPtr);
}

/// alloc ** [CArray]
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
pub unsafe extern "C" fn CStr_free(dcs: *mut c_char) {
    let mut dcs = dcs;
    dcs.free();
}

#[no_mangle]
pub unsafe extern "C" fn CStr_dFree(dcs: *mut *mut c_char) {
    let mut dcs = dcs;
    d_ptr_free(&mut dcs);
}

#[no_mangle]
pub unsafe extern "C" fn CStr_dAlloc() -> *mut *mut c_char {
    d_ptr_alloc()
}

#[no_mangle]
pub unsafe extern "C" fn CBool_free(dcs: *mut CBool) {
    Box::from_raw(dcs);
}

#[no_mangle]
pub unsafe extern "C" fn CBool_alloc() -> *mut CBool {
    let c_bool: *mut CBool = Box::into_raw(Box::new(0));
    c_bool
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

#[no_mangle]
pub extern "C" fn CDbName_dAlloc() -> *mut *mut CDbName {
    d_ptr_alloc()
}

#[no_mangle]
pub unsafe extern "C" fn CDbName_dFree(dPtr: *mut *mut CDbName) {
    let mut dPtr = dPtr;
    d_ptr_free(&mut dPtr);
}

#[no_mangle]
pub extern "C" fn CArrayInt64_dAlloc() -> *mut *mut CArray<i64> {
    d_ptr_alloc()
}

#[no_mangle]
pub unsafe extern "C" fn CArrayInt64_dFree(dPtr: *mut *mut CArray<i64>) {
    let mut dPtr = dPtr;
    d_ptr_free(&mut dPtr);
}

#[no_mangle]
pub extern "C" fn CAccountInfoSyncProg_dAlloc() -> *mut *mut CAccountInfoSyncProg {
    d_ptr_alloc()
}

#[no_mangle]
pub unsafe extern "C" fn CAccountInfoSyncProg_dFree(dPtr: *mut *mut CAccountInfoSyncProg) {
    let mut dPtr = dPtr;
    d_ptr_free(&mut dPtr);
}

#[no_mangle]
pub extern "C" fn CAccountInfo_dAlloc() -> *mut *mut CAccountInfo {
    d_ptr_alloc()
}

#[no_mangle]
pub unsafe extern "C" fn CAccountInfo_dFree(dPtr: *mut *mut CAccountInfo) {
    let mut dPtr = dPtr;
    d_ptr_free(&mut dPtr);
}

#[no_mangle]
pub extern "C" fn CSubChainBasicInfo_dAlloc() -> *mut *mut CSubChainBasicInfo {
    d_ptr_alloc()
}

#[no_mangle]
pub unsafe extern "C" fn CSubChainBasicInfo_dFree(dPtr: *mut *mut CSubChainBasicInfo) {
    let mut dPtr = dPtr;
    d_ptr_free(&mut dPtr);
}

#[no_mangle]
pub extern "C" fn CArrayCChar_dAlloc() -> *mut *mut CArray<*mut c_char> {
    d_ptr_alloc()
}

#[no_mangle]
pub unsafe extern "C" fn CArrayCChar_dFree(dPtr: *mut *mut CArray<*mut c_char>) {
    let mut dPtr = dPtr;
    d_ptr_free(&mut dPtr);
}

#[no_mangle]
pub extern "C" fn CExtrinsicContext_dAlloc() -> *mut *mut CArray<CExtrinsicContext> {
    d_ptr_alloc()
}

#[no_mangle]
pub unsafe extern "C" fn CExtrinsicContext_dFree(dPtr: *mut *mut CArray<CExtrinsicContext>) {
    let mut dPtr = dPtr;
    d_ptr_free(&mut dPtr);
}

#[no_mangle]
pub extern "C" fn CArrayCTokenAddress_dAlloc() -> *mut *mut CArray<CTokenAddress> {
    d_ptr_alloc()
}

#[no_mangle]
pub unsafe extern "C" fn CArrayCTokenAddress_dFree(dPtr: *mut *mut CArray<CTokenAddress>) {
    let mut dPtr = dPtr;
    d_ptr_free(&mut dPtr);
}

#[no_mangle]
pub extern "C" fn CArrayCEthChainTokenAuth_dAlloc() -> *mut *mut CArray<CEthChainTokenAuth> {
    d_ptr_alloc()
}

#[no_mangle]
pub unsafe extern "C" fn CArrayCEthChainTokenAuth_dFree(dPtr: *mut *mut CArray<CEthChainTokenAuth>) {
    let mut dPtr = dPtr;
    d_ptr_free(&mut dPtr);
}

#[no_mangle]
pub extern "C" fn CArrayCEthChainTokenNonAuth_dAlloc() -> *mut *mut CArray<CEthChainTokenNonAuth> {
    d_ptr_alloc()
}

#[no_mangle]
pub unsafe extern "C" fn CArrayCEthChainTokenNonAuth_dFree(dPtr: *mut *mut CArray<CEthChainTokenNonAuth>) {
    let mut dPtr = dPtr;
    d_ptr_free(&mut dPtr);
}

#[no_mangle]
pub extern "C" fn CArrayCEthChainTokenDefault_dAlloc() -> *mut *mut CArray<CEthChainTokenDefault> {
    d_ptr_alloc()
}

#[no_mangle]
pub unsafe extern "C" fn CArrayCEthChainTokenDefault_dFree(dPtr: *mut *mut CArray<CEthChainTokenDefault>) {
    let mut dPtr = dPtr;
    d_ptr_free(&mut dPtr);
}

#[no_mangle]
pub extern "C" fn CArrayCEeeChainTokenDefault_dAlloc() -> *mut *mut CArray<CEeeChainTokenDefault> {
    d_ptr_alloc()
}

#[no_mangle]
pub unsafe extern "C" fn CArrayCEeeChainTokenDefault_dFree(dPtr: *mut *mut CArray<CEeeChainTokenDefault>) {
    let mut dPtr = dPtr;
    d_ptr_free(&mut dPtr);
}

#[no_mangle]
pub extern "C" fn CArrayCBtcChainTokenDefault_dAlloc() -> *mut *mut CArray<CBtcChainTokenDefault> {
    d_ptr_alloc()
}

#[no_mangle]
pub unsafe extern "C" fn CArrayCBtcChainTokenDefault_dFree(dPtr: *mut *mut CArray<CBtcChainTokenDefault>) {
    let mut dPtr = dPtr;
    d_ptr_free(&mut dPtr);
}

#[no_mangle]
pub extern "C" fn CArrayCEeeChainTokenAuth_dAlloc() -> *mut *mut CArray<CEeeChainTokenAuth> {
    d_ptr_alloc()
}

#[no_mangle]
pub unsafe extern "C" fn CArrayCEeeChainTokenAuth_dFree(dPtr: *mut *mut CArray<CEeeChainTokenAuth>) {
    let mut dPtr = dPtr;
    d_ptr_free(&mut dPtr);
}

#[no_mangle]
pub extern "C" fn CArrayCBtcChainTokenAuth_dAlloc() -> *mut *mut CArray<CBtcChainTokenAuth> {
    d_ptr_alloc()
}

#[no_mangle]
pub unsafe extern "C" fn CArrayCBtcChainTokenAuth_dFree(dPtr: *mut *mut CArray<CBtcChainTokenAuth>) {
    let mut dPtr = dPtr;
    d_ptr_free(&mut dPtr);
}

#[no_mangle]
pub extern "C" fn CArrayCEeeChainTx_dAlloc() -> *mut *mut CArray<CEeeChainTx> {
    d_ptr_alloc()
}

#[no_mangle]
pub unsafe extern "C" fn CArrayCEeeChainTx_dFree(dPtr: *mut *mut CArray<CEeeChainTx>) {
    let mut dPtr = dPtr;
    d_ptr_free(&mut dPtr);
}

#[no_mangle]
pub extern "C" fn CWalletTokenStatus_dAlloc() -> *mut *mut CWalletTokenStatus{
    d_ptr_alloc()
}

#[no_mangle]
pub unsafe extern "C" fn CWalletTokenStatus_dFree(dPtr: *mut *mut CWalletTokenStatus) {
    let mut dPtr = dPtr;
    d_ptr_free(&mut dPtr);
}

#[no_mangle]
pub unsafe extern "C" fn CBtcNowLoadBlock_dAlloc() -> *mut *mut CBtcNowLoadBlock{
    d_ptr_alloc()
}

#[no_mangle]
pub unsafe extern "C" fn CbtcNowLoadBlock_dFree(dPtr: *mut *mut CBtcNowLoadBlock){
    let mut dPtr = dPtr;
    d_ptr_free(&mut dPtr)
}


// alloc free end