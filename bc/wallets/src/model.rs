// 该模块用于定义module database 层级之间的交互对象的定义

use super::*;

//用于定义与device_app_lib交互的数据格式
pub mod wallet;
//用于定义数据存储的结构
pub mod wallet_store;

pub use wallet::{Wallet,Mnemonic};
pub use wallet::chain::{BtcChain,EthChain,EeeChain};
pub use wallet::chain::digit::{EeeDigit,EthDigit,BtcDigit};
pub use wallet_store::{TbAddress,WalletObj};

#[derive(Debug,Clone)]
pub struct Address {
    pub chain_type: ChainType,
    pub pubkey: String,
    pub addr: String,
}
const DEFALUE_DIDIT_CHAIN_ID :i64= 3;
#[derive(Debug,Clone)]
pub  struct DigitItem{
    pub digit_id: Option<String>,
    pub contract_address: Option<String>,
    pub chain_id: i64,
    pub shortname: Option<String>,
    pub fullname: Option<String>,
    pub is_visible: Option<bool>,
    pub decimal: Option<i64>,
    pub imgurl: Option<String>,
}

impl Default for DigitItem{
    fn default() -> Self {
        DigitItem{
            digit_id:None,
            contract_address:None,
            chain_id:DEFALUE_DIDIT_CHAIN_ID,
            shortname:None,
            fullname:None,
            is_visible:Some(true),
            decimal:Some(18),
            imgurl:None,
        }
    }
}

