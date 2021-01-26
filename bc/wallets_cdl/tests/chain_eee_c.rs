#[macro_use]
extern crate serde_derive;

use wallets_types::{Error, InitParameters, SubChainBasicInfo, ChainVersion, AccountInfoSyncProg, StorageKeyParameters, DecodeAccountInfoParameters, EeeChainTokenDefault, CreateWalletParameters, Wallet};
use wallets_cdl::{CStruct, to_c_char, CR, CU64, CArray, chain_eee_c, to_str,
                  wallets_c::Wallets_init,
                  mem_c::{CError_free, CContext_dAlloc},
                  types::{CSubChainBasicInfo, CError},
                  parameters::{CChainVersion, CInitParameters, CCreateWalletParameters, CContext},
};
use mav::ma::{MSubChainBasicInfo, MAccountInfoSyncProg, EeeTokenType};
use mav::{kits, WalletType};
use std::ptr::null_mut;
use wallets_cdl::types::{CAccountInfoSyncProg, CWallet};
use wallets_cdl::mem_c::{CStr_dAlloc, CStr_dFree, CWallet_dAlloc, CWallet_dFree};
use wallets_cdl::wallets_c::{Wallets_generateMnemonic, Wallets_createWallet};


const TX_VERSION: u32 = 1;
const RUNTIME_VERSION: u32 = 6;

const GENESIS_HASH: &'static str = "0x6cec71473c1b8d2295541cb5c21edc4fdb1926375413bb28f78793978229cf48";//0x2fc77f8d90e56afbc241f36efa4f9db28ae410c71b20fd960194ea9d1dabb973

#[test]
fn eee_basic_info_test() {
    unsafe {
        let c_ctx = CContext_dAlloc();
        assert_ne!(null_mut(), c_ctx);
        let c_err = init_parameters(c_ctx);
        assert_ne!(null_mut(), c_err);
        assert_eq!(0 as CU64, (*c_err).code, "{:?}", *c_err);
        // query chain basic info
        let chain_info = get_chain_basic_info(c_ctx);
        assert_eq!(chain_info.is_none(), true);

        let save_res = save_basic_info(c_ctx);
        assert_eq!(save_res.is_ok(), true);
        wallets_cdl::mem_c::CContext_dFree(c_ctx);
    }
}

#[test]
fn eee_update_sync_record_test() {
    let m_sync_prog = MAccountInfoSyncProg {
        account: "5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY".to_string(),
        block_no: "20002".to_string(),
        block_hash: "0x41f01470971c270415cff96b3b11e2c66a82ed298bef3e7cafa35d0de20234a9".to_string(),
        ..Default::default()
    };
    unsafe {
        let c_ctx = CContext_dAlloc();
        assert_ne!(null_mut(), c_ctx);
        let c_err = init_parameters(c_ctx);
        assert_ne!(null_mut(), c_err);
        assert_eq!(0 as CU64, (*c_err).code, "{:?}", *c_err);
        let sync_prog = AccountInfoSyncProg::from(m_sync_prog);
        let mut c_sync_prog = CAccountInfoSyncProg::to_c_ptr(&sync_prog);
        let c_err = chain_eee_c::ChainEee_updateSyncRecord(*c_ctx, to_c_char("Test"), c_sync_prog) as *mut CError;
        assert_eq!(Error::SUCCESS().code, (*c_err).code, "{:?}", *c_err);
        CError_free(c_err);
        c_sync_prog.free();
        wallets_cdl::mem_c::CContext_dFree(c_ctx);
    }
}

#[test]
fn get_sync_record_test() {
    let c_ctx = CContext_dAlloc();
    assert_ne!(null_mut(), c_ctx);
    unsafe {
        let c_err = init_parameters(c_ctx);
        assert_ne!(null_mut(), c_err);
        assert_eq!(0 as CU64, (*c_err).code, "{:?}", *c_err);
        let c_sync_prog = wallets_cdl::mem_c::CAccountInfoSyncProg_dAlloc();
        let c_err = chain_eee_c::ChainEee_getSyncRecord(*c_ctx, to_c_char("Test"), to_c_char("5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY"), c_sync_prog) as *mut CError;
        assert_eq!(Error::SUCCESS().code, (*c_err).code, "{:?}", *c_err);
        CError_free(c_err);
        wallets_cdl::mem_c::CAccountInfoSyncProg_dFree(c_sync_prog);
        wallets_cdl::mem_c::CContext_dFree(c_ctx);
    }
}

