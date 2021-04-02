use std::ptr::null_mut;
use mav::kits;
use wallets_types::{InitParameters, Error, EthRawTxPayload, EthTransferPayload, EthChainTokenDefault, EthChainTokenAuth, EthChainTokenNonAuth};

use wallets_cdl::{CU64, chain_eth_c, to_c_char, CR, CStruct, CArray,
                  parameters::{CContext, CInitParameters, CEthTransferPayload, CEthRawTxPayload},
                  mem_c::{CContext_dAlloc, CError_free},
                  types::CError,
                  wallets_c::Wallets_init,
};

use mav::ma::{EthTokenType};
use wallets_cdl::mem_c::{CArrayCEthChainTokenDefault_dAlloc, CArrayCEthChainTokenAuth_dAlloc, CArrayCEthChainTokenDefault_dFree, CArrayCEthChainTokenNonAuth_dAlloc, CArrayCEthChainTokenNonAuth_dFree, CArrayCWallet_dAlloc};
use wallets_cdl::wallets_c::Wallets_all;

mod data;

#[test]
fn eth_tx_sign_test() {
    let c_ctx = CContext_dAlloc();
    assert_ne!(null_mut(), c_ctx);
    unsafe {
        let c_err = data::init_wallets_context(c_ctx);
        assert_ne!(null_mut(), c_err);
        assert_eq!(0 as CU64, (*c_err).code, "{:?}", *c_err);
        let wallet =   data::create_wallet(c_ctx);
        let sign_result = wallets_cdl::mem_c::CStr_dAlloc();
        let transfer_tx = EthTransferPayload {
            from_address: wallet.eth_chain.chain_shared.wallet_address.address.clone(),
            to_address: "0x00a329c0648769a73afac7f9381e08fb43dbea72".to_string(),
            contract_address: "".to_string(),
            value: "3".to_string(),
            nonce: "0".to_string(),
            gas_price: "0.00009".to_string(),
            gas_limit: "21000".to_string(),
            decimal: 18,
            ext_data: "".to_string(),
            password: "123456".to_string(),
        };
        let mut c_transfer_tx = CEthTransferPayload::to_c_ptr(&transfer_tx);
        let c_err = chain_eth_c::ChainEth_txSign(*c_ctx, to_c_char("Private"), c_transfer_tx, to_c_char("123456"), sign_result) as *mut CError;
        assert_eq!(Error::SUCCESS().code, (*c_err).code, "{:?}", *c_err);
        CError_free(c_err);
        c_transfer_tx.free();
        wallets_cdl::mem_c::CStr_dFree(sign_result);
        wallets_cdl::mem_c::CContext_dFree(c_ctx);
    }
}

#[test]
fn eth_raw_tx_sign_test() {
    let c_ctx = CContext_dAlloc();
    assert_ne!(null_mut(), c_ctx);
    unsafe {
        let c_err = data::init_wallets_context(c_ctx);
        assert_ne!(null_mut(), c_err);
        assert_eq!(0 as CU64, (*c_err).code, "{:?}", *c_err);
        let wallet =   data::create_wallet(c_ctx);
        let sign_result = wallets_cdl::mem_c::CStr_dAlloc();

        let raw_tx_payload = EthRawTxPayload {
            from_address:  wallet.eth_chain.chain_shared.wallet_address.address.clone(),
            raw_tx: "0xf86d068504a817c800837a1200941c9baedc94600b2d1c8a6d2bad1744e6182f300e880de0b6b3a76400008046a07e2c71664464b95fab4b1706785c244d86cef96b5e5c186a314c63306cfe9c54a0637c605b6004bb244cbea9bc69e18b7bd18b491c3794e17e31a0c932592bb476".to_string(),
        };
        let mut c_raw_tx_payload = CEthRawTxPayload::to_c_ptr(&raw_tx_payload);
        let c_err = chain_eth_c::ChainEth_rawTxSign(*c_ctx, to_c_char("Private"), c_raw_tx_payload, to_c_char("123456"), sign_result) as *mut CError;
        assert_eq!(Error::SUCCESS().code, (*c_err).code, "{:?}", *c_err);
        CError_free(c_err);
        c_raw_tx_payload.free();
        wallets_cdl::mem_c::CStr_dFree(sign_result);
        wallets_cdl::mem_c::CContext_dFree(c_ctx);
    }
}

