use rbatis_macro_driver::CRUDTable;
use serde::Deserialize;
use serde::Serialize;
use strum_macros::EnumIter;

use wallets_macro::{db_append_shared, DbBeforeSave, DbBeforeUpdate};

use crate::kits;
use crate::ma::dao::{self, Shared};

/// 动态库自己的配置，并不指app的配置
#[db_append_shared]
#[derive(PartialEq, Serialize, Deserialize, Clone, Debug, Default, CRUDTable, DbBeforeSave, DbBeforeUpdate)]
pub struct MSetting {
    #[serde(default)]
    pub key_str: String,
    /// 由于value可能会是数据库的关键字，所以加上str
    #[serde(default)]
    pub value_str: String,
}

impl MSetting {
    pub const fn create_table_script() -> &'static str {
        std::include_str!("../../../sql/m_setting.sql")
    }
}

#[derive(PartialEq, Debug, EnumIter)]
pub enum SettingType {
    CurrentWallet,
    CurrentChain,
    CurrentDbVersion,
    Other(String),
}

impl From<&str> for SettingType {
    fn from(setting_type: &str) -> Self {
        match setting_type {
            "CurrentWallet" => SettingType::CurrentWallet,
            "CurrentChain" => SettingType::CurrentChain,
            "CurrentDbVersion" => SettingType::CurrentDbVersion,
            _ => {
                SettingType::Other(setting_type.to_owned())
            }
        }
    }
}

impl From<&String> for SettingType {
    fn from(setting_type: &String) -> Self {
        SettingType::from(setting_type.as_str())
    }
}

impl ToString for SettingType {
    fn to_string(&self) -> String {
        match &self {
            SettingType::CurrentWallet => "CurrentWallet".to_owned(),
            SettingType::CurrentChain => "CurrentChain".to_owned(),
            SettingType::CurrentDbVersion => "CurrentDbVersion".to_owned(),
            SettingType::Other(key) => key.clone(),
        }
    }
}

#[cfg(test)]
mod tests {
    use strum::IntoEnumIterator;

    use crate::ma::SettingType;

    #[test]
    fn setting_type_test() {
        for it in SettingType::iter() {
            assert_eq!(it, SettingType::from(&it.to_string()));
        }
    }
}