#[test]
fn decode_account_info_test() {
    let c_ctx = CContext_dAlloc();
    assert_ne!(null_mut(), c_ctx);
    let encode_account_info = "0x01000000000000000000407ba5f06381960a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
    unsafe {
        let c_err = init_parameters(c_ctx);
        assert_ne!(null_mut(), c_err);
        assert_eq!(0 as CU64, (*c_err).code, "{:?}", *c_err);
        let chain_version = ChainVersion {
            genesis_hash: GENESIS_HASH.to_string(),
            runtime_version: 6,
            tx_version: 1,
        };
        let encode_param = DecodeAccountInfoParameters {
            encode_data: encode_account_info.to_string(),
            chain_version,
        };
        let mut c_encode_param = wallets_cdl::parameters::CDecodeAccountInfoParameters::to_c_ptr(&encode_param);
        let c_account_info = wallets_cdl::mem_c::CAccountInfo_dAlloc();
        let c_err = chain_eee_c::ChainEee_decodeAccountInfo(*c_ctx, to_c_char("Test"), c_encode_param, c_account_info) as *mut CError;
        assert_eq!(Error::SUCCESS().code, (*c_err).code, "{:?}", *c_err);
        CError_free(c_err);
        wallets_cdl::mem_c::CAccountInfo_dFree(c_account_info);
        c_encode_param.free();
        wallets_cdl::mem_c::CContext_dFree(c_ctx);
    }
}

#[test]
fn eee_get_storage_key_test() {
    let c_ctx = CContext_dAlloc();
    assert_ne!(null_mut(), c_ctx);
    unsafe {
        let c_err = init_parameters(c_ctx);
        assert_ne!(null_mut(), c_err);
        assert_eq!(0 as CU64, (*c_err).code, "{:?}", *c_err);
        let chain_version = ChainVersion {
            genesis_hash: GENESIS_HASH.to_string(),
            runtime_version: 6,
            tx_version: 1,
        };

        let storage_param = StorageKeyParameters {
            chain_version,
            module: "System".to_string(),
            storage_item: "Account".to_string(),
            account: "5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY".to_string(),
        };
        let mut c_storage_param = wallets_cdl::parameters::CStorageKeyParameters::to_c_ptr(&storage_param);
        let final_key = wallets_cdl::mem_c::CStr_dAlloc();
        let c_err = chain_eee_c::ChainEee_getStorageKey(*c_ctx, to_c_char("Test"), c_storage_param, final_key) as *mut CError;
        assert_eq!(Error::SUCCESS().code, (*c_err).code, "{:?}", *c_err);
        CError_free(c_err);
        wallets_cdl::mem_c::CStr_dFree(final_key);
        c_storage_param.free();
        wallets_cdl::mem_c::CContext_dFree(c_ctx);
    }
}

#[test]
fn eee_transfer_test() {
    let c_ctx = CContext_dAlloc();
    assert_ne!(null_mut(), c_ctx);
    let chain_version = ChainVersion {
        genesis_hash: GENESIS_HASH.to_string(),
        runtime_version: 6,
        tx_version: 1,
    };
    unsafe {
        let c_err = init_parameters(c_ctx);
        assert_ne!(null_mut(), c_err);
        assert_eq!(0 as CU64, (*c_err).code, "{:?}", *c_err);
        CError_free(c_err);
        let payload = wallets_types::EeeTransferPayload {
            from_account: "5GxGZWfdE5v7ZbEWyEfXZ1R6kaKsdne3FWMzgazEQwN4j2a4".to_string(),
            to_account: "5CHvQU81NU367NohiMBxuWsfLMaNucZ4Vw3kG1g5EvhjBc9H".to_string(),
            value: "20000".to_string(),
            index: 0,
            chain_version,
            ext_data: "".to_string(),
            password: "1".to_string(),
        };
        let mut c_payload = wallets_cdl::parameters::CEeeTransferPayload::to_c_ptr(&payload);
        let sign_result = wallets_cdl::mem_c::CStr_dAlloc();
        let c_err = chain_eee_c::ChainEee_eeeTransfer(*c_ctx, to_c_char("Test"), c_payload, sign_result) as *mut CError;
        assert_eq!(Error::SUCCESS().code, (*c_err).code, "{:?}", *c_err);
        CError_free(c_err);
        wallets_cdl::mem_c::CStr_dFree(sign_result);
        c_payload.free();
        wallets_cdl::mem_c::CContext_dFree(c_ctx);
    }
}

