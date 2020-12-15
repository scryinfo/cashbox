#[cfg(test)]
mod tests {
    use std::ptr::null_mut;

    use async_std::task::block_on;

    use mav::{kits, WalletType};
    use mav::ma::DbCreateType;
    use wallets::Contexts;
    use wallets_types::{CreateWalletParameters, InitParameters, WalletError};

    use crate::kits::{CR, CStruct, CU64, to_str};
    use crate::parameters::{CCreateWalletParameters, CInitParameters};
    use crate::types::{CError, CWallet};
    use crate::wallets_c::{CContext_dAlloc, CContext_dFree, CError_free, CStr_dAlloc, CStr_dFree, CWallet_dAlloc, CWallet_dFree, Wallets_createWallet, Wallets_generateMnemonic, Wallets_init, Wallets_uninit};

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
            CError_free(c_err);
            assert_eq!(15, words.len());
        }
    }

    #[test]
    fn init_test() {
        unsafe {
            let ctx = CContext_dAlloc();
            assert_ne!(null_mut(), ctx);
            let parameters = init_parameters();
            let mut ptr = CInitParameters::to_c_ptr(&parameters);
            let c_err = Wallets_init(ptr, ctx) as *mut CError;
            assert_ne!(null_mut(), c_err);
            let err = &*c_err;
            assert_eq!(0 as CU64, err.code);
            CError_free(c_err);
            ptr.free();

            assert_ne!(null_mut(), *ctx);
            assert_eq!(parameters.context_note.as_str(), to_str((**ctx).contextNote));
            assert_ne!(0, to_str((**ctx).id).len());

            {//only release memory
                let c_err = Wallets_uninit(*ctx) as *mut CError;
                assert_ne!(null_mut(), c_err);
                CError_free(c_err);
                CContext_dFree(ctx);

                // let _ = free_wallets();
            }
        }
    }

    #[test]
    fn wallets_test() {
        unsafe {
            let context = {
                let ctx = CContext_dAlloc();
                let parameters = init_parameters();
                let mut ptr = CInitParameters::to_c_ptr(&parameters);
                let c_err = Wallets_init(ptr, ctx) as *mut CError;
                assert_eq!(0 as CU64, (*c_err).code);
                CError_free(c_err);
                ptr.free();
                let t = block_on(mav::ma::Db::init_tables(&parameters.db_name, &DbCreateType::Drop));
                if let Err(e) = &t {
                    panic!(e.to_string());
                }
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
                let mut parameters = CCreateWalletParameters::to_c_ptr(&parameters);
                let c_err = Wallets_createWallet(*context, parameters, cw) as *mut CError;
                parameters.free();
                assert_eq!(0 as CU64, (*c_err).code, "{}", to_str((*c_err).message));
                CError_free(c_err);
                assert_ne!(null_mut(), *cw);
                let w = CWallet::to_rust(&**cw);
                CWallet_dFree(cw);
                w
            };
            let _ = free_wallets();
            CContext_dFree(context);
        }
    }

    fn init_parameters() -> InitParameters {
        let mut p = InitParameters::default();
        p.db_name.0 = mav::ma::DbNames::new("test_", "");
        p.context_note = format!("test_{}", kits::uuid());
        p
    }

    fn free_wallets() -> Result<(), WalletError> {
        let lock = Contexts::collection().lock();
        let mut ins = lock.borrow_mut();
        let _ = ins.clean()?;
        Ok(())
    }
}