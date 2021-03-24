#![allow(non_snake_case)]
#![allow(non_upper_case_globals)]

use std::os::raw::c_char;

use wallets_macro::{DlCR, DlDefault, DlStruct};
use wallets_types::{
    AccountInfo, ChainVersion, Context, CreateWalletParameters, DbName,
    DecodeAccountInfoParameters, InitParameters, RawTxParam, StorageKeyParameters, EeeTransferPayload, EthTransferPayload, EthRawTxPayload, ExtrinsicContext,EeeChainTx,WalletTokenStatus
};

use crate::kits::{to_c_char, to_str, CStruct, CR, CBool,Assignment};
use crate::CArray;

#[repr(C)]
#[derive(Debug, DlStruct, DlDefault, DlCR)]
pub struct CInitParameters {
    pub dbName: *mut CDbName,
    pub isMemoryDb:CBool,
    pub contextNote: *mut c_char,
}

#[repr(C)]
#[derive(Debug, DlStruct, DlDefault, DlCR)]
pub struct CDbName {
    pub path: *mut c_char,
    pub prefix: *mut c_char,
    pub cashboxWallets: *mut c_char,
    pub cashboxMnemonic: *mut c_char,
    pub walletMainnet: *mut c_char,
    pub walletPrivate: *mut c_char,
    pub walletTestnet: *mut c_char,
    pub walletTestnetPrivate: *mut c_char,
}

#[repr(C)]
#[derive(Debug, DlStruct, DlDefault, DlCR)]
pub struct CCreateWalletParameters {
    pub name: *mut c_char,
    pub password: *mut c_char,
    pub mnemonic: *mut c_char,
    pub walletType: *mut c_char,
}

#[repr(C)]
#[derive(Debug, DlStruct, DlDefault, DlCR)]
pub struct CContext {
    pub id: *mut c_char,
    //上下文的唯一标识
    pub contextNote: *mut c_char,
}

#[repr(C)]
#[derive(Debug, DlStruct, DlDefault, DlCR)]
pub struct CEeeTransferPayload {
    pub fromAccount: *mut c_char,
    pub toAccount: *mut c_char,
    pub value: *mut c_char,
    pub index: u32,
    pub chainVersion: *mut CChainVersion,
    pub extData: *mut c_char,
    pub password: *mut c_char,
}

#[repr(C)]
#[derive(Debug, DlStruct, DlDefault, DlCR)]
pub struct CRawTxParam {
    pub rawTx: *mut c_char,
    pub walletId: *mut c_char,
    pub password: *mut c_char,
}

#[repr(C)]
#[derive(Debug, DlStruct, DlDefault, DlCR)]
pub struct CAccountInfo {
    pub nonce: u32,
    pub refCount: u32,
    pub freeBalance: *mut c_char,
    pub reserved: *mut c_char,
    pub miscFrozen: *mut c_char,
    pub feeFrozen: *mut c_char,
}

#[repr(C)]
#[derive(Debug, DlStruct, DlDefault, DlCR)]
pub struct CDecodeAccountInfoParameters {
    pub encodeData: *mut c_char,
    pub chainVersion: *mut CChainVersion,
}

#[repr(C)]
#[derive(Debug, DlStruct, DlDefault, DlCR)]
pub struct CStorageKeyParameters {
    pub chainVersion: *mut CChainVersion,
    pub module: *mut c_char,
    pub storageItem: *mut c_char,
    pub account: *mut c_char,
}

#[repr(C)]
#[derive(Debug, DlStruct, DlDefault, DlCR)]
pub struct CExtrinsicContext {
    pub chainVersion: *mut CChainVersion,
    pub account: *mut c_char,
    pub blockHash: *mut c_char,
    pub blockNumber: *mut c_char,
    pub event: *mut c_char,
    pub extrinsics: *mut CArray<*mut c_char>,
}


#[repr(C)]
#[derive(Debug, DlStruct, DlDefault, DlCR)]
pub struct CChainVersion {
    pub genesisHash: *mut c_char,
    pub runtimeVersion: i32,
    pub txVersion: i32,
}

#[repr(C)]
#[derive(Debug, DlStruct, DlDefault, DlCR)]
pub struct CEthTransferPayload {
    pub fromAddress: *mut c_char,
    pub toAddress: *mut c_char,
    pub contractAddress: *mut c_char,
    pub value: *mut c_char,
    pub nonce: *mut c_char,
    pub gasPrice: *mut c_char,
    pub gasLimit: *mut c_char,
    pub decimal: u32,
    pub extData: *mut c_char,
}


#[repr(C)]
#[derive(Debug, DlStruct, DlDefault, DlCR)]
pub struct CEthRawTxPayload {
    pub fromAddress: *mut c_char,
    pub rawTx: *mut c_char,
}
#[repr(C)]
#[derive(Debug, DlStruct, DlDefault, DlCR)]
pub struct  CEeeChainTx{
    pub txHash:*mut c_char,
    pub blockHash:*mut c_char,
    pub blockNumber:*mut c_char,
    pub signer:*mut c_char,
    pub walletAccount:*mut  c_char,
    pub fromAddress:*mut c_char,
    pub toAddress:*mut c_char,
    pub value:*mut c_char,
    pub extension:*mut c_char,
    pub status:CBool,
    pub txTimestamp:i64,
    pub txBytes:*mut c_char,
}


#[repr(C)]
#[derive(Debug, Clone, DlStruct, DlDefault, DlCR)]
pub struct CWalletTokenStatus{
    pub walletId: *mut c_char,
    pub chainType: *mut c_char,
    pub tokenId: *mut c_char,
    pub isShow: CBool,
}