#[test]
fn eee_tokenx_transfer_test() {
    let c_ctx = CContext_dAlloc();
    assert_ne!(null_mut(), c_ctx);
    let chain_version = ChainVersion {
        genesis_hash: GENESIS_HASH.to_string(),
        runtime_version: 6,
        tx_version: 1,
    };
    unsafe {
        let c_err = init_parameters(c_ctx);
        assert_ne!(null_mut(), c_err);
        assert_eq!(0 as CU64, (*c_err).code, "{:?}", *c_err);
        let payload = wallets_types::EeeTransferPayload {
            from_account: "5GxGZWfdE5v7ZbEWyEfXZ1R6kaKsdne3FWMzgazEQwN4j2a4".to_string(),
            to_account: "5CHvQU81NU367NohiMBxuWsfLMaNucZ4Vw3kG1g5EvhjBc9H".to_string(),
            value: "20000".to_string(),
            index: 0,
            chain_version,
            ext_data: "".to_string(),
            password: "123".to_string(),
        };
        let mut c_payload = wallets_cdl::parameters::CEeeTransferPayload::to_c_ptr(&payload);
        let sign_result = wallets_cdl::mem_c::CStr_dAlloc();
        let c_err = chain_eee_c::ChainEee_tokenXTransfer(*c_ctx, to_c_char("Test"), c_payload, sign_result) as *mut CError;
        assert_eq!(Error::SUCCESS().code, (*c_err).code, "{:?}", *c_err);
        CError_free(c_err);
        wallets_cdl::mem_c::CStr_dFree(sign_result);
        c_payload.free();
        wallets_cdl::mem_c::CContext_dFree(c_ctx);
    }
}

#[test]
fn eee_tx_submittable_sign_test() {
    let c_ctx = CContext_dAlloc();
    assert_ne!(null_mut(), c_ctx);
    unsafe {
        let c_err = init_parameters(c_ctx);
        assert_ne!(null_mut(), c_err);
        assert_eq!(0 as CU64, (*c_err).code, "{:?}", *c_err);
        let sign_result = wallets_cdl::mem_c::CStr_dAlloc();
        let raw_tx_param = wallets_types::RawTxParam {
            raw_tx: "0xa8040500a05de342fa2a9aed2f2899c97cdb25ba1ec6d1bedfb39b87afcefa981bb4956c0b0040e59c3012000000006cec71473c1b8d2295541cb5c21edc4fdb1926375413bb28f78793978229cf480600000001000000".to_string(),
            wallet_id: "3eaf89eb-3ce0-4e8e-b3bb-0689b1e98261".to_string(),
            password: "1".to_string(),
        };
        //  wallets_cdl::parameters::CRawTxParam
        let mut c_raw_tx = wallets_cdl::parameters::CRawTxParam::to_c_ptr(&raw_tx_param);
        let c_err = chain_eee_c::ChainEee_txSubmittableSign(*c_ctx, to_c_char("Test"), c_raw_tx, sign_result) as *mut CError;
        assert_eq!(Error::SUCCESS().code, (*c_err).code, "{:?}", *c_err);
        CError_free(c_err);
        wallets_cdl::mem_c::CStr_dFree(sign_result);
        c_raw_tx.free();
        wallets_cdl::mem_c::CContext_dFree(c_ctx);
    }
}