#[test]
fn eth_decode_addition_data_test() {
    let c_ctx = CContext_dAlloc();
    assert_ne!(null_mut(), c_ctx);
    unsafe {
        let c_err = data::init_wallets_context(c_ctx);
        assert_ne!(null_mut(), c_err);
        assert_eq!(0 as CU64, (*c_err).code, "{:?}", *c_err);
        let addition_data = wallets_cdl::mem_c::CStr_dAlloc();
        let encode_data = "0xa9059cbb000000000000000000000000c0c4824527ffb27a51034cea1e37840ed69a5f1e00000000000000000000000000000000000000000000000000000000000a2d77646464";
        let c_err = chain_eth_c::ChainEth_decodeAdditionData(*c_ctx, to_c_char(encode_data), addition_data) as *mut CError;
        assert_eq!(Error::SUCCESS().code, (*c_err).code, "{:?}", *c_err);
        CError_free(c_err);
        wallets_cdl::mem_c::CStr_dFree(addition_data);
        wallets_cdl::mem_c::CContext_dFree(c_ctx);
    }
}

#[test]
fn eth_update_default_token_list_test() {
    let c_ctx = CContext_dAlloc();
    assert_ne!(null_mut(), c_ctx);
    unsafe {
        let c_err = data::init_wallets_context(c_ctx);
        assert_ne!(null_mut(), c_err);
        assert_eq!(0 as CU64, (*c_err).code, "{:?}", *c_err);
        //CEthChainTokenDefault
        let mut default_tokens = Vec::new();
        {
            let mut eth = EthChainTokenDefault::default();
            eth.net_type = "Main".to_string();
            eth.eth_chain_token_shared.m.token_type = EthTokenType::Eth.to_string();
            eth.m.contract_address = "".to_owned();
            eth.eth_chain_token_shared.m.decimal = 18;
            eth.eth_chain_token_shared.m.gas_limit = 0; //todo
            eth.eth_chain_token_shared.m.gas_price = "".to_owned(); //todo

            eth.eth_chain_token_shared.m.token_shared.name = "Ethereum".to_owned();
            eth.eth_chain_token_shared.m.token_shared.symbol = "ETH".to_owned();
            eth.eth_chain_token_shared.m.token_shared.logo_url = "".to_owned();//todo
            eth.eth_chain_token_shared.m.token_shared.logo_bytes = "".to_owned();
            eth.eth_chain_token_shared.m.token_shared.project_name = "ethereum".to_owned();
            eth.eth_chain_token_shared.m.token_shared.project_home = "https://ethereum.org/zh/".to_owned();
            eth.eth_chain_token_shared.m.token_shared.project_note = "Ethereum is a global, open-source platform for decentralized applications.".to_owned();
            default_tokens.push(eth);
        }
        {
            let mut ddd = EthChainTokenDefault::default();
            ddd.net_type = "Main".to_string();
            ddd.eth_chain_token_shared.m.token_type = EthTokenType::Erc20.to_string();
            ddd.m.contract_address = "0xcc638fca332190b63be1605baefde1df0b3b026e".to_owned();
            ddd.eth_chain_token_shared.m.decimal = 18;
            ddd.eth_chain_token_shared.m.gas_limit = 0; //todo
            ddd.eth_chain_token_shared.m.gas_price = "".to_owned(); //todo

            ddd.eth_chain_token_shared.m.token_shared.name = "DDD".to_owned();
            ddd.eth_chain_token_shared.m.token_shared.symbol = "DDD".to_owned();
            ddd.eth_chain_token_shared.m.token_shared.logo_url = "".to_owned();//todo
            ddd.eth_chain_token_shared.m.token_shared.logo_bytes = "".to_owned();
            ddd.eth_chain_token_shared.m.token_shared.project_name = "scryinfo".to_owned();
            ddd.eth_chain_token_shared.m.token_shared.project_home = "https://scry.info/".to_owned();
            ddd.eth_chain_token_shared.m.token_shared.project_note = "SCRY.INFO is an open source blockchain kits protocol layer, oracle of the blockchain world, cornerstone of kits smart contract applications.".to_owned();
            default_tokens.push(ddd);
        }

        let mut c_tokens = CArray::to_c_ptr(&default_tokens);
        let c_err = chain_eth_c::ChainEth_updateDefaultTokenList(*c_ctx, c_tokens) as *mut CError;
        assert_eq!(Error::SUCCESS().code, (*c_err).code, "{:?}", *c_err);
        CError_free(c_err);
        let _wallet_test = data::create_wallet(c_ctx);
        let c_array_wallet = CArrayCWallet_dAlloc();
        let c_err = Wallets_all(*c_ctx, to_c_char("Main"),c_array_wallet) as *mut CError;
        assert_eq!(0 as CU64, (*c_err).code, "{:?}", *c_err);
        CError_free(c_err);
        c_tokens.free();
        wallets_cdl::mem_c::CContext_dFree(c_ctx);
    }
}

