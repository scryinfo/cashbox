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
pub struct DigitExport{
    pub id:Option<String>,
    #[serde(rename = "contractAddress")]
    pub contract_address: Option<String>,
    #[serde(rename = "shortName")]
    pub short_name: String,
    #[serde(rename = "fullName")]
    pub full_name: String,
    pub group_name: Option<String>,
    pub decimal: i64,
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
pub struct AuthDigit{
    pub id:String,
    pub contract:String,
    #[serde(rename = "acceptId")]
    pub accept_id:String,
    #[serde(rename = "chainType")]
    pub chain_type:String,
    pub symbol:String,//简写名称
    pub name:String,//完整的名称
    pub publisher:String,
    pub project:String,
    #[serde(rename = "logoUrl")]
    pub logo_url:String,
    #[serde(rename = "logoBytes")]
    pub logo_bytes:String,
    pub decimal:i64,
    #[serde(rename = "gasLimit")]
    pub gas_limit:i64,
    pub mark:String,
    pub version:i64,
    #[serde(rename = "createTime")]
    pub create_time:i64,
    #[serde(rename = "updateTime")]
    pub update_time:i64,

}

#[derive(Debug, Default, Clone)]
pub struct DigitList{
    pub count:u32,
    pub auth_digit:Vec<AuthDigit>,
}
#[derive(Debug,Clone)]
pub  struct DigitItem{
    pub digit_id: Option<String>,
    pub contract_address: Option<String>,
    pub chain_id: i64,
    pub short_name: Option<String>,
    pub full_name: Option<String>,
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
            short_name:None,
            full_name:None,
            is_visible:Some(true),
            decimal:Some(18),
            imgurl:None,
        }
    }
}

