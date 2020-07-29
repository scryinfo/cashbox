#[macro_use]
extern crate serde_derive;

use tiny_keccak::Keccak;

use sp_core::{
    H256,ecdsa, ed25519, sr25519,
    crypto::{Pair, Ss58Codec},
    hexdisplay::HexDisplay
};
use codec::{Encode,Decode};
use node_runtime::{AccountId, Balance,Event, Index, Signature,Call, Runtime,BalancesCall::{self,transfer as transfercall}};
use node_runtime::TimestampCall::set;

use system::Phase;


mod crypto;
mod transaction;
pub mod error;

pub use crypto::{Sr25519, Ed25519, Crypto};
pub use transaction::{tx_sign,transfer,decode_account_info,account_info_key};

use std::collections::HashMap;


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
     //Destination account, balance account
    pub value: Option<u128>,
    pub hash: Option<String>,
    pub timestamp: Option<u64>,
}
/*
pub fn transfer(_mnemonic: &str, _to: &str, _amount: &str, _genesis_hash: &[u8], _index: u32, _runtime_version: u32) -> Result<String, error::Error> {
    unimplemented!()
}

pub fn tx_sign(_mnemonic: &str, _genesis_hash: &[u8], _index: u32, _func_data: &[u8], _version: u32) -> Result<String, error::Error> {
    unimplemented!()
}
*/
/*
pub fn account_info_key(_account_id: &str) -> Result<String, error::Error> {
    unimplemented!()
}

pub fn decode_account_info(_info: &str) -> Result<EeeAccountInfo, error::Error> {
    unimplemented!()
}
*/
// 通知事件数据 使用hex 方式编码的字符串,将通知事件的结果与交易关联起来
pub fn event_decode(event_data:&str,_blockhash:&str,_account:&str)->HashMap<u32,bool> {
    let enents_bytes = hex::decode(event_data.get(2..).unwrap()).unwrap();
    let events = Vec::<system::EventRecord<Event, H256>>::decode(&mut &enents_bytes[..]);
    let mut tx_result = HashMap::with_capacity(8);
    for record in events {
        for event in record {
            //todo 将索引与区块交易中的索引关联起来，怎么来确定交易索引与交易结果之间的关系？
            let index = if let  Phase::ApplyExtrinsic(index) = event.phase{index}else { 0 };
            //todo 当交易失败，不会存在该通知记录
            match event.event {
                Event::system(se) => {
                    match &se {
                        system::RawEvent::ExtrinsicSuccess(_dispath) => {
                            tx_result.insert(index,true);
                        },
                        system::RawEvent::ExtrinsicFailed(_err, _info) => {
                            tx_result.insert(index,false);
                        },
                        _ => log::error!("ignoring unsupported  system event")
                    }
                },
                _ => log::error!("ignoring unsupported event")
            }
        }
    }
    tx_result
}
pub fn decode_extrinsics(extrinsics_json:&str,target_account:&str)->Result<HashMap<u32,TransferDetail>,error::Error>{
    let target_account = AccountId::from_ss58check(target_account)?;
    let json_data:Vec<String>   = serde_json::from_str(extrinsics_json)?;
    let mut map = HashMap::new();
    for index in 0..json_data.len() {
        let extrinsic_encode_bytes = hex::decode(json_data[index].get(2..).unwrap())?;
        let extrinsic = node_runtime::UncheckedExtrinsic::decode(&mut &extrinsic_encode_bytes[..])?;
        let mut tx = TransferDetail::default();
        match &extrinsic.function {
            Call::Timestamp(set(date,))=> {
                tx.timestamp = Some(*date);
                map.insert(index as u32,tx);
            }
            Call::Balances(transfercall(to,vaule))=>{//需要将交易发送者的信息关联出来
                if let Some((account,_,(_,_,_,_,nonce,_,_))) = &extrinsic.signature{
                    if !target_account.ge(to)&&!target_account.ge(&account){
                        continue
                    }
                    tx.value = Some(*vaule);
                    tx.to = Some(to.to_ss58check());
                    tx.from = Some(account.to_ss58check());
                    tx.index = Some(nonce.get_value());
                }

                let extrinsic_func_byte =   extrinsic.encode();
                let blake2_result =blake2_rfc::blake2b::blake2b(32, &[], &extrinsic_func_byte);
                let hash = blake2_result.as_bytes();
                tx.hash = Some(format!("0x{}",hex::encode(hash)));
               map.insert(index as u32,tx);
            },
            _=> println!(" extrinsic.function")
        }
    }
    Ok(map)
}

#[test]
fn decode_extrinsics_test() {
    let data = r#"["0x280402000b00adc5647201","0x3d0284d43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d0154c32d047e9629b33ad92c12920b60e722ab60aa9138e94a1f98ddd8c4e81f742eb8769f0177a011bcec4d6febf2290121b94ced49642abcbd38aa170f13c48fb60218000400306721211d5404bd9da88e0204360a1a9ab8b87c66c1bc2fcdd37f3c2222cc200b0060b7986c88"]"#;
    match decode_extrinsics(data, "5DAAnrj7VHTznn2AWBemMuyBwZWs6FNFjdyVXUeYum3PTXFy") {
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



