use rbatis::crud::CRUDEnable;
use rbatis_macro_driver::CRUDEnable;
use serde::Deserialize;
use serde::Serialize;
use strum_macros::EnumIter;

use wallets_macro::{db_append_shared, DbBeforeSave, DbBeforeUpdate};

use crate::kits;
use crate::ma::dao::{self, Shared};
use crate::ma::MTokenShared;

#[derive(PartialEq, Clone, Debug, EnumIter)]
pub enum EthTokenType {
    Eth,
    Erc20,
}

impl EthTokenType {
    fn from(token_type: &str) -> Option<Self> {
        match token_type {
            "Eth" => Some(EthTokenType::Eth),
            "Erc20" => Some(EthTokenType::Erc20),
            _ => {
                log::error!("the str:{} can not be EthTokenType",token_type);
                None
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

    pub token_type: String,
    ///
    pub erc20: String,
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
    ///
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
#[db_append_shared]
#[derive(Serialize, Deserialize, Clone, Debug, Default, CRUDEnable, DbBeforeSave, DbBeforeUpdate)]
pub struct MEthChainTokenDefault {
    /// [crate::db::TokenShared]
    #[serde(default)]
    pub chain_token_shared_id: String,
    ///
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
    use strum::IntoEnumIterator;

    use crate::ma::EthTokenType;

    #[test]
    fn eth_token_type_test() {
        for it in EthTokenType::iter() {
            assert_eq!(it, EthTokenType::from(&it.to_string()));
        }
    }
}