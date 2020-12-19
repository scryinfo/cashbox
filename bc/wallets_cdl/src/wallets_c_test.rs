#[cfg(test)]
mod tests {
    use std::ptr::null_mut;

    use async_std::task::block_on;

    use mav::{kits, WalletType};
    use mav::ma::DbCreateType;
    use wallets_types::{CreateWalletParameters, Error, InitParameters, Wallet};

    use crate::kits::{CR, CStruct, CU64, to_c_char, to_str};
    use crate::parameters::{CContext, CCreateWalletParameters, CInitParameters};
    use crate::types::{CError, CWallet};
    use crate::wallets_c::{CContext_dAlloc, CContext_dFree, CError_free, CStr_dAlloc, CStr_dFree, CWallet_dAlloc, CWallet_dFree, Wallets_createWallet, Wallets_findById, Wallets_generateMnemonic, Wallets_init, Wallets_uninit};

    #[test]
    fn mnemonic_test() {
        unsafe {//invalid parameters
            let c_err = Wallets_generateMnemonic(null_mut()) as *mut CError;
            assert_eq!(Error::PARAMETER().code, (*c_err).code, "{:?}", c_err);
            CError_free(c_err);
        }
        unsafe {
            let ptr = CStr_dAlloc();
            let c_err = Wallets_generateMnemonic(ptr) as *mut CError;
            assert_ne!(null_mut(), c_err);
            assert_eq!(0 as CU64, (*c_err).code, "{:?}", c_err);
            let words: Vec<&str> = to_str(*ptr).split(" ").collect();
            CStr_dFree(ptr);
            CError_free(c_err);
            assert_eq!(15, words.len());
        }
    }

    #[test]
    fn wallets_test() {
        init_test();
        unsafe {
            let c_ctx = {
                let c_ctx = CContext_dAlloc();
                let parameters = init_parameters();
                let mut c_parameters = CInitParameters::to_c_ptr(&parameters);
                {
                    let c_err = Wallets_init(c_parameters, c_ctx) as *mut CError;
                    assert_eq!(0 as CU64, (*c_err).code, "{:?}", c_err);
                    CError_free(c_err);
                }
                c_parameters.free();
                let re = block_on(mav::ma::Db::init_tables(&parameters.db_name, &DbCreateType::Drop));
                assert_eq!(false, re.is_err(), "{:?}", re);
                c_ctx
            };

            let mnemonic = {
                let p_mn = CStr_dAlloc();
                {
                    let c_err = Wallets_generateMnemonic(p_mn) as *mut CError;
                    assert_eq!(0 as CU64, (*c_err).code, "{:?}", c_err);
                    CError_free(c_err);
                }
                let mn = to_str(*p_mn).to_owned();
                CStr_dFree(p_mn);
                mn
            };
            let wallet = {
                {//invalid parameters
                    let mut parameters = CCreateWalletParameters::to_c_ptr(&CreateWalletParameters {
                        name: "test".to_owned(),
                        password: "1".to_string(),
                        mnemonic: mnemonic.clone(),
                        wallet_type: WalletType::Normal.to_string(),
                    });
                    let mut c_wallet = CWallet_dAlloc();
                    {
                        let c_err = Wallets_createWallet(null_mut(), null_mut(), null_mut()) as *mut CError;
                        assert_eq!(Error::PARAMETER().code, (*c_err).code, "{:?}", c_err);
                        CError_free(c_err);

                        let c_err = Wallets_createWallet(null_mut(), parameters, null_mut()) as *mut CError;
                        assert_eq!(Error::PARAMETER().code, (*c_err).code, "{:?}", c_err);
                        CError_free(c_err);

                        let c_err = Wallets_createWallet(null_mut(), null_mut(), c_wallet) as *mut CError;
                        assert_eq!(Error::PARAMETER().code, (*c_err).code, "{:?}", c_err);
                        CError_free(c_err);

                        let c_err = Wallets_createWallet(*c_ctx, null_mut(), null_mut()) as *mut CError;
                        assert_eq!(Error::PARAMETER().code, (*c_err).code, "{:?}", c_err);
                        CError_free(c_err);

                        let c_err = Wallets_createWallet(*c_ctx, parameters, null_mut()) as *mut CError;
                        assert_eq!(Error::PARAMETER().code, (*c_err).code, "{:?}", c_err);
                        CError_free(c_err);

                        let c_err = Wallets_createWallet(*c_ctx, null_mut(), c_wallet) as *mut CError;
                        assert_eq!(Error::PARAMETER().code, (*c_err).code, "{:?}", c_err);
                        CError_free(c_err);
                    }
                    c_wallet.free();
                    parameters.free();
                }

                let c_wallet = CWallet_dAlloc();
                let parameters = CreateWalletParameters {
                    name: "test".to_owned(),
                    password: "1".to_string(),
                    mnemonic: mnemonic.clone(),
                    wallet_type: WalletType::Normal.to_string(),
                };
                let mut c_parameters = CCreateWalletParameters::to_c_ptr(&parameters);
                let c_err = Wallets_createWallet(*c_ctx, c_parameters, c_wallet) as *mut CError;
                c_parameters.free();
                assert_eq!(0 as CU64, (*c_err).code, "{:?}", *c_err);
                CError_free(c_err);
                assert_ne!(null_mut(), *c_wallet);
                let w = CWallet::to_rust(&**c_wallet);
                CWallet_dFree(c_wallet);
                w
            };

            let temp = find_by_id_test(*c_ctx, &wallet.id);
            assert_eq!(wallet.id, temp.id);
            assert_eq!(wallet.name, temp.name);

            CContext_dFree(c_ctx);
        }
    }

