use sp_core::crypto::{AccountId32 as AccountId,Ss58Codec};
use std::sync::mpsc::channel;
use eee::node_metadata::Metadata;
use eee::chain_helper::ChainHelper;
use frame_metadata::RuntimeMetadataPrefixed;
use codec::{Encode, Decode, Compact};
use std::convert::TryFrom;

const TX_VERSION: u32 = 1;
const RUNTIME_VERSION: u32 = 6;
const URL: &'static str = "ws://127.0.0.1:9945";
const GENESIS_HASH: &'static str = "0xc68cadef9d04fd235d7deb94db1332767f3da2a1bf5462c75dba3a2047f8c15d";//0x2fc77f8d90e56afbc241f36efa4f9db28ae410c71b20fd960194ea9d1dabb973
const METADATA_REQ: &'static str = r#"{"id":1,"jsonrpc":"2.0","method":"state_getMetadata","params":[]}"#;

pub mod rpc;

fn get_request(url: &str, jsonreq: &str) -> Option<String> {
    let (result_in, result_out) = channel();
    rpc::get(url.to_string(), jsonreq.to_string(), result_in);
    let str = result_out.recv().unwrap();

    match &str[..] {
        "null" => None,
        _ => Some(str),
    }
}

#[test]
fn get_chain_runtime_metadata_test() {
    let hex_str = get_request(URL, METADATA_REQ).expect("get metadata data");
    let runtime_vec = scry_crypto::hexstr_to_vec(&hex_str).expect("vec format is wrong");
    let prefixed = RuntimeMetadataPrefixed::decode(&mut &runtime_vec[..]).expect("runtime prefixed");
    let metadata = Metadata::try_from(prefixed).expect("Metadata");
    metadata.print_overview();
    metadata.print_modules_with_calls();
    metadata.print_modules_with_events();
}

#[test]
fn ref_count_key_test() {
    let metadata_hex = get_request(URL, METADATA_REQ).unwrap();
    let genesis_byte = scry_crypto::hexstr_to_vec(GENESIS_HASH).unwrap();
    let helper = ChainHelper::init(&metadata_hex, &genesis_byte[..], RUNTIME_VERSION, TX_VERSION, Some(15));
    assert!(helper.is_ok());
    let helper = helper.unwrap();
    let storage_key = helper.get_storage_value_key("System", "UpgradedToU32RefCount");
    println!("{:?}", storage_key);
}

#[test]
fn decode_extrinsics_test() {
    let input_tx = r#"0x490284ffd43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d01e6291e2731dbb933d9ac8b03fe06c96d8c284a2281b66f93800d7adb8d1e3845adafbf522e610797e1bfd54dbcd24b53146b8ef42168c95430884f320b153680e60000000603ff54065129457ea102a3d978e78c88c93e7e9298d06378874b7206e43cf4c6f67f0f0000c16ff28623"#;
    let metadata_hex = get_request(URL, METADATA_REQ).unwrap();
    let genesis_byte = scry_crypto::hexstr_to_vec(GENESIS_HASH).unwrap();
    let helper = ChainHelper::init(&metadata_hex, &genesis_byte[..], RUNTIME_VERSION, TX_VERSION, Some(15));
    assert!(helper.is_ok());
    let helper = helper.unwrap();

    let txs = vec![String::from(input_tx)];
    let decode_ret = helper.decode_extrinsics(&txs, "5DxskoXeEEyTg3pqQVfkku43VcumqL3rfkQKAgvHmEh4c6tX");
    println!("{:?}", decode_ret);
}

