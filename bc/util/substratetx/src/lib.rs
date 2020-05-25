#[macro_use]
extern crate serde_derive;

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
fn event_key_test(){
    println!("hash key:{}",transaction::event_key());
}



