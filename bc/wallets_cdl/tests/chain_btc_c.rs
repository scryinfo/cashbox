use mav::ma::BtcTokenType;
use mav::{kits, CFalse, NetType, WalletType};
use std::ptr::null_mut;
use wallets_cdl::chain_btc_c::{ChainBtc_start, ChainBtc_loadNowBlockNumber};
use wallets_cdl::mem_c::{CWallet_dFree, CBtcNowLoadBlock_dAlloc};
use wallets_cdl::parameters::{CCreateWalletParameters, CBtcNowLoadBlock};
use wallets_cdl::wallets_c::{Wallets_createWallet, Wallets_changeNetType};
use wallets_cdl::{chain_btc_c, mem_c::{CContext_dAlloc, CError_free, CWallet_dAlloc}, parameters::{CContext, CInitParameters}, types::CError, wallets_c::Wallets_init, CArray, CStruct, CR, CU64, to_c_char};
use wallets_types::{BtcChainTokenDefault, CreateWalletParameters, Error, InitParameters, BtcNowLoadBlock};
use wallets_cdl::types::CWallet;

#[test]
fn btc_update_default_token_list_test() {
    let c_ctx = CContext_dAlloc();
    assert_ne!(null_mut(), c_ctx);
    unsafe {
        let c_err = init_parameters(c_ctx);
        assert_ne!(null_mut(), c_err);
        assert_eq!(0 as CU64, (*c_err).code, "{:?}", *c_err);
        //CEthChainTokenDefault
        let mut default_tokens = Vec::new();
        {
            let mut btc = BtcChainTokenDefault::default();
            btc.net_type = "Private".to_string();
            btc.btc_chain_token_shared.m.token_type = BtcTokenType::Btc.to_string();
            btc.btc_chain_token_shared.m.decimal = 9;

            btc.btc_chain_token_shared.m.token_shared.name = "Bitcoin".to_owned();
            btc.btc_chain_token_shared.m.token_shared.symbol = "BTC".to_owned();
            btc.btc_chain_token_shared.m.token_shared.logo_url = "".to_owned(); //todo
            btc.btc_chain_token_shared.m.token_shared.logo_bytes = "".to_owned();
            btc.btc_chain_token_shared.m.token_shared.project_name = "Bitcoin".to_owned();
            btc.btc_chain_token_shared.m.token_shared.project_home =
                "https://bitcoin.org/en/".to_owned();
            btc.btc_chain_token_shared.m.token_shared.project_note =
                "Bitcoin is a global, open-source platform for decentralized applications."
                    .to_owned();
            default_tokens.push(btc);
        }

        let mut c_tokens = CArray::to_c_ptr(&default_tokens);
        let c_err = chain_btc_c::ChainBtc_updateDefaultTokenList(*c_ctx, c_tokens) as *mut CError;
        assert_eq!(Error::SUCCESS().code, (*c_err).code, "{:?}", *c_err);
        CError_free(c_err);
        c_tokens.free();
        wallets_cdl::mem_c::CContext_dFree(c_ctx);
    }
}

fn init_parameters(c_ctx: *mut *mut CContext) -> *mut CError {
    let mut p = InitParameters::default();
    p.db_name.0 = mav::ma::DbName::new("test_", "");
    p.context_note = format!("test_{}", kits::uuid());
    let c_parameters = CInitParameters::to_c_ptr(&p);

    let c_err = unsafe { Wallets_init(c_parameters, c_ctx) as *mut CError };
    c_err
}

#[test]
#[ignore]
fn btc_start_test() {
    // not create only init
    let c_ctx = CContext_dAlloc();
    assert_ne!(null_mut(), c_ctx);
    unsafe {
        let c_init_parameters = {
            let mut p = InitParameters::default();
            p.is_memory_db = CFalse;
            let prefix = "test_";
            p.db_name.0 = mav::ma::DbName::new(&prefix, "");
            p.context_note = format!("test_{}", prefix);
            CInitParameters::to_c_ptr(&p)
        };
        let c_err = Wallets_init(c_init_parameters, c_ctx) as *mut CError;
        assert_eq!(0 as CU64, (*c_err).code, "{:?}", *c_err);
        CError_free(c_err);

        let c_err =  Wallets_changeNetType(*c_ctx,to_c_char(NetType::Test.to_string().as_str())) as *mut CError;
        assert_eq!(0 as CU64, (*c_err).code, "{:?}", *c_err);
        CError_free(c_err);
        // create wallet (now we get mnemonic and address)
        let c_wallet = CWallet_dAlloc();
        let parameters = {
            let mnemonic =
                "lawn duty beauty guilt sample fiction name zero demise disagree cram hand";
            let mut p = CreateWalletParameters {
                name: "murmel".to_string(),
                password: "".to_string(),
                mnemonic: mnemonic.to_string(),
                wallet_type: WalletType::Test.to_string(),
            };
            CCreateWalletParameters::to_c_ptr(&mut p)
        };
        let c_err = Wallets_createWallet(*c_ctx, parameters, c_wallet) as *mut CError;
        assert_eq!(0 as CU64, (*c_err).code, "{:?}", *c_err);
        let r_wallet = CWallet::to_rust(&**c_wallet);
        CError_free(c_err);
        CWallet_dFree(c_wallet);

        let c_err = ChainBtc_start(*c_ctx, to_c_char(&r_wallet.id)) as *mut CError;
        assert_eq!(0 as CU64, (*c_err).code, "{:?}", *c_err);
        CError_free(c_err);
        wallets_cdl::mem_c::CContext_dFree(c_ctx);
    }
}

#[test]
fn btc_load_now_blocknumber_test(){
    let c_ctx = CContext_dAlloc();
    assert_ne!(null_mut(), c_ctx);
    unsafe {
        let c_init_parameters = {
            let mut p = InitParameters::default();
            p.is_memory_db = CFalse;
            let prefix = "test_";
            p.db_name.0 = mav::ma::DbName::new(&prefix, "");
            p.context_note = format!("test_{}", prefix);
            CInitParameters::to_c_ptr(&p)
        };
        let c_err = Wallets_init(c_init_parameters, c_ctx) as *mut CError;
        assert_eq!(0 as CU64, (*c_err).code, "{:?}", *c_err);
        CError_free(c_err);

        let c_err =  Wallets_changeNetType(*c_ctx,to_c_char(NetType::Test.to_string().as_str())) as *mut CError;
        assert_eq!(0 as CU64, (*c_err).code, "{:?}", *c_err);
        CError_free(c_err);

        let c_block = CBtcNowLoadBlock_dAlloc();
        let c_err = ChainBtc_loadNowBlockNumber(*c_ctx, c_block) as *mut CError;
        assert_eq!(Error::SUCCESS().code, (*c_err).code, "{:?}", *c_err);
        CError_free(c_err);
        let block :BtcNowLoadBlock = CBtcNowLoadBlock::to_rust(&**c_block);
        wallets_cdl::mem_c::CbtcNowLoadBlock_dFree(c_block);
        wallets_cdl::mem_c::CContext_dFree(c_ctx);
    }

}