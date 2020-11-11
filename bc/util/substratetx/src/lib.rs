#[macro_use]
extern crate serde_derive;
use std::collections::HashMap;
use tiny_keccak::Keccak;
use sp_core::{
    H256 as Hash,
    crypto::{Pair, Ss58Codec,AccountId32 as AccountId},
};

use sp_runtime::{
    generic::Era,
    MultiSignature,
};
use codec::{Encode, Decode, Compact};
use system::Phase;
pub use crypto::{Sr25519, Ed25519, Crypto};

use events::{EventsDecoder, RuntimeEvent, SystemEvent};
use extrinsic::xt_primitives::{GenericAddress, GenericExtra, AdditionalSigned};

mod crypto;

pub mod error;
pub mod node_metadata;

#[macro_use]
pub mod extrinsic;
pub mod node_helper;
pub mod events;

/// The block number type used in this runtime.
pub type BlockNumber = u64;
/// The timestamp moment type used in this runtime.
pub type Moment = u64;

//fixme: make generic
pub type Balance = u128;

pub trait Keccak256<T> {
    fn keccak256(&self) -> T
        where T: Sized;
}

impl<T> Keccak256<[u8; 32]> for T where T: AsRef<[u8]> {
    fn keccak256(&self) -> [u8; 32] {
        let mut keccak = Keccak::new_keccak256();
        let mut result = [0u8; 32];
        keccak.update(self.as_ref());
        keccak.finalize(&mut result);
        result
    }
}

/// Used to transfer the decoded result of account information, use the default unit here?
#[derive(Clone, Debug, Default, Decode)]
pub struct EeeAccountInfo {
    pub nonce: u32,
    pub refcount: u32,
    pub free: u128,
    //To avoid java does not support u128 type format, all converted to String format
    pub reserved: u128,
    pub misc_frozen: u128,
    pub fee_frozen: u128,
}

//Designed as an option, when the transaction is a transaction that sets the block time, there is no signature
#[derive(Default, Debug)]
pub struct TransferDetail {
    pub index: Option<u32>,
    //The transaction nonce corresponding to the signed account
    pub from: Option<String>,
    //Signature account from which account is transferred out of balance
    pub to: Option<String>,
    pub signer: Option<String>,
    //Destination account, balance account
    pub value: Option<u128>,
    pub hash: Option<String>,
    pub timestamp: Option<u64>,
    pub token_name: String,
    pub method_name: String,
    pub ext_data: Option<String>,
}

/*/// Do a XX 128-bit hash and place result in `dest`.
fn twox_128_into(data: &[u8], dest: &mut [u8; 16]) {
    let mut h0 = twox_hash::XxHash::with_seed(0);
    let mut h1 = twox_hash::XxHash::with_seed(1);
    h0.write(data);
    h1.write(data);
    let r0 = h0.finish();
    let r1 = h1.finish();

    LittleEndian::write_u64(&mut dest[0..8], r0);
    LittleEndian::write_u64(&mut dest[8..16], r1);
}

/// Do a XX 128-bit hash and return result.
pub fn twox_128(data: &[u8]) -> [u8; 16] {
    let mut r: [u8; 16] = [0; 16];
    twox_128_into(data, &mut r);
    r
}*/

// pub fn encode_account_storage_key(module: &str, storage: &str, puk: &str) -> Result<String, error::Error> {
//     let module_byte = twox_128(module.as_bytes());
//     let storage_byte = twox_128(storage.as_bytes());
//     let pub_key_without_0x = puk.get(2..).unwrap();
//     let pub_vec = hex::decode(pub_key_without_0x)?;
//     let blake2_result = blake2_rfc::blake2b::blake2b(16, &[], &pub_vec);
//     let puk_hash = hex::encode(blake2_result.as_bytes());
//     let mut final_key = Vec::from(&module_byte[..]);
//     final_key.extend_from_slice(&storage_byte[..]);
//     let key_start = hex::encode(&final_key);
//     Ok(format!("0x{}{}{}", key_start, puk_hash, pub_key_without_0x))
// }

pub fn hexstr_to_vec(hexstr: &str) -> Result<Vec<u8>, error::Error> {
    let hexstr = hexstr
        .trim_matches('\"')
        .to_string()
        .trim_start_matches("0x")
        .to_string();
    hex::decode(&hexstr).map_err(|err| err.into())
}


#[cfg(test)]
mod tests {
    use super::*;
    use sp_core::crypto::AccountId32 as AccountId;
    use std::sync::mpsc::channel;

