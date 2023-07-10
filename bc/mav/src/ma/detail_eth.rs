// use rbatis::crud::CRUDTable;
// use rbatis_macro_driver::CRUDTable;
use serde::Deserialize;
use serde::Serialize;
use strum_macros::EnumIter;

use wallets_macro::{db_append_shared, DbBeforeSave, DbBeforeUpdate};
use async_trait::async_trait;

use crate::kits;
use crate::ma::dao::{self, Shared};
use crate::ma::MTokenShared;

#[derive(PartialEq, Clone, Debug, EnumIter)]
pub enum EthTokenType {
    Eth,
    Erc20,
}

impl EthTokenType {
    #[allow(dead_code)]
    fn from(token_type: &str) -> Result<Self, kits::Error> {
        match token_type {
            "Eth" => Ok(EthTokenType::Eth),
            "Erc20" => Ok(EthTokenType::Erc20),
            _ => {
                let err = format!("the str:{} can not be EthTokenType", token_type);
                log::error!("{}", err);
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
#[db_append_shared()] //
#[derive(PartialEq, Serialize, Deserialize, Clone, Debug, Default, DbBeforeSave, DbBeforeUpdate)]
pub struct MEthChainTokenShared {
    #[serde(flatten)]
    pub token_shared: MTokenShared,
    #[serde(default)]
    pub token_type: String,
    #[serde(default)]
    pub gas_limit: i64,
    #[serde(default)]
    pub gas_price: String,
    #[serde(default)]
    pub decimal: i32,
}
// .eq(MEeeChainTokenShared::token_type, &eth.token_type);
// MEthChainTokenShared::fetch_by_wrapper(rb, "", &wrapper).await?
rbatis::crud!(MEthChainTokenShared{});
rbatis::impl_select!(MEthChainTokenShared{select_by_token_type(t : &str) -> Option => "`where token_type = #{t} limit 1`"});

impl MEthChainTokenShared {
    pub const fn create_table_script() -> &'static str {
        std::include_str!("../../../sql/m_eth_chain_token_shared.sql")
    }
}

#[db_append_shared]
#[derive(PartialEq, Serialize, Deserialize, Clone, Debug, Default, DbBeforeSave, DbBeforeUpdate)]
pub struct MEthChainTokenAuth {
    /// [EthChainTokenShared]
    #[serde(default)]
    pub chain_token_shared_id: String,
    #[serde(default)]
    pub net_type: String,
    ///如果是eth，那么合约地址为零长度字符串
    #[serde(default)]
    pub contract_address: String,
    /// 显示位置，以此从小到大排列
    #[serde(default)]
    pub position: i64,
    #[serde(default)]
    pub status: i64,
    //  ///这个是为了使用方便，它不会生成数据库字段
    /*    #[serde(skip)]
        pub chain_token_shared: MEthChainTokenShared,*/
}

impl MEthChainTokenAuth {
    pub const fn create_table_script() -> &'static str {
        std::include_str!("../../../sql/m_eth_chain_token_auth.sql")
    }
}

/// DefaultToken must be a [EthChainTokenAuth]
#[db_append_shared()]
#[derive(PartialEq, Serialize, Deserialize, Clone, Debug, Default, DbBeforeSave, DbBeforeUpdate)]
pub struct MEthChainTokenDefault {
    /// [crate::db::TokenShared]
    #[serde(default)]
    pub chain_token_shared_id: String,
    #[serde(default)]
    pub net_type: String,
    ///如果是eth，那么合约地址为零长度字符串
    #[serde(default)]
    pub contract_address: String,
    /// 显示位置，以此从小到大排列
    #[serde(default)]
    pub position: i64,
    #[serde(default)]
    pub status: i64,
    ///这个是为了使用方便，它不会生成数据库字段
    #[serde(skip)]
    pub chain_token_shared: MEthChainTokenShared,
}

impl MEthChainTokenDefault {
    pub const fn create_table_script() -> &'static str {
        std::include_str!("../../../sql/m_eth_chain_token_default.sql")
    }
}

#[db_append_shared]
#[derive(PartialEq, Serialize, Deserialize, Clone, Debug, Default, DbBeforeSave, DbBeforeUpdate)]
pub struct MEthChainTokenNonAuth {
    #[serde(default)]
    pub chain_token_shared_id: String,
    #[serde(default)]
    pub net_type: String,
    #[serde(default)]
    pub contract_address: String,
    /// 显示位置，以此从小到大排列
    #[serde(default)]
    pub position: i64,
    #[serde(default)]
    pub status: i64,
    /* #[serde(skip)]
     pub chain_token_shared: MEthChainTokenShared,*/
}

impl MEthChainTokenNonAuth {
    pub const fn create_table_script() -> &'static str {
        std::include_str!("../../../sql/m_eth_chain_token_non_auth.sql")
    }
}

