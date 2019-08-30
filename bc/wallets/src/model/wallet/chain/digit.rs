use super::*;

#[repr(C)]
#[derive(Clone)]
pub struct EeeDigit {
    pub status: StatusCode,
    pub digit_id: String,
    pub chain_id: String,
    pub address: Option<String>,
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
    pub address: Option<String>,
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
    pub address: Option<String>,
    pub contract_address: Option<String>,
    pub fullname: Option<String>,
    pub shortname: Option<String>,
    pub balance: Option<String>,
    pub is_visible: Option<bool>,
    pub decimal: Option<i64>,
    pub imgurl: Option<String>,
}
