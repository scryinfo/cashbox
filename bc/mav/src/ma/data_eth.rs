use std::fmt;
use crate::ma::{TxShared};

//eth

/// eth链的token
#[derive(Default, Clone)]
pub struct EthChainToken {
    //primary key
    pub id: String,
    pub next_id: String,
    /// 手动加入的token就没有token shared内容
    /// [crate::db::BtcChainTokenShared]
    pub chain_token_shared_id: Option<String>,
    /// [crate::db::Wallet]
    pub wallet_id: String,
    /// [crate::ChainType]
    pub chain_type: String,
    /// 是否显示
    pub show: bool,

    /// 交易时默认的gas limit
    pub gas_limit: i64,
    /// 交易时默认的gas price
    pub gas_price: String,
    /// 糖度
    pub decimal: i32,

}

/// eth chain的交易，包含eth，erc20等
#[derive(Default, Clone)]
pub struct EthChainTx {
    pub tx_shared: TxShared,

    /// [crate::TxStatus]
    pub status: String,
    /// 链上的时间戳
    pub tx: i64,
    /// from是数据库的关键字，所以加上 address
    /// 这是签名地址
    pub from_address: String,
    /// 接收到token的地址，如果为erc20时，此地址为空
    pub to_address: String,
    pub value: String,
    pub fee: String,
    pub gas_price: String,
    pub gas_limit: i64,
    pub nonce: String,
    /// 原始的input data
    pub input_data: String,

    /// 解析过的扩展数据，这里eth与erc20的处理是不一样的
    pub extension: String,
}

/// 类型以[ERC-20](https://eips.ethereum.org/EIPS/eip-20)规范中的命名，所以要保持定义的值，不能作命名转换
///
/// 这只列出会产生交易的接口
pub enum EthErc20Face {
    #[allow(non_camel_case_types)]transfer,
    #[allow(non_camel_case_types)]transferFrom,
    #[allow(non_camel_case_types)]approve,
    NotSupport,
}

impl From<&str> for EthErc20Face {
    fn from(erc20: &str) -> Self {
        match erc20 {
            "transfer" => EthErc20Face::transfer,
            "transferFrom" => EthErc20Face::transferFrom,
            "approve" => EthErc20Face::approve,
            _ => EthErc20Face::NotSupport
        }
    }
}

//有可能可以自动转换，如果以后发现不需要，就把它删除了
impl From<&String> for EthErc20Face {
    fn from(erc20: &String) -> Self {
        EthErc20Face::from(erc20.as_str())
    }
}

impl fmt::Display for EthErc20Face {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        let str =
            match *self {
                EthErc20Face::transfer => "transfer",
                EthErc20Face::transferFrom => "transferFrom",
                EthErc20Face::approve => "approve",
                EthErc20Face::NotSupport => "NotSupport",
            };
        write!(f, "{}", str)
    }
}

#[derive(Default, Clone)]
pub struct EthErc20Tx {
    pub id: String,
    pub eth_chain_tx_id: String,
    pub contract_address: String,
    /// [Erc20::transfer] 与 [Erc20::transferFrom]此地址有值，其余为""
    pub to_address: String,
    pub token: String,
    /// [Erc20]
    pub erc20_face: String,
}

//eth end