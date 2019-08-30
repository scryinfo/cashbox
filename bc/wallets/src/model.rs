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

pub struct Address {
    pub chain_type: ChainType,
    pub pubkey: String,
    pub addr: String,
}
