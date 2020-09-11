use super::*;
use std::fmt;

///Define the wallet data structure that interacts with the App
///
#[repr(C)]
pub struct Mnemonic {
    pub status: StatusCode,
    pub mnid: String,
    pub mn: Vec<u8>,
}

#[repr(C)]
#[derive(Default)]
pub struct Wallet {
    pub status: StatusCode,
    pub wallet_id: String,
    pub wallet_type: i64,
    //This value does not exist in the case of Null
    pub wallet_name: Option<String>,
    pub display_chain_id: i64,
    pub selected: bool,
    pub create_time: String,
    pub eee_chain: Option<EeeChain>,
    pub eth_chain: Option<EthChain>,
    pub btc_chain: Option<BtcChain>,
}

impl fmt::Debug for Wallet {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "Wallet {{ status: {}, wallet_id: {},wallet_type:{},wallet_name:{:?} }}", self.status.clone() as u32, self.wallet_id, self.wallet_type, self.wallet_name)
    }
}

#[repr(C)]
#[derive(Clone, Default)]
pub struct EeeChain {
    pub status: StatusCode,
    pub chain_id: String,
    pub wallet_id: String,
    pub address: String,
    pub pub_key:String,
    pub domain: Option<String>,
    pub is_visible: Option<bool>,
    pub chain_type: Option<ChainType>,
    pub digit_list: Vec<EeeDigit>,
}

#[repr(C)]
#[derive(Clone, Default)]
pub struct EthChain {
    pub status: StatusCode,
    pub chain_id: String,
    pub wallet_id: String,
    pub address: String,
    pub pub_key:String,
    pub domain: Option<String>,
    pub is_visible: Option<bool>,
    pub chain_type: Option<ChainType>,
    pub digit_list: Vec<EthDigit>,
}


#[repr(C)]
#[derive(Clone, Default)]
pub struct BtcChain {
    pub status: StatusCode,
    pub chain_id: String,
    pub wallet_id: String,
    pub address: String,
    pub pub_key:String,
    pub domain: Option<String>,
    pub is_visible: Option<bool>,
    pub chain_type: Option<ChainType>,
    pub digit_list: Vec<BtcDigit>,
}

#[repr(C)]
#[derive(Clone)]
pub struct EeeDigit {
    pub status: StatusCode,
    pub digit_id: String,
    pub chain_id: String,
    // pub address: Option<String>,
    pub contract_address: Option<String>,
    pub fullname: Option<String>,
    pub shortname: Option<String>,
    pub balance: Option<String>,
    pub is_visible: Option<bool>,
    pub decimal: Option<i64>,
    pub imgurl: Option<String>,
}

#[repr(C)]
#[derive(Clone)]
pub struct EthDigit {
    pub status: StatusCode,
    pub digit_id: String,
    pub chain_id: String,
    //pub address: Option<String>,
    pub contract_address: Option<String>,
    pub fullname: Option<String>,
    pub shortname: Option<String>,
    pub balance: Option<String>,
    pub is_visible: Option<bool>,
    pub decimal: Option<i64>,
    pub imgurl: Option<String>,
}

#[repr(C)]
#[derive(Clone)]
pub struct BtcDigit {
    pub status: StatusCode,
    pub digit_id: String,
    pub chain_id: String,
    //  pub address: Option<String>,
    pub contract_address: Option<String>,
    pub fullname: Option<String>,
    pub shortname: Option<String>,
    pub balance: Option<String>,
    pub is_visible: Option<bool>,
    pub decimal: Option<i64>,
    pub imgurl: Option<String>,
}













