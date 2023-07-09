use std::fmt;

// use rbatis::crud::CRUDTable;
// use rbatis_macro_driver::CRUDTable;
use serde::Deserialize;
use serde::Serialize;
use strum_macros::EnumIter;

use wallets_macro::{db_append_shared, DbBeforeSave, DbBeforeUpdate};

use crate::kits;
use crate::ma::dao::{self, Shared};
use crate::ma::TxShared;

//eth

/// eth链的token
#[db_append_shared]
#[derive(PartialEq, Serialize, Deserialize, Clone, Debug, Default, DbBeforeSave, DbBeforeUpdate)]
pub struct MEthChainToken {
    #[serde(default)]
    pub next_id: String,
    /// 手动加入的token就没有token shared内容
    /// [crate::ma::MEthChainTokenShared]
    #[serde(default)]
    pub chain_token_shared_id: String,
    /// [crate::ma::MWallet]
    #[serde(default)]
    pub wallet_id: String,
    /// [crate::ChainType]
    #[serde(default)]
    pub chain_type: String,
    #[serde(default)]
    pub contract_address: String,
    /// 是否显示
    //#[serde(default, deserialize_with = "bool_from_u32", serialize_with = "bool_to_u32")]
    #[serde(default)]
    pub show: u32,
    /// 精度
    #[serde(default)]
    pub decimal: i32,
}

impl MEthChainToken {
    pub const fn create_table_script() -> &'static str {
        std::include_str!("../../../sql/m_eth_chain_token.sql")
    }
}

/// eth chain的交易，包含eth，erc20等
#[db_append_shared()]
#[derive(PartialEq, Serialize, Deserialize, Clone, Debug, Default, DbBeforeSave, DbBeforeUpdate)]
pub struct MEthChainTx {
    #[serde(flatten)]
    pub tx_shared: TxShared,
    #[serde(default)]
    pub wallet_account: String,
    /// [crate::TxStatus]
    #[serde(default)]
    pub status: String,
    /// 链上的时间戳
    #[serde(default)]
    pub tx: i64,
    /// from是数据库的关键字，所以加上 address
    /// 这是签名地址
    #[serde(default)]
    pub from_address: String,
    /// 接收到token的地址，如果为erc20时，此地址为空
    #[serde(default)]
    pub to_address: String,
    #[serde(default)]
    pub value: String,
    #[serde(default)]
    pub fee: String,
    #[serde(default)]
    pub gas_price: String,
    #[serde(default)]
    pub gas_limit: i64,
    #[serde(default)]
    pub nonce: String,
    /// 原始的input data
    #[serde(default)]
    pub input_data: String,
    /// 解析过的扩展数据，这里eth与erc20的处理是不一样的
    #[serde(default)]
    pub extension: String,
}

impl MEthChainTx {
    pub const fn create_table_script() -> &'static str {
        std::include_str!("../../../sql/m_eth_chain_tx.sql")
    }
}

/// 类型以[ERC-20](https://eips.ethereum.org/EIPS/eip-20)规范中的命名，所以要保持定义的值，不能作命名转换
///
/// 这只列出会产生交易的接口
#[derive(PartialEq, Clone, Debug, EnumIter)]
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

#[db_append_shared]
#[derive(PartialEq, Serialize, Deserialize, Clone, Debug, Default, DbBeforeSave, DbBeforeUpdate)]
pub struct MEthErc20Tx {
    #[serde(default)]
    pub eth_chain_tx_id: String,
    #[serde(default)]
    pub contract_address: String,
    /// [Erc20::transfer] 与 [Erc20::transferFrom]此地址有值，其余为""
    #[serde(default)]
    pub to_address: String,
    #[serde(default)]
    pub token: String,
    /// [Erc20]
    #[serde(default)]
    pub erc20_face: String,
}

impl MEthErc20Tx {
    pub const fn create_table_script() -> &'static str {
        std::include_str!("../../../sql/m_eth_erc20_tx.sql")
    }
}

//eth end

#[cfg(test)]
mod tests {
    use futures::executor::block_on;
    use rbatis::crud::CRUDTable;
    use rbatis::rbatis::Rbatis;
    use strum::IntoEnumIterator;

    use crate::ChainType;
    use crate::kits::test::make_memory_rbatis_test;
    use crate::ma::{Dao, Db, DbCreateType, EthErc20Face, MEthChainToken, MEthChainTx, MEthErc20Tx};

    #[test]
    fn eth_erc20_face_test() {
        for it in EthErc20Face::iter() {
            assert_eq!(it, EthErc20Face::from(&it.to_string()));
        }
    }

    #[test]
    fn m_eth_chain_token_test() {
        let rb = block_on(init_memory());
        let re = block_on(MEthChainToken::list(&rb, ""));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let mut m = MEthChainToken::default();
        m.chain_type = ChainType::EEE.to_string();
        m.wallet_id = "wallet_id".to_owned();

        let re = block_on(m.save(&rb, ""));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let re = block_on(MEthChainToken::list(&rb, ""));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let ms = re.unwrap();
        assert_eq!(1, ms.len(), "{:?}", ms);

        let db_m = &ms.as_slice()[0];
        assert_eq!(&m, db_m);

        let re = block_on(MEthChainToken::fetch_by_id(&rb, "", &m.id));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let db_m = re.unwrap().unwrap();
        assert_eq!(m, db_m);
    }

    #[test]
    fn m_eth_chain_tx_test() {
        let rb = block_on(init_memory());
        let re = block_on(MEthChainTx::list(&rb, ""));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let mut m = MEthChainTx::default();
        m.value = "value".to_owned();

        let re = block_on(m.save(&rb, ""));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let re = block_on(MEthChainTx::list(&rb, ""));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let ms = re.unwrap();
        assert_eq!(1, ms.len(), "{:?}", ms);

        let db_m = &ms.as_slice()[0];
        assert_eq!(&m, db_m);

        let re = block_on(MEthChainTx::fetch_by_id(&rb, "", &m.id));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let db_m = re.unwrap().unwrap();
        assert_eq!(m, db_m);
    }

    #[test]
    fn m_eth_erc20_tx_test() {
        let rb = block_on(init_memory());
        let re = block_on(MEthErc20Tx::list(&rb, ""));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let mut m = MEthErc20Tx::default();
        m.token = "token".to_owned();

        let re = block_on(m.save(&rb, ""));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let re = block_on(MEthErc20Tx::list(&rb, ""));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let ms = re.unwrap();
        assert_eq!(1, ms.len(), "{:?}", ms);

        let db_m = &ms.as_slice()[0];
        assert_eq!(&m, db_m);

        let re = block_on(MEthErc20Tx::fetch_by_id(&rb, "", &m.id));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let db_m = re.unwrap().unwrap();
        assert_eq!(m, db_m);
    }

    async fn init_memory() -> Rbatis {
        let rb = make_memory_rbatis_test().await;
        let r = Db::create_table(&rb, MEthChainToken::create_table_script(), &MEthChainToken::table_name(), &DbCreateType::Drop).await;
        assert_eq!(false, r.is_err(), "{:?}", r);
        let r = Db::create_table(&rb, MEthChainTx::create_table_script(), &MEthChainTx::table_name(), &DbCreateType::Drop).await;
        assert_eq!(false, r.is_err(), "{:?}", r);
        let r = Db::create_table(&rb, MEthErc20Tx::create_table_script(), &MEthErc20Tx::table_name(), &DbCreateType::Drop).await;
        assert_eq!(false, r.is_err(), "{:?}", r);
        rb
    }
}
