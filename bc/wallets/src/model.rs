// This module is used to define the definition of interactive objects between module database levels
use super::*;

//Used to define the data format interacting with device_app_lib
mod wallet;

//Used to define the structure of data storage
pub mod wallet_store;

pub use wallet::{Wallet, Mnemonic};
pub use wallet::{BtcChain, EthChain, EeeChain};
pub use wallet::{EeeDigit, EthDigit, BtcDigit};
pub use wallet_store::{TbAddress, WalletObj};

/*const DEFALUE_DIDIT_CHAIN_ID :i64= 3;*/

#[derive(Debug, Clone)]
pub struct Address {
    pub chain_type: ChainType,
    pub pubkey: String,
    pub addr: String,
}

/// Description of a Digit
/// Used for import of default tokens
#[derive(Debug, Default, Clone, PartialEq, Deserialize, Serialize)]
pub struct DefaultDigit {
     pub id: Option<String>,
     #[serde(rename = "contractAddress")]
     pub contract_address: Option<String>,
     #[serde(rename = "shortName")]
     pub short_name: String,
     #[serde(rename = "fullName")]
     pub full_name: String,
     pub group_name: Option<String>,
     pub decimal: String,
     #[serde(rename = "chainType")]
     pub chain_type: String,
     #[serde(rename = "urlImg")]
     pub img_url: Option<String>,
     pub is_basic: Option<bool>,
     pub is_default: Option<bool>,
     pub status: Option<i64>,

}

/// Description of a Digit
/// Import of authentication tokens
#[derive(Debug, Default, Clone, PartialEq, Deserialize, Serialize)]
pub struct EthToken {
    pub id: String,
    #[serde(rename = "contractAddress")]
    pub contract: String,
    #[serde(rename = "acceptId")]
    pub accept_id: Option<String>,
    #[serde(rename = "chainType")]
    pub chain_type: String,
    #[serde(rename = "shortName")]
    pub symbol: String,
    //Abbreviated name
     #[serde(rename = "fullName")]
     pub name: String,
     //Complete name
    pub publisher: Option<String>,
    pub project: Option<String>,
    #[serde(rename = "urlImg")]
    pub logo_url: String,
    #[serde(rename = "logoBytes")]
    pub logo_bytes: Option<String>,
    pub decimal: String,
    #[serde(rename = "gasLimit")]
    pub gas_limit: Option<i64>,
    pub mark: Option<String>,
    pub version: Option<i64>,
    #[serde(rename = "createTime")]
    pub create_time: Option<i64>,
    #[serde(rename = "updateTime")]
    pub update_time: Option<i64>,

}

#[derive(Debug, Default, Clone)]
pub struct DigitList {
    pub count: u32,
    pub eth_tokens: Vec<EthToken>,
}

#[derive(Debug, Default, Clone)]
pub struct SyncStatus {
    pub account: String,
    pub block_hash: String,
    pub block_num: i64,
    pub chain_type: i64,
}

#[derive(Debug, Default, Clone)]
pub struct EeeTxRecord{
    pub tx_hash:String,
    pub block_hash:String,
    pub from:Option<String>,
    pub to:Option<String>,
    pub value:Option<String>,
    pub ext_data:Option<String>,
    pub fees:Option<String>,
    pub signer:String,
    pub is_success:bool,
    pub timestamp:String,
}

#[derive(Debug, Default, Clone)]
pub struct SubChainBasicInfo {
    pub genesis_hash: String,
    pub metadata: String,
    pub runtime_version: i32,
    pub tx_version: i32,
    pub ss58_format: i32,
    pub token_decimals: i32,
    pub token_symbol: String,
}
