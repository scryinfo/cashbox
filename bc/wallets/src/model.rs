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

const DEFALUE_DIDIT_CHAIN_ID :i64= 3;

#[derive(Debug,Clone)]
pub struct Address {
    pub chain_type: ChainType,
    pub pubkey: String,
    pub addr: String,
}

/// Description of a Digit
/// 用于默认代币的导入
#[derive(Debug, Default, Clone, PartialEq, Deserialize, Serialize)]
pub struct DefaultDigit {
    pub id:Option<String>,
    #[serde(rename = "contractAddress")]
    pub contract_address: Option<String>,
    #[serde(rename = "shortName")]
    pub short_name: String,
    #[serde(rename = "fullName")]
    pub full_name: String,
    pub group_name: Option<String>,
    pub decimal: String,//todo 修改为数字型
    #[serde(rename = "chainType")]
    pub chain_type:String,
    #[serde(rename = "urlImg")]
    pub img_url: Option<String>,
    pub is_basic:Option<bool>,
    pub is_default:Option<bool>,
    pub status:Option<i64>,

}

/// Description of a Digit
/// 用于认证代币的导入
#[derive(Debug, Default, Clone, PartialEq, Deserialize, Serialize)]
pub struct EthToken {
    pub id:String,
    #[serde(rename = "contractAddress")]
    pub contract:String,
    #[serde(rename = "acceptId")]
    pub accept_id:Option<String>,
    #[serde(rename = "chainType")]
    pub chain_type:String,
    #[serde(rename = "shortName")]
    pub symbol:String,//简写名称
    #[serde(rename = "fullName")]
    pub name:String,//完整的名称
    pub publisher:Option<String>,
    pub project:Option<String>,
    #[serde(rename = "urlImg")]
    pub logo_url:String,
    #[serde(rename = "logoBytes")]
    pub logo_bytes:Option<String>,
    pub decimal:String,
    #[serde(rename = "gasLimit")]
    pub gas_limit:Option<i64>,
    pub mark:Option<String>,
    pub version:Option<i64>,
    #[serde(rename = "createTime")]
    pub create_time:Option<i64>,
    #[serde(rename = "updateTime")]
    pub update_time:Option<i64>,

}

#[derive(Debug, Default, Clone)]
pub struct DigitList{
    pub count:u32,
    pub eth_tokens:Vec<EthToken>,
}

#[derive(Debug, Default, Clone)]
pub struct SyncStatus{
    pub account:String,
    pub block_hash:String,
    pub block_num:i64,
    pub chain_type:i64,
}

