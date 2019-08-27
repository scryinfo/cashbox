use super::walletstore;
use super::account_generate::*;
use super::walletstore::{TbMnemonic, TbWallet};
use crate::{StatusCode, ChainType};


#[repr(C)]
pub struct Mnemonic {
    pub status: StatusCode,
    pub mnid: String,
    pub mn: Vec<u8>,
    pub chain_list: Vec<Chain>,

}

#[repr(C)]
pub struct Address {
    pub chain_type: ChainType,
    pub pubkey: String,
    pub addr: String,
    pub pri_key: Vec<u8>,
}

#[repr(C)]
pub struct Chain {
    pub status: StatusCode,
    pub chain_id: String,
    pub wallet_id: String,
    pub chain_address: Option<String>,
    pub is_visible: Option<bool>,
    pub chain_type: Option<ChainType>,
    pub digit_list: Vec<Digit>,
}

#[repr(C)]
pub struct Digit {
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
pub struct Wallet {
    pub status: StatusCode,
    pub wallet_id: String,
    //这个值不会存在Null 的情况
    pub wallet_name: Option<String>,
    pub chain_list: Vec<Chain>,
}

const SCRYPT_LOG_N: u8 = 5;
//调试 将迭代次数降低
const SCRYPT_P: u32 = 1;
//u32 的数据类型为使用scrypt这个库中定义
const SCRYPT_R: u32 = 8;
const SCRYPT_DKLEN: usize = 32;
const CIPHER_KEY_SIZE: &'static str = "aes-128-ctr";

pub mod chain;
pub mod digit;
pub mod wallet;
