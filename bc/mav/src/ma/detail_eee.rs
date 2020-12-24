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
pub enum EeeTokenType {
    Eee,
}

impl EeeTokenType {
    fn from(token_type: &str) -> Result<Self, kits::Error> {
        match token_type {
            "Eee" => Ok(EeeTokenType::Eee),
            _ => {
                let err = format!("the str:{} can not be EeeTokenType", token_type);
                log::error!("{}",err);
                Err(kits::Error::from(err.as_str()))
            }
        }
    }
}

impl ToString for EeeTokenType {
    fn to_string(&self) -> String {
        match &self {
            EeeTokenType::Eee => "Eee".to_owned(),
        }
    }
}

// eee
#[db_append_shared(CRUDEnable)]
#[derive(Serialize, Deserialize, Clone, Debug, Default, DbBeforeSave, DbBeforeUpdate)]
pub struct MEeeChainTokenShared {
    #[serde(flatten)]
    pub token_shared: MTokenShared,

    pub token_type: String,
    //
    // pub contract_address: String,

    #[serde(default)]
    pub gas: i64,
    /// 精度
    #[serde(default)]
    pub decimal: i32,
}

impl MEeeChainTokenShared {
    pub const fn create_table_script() -> &'static str {
        std::include_str!("../../../sql/m_eee_chain_token_shared.sql")
    }
}

#[db_append_shared]
#[derive(Serialize, Deserialize, Clone, Debug, Default, CRUDEnable, DbBeforeSave, DbBeforeUpdate)]
pub struct MEeeChainTokenAuth {
    /// [EeeChainTokenShared]
    #[serde(default)]
    pub chain_token_shared_id: String,
    /// 显示位置，以此从小到大排列
    #[serde(default)]
    pub position: i64,
}

impl MEeeChainTokenAuth {
    pub const fn create_table_script() -> &'static str {
        std::include_str!("../../../sql/m_eee_chain_token_auth.sql")
    }
}

/// DefaultToken must be a [EeeChainTokenAuth]
#[db_append_shared(CRUDEnable)]
#[derive(Serialize, Deserialize, Clone, Debug, Default, DbBeforeSave, DbBeforeUpdate)]
pub struct MEeeChainTokenDefault {
    /// [EeeChainTokenShared]
    #[serde(default)]
    pub chain_token_shared_id: String,

    pub net_type: String,
    /// 显示位置，以此从小到大排列
    #[serde(default)]
    pub position: i64,

    #[serde(skip)]
    pub chain_token_shared: MEeeChainTokenShared,
}

impl MEeeChainTokenDefault {
    pub const fn create_table_script() -> &'static str {
        std::include_str!("../../../sql/m_eee_chain_token_default.sql")
    }
}
// eee end

#[cfg(test)]
mod tests {
    use strum::IntoEnumIterator;

    use crate::ma::EeeTokenType;

    #[test]
    fn eee_token_type_test() {
        for it in EeeTokenType::iter() {
            assert_eq!(it, EeeTokenType::from(&it.to_string()).unwrap());
        }
    }
}