#![allow(non_snake_case)]
#![allow(non_upper_case_globals)]

use std::os::raw::c_char;

use wallets_macro::{DlDefault, DlStruct};

pub use crate::chain::{*};
pub use crate::chain_btc::{*};
pub use crate::chain_eee::{*};
pub use crate::chain_eth::{*};
use crate::drop_ctype;
pub use crate::kits::{CBool, CFalse, CTrue, CU64};
use crate::kits::{CArray, CStruct, free_c_char, pointer_alloc, pointer_free};
pub use crate::types_btc::{*};
pub use crate::types_eee::{*};
pub use crate::types_eth::{*};

#[repr(C)]
#[derive(Debug, Clone, DlStruct, DlDefault)]
pub struct CError {
    //由于很多地方都有使用 error这个名字，加一个C减少重名
    pub code: CU64,
    pub message: *mut c_char,
}

#[repr(C)]
#[derive(Debug, Clone, DlStruct, DlDefault)]
pub struct Wallet {
    pub id: *mut c_char,
    pub nextId: *mut c_char,
    pub ethChains: *mut EthChain,
    pub eeeChains: *mut EeeChain,
    pub btcChains: *mut BtcChain,
}

impl Wallet {
    pub fn to_c(wallet: &wallets_types::Wallet) -> *mut Wallet {
        let temp = Box::new(Wallet::default());
        //todo
        Box::into_raw(temp)
    }
    pub fn to_rust(wallet: &Wallet) -> wallets_types::Wallet {
        let w = wallets_types::Wallet::default();
        //todo
        w
    }
}


#[repr(C)]
#[derive(Debug, Clone, DlStruct, DlDefault)]
pub struct Address {
    pub id: *mut c_char,
    pub walletId: *mut c_char,
    pub chainType: *mut c_char,
    pub address: *mut c_char,
    pub publicKey: *mut c_char,
}

#[repr(C)]
#[derive(Debug, Clone, DlStruct, DlDefault)]
pub struct TokenShared {
    pub id: *mut c_char,
    pub nextId: *mut c_char,
    pub name: *mut c_char,
    pub symbol: *mut c_char,
}

#[repr(C)]
#[derive(Debug, Clone, DlStruct, DlDefault)]
pub struct ChainShared {
    pub id: *mut c_char,
    pub walletId: *mut c_char,
    pub chainType: *mut c_char,
    /// 钱包地址
    pub walletAddress: *mut Address,
}


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
pub extern "C" fn CArrayWallet_dAlloc() -> *mut *mut CArray<Wallet> {
    pointer_alloc()
}

#[no_mangle]
pub unsafe extern "C" fn CArrayWallet_dFree(dPtr: *mut *mut CArray<Wallet>) {
    pointer_free(dPtr)
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
