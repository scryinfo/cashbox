use rbatis::crud::CRUDEnable;
use rbatis_macro_driver::CRUDEnable;
use serde::Deserialize;
use serde::Serialize;
use strum_macros::EnumIter;

use wallets_macro::{db_append_shared, DbBeforeSave, DbBeforeUpdate};

use crate::kits::{self};
use crate::ma::dao::{self, Shared};
use crate::ma::MTokenShared;

#[derive(PartialEq, Clone, Debug, EnumIter)]
pub enum EthTokenType {
    Eth,
    Erc20,
}

impl EthTokenType {
    fn from(token_type: &str) -> Result<Self, kits::Error> {
        match token_type {
            "Eth" => Ok(EthTokenType::Eth),
            "Erc20" => Ok(EthTokenType::Erc20),
            _ => {
                let err = format!("the str:{} can not be EthTokenType", token_type);
                log::error!("{}",err);
                Err(kits::Error::from(err.as_str()))
            }
        }
    }
}

impl ToString for EthTokenType {
    fn to_string(&self) -> String {
        match &self {
            EthTokenType::Eth => "Eth".to_owned(),
            EthTokenType::Erc20 => "Erc20".to_owned(),
        }
    }
}

//eth
#[db_append_shared(CRUDEnable)]
#[derive(Serialize, Deserialize, Clone, Debug, Default, DbBeforeSave, DbBeforeUpdate)]
pub struct MEthChainTokenShared {
    #[serde(flatten)]
    pub token_shared: MTokenShared,
    #[serde(default)]
    pub token_type: String,
    ///如果是eth，那么合约地址为零长度字符串
    #[serde(default)]
    pub contract_address: String,

    /// 交易时默认的gas limit
    #[serde(default)]
    pub gas_limit: i64,
    /// 交易时默认的gas price
    #[serde(default)]
    pub gas_price: String,
    /// 糖度
    #[serde(default)]
    pub decimal: i32,
}

impl MEthChainTokenShared {
    pub const fn create_table_script() -> &'static str {
        std::include_str!("../../../sql/m_eth_chain_token_shared.sql")
    }
}

#[db_append_shared]
#[derive(Serialize, Deserialize, Clone, Debug, Default, CRUDEnable, DbBeforeSave, DbBeforeUpdate)]
pub struct MEthChainTokenAuth {
    /// [EthChainTokenShared]
    #[serde(default)]
    pub chain_token_shared_id: String,
    #[serde(default)]
    pub net_type: String,
    /// 显示位置，以此从小到大排列
    #[serde(default)]
    pub position: i64,
}

impl MEthChainTokenAuth {
    pub const fn create_table_script() -> &'static str {
        std::include_str!("../../../sql/m_eth_chain_token_auth.sql")
    }
}

/// DefaultToken must be a [EthChainTokenAuth]
#[db_append_shared(CRUDEnable)]
#[derive(Serialize, Deserialize, Clone, Debug, Default, DbBeforeSave, DbBeforeUpdate)]
pub struct MEthChainTokenDefault {
    /// [crate::db::TokenShared]
    #[serde(default)]
    pub chain_token_shared_id: String,

    #[serde(default)]
    pub net_type: String,
    /// 显示位置，以此从小到大排列
    #[serde(default)]
    pub position: i64,

    ///这个是为了使用方便，它不会生成数据库字段
    #[serde(skip)]
    pub chain_token_shared: MEthChainTokenShared,
}

impl MEthChainTokenDefault {
    pub const fn create_table_script() -> &'static str {
        std::include_str!("../../../sql/m_eth_chain_token_default.sql")
    }
}
//eth end

#[cfg(test)]
mod tests {
    use futures::executor::block_on;
    use rbatis::crud::CRUDEnable;
    use rbatis::rbatis::Rbatis;
    use strum::IntoEnumIterator;

    use crate::kits::test::make_memory_rbatis_test;
    use crate::ma::{Dao, Db, DbCreateType, EthTokenType, MEthChainTokenDefault};

    #[test]
    fn eth_token_type_test() {
        for it in EthTokenType::iter() {
            assert_eq!(it, EthTokenType::from(&it.to_string()).unwrap());
        }
    }

    #[test]
    fn skip_test() {
        let bean: serde_json::Result<MEthChainTokenDefault> = serde_json::from_str("{}");
        if bean.is_err() {
            let err = bean.err().unwrap();
            println!("{}", err);
        }

        let rb = block_on(init_memory());
        let re = block_on(MEthChainTokenDefault::list(&rb, ""));
        assert_eq!(false, re.is_err(), "{:?}", re);
    }

    async fn init_memory() -> Rbatis {
        let rb = make_memory_rbatis_test().await;
        let r = Db::create_table(&rb, MEthChainTokenDefault::create_table_script(), &MEthChainTokenDefault::table_name(), &DbCreateType::Drop).await;
        assert_eq!(false, r.is_err(), "{:?}", r);
        rb
    }
}

