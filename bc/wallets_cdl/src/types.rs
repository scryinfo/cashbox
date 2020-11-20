#![allow(non_snake_case)]
#![allow(non_upper_case_globals)]

use std::os::raw::c_char;
use std::ptr::null_mut;

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

#[repr(C)]
#[derive(Debug, Clone)]
pub struct CError {
    //由于很多地方都有使用 error这个名字，加一个C减少重名
    pub code: CU64,
    pub message: *mut c_char,
}

impl Default for CError {
    fn default() -> Self {
        CError {
            code: 0,
            message: null_mut(),
        }
    }
}

impl CStruct for CError {
    fn free(&mut self) {
        self.message.free();
    }
}

drop_ctype!(CError);

#[repr(C)]
#[derive(Debug, Clone)]
pub struct Wallet {
    pub id: *mut c_char,
    pub nextId: *mut c_char,
    pub ethChains: *mut EthChain,
    pub eeeChains: *mut EeeChain,
    pub btcChains: *mut BtcChain,
}

impl CStruct for Wallet {
    fn free(&mut self) {
        self.id.free();
        self.nextId.free();
        self.ethChains.free();
        self.eeeChains.free();
        self.btcChains.free();
    }
}

drop_ctype!(Wallet);

impl Default for Wallet {
    fn default() -> Self {
        Self {
            id: null_mut(),
            nextId: null_mut(),
            ethChains: null_mut(),
            eeeChains: null_mut(),
            btcChains: null_mut(),
        }
    }
}

#[repr(C)]
#[derive(Debug, Clone)]
pub struct Address {
    pub id: *mut c_char,
    pub walletId: *mut c_char,
    pub chainType: *mut c_char,
    pub address: *mut c_char,
    pub publicKey: *mut c_char,
}

impl CStruct for Address {
    fn free(&mut self) {
        self.id.free();
        self.walletId.free();
        self.chainType.free();
        self.address.free();
        self.publicKey.free();
    }
}
drop_ctype!(Address);
#[repr(C)]
#[derive(Debug, Clone)]
pub struct TokenShared {
    pub id: *mut c_char,
    pub nextId: *mut c_char,
    pub name: *mut c_char,
    pub symbol: *mut c_char,
}

impl CStruct for TokenShared {
    fn free(&mut self) {
        self.id.free();
        self.nextId.free();
        self.name.free();
        self.symbol.free();
    }
}
drop_ctype!(TokenShared);
#[repr(C)]
#[derive(Debug, Clone)]
pub struct ChainShared {
    pub id: *mut c_char,
    pub walletId: *mut c_char,
    pub chainType: *mut c_char,
    #[doc = " 钱包地址"]
    pub walletAddress: *mut Address,
}

impl CStruct for ChainShared {
    fn free(&mut self) {
        self.id.free();
        self.walletId.free();
        self.chainType.free();
        self.walletAddress.free();
    }
}
drop_ctype!(ChainShared);
#[repr(C)]
#[derive(Debug, Clone)]
pub struct InitParameters {
    pub code: u64,
}

impl CStruct for InitParameters {
    fn free(&mut self) {}
}
drop_ctype!(InitParameters);
#[repr(C)]
#[derive(Debug, Clone)]
pub struct UnInitParameters {
    pub code: u64,
}

impl CStruct for UnInitParameters {
    fn free(&mut self) {}
}
drop_ctype!(UnInitParameters);
#[repr(C)]
#[derive(Debug, Clone)]
pub struct Context {}

impl CStruct for Context {
    fn free(&mut self) {}
}
drop_ctype!(Context);

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
    fn test_free() {
        let e = CError::default();
    }
}
