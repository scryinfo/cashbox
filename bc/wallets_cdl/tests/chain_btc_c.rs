use std::ptr::null_mut;
use mav::{kits, NetType, CFalse};
use mav::ma::BtcTokenType;
use wallets_types::{InitParameters, Error, BtcChainTokenDefault};
use wallets_cdl::{CU64, CR, CStruct, CArray,types::CError, wallets_c::Wallets_init, chain_btc_c,
                  parameters::{CContext, CInitParameters,},
                  mem_c::{CContext_dAlloc, CError_free},
};
use wallets_cdl::chain_btc_c::ChainBtc_start;

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
            btc.btc_chain_token_shared.m.token_shared.logo_url = "".to_owned();//todo
            btc.btc_chain_token_shared.m.token_shared.logo_bytes = "".to_owned();
            btc.btc_chain_token_shared.m.token_shared.project_name = "Bitcoin".to_owned();
            btc.btc_chain_token_shared.m.token_shared.project_home = "https://bitcoin.org/en/".to_owned();
            btc.btc_chain_token_shared.m.token_shared.project_note = "Bitcoin is a global, open-source platform for decentralized applications.".to_owned();
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

    let c_err = unsafe {
        Wallets_init(c_parameters, c_ctx) as *mut CError
    };
    c_err
}

#[test]
fn btc_start_test() {
    // not create only init
    let c_ctx = CContext_dAlloc();
    assert_ne!(null_mut(), c_ctx);
    unsafe {
        let c_init_parameters = {
            let mut p = InitParameters::default();
            p.net_type = NetType::Test.to_string();
            p.is_memory_db = CFalse;
            let prefix = "test_";
            p.db_name.0 = mav::ma::DbName::new(&prefix, "");
            p.context_note = format!("test_{}", prefix);
            CInitParameters::to_c_ptr(&p)
        };
        let c_err = Wallets_init(c_init_parameters, c_ctx) as *mut CError;
        assert_eq!(0 as CU64, (*c_err).code, "{:?}", *c_err);
        CError_free(c_err);
        let c_err = ChainBtc_start(*c_ctx) as *mut CError;
        assert_eq!(0 as CU64, (*c_err).code, "{:?}", *c_err);
        CError_free(c_err);
        wallets_cdl::mem_c::CContext_dFree(c_ctx);
    }
}