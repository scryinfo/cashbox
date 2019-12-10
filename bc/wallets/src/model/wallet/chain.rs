use super::*;

pub mod digit;

#[repr(C)]
#[derive(Clone,Default)]
pub struct EeeChain {
    pub status: StatusCode,
    pub chain_id: String,
    pub wallet_id: String,
    pub address: String,
    pub domain: Option<String>,
    pub is_visible: Option<bool>,
    pub chain_type: Option<ChainType>,
    pub digit_list: Vec<digit::EeeDigit>,
}

#[repr(C)]
#[derive(Clone,Default)]
pub struct EthChain {
    pub status: StatusCode,
    pub chain_id: String,
    pub wallet_id: String,
    pub address: String,
    pub domain: Option<String>,
    pub is_visible: Option<bool>,
    pub chain_type: Option<ChainType>,
    pub digit_list: Vec<digit::EthDigit>,
}


#[repr(C)]
#[derive(Clone,Default)]
pub struct BtcChain {
    pub status: StatusCode,
    pub chain_id: String,
    pub wallet_id: String,
    pub address: String,
    pub domain: Option<String>,
    pub is_visible: Option<bool>,
    pub chain_type: Option<ChainType>,
    pub digit_list: Vec<digit::BtcDigit>,
}

