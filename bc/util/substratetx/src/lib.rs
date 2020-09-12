#[macro_use]
extern crate serde_derive;

use tiny_keccak::Keccak;

use sp_core::{
    H256, ecdsa, ed25519, sr25519,
    crypto::{Pair, Ss58Codec},
    hexdisplay::HexDisplay,
};
use codec::{Encode, Decode};
use node_runtime::{AccountId, Balance, Event, Index, Signature, Call, Runtime, TokenXCall, BalancesCall::{self, transfer as transfercall, transfer_keep_alive}};
use node_runtime::TimestampCall::set;

use system::{Phase};
use byteorder::{ByteOrder, LittleEndian};

mod crypto;
mod transaction;
pub mod error;

pub use crypto::{Sr25519, Ed25519, Crypto};
pub use transaction::{tx_sign, tokenx_transfer, transfer, decode_account_info, account_info_key};

use std::collections::HashMap;
use std::hash::Hasher;


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
#[derive(Clone, Debug, Default)]
pub struct EeeAccountInfo {
    pub nonce: u32,
    pub refcount: u32,
    pub free: String,
    //To avoid java does not support u128 type format, all converted to String format
    pub reserved: String,
    pub misc_frozen: String,
    pub fee_frozen: String,
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
    pub method_name:String,
    pub ext_data: Option<String>,
}

/// Do a XX 128-bit hash and place result in `dest`.
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
}

pub fn encode_account_storage_key(module: &str, storage: &str, puk: &str) -> Result<String, error::Error> {
    let module_byte = twox_128(module.as_bytes());
    let storage_byte = twox_128(storage.as_bytes());
    let pub_key_without_0x = puk.get(2..).unwrap();
    let pub_vec = hex::decode(pub_key_without_0x)?;
    let blake2_result = blake2_rfc::blake2b::blake2b(16, &[], &pub_vec);
    let puk_hash = hex::encode(blake2_result.as_bytes());
    let mut final_key = Vec::from(&module_byte[..]);
    final_key.extend_from_slice(&storage_byte[..]);
    let key_start = hex::encode(&final_key);
    Ok(format!("0x{}{}{}",key_start,puk_hash,pub_key_without_0x))

}