    const TX_VERSION: u32 = 1;
    const RUNTIME_VERSION: u32 = 6;
    const URL: &'static str = "ws://192.168.1.7:9944";
    const GENESIS_HASH: &'static str = "0x7fa792d0aff5e5529e0125faf969f7adfd65894b962e24681f18eab116975a20";
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
        let data = get_request(URL, METADATA_REQ).unwrap();
        match node_helper::ChainHelper::get_chain_runtime_metadata(&data) {
            Ok(meta) => {
                meta.print_overview();
                meta.print_modules_with_calls();
                meta.print_modules_with_events();
            }
            Err(err) => {
                println!("get metadata error:{:?}", err);
            }
        }
    }

    #[test]
    fn decode_extrinsics_test() {
        let input_tx = r#"["0x280402000bc01bb6ab7501","0x3d028454065129457ea102a3d978e78c88c93e7e9298d06378874b7206e43cf4c6f67f010e85977b32d9b3ad26dc7ddc3c6a3d3b834cfbaaf2f44e5e323ec333046cb43eab08f603f1bf73abf921ef7dc90c68312316a3b45fed585f90b0e37522a87c8900040005034c37ff22d2e3537d83f19ac2f1adafb0b3f9563122232ac93b4bbb949852e72e0f00008d49fd1a07"]"#;
        let metadata_hex = get_request(URL, METADATA_REQ).unwrap();
        let genesis_byte = hexstr_to_vec(GENESIS_HASH).unwrap();
        let helper = node_helper::ChainHelper::init(&metadata_hex, &genesis_byte[..], RUNTIME_VERSION, TX_VERSION, Some(15));
        assert!(helper.is_ok());
        let helper = helper.unwrap();
        let decode_ret = helper.decode_extrinsics(input_tx, "5DxskoXeEEyTg3pqQVfkku43VcumqL3rfkQKAgvHmEh4c6tX");
        println!("{:?}", decode_ret);
    }

    #[test]
    fn decode_event_test() {
        let metadata_hex = get_request(URL, METADATA_REQ).unwrap();
        let genesis_byte = hexstr_to_vec(GENESIS_HASH).unwrap();
        let helper = node_helper::ChainHelper::init(&metadata_hex, &genesis_byte[..], RUNTIME_VERSION, TX_VERSION, Some(15));
        assert!(helper.is_ok());
        let helper = helper.unwrap();
        let event_str = r#"0x0c00000000000000482d7c090000000002000000010000000502d43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d54065129457ea102a3d978e78c88c93e7e9298d06378874b7206e43cf4c6f67f0000c16ff28623000000000000000000000001000000000068663b0a00000000000000"#;
        let decode_ret = helper.decode_events(event_str, None);
        assert!(decode_ret.is_ok());

        println!("event decode result:{:?}", decode_ret);
    }

    #[test]
    fn storage_map_key_test() {
        let metadata_hex = get_request(URL, METADATA_REQ).unwrap();
        let genesis_byte = hexstr_to_vec(GENESIS_HASH).unwrap();
        let helper = node_helper::ChainHelper::init(&metadata_hex, &genesis_byte[..], RUNTIME_VERSION, TX_VERSION, Some(15));
        assert!(helper.is_ok());
        let helper = helper.unwrap();
        let account_id = AccountId::from_ss58check("5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY").unwrap();
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
        let genesis_byte = hexstr_to_vec(GENESIS_HASH).unwrap();
        let helper = node_helper::ChainHelper::init(&metadata_hex, &genesis_byte[..], RUNTIME_VERSION, TX_VERSION, Some(15));
        assert!(helper.is_ok());
        let helper = helper.unwrap();
        let sign_ret = helper.token_transfer_sign("eee", mnemonic, "5Dne8YVzkp7YKRJVMP8GYm9xTtNdW1crtZeeh6NavTPdLoUY", amount, 3);
        assert!(sign_ret.is_ok());
        println!("signed tx result:{}", sign_ret.unwrap());
    }

    #[test]
    fn tx_sign_test() {
        let mnemonic = "left purse east join crumble common squeeze erupt dinner increase sorry negative";
        let amount = "2000000000000000";
        let func_data = [
            172u8, 4, 5, 3, 76, 55, 255, 34, 210, 227,
            83, 125, 131, 241, 154, 194, 241, 173, 175, 176,
            179, 249, 86, 49, 34, 35, 42, 201, 59, 75,
            187, 148, 152, 82, 231, 46, 15, 0, 0, 141,
            73, 253, 26, 7];
        let metadata_hex = get_request(URL, METADATA_REQ).unwrap();
        let genesis_byte = hexstr_to_vec(GENESIS_HASH).unwrap();
        let helper = node_helper::ChainHelper::init(&metadata_hex, &genesis_byte[..], RUNTIME_VERSION, TX_VERSION, Some(15));
        assert!(helper.is_ok());
        let helper = helper.unwrap();
        let ret = helper.tx_sign(mnemonic, 1, &func_data[..]);
        assert!(ret.is_ok());
        let ret_str = ret.unwrap();
        println!("signed tx result:{}", ret_str);
        println!("{:?}", hexstr_to_vec(&ret_str));
    }
}




