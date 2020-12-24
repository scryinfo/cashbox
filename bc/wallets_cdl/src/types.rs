#![allow(non_snake_case)]
#![allow(non_upper_case_globals)]

use std::fmt;
use std::os::raw::c_char;

use wallets_macro::{DlCR, DlDefault, DlStruct};
use wallets_types::{Address, ChainShared, Error, TokenShared, Wallet};

pub use crate::chain::{*};
pub use crate::chain_btc::{*};
pub use crate::chain_eee::{*};
pub use crate::chain_eth::{*};
pub use crate::kits::{CR, CU64};
use crate::kits::{CMark, CStruct, to_c_char, to_str};
pub use crate::types_btc::{*};
pub use crate::types_eee::{*};
pub use crate::types_eth::{*};

#[repr(C)]
#[derive(DlStruct, DlDefault, DlCR)]
pub struct CError {
    //由于很多地方都有使用 error这个名字，加一个C减少重名
    pub code: CU64,
    pub message: *mut c_char,
}

impl fmt::Debug for CError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        let message = to_str(self.message).to_owned();
        f.debug_struct("CError")
            .field("code", &self.code)
            .field("message", &message)
            .finish()
    }
}

#[repr(C)] //
#[derive(Debug, DlStruct, DlDefault, DlCR)]
pub struct CWallet {
    pub id: *mut c_char,
    pub nextId: *mut c_char,
    pub name: *mut c_char,
    pub ethChain: *mut CEthChain,
    pub eeeChain: *mut CEeeChain,
    pub btcChain: *mut CBtcChain,
}

#[repr(C)]
#[derive(Debug, DlStruct, DlDefault, DlCR)]
pub struct CAddress {
    pub id: *mut c_char,
    pub walletId: *mut c_char,
    pub chainType: *mut c_char,
    pub address: *mut c_char,
    pub publicKey: *mut c_char,
}

#[repr(C)]
#[derive(Debug, DlStruct, DlDefault, DlCR)]
pub struct CTokenShared {
    pub chainType: *mut c_char,
    pub name: *mut c_char,
    pub symbol: *mut c_char,
    pub logoUrl: *mut c_char,
    pub logoBytes: *mut c_char,
    pub project: *mut c_char,
    pub auth: bool,
}

#[repr(C)]
#[derive(Debug, DlStruct, DlDefault, DlCR)]
pub struct CChainShared {
    pub walletId: *mut c_char,
    pub chainType: *mut c_char,
    /// 钱包地址
    pub walletAddress: *mut CAddress,
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
