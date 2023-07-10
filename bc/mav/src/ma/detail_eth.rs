use serde::Deserialize;
use serde::Serialize;
use strum_macros::EnumIter;
use rbatis::py_sql;

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
rbatis::impl_select!(MEthChainTokenShared{select_by_id(id : &str) -> Option => "`where id = #{id} limit 1`"});

impl MEthChainTokenShared {
    pub const fn create_table_script() -> &'static str {
        std::include_str!("../../../sql/m_eth_chain_token_shared.sql")
    }

    #[py_sql("`select a.* from m_eth_chain_token_default b left join m_eth_chain_token_shared a on b.chain_token_shared_id = a.id`
     `where b.net_type = #{net_type}'"
    )]
    pub async fn list_by_net_type(
        rb: &mut dyn rbatis::executor::Executor,
        net_type: &str,
    ) -> Result<Vec<MEthChainTokenShared>, rbatis::Error> {
        rbatis::impled!()
    }
    #[py_sql("`select * from m_eth_chain_token_shared where id in (select id from m_eth_chain_token_auth where net_type = #{net_type} oder by create_time desc limit #{page_size} offset #{start_item})`")]
    pub async fn select_auth_page_net_type_and_id_in(
        rb: &mut dyn rbatis::executor::Executor,
        net_type: &str,
        start_item: u64, page_size: u64
    ) -> Result<Vec<MEthChainTokenShared>, rbatis::Error> {
        rbatis::impled!()
    }
    #[py_sql("`select * from m_eth_chain_token_non_auth a left join m_eth_chain_token_shared b on a.chain_token_shared_id = b.id where a.net_type = #{net_type} )`")]
    pub async fn select_nonauth_net_type_and_id_in(
        rb: &mut dyn rbatis::executor::Executor,
        net_type: &str,
    ) -> Result<Vec<MEthChainTokenShared>, rbatis::Error> {
        rbatis::impled!()
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
rbatis::crud!(MEthChainTokenAuth{});
rbatis::impl_select_page!(MEthChainTokenAuth{select_page_net_type_status_order_create_time(net_type:&str,status: i64) =>
    "`where net_type= #{net_type} and = #{status} order by create_time desc`"});
rbatis::impl_select!(MEthChainTokenAuth{select_by_shared_id_net_type_status(shared_id:&str, net_type:&str,status: i64) =>
    "`where chain_token_shared_id= #{shared_id} net_type= #{net_type} and = #{status} order by create_time desc`"});

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

rbatis::crud!(MEthChainTokenDefault{});
rbatis::impl_select!(MEthChainTokenDefault{select_token_shared_id_and_net_type(shared_id: &str, net_type: &str)->
    Option => "`where chain_token_shared_id = #{shared_id} and net_type = #{net_type} limit 1`"});

// let wrapper = wallets_db.new_wrapper()
// .eq(MEthChainTokenDefault::net_type, net_type.to_string())
// .order_by(true, &[MEthChainTokenDefault::position]);

rbatis::impl_select!(MEthChainTokenDefault{select_by_net_type_order_position(net_type:&str)=>
    "`where net_type= #{net_type} order by position`"});

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

rbatis::crud!(MEthChainTokenNonAuth{});
rbatis::impl_select!(MEthChainTokenNonAuth{select_net_type_status_order_position(net_type:&str, status: i64) =>
    "`where net_type= #{net_type} and status= #{status} order by position desc`"});

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

