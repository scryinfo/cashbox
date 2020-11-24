#![allow(non_snake_case)]
#![allow(non_upper_case_globals)]

use std::os::raw::c_char;

pub use crate::chain::{*};
pub use crate::chain_btc::{*};
pub use crate::chain_eee::{*};
pub use crate::chain_eth::{*};
use crate::drop_ctype;
pub use crate::kits::{CBool, CFalse, CTrue, CU64};
use crate::kits::{CArray, CStruct, free_c_char};
pub use crate::types_btc::{*};
pub use crate::types_eee::{*};
pub use crate::types_eth::{*};

use wallets_macro::{DlStruct,DlDefault};

#[repr(C)]
#[derive(Debug, Clone,DlStruct,DlDefault)]
pub struct CError {
    //由于很多地方都有使用 error这个名字，加一个C减少重名
    pub code: CU64,
    pub message: *mut c_char,
}

#[repr(C)]
#[derive(Debug, Clone,DlStruct,DlDefault)]
pub struct Wallet {
    pub id: *mut c_char,
    pub nextId: *mut c_char,
    pub ethChains: *mut EthChain,
    pub eeeChains: *mut EeeChain,
    pub btcChains: *mut BtcChain,
}

#[repr(C)]
#[derive(Debug, Clone,DlStruct,DlDefault)]
pub struct Address {
    pub id: *mut c_char,
    pub walletId: *mut c_char,
    pub chainType: *mut c_char,
    pub address: *mut c_char,
    pub publicKey: *mut c_char,
}

#[repr(C)]
#[derive(Debug, Clone,DlStruct,DlDefault)]
pub struct TokenShared {
    pub id: *mut c_char,
    pub nextId: *mut c_char,
    pub name: *mut c_char,
    pub symbol: *mut c_char,
}

#[repr(C)]
#[derive(Debug, Clone,DlStruct,DlDefault)]
pub struct ChainShared {
    pub id: *mut c_char,
    pub walletId: *mut c_char,
    pub chainType: *mut c_char,
    /// 钱包地址
    pub walletAddress: *mut Address,
}

#[repr(C)]
#[derive(Debug, Clone,DlStruct,DlDefault)]
pub struct InitParameters {
    pub code: u64,
}

#[repr(C)]
#[derive(Debug, Clone,DlStruct,DlDefault)]
pub struct UnInitParameters {
    pub code: u64,
}

#[repr(C)]
#[derive(Debug, Clone,DlStruct,DlDefault)]
pub struct Context {}

#[no_mangle]
pub extern "C" fn CStr_free(cs: *mut c_char) {
    let mut t = cs;//由于 free_c_char 会把参数的值修改为空，所以这里要定义一个临时变量，
    free_c_char(&mut t);
}

#[no_mangle]
pub unsafe extern "C" fn CError_free(error: *mut CError) {
    if !error.is_null() {
        Box::from_raw(error);
    }
}

#[no_mangle]
pub extern "C" fn Wallet_alloc() -> *mut Wallet {
    Box::into_raw(Box::new(Wallet::default()))
}

#[no_mangle]
pub unsafe extern "C" fn Wallet_free(ptr: *mut Wallet) {
    Box::from_raw(ptr);
}

#[no_mangle]
pub extern "C" fn CArrayWallet_alloc() -> *mut CArray<Wallet> {
    Box::into_raw(Box::new(CArray::<Wallet>::default()))
}

#[no_mangle]
pub unsafe extern "C" fn CArrayWallet_free(ptr: *mut CArray<Wallet>) {
    Box::from_raw(ptr);
}

#[cfg(test)]
mod tests {
    use crate::types::CError;

    #[test]
    fn c_error() {
        let e = CError::default();
        assert_eq!(0, e.code);
        assert_eq!(std::ptr::null_mut(), e.message);
    }
}
