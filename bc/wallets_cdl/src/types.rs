pub type CBool = u16;
pub const CFalse: CBool = 0;
pub const CTrue: CBool = 1;
pub type CU64 = u64;
pub const Success: CU64 = 0;


pub use crate::types_eth::{*};
pub use crate::types_eee::{*};
pub use crate::types_btc::{*};

pub use crate::chain::{*};
pub use crate::chain_eth::{*};
pub use crate::chain_eee::{*};
pub use crate::chain_btc::{*};
use std::os::raw::c_char;

#[repr(C)]
#[derive(Debug, Copy, Clone)]
pub struct CError {
    pub code: CU64,
    pub message: *mut c_char,
}

#[repr(C)]
#[derive(Debug, Copy, Clone)]
pub struct Wallet {
    pub id: *mut c_char,
    pub nextId: *mut c_char,
    pub ethChains: *mut EthChain,
    pub eeeChains: *mut EeeChain,
    pub btcChains: *mut BtcChain,
}

#[repr(C)]
#[derive(Debug, Copy, Clone)]
pub struct Address {
    pub id: *mut c_char,
    pub walletId: *mut c_char,
    pub chainType: *mut c_char,
    pub address: *mut c_char,
    pub publicKey: *mut c_char,
}
#[repr(C)]
#[derive(Debug, Copy, Clone)]
pub struct TokenShared {
    pub id: *mut c_char,
    pub nextId: *mut c_char,
    pub name: *mut c_char,
    pub symbol: *mut c_char,
}
#[repr(C)]
#[derive(Debug, Copy, Clone)]
pub struct ChainShared {
    pub id: *mut c_char,
    pub walletId: *mut c_char,
    pub chainType: *mut c_char,
    #[doc = " 钱包地址"]
    pub walletAddress: *mut Address,
}

#[repr(C)]
#[derive(Debug, Copy, Clone)]
pub struct InitParameters {
    pub code: u64,
}

#[repr(C)]
#[derive(Debug, Copy, Clone)]
pub struct UnInitParameters {
    pub code: u64,
}