#[test]
fn eee_tx_sign_test() {
    let c_ctx = CContext_dAlloc();
    assert_ne!(null_mut(), c_ctx);
    unsafe {
        let c_err = init_parameters(c_ctx);
        assert_ne!(null_mut(), c_err);
        assert_eq!(0 as CU64, (*c_err).code, "{:?}", *c_err);
        //create test wallet
        let wallet = create_wallet(c_ctx);
        //check chain basic info
        let chain_info = get_chain_basic_info(c_ctx);
        assert_eq!(chain_info.is_some(), true);
        // sign tx
        let sign_result = wallets_cdl::mem_c::CStr_dAlloc();
        let raw_tx_param = wallets_types::RawTxParam {
            raw_tx: "0xa8040500a05de342fa2a9aed2f2899c97cdb25ba1ec6d1bedfb39b87afcefa981bb4956c0b0040e59c3012000000006cec71473c1b8d2295541cb5c21edc4fdb1926375413bb28f78793978229cf480600000001000000".to_string(),
            wallet_id: wallet.id.clone(),
            password: "1".to_string(),
        };
        //  wallets_cdl::parameters::CRawTxParam
        let mut c_raw_tx = wallets_cdl::parameters::CRawTxParam::to_c_ptr(&raw_tx_param);
        let c_err = chain_eee_c::ChainEee_txSign(*c_ctx, to_c_char("Test"), c_raw_tx, sign_result) as *mut CError;
        assert_eq!(Error::SUCCESS().code, (*c_err).code, "{:?}", *c_err);
        CError_free(c_err);
        wallets_cdl::mem_c::CStr_dFree(sign_result);
        c_raw_tx.free();
        wallets_cdl::mem_c::CContext_dFree(c_ctx);
    }
}

#[test]
fn eee_update_default_token_list_test() {
    let c_ctx = CContext_dAlloc();
    assert_ne!(null_mut(), c_ctx);
    unsafe {
        let c_err = init_parameters(c_ctx);
        assert_ne!(null_mut(), c_err);
        assert_eq!(0 as CU64, (*c_err).code, "{:?}", *c_err);
        //CEthChainTokenDefault
        let mut default_tokens = Vec::new();
        {
            let mut eee = EeeChainTokenDefault::default();
            eee.net_type = "Private".to_string();
            eee.eee_chain_token_shared.m.token_type = EeeTokenType::Eee.to_string();
            eee.eee_chain_token_shared.m.decimal = 15;
            eee.eee_chain_token_shared.m.gas_limit = 0; //todo
            eee.eee_chain_token_shared.m.gas_price = "".to_owned(); //todo

            eee.eee_chain_token_shared.m.token_shared.name = "EEE".to_owned();
            eee.eee_chain_token_shared.m.token_shared.symbol = "EEE".to_owned();
            eee.eee_chain_token_shared.m.token_shared.logo_url = "".to_owned();//todo
            eee.eee_chain_token_shared.m.token_shared.logo_bytes = "".to_owned();
            eee.eee_chain_token_shared.m.token_shared.project_name = "scryinfo".to_owned();
            eee.eee_chain_token_shared.m.token_shared.project_home = "https://scry.info/".to_owned();
            eee.eee_chain_token_shared.m.token_shared.project_note = "SCRY.INFO is an open source blockchain data protocol layer, oracle of the blockchain world, cornerstone of data smart contract applications.".to_owned();
            default_tokens.push(eee);
        }
        {
            let mut tokenx = EeeChainTokenDefault::default();
            tokenx.net_type = "Private".to_string();
            tokenx.eee_chain_token_shared.m.token_type = "Tokenx".to_string();

            tokenx.eee_chain_token_shared.m.decimal = 15;
            tokenx.eee_chain_token_shared.m.gas_limit = 0; //todo
            tokenx.eee_chain_token_shared.m.gas_price = "".to_owned(); //todo

            tokenx.eee_chain_token_shared.m.token_shared.name = "TOKENX".to_owned();
            tokenx.eee_chain_token_shared.m.token_shared.symbol = "TOX".to_owned();
            tokenx.eee_chain_token_shared.m.token_shared.logo_url = "".to_owned();//todo
            tokenx.eee_chain_token_shared.m.token_shared.logo_bytes = "".to_owned();
            tokenx.eee_chain_token_shared.m.token_shared.project_name = "scryinfo".to_owned();
            tokenx.eee_chain_token_shared.m.token_shared.project_home = "https://scry.info/".to_owned();
            tokenx.eee_chain_token_shared.m.token_shared.project_note = "SCRY.INFO is an open source blockchain data protocol layer, oracle of the blockchain world, cornerstone of data smart contract applications.".to_owned();
            default_tokens.push(tokenx);
        }

        let mut c_tokens = CArray::to_c_ptr(&default_tokens);
        let c_err = chain_eee_c::ChainEee_updateDefaultTokenList(*c_ctx, c_tokens) as *mut CError;
        assert_eq!(Error::SUCCESS().code, (*c_err).code, "{:?}", *c_err);
        CError_free(c_err);
        c_tokens.free();
        wallets_cdl::mem_c::CContext_dFree(c_ctx);
    }
}


