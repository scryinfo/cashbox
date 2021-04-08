use super::*;

use wallets_types::{CreateWalletParameters, Wallet};
use wallets_cdl::{
    to_str,
    mem_c::{CWallet_dFree, CStr_dFree, CStr_dAlloc, CWallet_dAlloc},
    wallets_c::{Wallets_createWallet, Wallets_generateMnemonic},
    parameters::CCreateWalletParameters,
    types::CWallet,
};


pub mod node_rpc;

pub fn create_wallet(c_ctx: *mut *mut CContext) -> Wallet {
    unsafe {
        let mnemonic = {
            let p_mn = CStr_dAlloc();
            {
                let c_err = Wallets_generateMnemonic(18, p_mn) as *mut CError;
                assert_eq!(0 as CU64, (*c_err).code, "{:?}", *c_err);
                CError_free(c_err);
            }
            let mn = to_str(*p_mn).to_owned();
            CStr_dFree(p_mn);
            mn
        };
        //invalid parameters
        let mut c_parameters = CCreateWalletParameters::to_c_ptr(&CreateWalletParameters {
            name: "test".to_owned(),
            password: "123456".to_string(),
            mnemonic: mnemonic.clone(),
            wallet_type: mav::WalletType::Test.to_string(),
        });
        let c_wallet = CWallet_dAlloc();
        let c_err = Wallets_createWallet(*c_ctx, c_parameters, c_wallet) as *mut CError;
        c_parameters.free();
        assert_eq!(0 as CU64, (*c_err).code, "{:?}", *c_err);
        CError_free(c_err);
        assert_ne!(null_mut(), *c_wallet);
        let w = CWallet::to_rust(&**c_wallet);
        CWallet_dFree(c_wallet);
        w
    }
}

pub fn init_wallets_context(c_ctx: *mut *mut CContext) -> *mut CError {
    let p = init_parameters();
    let c_parameters = CInitParameters::to_c_ptr(&p);
    let c_err = unsafe {
        Wallets_init(c_parameters, c_ctx) as *mut CError
    };
    c_err
}

pub fn init_parameters() -> InitParameters {
    let mut p = InitParameters::default();
    p.net_type="Test".to_string();
    //p.is_memory_db=mav::CTrue;
    //let prefix = format!("{}_",kits::uuid());
    let prefix = "test_";
    p.db_name.0 = mav::ma::DbName::new(&prefix, "");
    p.context_note = format!("test_{}", prefix);
    p
}