#[test]
fn eth_update_auth_token_list_test() {
    let c_ctx = CContext_dAlloc();
    assert_ne!(null_mut(), c_ctx);
    unsafe {
        let c_err = data::init_wallets_context(c_ctx);
        assert_ne!(null_mut(), c_err);
        assert_eq!(0 as CU64, (*c_err).code, "{:?}", *c_err);
        //CEthChainTokenDefault
        let mut auth_tokens = Vec::new();
        {
            let mut eth = EthChainTokenAuth::default();
            eth.net_type = "Private".to_string();
            eth.eth_chain_token_shared.m.token_type = EthTokenType::Erc20.to_string();
            eth.m.contract_address = "0x6f259637dcd74c767781e37bc6133cd6a68aa161".to_owned();
            eth.eth_chain_token_shared.decimal = 18;
            eth.eth_chain_token_shared.gas_limit = 0; //todo
            eth.eth_chain_token_shared.gas_price = "".to_owned(); //todo

            eth.eth_chain_token_shared.m.token_shared.name = "HuobiToken".to_owned();
            eth.eth_chain_token_shared.m.token_shared.symbol = "HT".to_owned();
            eth.eth_chain_token_shared.m.token_shared.logo_url = "".to_owned();//todo
            eth.eth_chain_token_shared.m.token_shared.logo_bytes = "".to_owned();
            eth.eth_chain_token_shared.m.token_shared.project_name = "HuobiToken".to_owned();
            eth.eth_chain_token_shared.m.token_shared.project_home = "https://www.huobipro.com/".to_owned();
            eth.eth_chain_token_shared.m.token_shared.project_note = "A Global Cryptocurrency Leader Since 2013.".to_owned();
            auth_tokens.push(eth);
        }

        let mut c_tokens = CArray::to_c_ptr(&auth_tokens);
        let c_err = chain_eth_c::ChainEth_updateAuthTokenList(*c_ctx, c_tokens) as *mut CError;
        assert_eq!(Error::SUCCESS().code, (*c_err).code, "{:?}", *c_err);
        CError_free(c_err);
        c_tokens.free();
        wallets_cdl::mem_c::CContext_dFree(c_ctx);
    }
}
#[test]
fn query_eth_auth_token_list_test() {
    let c_ctx = CContext_dAlloc();
    assert_ne!(null_mut(), c_ctx);
    unsafe {
        let c_err = data::init_wallets_context(c_ctx);
        assert_ne!(null_mut(), c_err);
        assert_eq!(0 as CU64, (*c_err).code, "{:?}", *c_err);
        let token_auth = CArrayCEthChainTokenAuth_dAlloc();
        let c_err =  chain_eth_c::ChainEth_getAuthTokenList(*c_ctx,to_c_char("Private"),0,10,token_auth) as *mut CError;
        assert_eq!(Error::SUCCESS().code, (*c_err).code, "{:?}", *c_err);
        CError_free(c_err);
        let _eth_token_auth_vec: Vec<EthChainTokenAuth> = CArray::to_rust(&**token_auth);
        wallets_cdl::mem_c::CContext_dFree(c_ctx);
    }
}