#[test]
fn eee_tx_explorer_test() {

    //query node basic info

    //query node best height

    //query account tx
    unimplemented!()
}

fn init_basic_info_parameters() -> MSubChainBasicInfo {
    let chain_metadata = include_str!("chain_metadata.rs");
    MSubChainBasicInfo {
        genesis_hash: GENESIS_HASH.to_string(),
        metadata: chain_metadata.to_string(),
        runtime_version: RUNTIME_VERSION as i32,
        tx_version: TX_VERSION as i32,
        ss58_format_prefix: 42,
        token_decimals: 15,
        token_symbol: "EEE".to_string(),
        is_default: 1,
        ..Default::default()
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

fn create_wallet(c_ctx: *mut *mut CContext) -> Wallet {
    unsafe {
        let mnemonic = {
            let p_mn = CStr_dAlloc();
            {
                let c_err = Wallets_generateMnemonic(p_mn) as *mut CError;
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
            password: "1".to_string(),
            mnemonic: mnemonic.clone(),
            wallet_type: WalletType::Test.to_string(),
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

fn save_basic_info(c_ctx: *mut *mut CContext) -> Result<(), String> {
    let m_chain_basic_info = init_basic_info_parameters();
    let chain_basic_info = SubChainBasicInfo::from(m_chain_basic_info);
    let mut c_basic_info = CSubChainBasicInfo::to_c_ptr(&chain_basic_info);
    unsafe {
        let c_err = chain_eee_c::ChainEee_updateBasicInfo(*c_ctx, to_c_char("Test"), c_basic_info) as *mut CError;
        let res = {
            if Error::SUCCESS().code == (*c_err).code {
                Ok(())
            } else {
                Err(format!("{:?}", *c_err))
            }
        };
        CError_free(c_err);
        c_basic_info.free();
        res
    }
}

fn get_chain_basic_info(c_ctx: *mut *mut CContext) -> Option<SubChainBasicInfo> {
    let chain_version = ChainVersion {
        genesis_hash: GENESIS_HASH.to_string(),
        runtime_version: RUNTIME_VERSION as i32,
        tx_version: TX_VERSION as i32,
    };
    unsafe {
        let c_basicinfo = wallets_cdl::mem_c::CSubChainBasicInfo_dAlloc();
        let mut c_chain_version = CChainVersion::to_c_ptr(&chain_version);
        let c_err = chain_eee_c::ChainEee_getBasicInfo(*c_ctx, to_c_char("Test"), c_chain_version, c_basicinfo) as *mut CError;
        let res = {
            if Error::SUCCESS().code == (*c_err).code {
                let chain_basic_info = CSubChainBasicInfo::to_rust(&**c_basicinfo);
                wallets_cdl::mem_c::CSubChainBasicInfo_dFree(c_basicinfo);
                Some(chain_basic_info)
            } else {
                println!("error code:{},detail:{:?}", (*c_err).code, *c_err);
                None
            }
        };
        CError_free(c_err);
        c_chain_version.free();
        res
    }
}