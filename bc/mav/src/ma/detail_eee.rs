use rbatis::crud::CRUDTable;
use rbatis_macro_driver::CRUDTable;
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
    TokenX,
}

impl EeeTokenType {
    #[allow(dead_code)]
    fn from(token_type: &str) -> Result<Self, kits::Error> {
        match token_type {
            "Eee" => Ok(EeeTokenType::Eee),
            "TokenX" => Ok(EeeTokenType::TokenX),
            _ => {
                let err = format!("the str:{} can not be EeeTokenType", token_type);
                log::error!("{}", err);
                Err(kits::Error::from(err.as_str()))
            }
        }
    }
}

impl ToString for EeeTokenType {
    fn to_string(&self) -> String {
        match &self {
            EeeTokenType::Eee => "Eee".to_owned(),
            EeeTokenType::TokenX => "TokenX".to_owned(),
        }
    }
}

// eee
#[db_append_shared(CRUDTable)]
#[derive(PartialEq, Serialize, Deserialize, Clone, Debug, Default, DbBeforeSave, DbBeforeUpdate)]
pub struct MEeeChainTokenShared {
    #[serde(flatten)]
    pub token_shared: MTokenShared,
    #[serde(default)]
    pub token_type: String,
    #[serde(default)]
    pub gas_price: String,
    /// 交易时默认的gas limit
    #[serde(default)]
    pub gas_limit: i64,
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
#[derive(PartialEq, Serialize, Deserialize, Clone, Debug, Default, CRUDTable, DbBeforeSave, DbBeforeUpdate)]
pub struct MEeeChainTokenAuth {
    /// [EeeChainTokenShared]
    #[serde(default)]
    pub chain_token_shared_id: String,
    #[serde(default)]
    pub net_type: String,
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
#[db_append_shared(CRUDTable)]
#[derive(PartialEq, Serialize, Deserialize, Clone, Debug, Default, DbBeforeSave, DbBeforeUpdate)]
pub struct MEeeChainTokenDefault {
    /// [EeeChainTokenShared]
    #[serde(default)]
    pub chain_token_shared_id: String,
    #[serde(default)]
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
    use futures::executor::block_on;
    use rbatis::crud::CRUDTable;
    use rbatis::rbatis::Rbatis;
    use strum::IntoEnumIterator;

    use crate::kits::test::make_memory_rbatis_test;
    use crate::ma::{Dao, Db, DbCreateType, EeeTokenType, MEeeChainTokenAuth, MEeeChainTokenDefault, MEeeChainTokenShared};
    use crate::NetType;

    #[test]
    fn eee_token_type_test() {
        for it in EeeTokenType::iter() {
            assert_eq!(it, EeeTokenType::from(&it.to_string()).unwrap());
        }
    }

    #[test]
    fn m_eee_chain_token_default_test() {
        let rb = block_on(init_memory());
        let re = block_on(MEeeChainTokenDefault::list(&rb, ""));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let mut token = MEeeChainTokenDefault::default();
        token.chain_token_shared_id = "chain_token_shared_id".to_owned();
        token.net_type = NetType::Main.to_string();
        token.position = 1;

        let re = block_on(token.save(&rb, ""));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let re = block_on(MEeeChainTokenDefault::list(&rb, ""));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let tokens = re.unwrap();
        assert_eq!(1, tokens.len(), "{:?}", tokens);

        let db_token = &tokens.as_slice()[0];
        assert_eq!(&token, db_token);

        let re = block_on(MEeeChainTokenDefault::fetch_by_id(&rb, "", &token.id));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let db_token = re.unwrap().unwrap();
        assert_eq!(token, db_token);
    }

    #[test]
    fn m_eee_chain_token_shared_test() {
        let rb = block_on(init_memory());
        let re = block_on(MEeeChainTokenShared::list(&rb, ""));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let mut token = MEeeChainTokenShared::default();
        token.token_type = EeeTokenType::Eee.to_string();
        token.decimal = 18;
        token.token_shared.project_name = "test".to_owned();
        token.token_shared.project_home = "http://".to_owned();
        token.token_shared.project_note = "test".to_owned();
        token.token_shared.logo_bytes = "bytes".to_owned();
        token.token_shared.logo_url = "http://".to_owned();
        token.token_shared.symbol = "EEE".to_owned();
        token.token_shared.name = "EEE".to_owned();

        let re = block_on(token.save(&rb, ""));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let re = block_on(MEeeChainTokenShared::list(&rb, ""));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let tokens = re.unwrap();
        assert_eq!(1, tokens.len(), "{:?}", tokens);

        let db_token = &tokens.as_slice()[0];
        assert_eq!(&token, db_token);

        let re = block_on(MEeeChainTokenShared::fetch_by_id(&rb, "", &token.id));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let db_token = re.unwrap().unwrap();
        assert_eq!(token, db_token);
    }

    #[test]
    fn m_eee_chain_token_auth_test() {
        let rb = block_on(init_memory());
        let re = block_on(MEeeChainTokenAuth::list(&rb, ""));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let mut token = MEeeChainTokenAuth::default();
        token.chain_token_shared_id = "chain_token_shared_id".to_owned();
        token.net_type = NetType::Main.to_string();
        token.position = 1;

        let re = block_on(token.save(&rb, ""));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let re = block_on(MEeeChainTokenAuth::list(&rb, ""));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let tokens = re.unwrap();
        assert_eq!(1, tokens.len(), "{:?}", tokens);

        let db_token = &tokens.as_slice()[0];
        assert_eq!(&token, db_token);

        let re = block_on(MEeeChainTokenAuth::fetch_by_id(&rb, "", &token.id));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let db_token = re.unwrap().unwrap();
        assert_eq!(token, db_token);
    }

    async fn init_memory() -> Rbatis {
        let rb = make_memory_rbatis_test().await;
        let r = Db::create_table(&rb, MEeeChainTokenDefault::create_table_script(), &MEeeChainTokenDefault::table_name(), &DbCreateType::Drop).await;
        assert_eq!(false, r.is_err(), "{:?}", r);
        let r = Db::create_table(&rb, MEeeChainTokenShared::create_table_script(), &MEeeChainTokenShared::table_name(), &DbCreateType::Drop).await;
        assert_eq!(false, r.is_err(), "{:?}", r);
        let r = Db::create_table(&rb, MEeeChainTokenAuth::create_table_script(), &MEeeChainTokenAuth::table_name(), &DbCreateType::Drop).await;
        assert_eq!(false, r.is_err(), "{:?}", r);
        rb
    }
}
