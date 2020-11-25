#[macro_use]
extern crate serde_derive;
use std::collections::HashMap;
use tiny_keccak::Keccak;
pub use sp_core::{
    H256 as Hash,
    crypto::{Pair, Ss58Codec,AccountId32 as AccountId},
};

use sp_runtime::{
    generic::Era,
    MultiSignature,
};
use codec::{Encode, Decode, Compact};
use system::Phase;
use events::{EventsDecoder, RuntimeEvent, SystemEvent};
use extrinsic::xt_primitives::{GenericAddress, GenericExtra, AdditionalSigned};
pub use node_helper::ChainHelper as SubChainHelper;
pub use crypto::{Sr25519, Ed25519, Crypto};

mod crypto;

pub mod error;
pub mod node_metadata;
//pub mod multiaddress;

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


pub fn decode_account_info(info: &str) -> Result<EeeAccountInfo, error::Error> {
    let state_vec = hexstr_to_vec(info)?;
    EeeAccountInfo::decode(&mut &state_vec.as_slice()[..]).map_err(|err| err.into())
}
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
    use node_metadata::Metadata;
    use frame_metadata::RuntimeMetadataPrefixed;
    use std::convert::TryFrom;

    const TX_VERSION: u32 = 1;
    const RUNTIME_VERSION: u32 = 6;
    const URL: &'static str = "ws://192.168.1.7:9947";
    //const GENESIS_HASH: &'static str = "0x85caf08522f79bae099d06348fe8b42f411159352fabd2dbd6a41f52afe8208c";
    const GENESIS_HASH: &'static str =  "0x286a1642a861e1c5d83365167f04c0bfd756108c931eac9d55bca171c46c707f";
    const METADATA_REQ: &'static str = r#"{"id":1,"jsonrpc":"2.0","method":"state_getMetadata","params":["0xdc7f2230c290ff11dbe94353058ed32ee939f734781307f051a0857d0e856c32"]}"#;

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
        let hex_str = get_request(URL, METADATA_REQ).expect("get metadata json-rpc");
        let runtime_vec = hexstr_to_vec(&hex_str).expect("vec format is wrong");
        let prefixed = RuntimeMetadataPrefixed::decode(&mut &runtime_vec[..]).expect("runtime prefixed");
        let metadata = Metadata::try_from(prefixed).expect("Metadata");
        metadata.print_overview();
        metadata.print_modules_with_calls();
        metadata.print_modules_with_events();
    }

    #[test]
    fn decode_extrinsics_test() {
        let input_tx = r#"["0x490284ffd43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d01e6291e2731dbb933d9ac8b03fe06c96d8c284a2281b66f93800d7adb8d1e3845adafbf522e610797e1bfd54dbcd24b53146b8ef42168c95430884f320b153680e60000000603ff54065129457ea102a3d978e78c88c93e7e9298d06378874b7206e43cf4c6f67f0f0000c16ff28623"]"#;
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
        env_logger::init();
        let metadata_hex = get_request(URL, METADATA_REQ).unwrap();
        let genesis_byte = hexstr_to_vec(GENESIS_HASH).unwrap();
        let helper = node_helper::ChainHelper::init(&metadata_hex, &genesis_byte[..], RUNTIME_VERSION, TX_VERSION, Some(15)).expect("get metadata");

       // let event_str = r#"0x0400000000000000482d7c0900000000020000"#;
        let event_str = r#"0x1c00000000000000482d7c09000000000200000001000000000000000000000000000200000002000000000354065129457ea102a3d978e78c88c93e7e9298d06378874b7206e43cf4c6f67f000002000000030054065129457ea102a3d978e78c88c93e7e9298d06378874b7206e43cf4c6f67f0000c16ff286230000000000000000000000020000000302d43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d54065129457ea102a3d978e78c88c93e7e9298d06378874b7206e43cf4c6f67f0000c16ff286230000000000000000000000020000000c06f0e60aba130100000000000000000000000002000000000068663b0a00000000000000"#;
        let decode_ret = helper.decode_events(event_str, None);
        println!("decode event is:{:?}",decode_ret);
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
        let sign_ret = helper.token_transfer_sign("eee", mnemonic, "5Dne8YVzkp7YKRJVMP8GYm9xTtNdW1crtZeeh6NavTPdLoUY", amount, 3,None);
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