// Notification event data Use hex-encoded strings to associate the results of notification events with transactions
pub fn event_decode(event_data: &str, _blockhash: &str, _account: &str) -> HashMap<u32, bool> {
    let enents_bytes = hex::decode(event_data.get(2..).unwrap()).unwrap();
    let events = Vec::<system::EventRecord<Event, H256>>::decode(&mut &enents_bytes[..]);
    let mut tx_result = HashMap::with_capacity(8);
    for record in events {
        for event in record {
            //todo 将索引与区块交易中的索引关联起来，怎么来确定交易索引与交易结果之间的关系？
            let index = if let Phase::ApplyExtrinsic(index) = event.phase { index } else { 0 };
            //todo 当交易失败，不会存在该通知记录
            println!("event detail is:{:?}", event.event);
            match event.event {
                Event::frame_system(se) => { //todo
                    match &se {
                        system::RawEvent::ExtrinsicSuccess(_dispath) => {
                            tx_result.insert(index, true);
                        }
                        system::RawEvent::ExtrinsicFailed(_err, _info) => {
                            tx_result.insert(index, false);
                        }
                        _ => log::error!("ignoring unsupported  system event")
                    }
                }
                _ => log::error!("ignoring unsupported event")
            }
        }
    }
    tx_result
}
fn decode_nonce(input:&[u8])->Option<u32>{
    let mut nonce_array = [0u8;4];
    if nonce_array.len()<input.len(){
        return None;
    }
    &nonce_array[0..input.len()].copy_from_slice(input);
    Some(u32::from_le_bytes(nonce_array)/4)
}
pub fn decode_extrinsics(extrinsics_json: &str, target_account: &str) -> Result<HashMap<u32, TransferDetail>, error::Error> {
    let target_account = AccountId::from_ss58check(target_account)?;
    let json_data: Vec<String> = serde_json::from_str(extrinsics_json)?;

    let mut map = HashMap::new();
    for index in 0..json_data.len() {
        let extrinsic_encode_bytes = hex::decode(json_data[index].get(2..).unwrap())?;
        let extrinsic = node_runtime::UncheckedExtrinsic::decode(&mut &extrinsic_encode_bytes[..])?;

        let extrinsic_func_byte = extrinsic.encode();
        let blake2_result = blake2_rfc::blake2b::blake2b(32, &[], &extrinsic_func_byte);
        let hash = blake2_result.as_bytes();

        let mut tx = TransferDetail::default();
        tx.hash = Some(format!("0x{}", hex::encode(hash)));
        println!("tx detail is:{:?}", extrinsic.function);

        match &extrinsic.function {
            Call::Timestamp(set(date, )) => {
                tx.timestamp = Some(*date);
                map.insert(index as u32, tx);
            }
            Call::Balances(transfercall(to, value)) | Call::Balances(transfer_keep_alive(to, value)) => {//需要将交易发送者的信息关联出来
                if let Some((account, _, (_, _, _, _, nonce, _, _))) = &extrinsic.signature {
                    if !target_account.ge(to) && !target_account.ge(&account) {
                        continue;
                    }
                    let nonce_byte=nonce.encode();
                   let nonce =  decode_nonce(nonce_byte.as_slice());
                    tx.value = Some(*value);
                    tx.to = Some(to.to_ss58check());
                    tx.signer = Some(account.to_ss58check());
                    tx.index =nonce;//todo
                    tx.token_name = "EEE".to_string();
                    tx.method_name = "transfer".to_string();
                    map.insert(index as u32, tx);
                }
            }
            Call::TokenX(TokenXCall::transfer(to, value, ext)) => {
                if let Some((account, _, (_, _, _, _, nonce, _, _))) = &extrinsic.signature {
                    if !target_account.ge(to) && !target_account.ge(&account) {
                        continue;
                    }
                    let nonce_byte=nonce.encode();

                    let nonce =  decode_nonce(nonce_byte.as_slice());
                    tx.value = Some(*value);
                    tx.to = Some(to.to_ss58check());
                    tx.signer =  Some(account.to_ss58check());
                    tx.index = nonce;//todo
                    tx.token_name = "TokenX".to_string();
                    tx.method_name = "transfer".to_string();

                    let ext_str = {
                        let ext_data_len = ext.len();
                        let temp_array = vec![0u8;ext_data_len];
                        if !temp_array.as_slice().ge(&ext[..]) {
                            Some( format!("0x{}",hex::encode(ext)))
                        }else{
                            None
                        }
                    };
                    tx.ext_data =ext_str;
                    map.insert(index as u32, tx);
                }
            }
            Call::TokenX(TokenXCall::transfer_from(from, to, value, ext)) => {
                if let Some((account, _, (_, _, _, _, nonce, _, _))) = &extrinsic.signature {
                    if !target_account.ge(to) && !target_account.ge(&account) {
                        continue;
                    }
                    let nonce_byte=nonce.encode();
                    let nonce =  decode_nonce(nonce_byte.as_slice());
                    tx.value = Some(*value);
                    tx.to = Some(to.to_ss58check());
                    tx.from = Some(from.to_ss58check());
                    tx.signer = Some(account.to_ss58check());
                    tx.index = nonce;//todo
                    tx.token_name = "TokenX".to_string();
                    tx.method_name="transfer_from".to_string();
                    if let Ok(ext_str) = String::from_utf8(ext.clone()){
                        tx.ext_data =Some(ext_str)
                    }else {
                        tx.ext_data = Some(  format!("0x{}",hex::encode(ext)))
                    }
                    map.insert(index as u32, tx);
                }
            }
           /* Call::TokenX(TokenXCall::authorize_tokenx(target, quantity, ext)) => {
                if let Some((account, _, (_, _, _, _, nonce, _, _))) = &extrinsic.signature {
                    if !target_account.ge(target) && !target_account.ge(&account) {
                        continue;
                    }
                }
                log::info!("TokenXCall::authorize_tokenx");
            }
            Call::TokenX(TokenXCall::approve(to, value, ext)) => {//需要将交易发送者的信息关联出来
            log::info!("TokenXCall::approve");
            }*/
            _ => log::info!("extrinsic.function")
        }

    }
    Ok(map)
}

#[test]
fn decode_extrinsics_test() {
    let data = r#"["0x280402000b208b95717401","0x2d0284306721211d5404bd9da88e0204360a1a9ab8b87c66c1bc2fcdd37f3c2222cc200118cc282a465f5de1c99dc5e346296dcdce0751bf484be239129de0fcb52c682b8767451a4ad6257754f83a055d20eab1e6814680b811d09ae07be3e2122fcd82060608000605766093d22a1f2be22b983cfcc89eb28cf89c8c849dc9a4688905d9ae300b465d040400"]"#;
    match decode_extrinsics(data, "5EjvCP7DL9mS8wNyqVgef3oygW8KtbzsRFoRguixFQkSuFNC") {
        Ok(res) => {
            for (index, hash) in &res {
                println!("index:{},tx hash is:{:?}", index, hash);
            }
        }
        Err(msg) => println!("error info {}", msg)
    }
}

#[test]
fn data_decode_test() {
    let encode_event = r#"0x0800000000000000102700000101000001000000000103050340420f00000100"#;
    // let encode_event = r#"0x140000000000000010270000010100000100000000038e50224acdcc7591c0e9a28ab7d91c099574f8d47f3a35a542dbaebf1ec5f30c00000100000002008e50224acdcc7591c0e9a28ab7d91c099574f8d47f3a35a542dbaebf1ec5f30c00c06e31d910010000000000000000000000010000000202ea990fcb7e9600adcf735a69d7bbcbaa62e52d2eb26125381379a91558fe083b8e50224acdcc7591c0e9a28ab7d91c099574f8d47f3a35a542dbaebf1ec5f30c00c06e31d91001000000000000000000000001000000000040420f00000100"#;
    let res = event_decode(encode_event, "", "");
    println!("res detail:{:?}", res);
}

#[test]
fn encode_account_storage_key_test(){
    let res = encode_account_storage_key("TokenX","Balances","0x766093d22a1f2be22b983cfcc89eb28cf89c8c849dc9a4688905d9ae300b465d");
   println!("key storage:{}",res.unwrap());
  //  assert_eq!(res.is_ok(),true)
}



