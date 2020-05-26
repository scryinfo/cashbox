#[macro_use]
extern crate serde_derive;

use codec::{Encode,Decode};

mod crypto;
mod transaction;
pub mod error;

pub use crypto::{Sr25519,Ed25519,Keccak256,Crypto};
pub use transaction::{tx_sign,transfer,decode_account_info,account_info_key};

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


#[test]
fn data_decode(){
    let encode_event = r#"0x1400000000000000c0257a090000000002000000010000000000000000000000000002000000020000000302d43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27dea990fcb7e9600adcf735a69d7bbcbaa62e52d2eb26125381379a91558fe083b00c06e31d910010000000000000000000000020000000c06609ba3070101000000000000000000000000020000000000c0769f0b00000000000000"#;
    let enent_bytes = hex::decode(encode_event.get(2..).unwrap()).unwrap();
    println!("{:?}",enent_bytes);

    let res = Decode::decode::<system::EventRecord<balances::Transfer,String>>(enent_bytes);
}