#[test]
fn query_eth_default_token_list_test() {
    let c_ctx = CContext_dAlloc();
    assert_ne!(null_mut(), c_ctx);
    unsafe {
        let c_err = data::init_wallets_context(c_ctx);
        assert_ne!(null_mut(), c_err);
        assert_eq!(0 as CU64, (*c_err).code, "{:?}", *c_err);
        let token_default = CArrayCEthChainTokenDefault_dAlloc();
        let c_err =  chain_eth_c::ChainEth_getDefaultTokenList(*c_ctx,to_c_char("Private"),token_default) as *mut CError;
        assert_eq!(Error::SUCCESS().code, (*c_err).code, "{:?}", *c_err);
        CError_free(c_err);
        let _eth_token_default_vec: Vec<EthChainTokenDefault> = CArray::to_rust(&**token_default);
        CArrayCEthChainTokenDefault_dFree(token_default);
        wallets_cdl::mem_c::CContext_dFree(c_ctx);
    }
}

#[test]
fn eth_update_non_auth_token_list_test() {
    let c_ctx = CContext_dAlloc();
    assert_ne!(null_mut(), c_ctx);
    unsafe {
        let c_err = data::init_wallets_context(c_ctx);
        assert_ne!(null_mut(), c_err);
        assert_eq!(0 as CU64, (*c_err).code, "{:?}", *c_err);
        //CEthChainTokenDefault
        let mut non_auth_tokens = Vec::new();
        {
            let mut eth = EthChainTokenNonAuth::default();
            eth.net_type = "Private".to_string();
            eth.eth_chain_token_shared.m.token_type = EthTokenType::Erc20.to_string();
            eth.m.contract_address = "0x6f259637dcd74c767781e37bc6133cd6a68aa161".to_owned();
            eth.eth_chain_token_shared.decimal = 18;
            eth.eth_chain_token_shared.gas_limit = 0; //todo
            eth.eth_chain_token_shared.gas_price = "".to_owned(); //todo

            eth.eth_chain_token_shared.m.token_shared.name = "HuobiToken".to_owned();
            eth.eth_chain_token_shared.m.token_shared.symbol = "HT".to_owned();
            eth.eth_chain_token_shared.m.token_shared.logo_url = "".to_owned();//todo
            eth.eth_chain_token_shared.m.token_shared.logo_bytes = "".to_owned();
            eth.eth_chain_token_shared.m.token_shared.project_name = "HuobiToken".to_owned();
            eth.eth_chain_token_shared.m.token_shared.project_home = "https://www.huobipro.com/".to_owned();
            eth.eth_chain_token_shared.m.token_shared.project_note = "A Global Cryptocurrency Leader Since 2013.".to_owned();
            non_auth_tokens.push(eth);
        }

        let mut c_tokens = CArray::to_c_ptr(&non_auth_tokens);
        let c_err = chain_eth_c::ChainEth_updateNonAuthTokenList(*c_ctx, c_tokens) as *mut CError;
        assert_eq!(Error::SUCCESS().code, (*c_err).code, "{:?}", *c_err);
        CError_free(c_err);
        c_tokens.free();
        wallets_cdl::mem_c::CContext_dFree(c_ctx);
    }
}

#[test]
fn query_eth_non_auth_token_list_test() {
    let c_ctx = CContext_dAlloc();
    assert_ne!(null_mut(), c_ctx);
    unsafe {
        let c_err = data::init_wallets_context(c_ctx);
        assert_ne!(null_mut(), c_err);
        assert_eq!(0 as CU64, (*c_err).code, "{:?}", *c_err);
        let token_default = CArrayCEthChainTokenNonAuth_dAlloc();
        let c_err =  chain_eth_c::ChainEth_getNonAuthTokenList(*c_ctx,to_c_char("Private"),token_default) as *mut CError;
        assert_eq!(Error::SUCCESS().code, (*c_err).code, "{:?}", *c_err);
        CError_free(c_err);
        let _eth_token_non_auth_vec: Vec<EthChainTokenNonAuth> = CArray::to_rust(&**token_default);
        CArrayCEthChainTokenNonAuth_dFree(token_default);
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