//eth end

#[cfg(test)]
mod tests {
    use futures::executor::block_on;
    use rbatis::crud::CRUDTable;
    use rbatis::rbatis::Rbatis;
    use strum::IntoEnumIterator;

    use crate::kits::test::make_memory_rbatis_test;
    use crate::ma::{Dao, Db, DbCreateType, EthTokenType, MEeeChainTokenShared, MEthChainTokenAuth, MEthChainTokenDefault};
    use crate::NetType;

    #[test]
    fn eth_token_type_test() {
        for it in EthTokenType::iter() {
            assert_eq!(it, EthTokenType::from(&it.to_string()).unwrap());
        }
    }

    #[test]
    fn m_eth_chain_token_default_test() {
        let rb = block_on(init_memory());
        let re = block_on(MEthChainTokenDefault::list(&rb, ""));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let mut token = MEthChainTokenDefault::default();
        token.chain_token_shared_id = "chain_token_shared_id".to_owned();
        token.net_type = NetType::Main.to_string();
        token.position = 1;

        let re = block_on(token.save(&rb, ""));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let re = block_on(MEthChainTokenDefault::list(&rb, ""));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let tokens = re.unwrap();
        assert_eq!(1, tokens.len(), "{:?}", tokens);

        let db_token = &tokens.as_slice()[0];
        assert_eq!(&token, db_token);

        let re = block_on(MEthChainTokenDefault::fetch_by_id(&rb, "", &token.id));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let db_token = re.unwrap().unwrap();
        assert_eq!(token, db_token);
    }

    #[test]
    fn m_eth_chain_token_shared_test() {
        let rb = block_on(init_memory());
        let re = block_on(MEeeChainTokenShared::list(&rb, ""));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let mut token = MEeeChainTokenShared::default();
        token.token_type = EthTokenType::Eth.to_string();
        token.gas_price = "10".to_owned();
        token.gas_limit = 10;
        token.decimal = 18;
        //token.contract_address = "contract".to_owned();
        token.token_shared.project_name = "test".to_owned();
        token.token_shared.project_home = "http://".to_owned();
        token.token_shared.project_note = "test".to_owned();
        token.token_shared.logo_bytes = "bytes".to_owned();
        token.token_shared.logo_url = "http://".to_owned();
        token.token_shared.symbol = "ETH".to_owned();
        token.token_shared.name = "ETH".to_owned();

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
    fn m_eth_chain_token_auth_test() {
        let rb = block_on(init_memory());
        let re = block_on(MEthChainTokenAuth::list(&rb, ""));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let mut token = MEthChainTokenAuth::default();
        token.chain_token_shared_id = "chain_token_shared_id".to_owned();
        token.net_type = NetType::Main.to_string();
        token.position = 1;

        let re = block_on(token.save(&rb, ""));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let re = block_on(MEthChainTokenAuth::list(&rb, ""));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let tokens = re.unwrap();
        assert_eq!(1, tokens.len(), "{:?}", tokens);

        let db_token = &tokens.as_slice()[0];
        assert_eq!(&token, db_token);

        let re = block_on(MEthChainTokenAuth::fetch_by_id(&rb, "", &token.id));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let db_token = re.unwrap().unwrap();
        assert_eq!(token, db_token);
    }

    async fn init_memory() -> Rbatis {
        let rb = make_memory_rbatis_test().await;
        let r = Db::create_table(&rb, MEthChainTokenDefault::create_table_script(), &MEthChainTokenDefault::table_name(), &DbCreateType::Drop).await;
        assert_eq!(false, r.is_err(), "{:?}", r);
        let r = Db::create_table(&rb, MEeeChainTokenShared::create_table_script(), &MEeeChainTokenShared::table_name(), &DbCreateType::Drop).await;
        assert_eq!(false, r.is_err(), "{:?}", r);
        let r = Db::create_table(&rb, MEthChainTokenAuth::create_table_script(), &MEthChainTokenAuth::table_name(), &DbCreateType::Drop).await;
        assert_eq!(false, r.is_err(), "{:?}", r);
        rb
    }
}

