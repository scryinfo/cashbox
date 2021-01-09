use std::ptr::null_mut;
use mav::kits;
use wallets_types::{InitParameters, Error, EthRawTxPayload, EthTransferPayload};

use wallets_cdl::{CU64, chain_eth_c, to_c_char,CR,CStruct,
                  parameters::{CContext, CInitParameters,CEthTransferPayload,CEthRawTxPayload},
                  mem_c::{CContext_dAlloc, CError_free},
                  types::CError,
                  wallets_c::Wallets_init,
};

#[test]
fn eth_tx_sign_test() {
    let c_ctx = CContext_dAlloc();
    assert_ne!(null_mut(), c_ctx);
    unsafe {
        let c_err = init_parameters(c_ctx);
        assert_ne!(null_mut(), c_err);
        assert_eq!(0 as CU64, (*c_err).code, "{:?}", *c_err);
        let sign_result = wallets_cdl::mem_c::CStr_dAlloc();
        let transfer_tx = EthTransferPayload{
            from_address: "0xfc7c721f7ca42c5b9b7485d8efffc453d725499e".to_string(),
            to_address: "0x00a329c0648769a73afac7f9381e08fb43dbea72".to_string(),
            contract_address: "".to_string(),
            value: "3".to_string(),
            nonce: "0".to_string(),
            gas_price: "0.00009".to_string(),
            gas_limit: "21000".to_string(),
            decimal: 18,
            ext_data: "".to_string(),
            password: "1".to_string()
        };
        let mut c_transfer_tx = CEthTransferPayload::to_c_ptr(&transfer_tx);
        let c_err = chain_eth_c::ChainEth_txSign(*c_ctx, to_c_char("Private"), c_transfer_tx, to_c_char("1"),sign_result) as *mut CError;
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
        let c_err = init_parameters(c_ctx);
        assert_ne!(null_mut(), c_err);
        assert_eq!(0 as CU64, (*c_err).code, "{:?}", *c_err);
        let sign_result = wallets_cdl::mem_c::CStr_dAlloc();
        let raw_tx_payload = EthRawTxPayload{
            from_address: "0xfc7c721f7ca42c5b9b7485d8efffc453d725499e".to_string(),
            raw_tx: "".to_string()
        };
        let mut c_raw_tx_payload = CEthRawTxPayload::to_c_ptr(&raw_tx_payload);
        let c_err = chain_eth_c::ChainEth_rawTxSign(*c_ctx,to_c_char("Private"),c_raw_tx_payload,to_c_char("1"),sign_result) as *mut CError;
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
        let c_err = init_parameters(c_ctx);
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
