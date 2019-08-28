use super::*;

pub mod chain;

#[repr(C)]
pub struct Mnemonic {
    pub status: StatusCode,
    pub mnid: String,
    pub mn: Vec<u8>,
}

#[repr(C)]
pub struct Wallet {
    pub status: StatusCode,
    pub wallet_id: String,
    //这个值不会存在Null 的情况
    pub wallet_name: Option<String>,
    pub eee_chain: Vec<chain::EeeChain>,
    pub eth_chain: Vec<chain::EthChain>,
    pub btc_chain: Vec<chain::BtcChain>,
}











