#[macro_use]
extern crate serde_derive;

use sp_core::{
    H256,ecdsa, ed25519, sr25519,
    crypto::{Pair, Ss58Codec},
    hexdisplay::HexDisplay
};
use codec::{Encode,Decode};
use node_runtime::{AccountId, Balance,Event, Index, Signature,Call, Runtime,BalancesCall};
use system::Phase;

mod crypto;
mod transaction;
pub mod error;

pub use crypto::{Sr25519,Ed25519,Keccak256,Crypto};
pub use transaction::{tx_sign,transfer,decode_account_info,account_info_key};

use std::sync::mpsc::channel;
use std::collections::HashMap;

/// 用于传递账户信息解码后的结果，这里使用默认的单位？
#[derive(Clone,Debug,Default)]
pub struct EeeAccountInfo{
    pub nonce:u32,
    pub refcount:u32,
    pub free: String,//为避免java不支持u128类型格式，全部转换为String格式
    pub reserved: String,
    pub misc_frozen: String,
    pub fee_frozen: String,
}

#[derive(Default,Debug)]
pub struct TransferEvent{
    pub index:u32,
    pub from:Option<String>,
    pub to:Option<String>,
    pub value:Option<u128>,
    pub result:bool,
}

impl TransferEvent{
    fn update_transfer_detail(&mut self,from:&str,to:&str,value:u128){
        self.from = Some(from.into());
        self.to = Some(to.into());
        self.value = Some(value.into());
    }
    fn update_result(&mut self,is_successful:bool){
        self.result = is_successful;
    }
}

// 通知事件数据 使用hex 方式编码的字符串  传递解析的交易详情，交易结果
pub fn event_decode(event_data:&str,blockhash:&str,account:&str)->HashMap<u32,TransferEvent> {
    let enents_bytes = hex::decode(event_data.get(2..).unwrap()).unwrap();
    let events = Vec::<system::EventRecord<Event, H256>>::decode(&mut &enents_bytes[..]);
    let mut all_extrinsic = HashMap::with_capacity(8);
    for record in events {
        for event in record {
            //todo 将索引与区块交易中的索引关联起来，怎么来确定交易索引与交易结果之间的关系？
            let index = if let  Phase::ApplyExtrinsic(index) = event.phase{
                index
            }else { 0 };
            let mut ex = TransferEvent{
                index,
                ..Default::default()
            };
            match event.event {

                Event::balances(be) => {
                    match &be {
                        balances::RawEvent::Transfer(transactor, dest, value) => {
                            ex.update_transfer_detail(&transactor.to_ss58check(),&dest.to_ss58check(),*value);
                            all_extrinsic.entry(index).or_insert(ex);
                        }
                        _ => {
                            log::error!("ignoring unsupported balances event");
                        }
                    }
                },
                Event::system(se) => {
                    if index==0 {
                        continue
                    }
                    match &se {
                        system::RawEvent::ExtrinsicSuccess(dispath) => {
                            ex.update_result(true);
                            all_extrinsic.entry(index).and_modify(|event|event.result = true).or_insert(ex);
                        },
                        system::RawEvent::ExtrinsicFailed(err, info) => {
                            ex.update_result(false);
                            all_extrinsic.entry(index).and_modify(|event|event.result = false).or_insert(ex);

                        },
                        _ => log::error!("ignoring unsupported balances event")
                    }
                },
                _ => log::error!("ignoring unsupported balances event")
            }
        }
    }
    all_extrinsic
}

#[test]
fn data_decode_test(){
    let encode_event = r#"0x0800000000000000102700000101000001000000000103050340420f00000100"#;
   // let encode_event = r#"0x140000000000000010270000010100000100000000038e50224acdcc7591c0e9a28ab7d91c099574f8d47f3a35a542dbaebf1ec5f30c00000100000002008e50224acdcc7591c0e9a28ab7d91c099574f8d47f3a35a542dbaebf1ec5f30c00c06e31d910010000000000000000000000010000000202ea990fcb7e9600adcf735a69d7bbcbaa62e52d2eb26125381379a91558fe083b8e50224acdcc7591c0e9a28ab7d91c099574f8d47f3a35a542dbaebf1ec5f30c00c06e31d91001000000000000000000000001000000000040420f00000100"#;
        let res = event_decode(encode_event,"","");
        println!("res detail:{:?}",res);
    }