    //单元测试是并行的，这里把它放入一个测试中进行测试，以减少并行给单元测试带来的问题
    fn init_test() {
        unsafe { //参数不正确的测试
            let c_err = Wallets_init(null_mut(), null_mut()) as *mut CError;
            assert_eq!(Error::PARAMETER().code, (*c_err).code, "{:?}", c_err);
            CError_free(c_err);

            let mut parameters = CInitParameters::to_c_ptr(&init_parameters());
            {
                let c_err = Wallets_init(parameters, null_mut()) as *mut CError;
                assert_eq!(Error::PARAMETER().code, (*c_err).code, "{:?}", c_err);
                CError_free(c_err);

                let ctx = CContext_dAlloc();
                {
                    assert_ne!(null_mut(), ctx);
                    let c_err = Wallets_init(null_mut(), ctx) as *mut CError;
                    assert_eq!(Error::PARAMETER().code, (*c_err).code, "{:?}", c_err);
                    CError_free(c_err);
                }
                CContext_dFree(ctx);
            }
            parameters.free();
        }
        unsafe {
            let ctx = CContext_dAlloc();
            assert_ne!(null_mut(), ctx);
            let parameters = init_parameters();
            let mut c_parameters = CInitParameters::to_c_ptr(&parameters);
            let c_err = Wallets_init(c_parameters, ctx) as *mut CError;
            assert_ne!(null_mut(), c_err);
            assert_eq!(0 as CU64, (*c_err).code, "{:?}", c_err);
            CError_free(c_err);
            c_parameters.free();

            assert_ne!(null_mut(), *ctx);
            assert_eq!(parameters.context_note.as_str(), to_str((**ctx).contextNote));
            assert_ne!(0, to_str((**ctx).id).len());

            {//only release memory
                let c_err = Wallets_uninit(*ctx) as *mut CError;
                assert_ne!(null_mut(), c_err);
                CError_free(c_err);
                CContext_dFree(ctx);
            }
        }
    }

    fn find_by_id_test(c_ctx: *mut CContext, wallet_id: &str) -> Wallet {
        unsafe { //invalid parameters

            let mut c_wallet_id = to_c_char("t");
            let mut c_wallet = CWallet_dAlloc();
            {
                let c_err = Wallets_findById(null_mut(), null_mut(), null_mut()) as *mut CError;
                assert_eq!(Error::PARAMETER().code, (*c_err).code, "{:?}", c_err);
                CError_free(c_err);
                let c_err = Wallets_findById(null_mut(), c_wallet_id, null_mut()) as *mut CError;
                assert_eq!(Error::PARAMETER().code, (*c_err).code, "{:?}", c_err);
                CError_free(c_err);
                let c_err = Wallets_findById(null_mut(), null_mut(), c_wallet) as *mut CError;
                assert_eq!(Error::PARAMETER().code, (*c_err).code, "{:?}", c_err);
                CError_free(c_err);

                let c_err = Wallets_findById(c_ctx, null_mut(), null_mut()) as *mut CError;
                assert_eq!(Error::PARAMETER().code, (*c_err).code, "{:?}", c_err);
                CError_free(c_err);
                let c_err = Wallets_findById(c_ctx, c_wallet_id, null_mut()) as *mut CError;
                assert_eq!(Error::PARAMETER().code, (*c_err).code, "{:?}", c_err);
                CError_free(c_err);
                let c_err = Wallets_findById(c_ctx, null_mut(), c_wallet) as *mut CError;
                assert_eq!(Error::PARAMETER().code, (*c_err).code, "{:?}", c_err);
                CError_free(c_err);
            }
            c_wallet.free();
            c_wallet_id.free();
        }

        let wallet =
            unsafe {
                let mut c_wallet_id = to_c_char(wallet_id);
                let mut c_wallet = CWallet_dAlloc();
                {
                    let mut not_id = to_c_char(kits::uuid().as_str());
                    let c_err = Wallets_findById(c_ctx, not_id, c_wallet) as *mut CError;
                    assert_eq!(Error::NoRecord().code, (*c_err).code, "{:?}", c_err);
                    CError_free(c_err);
                    not_id.free();

                    let c_err = Wallets_findById(c_ctx, c_wallet_id, c_wallet) as *mut CError;
                    assert_eq!(Error::SUCCESS().code, (*c_err).code, "{:?}", c_err);
                    CError_free(c_err);
                }
                let wallet = CWallet::to_rust(&**c_wallet);
                c_wallet.free();
                c_wallet_id.free();
                wallet
            };
        wallet
    }

    fn init_parameters() -> InitParameters {
        let mut p = InitParameters::default();
        p.db_name.0 = mav::ma::DbNames::new("test_", "");
        p.context_note = format!("test_{}", kits::uuid());
        p
    }
}