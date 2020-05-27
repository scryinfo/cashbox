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


pub struct TransferEvent{
    pub index:u32,
    pub from:Option<String>,
    pub to:Option<String>,
    pub value:Option<String>,
    pub result:Option<bool>,
}


// 通知事件数据 使用hex 方式编码的字符串  传递解析的交易详情，交易结果
fn event_decode(event_data:&str,blackhash:&str,account:&str) {
    let enents_bytes = hex::decode(event_data.get(2..).unwrap()).unwrap();
    println!("{:?}", enents_bytes);
    let events = Vec::<system::EventRecord<Event, H256>>::decode(&mut &enents_bytes[..]);
    for record in events {
        for event in record {
            //todo 将索引与区块交易中的索引关联起来，怎么来确定交易索引与交易结果之间的关系？
            if let  Phase::ApplyExtrinsic(index) = event.phase{
                println!("extrinsic index is:{:?}", index);
            }
            match event.event {
                Event::balances(be) => {
                    match &be {
                        balances::RawEvent::Transfer(transactor, dest, value) => {
                            println!("Transactor: {}", transactor);
                            println!("Destination: {}", dest);
                            println!("Value: {:?}", value);
                            // return;
                        }
                        _ => {
                            log::error!("ignoring unsupported balances event");
                        }
                    }
                },
                Event::system(se) => {
                    match &se {
                        system::RawEvent::ExtrinsicSuccess(dispath) => println!("ExtrinsicSuccess:{:?}", dispath),
                        system::RawEvent::ExtrinsicFailed(err, info) => {
                            println!("ExtrinsicFailed:{:?},{:?}", err, info)
                        },
                        _ => log::error!("ignoring unsupported balances event")
                    }
                },
                _ => log::error!("ignoring unsupported balances event")
            }
        }
    }
}

#[test]
fn data_decode_test(){
    let encode_event = r#"0x0800000000000000102700000101000001000000000103050340420f00000100"#;
        event_decode(encode_event,"","");
    }



