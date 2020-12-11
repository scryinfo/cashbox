#[cfg(test)]
mod tests {
    use std::ptr::null_mut;

    use mav::WalletType;
    use wallets_types::{CreateWalletParameters, InitParameters};

    use crate::kits::{CR, CU64, to_str};
    use crate::parameters::{CCreateWalletParameters, CInitParameters};
    use crate::types::{CError, CWallet};
    use crate::wallets_c::{CContext_dAlloc, CError_free, CStr_dAlloc, CStr_dFree, CWallet_dAlloc, Wallets_createWallet, Wallets_generateMnemonic, Wallets_init};

    #[test]
    fn memory_test() {
        assert_eq!(2 + 2, 4);
    }

    #[test]
    fn mnemonic_test() {
        unsafe {
            let ptr = CStr_dAlloc();
            let c_err = Wallets_generateMnemonic(ptr) as *mut CError;
            assert_ne!(null_mut(), c_err);
            let err = &*c_err;
            assert_eq!(0 as CU64, err.code);
            let words: Vec<&str> = to_str(*ptr).split(" ").collect();
            CStr_dFree(ptr);
            assert_eq!(15, words.len());
        }
    }

    #[test]
    fn init_test() {
        unsafe {
            let ctx = CContext_dAlloc();
            assert_ne!(null_mut(), ctx);
            let parameters = init_parameters();
            let c_err = Wallets_init(CInitParameters::to_c_ptr(&parameters), ctx) as *mut CError;
            assert_ne!(null_mut(), c_err);
            let err = &*c_err;
            assert_eq!(0 as CU64, err.code);
            CError_free(c_err);
            assert_ne!(null_mut(), *ctx);
            assert_eq!(parameters.context_note.as_str(), to_str((**ctx).contextNote));
            assert_ne!(0, to_str((**ctx).id).len());
        }
    }

    #[test]
    fn wallets_test() {
        unsafe {
            let context = {
                let ctx = CContext_dAlloc();
                let parameters = init_parameters();
                let c_err = Wallets_init(CInitParameters::to_c_ptr(&parameters), ctx) as *mut CError;
                assert_eq!(0 as CU64, (*c_err).code);
                CError_free(c_err);
                ctx
            };
            let mn = {
                let p_mn = CStr_dAlloc();
                let c_err = Wallets_generateMnemonic(p_mn) as *mut CError;
                assert_eq!(0 as CU64, (*c_err).code);
                CError_free(c_err);
                let mn = to_str(*p_mn).to_owned();
                CStr_dFree(p_mn);
                mn
            };
            let w = {
                let cw = CWallet_dAlloc();
                let parameters = CreateWalletParameters {
                    name: "test".to_owned(),
                    password: "1".to_string(),
                    mnemonic: mn,
                    wallet_type: WalletType::Normal.to_string(),
                };
                let parameters = CCreateWalletParameters::to_c_ptr(&parameters);
                let c_err = Wallets_createWallet(*context, parameters, cw) as *mut CError;
                assert_eq!(0 as CU64, (*c_err).code);
                CError_free(c_err);
                assert_ne!(null_mut(), *cw);
                let w = CWallet::to_rust(&**cw);
                w
            };
        }
    }

    fn init_parameters() -> InitParameters {
        let mut p = InitParameters::default();
        p.db_name.cashbox_wallets = "cashbox_wallets.db".to_owned();
        p.db_name.cashbox_mnemonic = "cashbox_mnemonic.db".to_owned();
        p.db_name.wallet_mainnet = "wallet_mainnet.db".to_owned();
        p.db_name.wallet_private = "wallet_private.db".to_owned();
        p.db_name.wallet_testnet = "wallet_testnet.db".to_owned();
        p.db_name.wallet_testnet_private = "wallet_testnet_private.db".to_owned();
        p.context_note = "context_test".to_owned();
        p
    }
}