#[test]
fn decode_event_test() {
    env_logger::init();
    let metadata_hex = get_request(URL, METADATA_REQ).unwrap();
    let genesis_byte = scry_crypto::hexstr_to_vec(GENESIS_HASH).unwrap();
    let helper = ChainHelper::init(&metadata_hex, &genesis_byte[..], RUNTIME_VERSION, TX_VERSION, Some(15)).expect("get metadata");

    // let event_str = r#"0x0400000000000000482d7c0900000000020000"#;
    let event_str = r#"0x1c00000000000000482d7c09000000000200000001000000000000000000000000000200000002000000000354065129457ea102a3d978e78c88c93e7e9298d06378874b7206e43cf4c6f67f000002000000030054065129457ea102a3d978e78c88c93e7e9298d06378874b7206e43cf4c6f67f0000c16ff286230000000000000000000000020000000302d43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d54065129457ea102a3d978e78c88c93e7e9298d06378874b7206e43cf4c6f67f0000c16ff286230000000000000000000000020000000c06f0e60aba130100000000000000000000000002000000000068663b0a00000000000000"#;
    let decode_ret = helper.decode_events(event_str, None);
    println!("decode event is:{:?}", decode_ret);
    assert!(decode_ret.is_ok());

    println!("event decode result:{:?}", decode_ret);
}

#[test]
fn storage_map_key_test() {
    let metadata_hex = get_request(URL, METADATA_REQ).unwrap();
    let genesis_byte = scry_crypto::hexstr_to_vec(GENESIS_HASH).unwrap();
    let helper = ChainHelper::init(&metadata_hex, &genesis_byte[..], RUNTIME_VERSION, TX_VERSION, Some(15));
    assert!(helper.is_ok());
    let helper = helper.unwrap();
    let account_id = AccountId::from_ss58check("5HguabiDW28a7pmPzVj6DHcAQoZ5DesD1KhXBWEAH4PXvDZ9").unwrap();
    // AccountInfo
    match helper.get_storage_map_key::<AccountId, u128>("System", "Account", account_id) {
        Ok(key) => {
            println!("{}", key)
        }
        Err(err) => println!("{:?}", err),
    }
}

#[test]
fn token_transfer_sign_test() {
    let mnemonic = "left purse east join crumble common squeeze erupt dinner increase sorry negative";
    let amount = "2000000000000000";
    let metadata_hex = get_request(URL, METADATA_REQ).unwrap();
    let genesis_byte = scry_crypto::hexstr_to_vec(GENESIS_HASH).unwrap();
    let helper = ChainHelper::init(&metadata_hex, &genesis_byte[..], RUNTIME_VERSION, TX_VERSION, Some(15));
    assert!(helper.is_ok());
    let helper = helper.unwrap();
    let sign_ret = helper.token_transfer_sign(eee::Token::EEE, mnemonic, "5Dne8YVzkp7YKRJVMP8GYm9xTtNdW1crtZeeh6NavTPdLoUY", amount, 3, None);
    assert!(sign_ret.is_ok());
    println!("signed tx result:{}", sign_ret.unwrap());
}

#[test]
fn tx_sign_test() {
    let mnemonic = "left purse east join crumble common squeeze erupt dinner increase sorry negative";
    let func_data = [
        172u8, 4, 5, 3, 76, 55, 255, 34, 210, 227,
        83, 125, 131, 241, 154, 194, 241, 173, 175, 176,
        179, 249, 86, 49, 34, 35, 42, 201, 59, 75,
        187, 148, 152, 82, 231, 46, 15, 0, 0, 141,
        73, 253, 26, 7];
    let metadata_hex = get_request(URL, METADATA_REQ).unwrap();
    let genesis_byte = scry_crypto::hexstr_to_vec(GENESIS_HASH).unwrap();
    let helper = ChainHelper::init(&metadata_hex, &genesis_byte[..], RUNTIME_VERSION, TX_VERSION, Some(15));
    assert!(helper.is_ok());
    let helper = helper.unwrap();
    let ret = helper.tx_sign(mnemonic, 1, &func_data[..], true);
    assert!(ret.is_ok());
    let ret_str = ret.unwrap();
    println!("signed tx result:{}", ret_str);
    println!("{:?}", scry_crypto::hexstr_to_vec(&ret_str));
}
