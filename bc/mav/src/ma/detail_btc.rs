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
pub enum BtcTokenType {
    Btc,
}

impl BtcTokenType {
    #[allow(dead_code)]
    fn from(token_type: &str) -> Result<Self, kits::Error> {
        match token_type {
            "Btc" => Ok(BtcTokenType::Btc),
            _ => {
                let err = format!("the str:{} can not be BtcTokenType", token_type);
                log::error!("{}", err);
                Err(kits::Error::from(err.as_str()))
            }
        }
    }
}

impl ToString for BtcTokenType {
    fn to_string(&self) -> String {
        match &self {
            BtcTokenType::Btc => "Btc".to_owned(),
        }
    }
}

//btc
#[db_append_shared(CRUDTable)]
#[derive(PartialEq, Serialize, Deserialize, Clone, Debug, Default, DbBeforeSave, DbBeforeUpdate)]
pub struct MBtcChainTokenShared {
    #[serde(flatten)]
    pub token_shared: MTokenShared,
    #[serde(default)]
    pub token_type: String,
    #[serde(default)]
    pub fee_per_byte: i64,
    /// 精度
    #[serde(default)]
    pub decimal: i32,

}

impl MBtcChainTokenShared {
    pub const fn create_table_script() -> &'static str {
        std::include_str!("../../../sql/m_btc_chain_token_shared.sql")
    }
}

#[db_append_shared]
#[derive(PartialEq, Serialize, Deserialize, Clone, Debug, Default, CRUDTable, DbBeforeSave, DbBeforeUpdate)]
pub struct MBtcChainTokenAuth {
    /// [BtcChainTokenShared]
    #[serde(default)]
    pub chain_token_shared_id: String,
    #[serde(default)]
    pub net_type: String,
    /// 显示位置，以此从小到大排列
    #[serde(default)]
    pub position: i64,
    #[serde(default)]
    pub status: i64,
}

impl MBtcChainTokenAuth {
    pub const fn create_table_script() -> &'static str {
        std::include_str!("../../../sql/m_btc_chain_token_auth.sql")
    }
}

/// DefaultToken must be a [BtcChainTokenAuth]
#[db_append_shared(CRUDTable)]
#[derive(PartialEq, Serialize, Deserialize, Clone, Debug, Default, DbBeforeSave, DbBeforeUpdate)]
pub struct MBtcChainTokenDefault {
    /// [BtcChainTokenShared]
    #[serde(default)]
    pub chain_token_shared_id: String,
    #[serde(default)]
    pub net_type: String,
    /// 显示位置，以此从小到大排列
    #[serde(default)]
    pub position: i64,
    #[serde(default)]
    pub status: i64,
    #[serde(skip)]
    pub chain_token_shared: MBtcChainTokenShared,
}

impl MBtcChainTokenDefault {
    pub const fn create_table_script() -> &'static str {
        std::include_str!("../../../sql/m_btc_chain_token_default.sql")
    }
}

//murmel defined
#[db_append_shared]
#[derive(PartialEq, Serialize, Deserialize, Clone, Debug, Default, CRUDTable, DbBeforeSave, DbBeforeUpdate)]
pub struct MProgress {
    #[serde(default)]
    pub header: String,
    #[serde(default)]
    pub timestamp: String,
}

impl MProgress {
    pub const fn create_table_script() -> &'static str {
        std::include_str!("../../../sql/m_progress.sql")
    }
}

#[db_append_shared]
#[derive(PartialEq, Serialize, Deserialize, Clone, Debug, Default, CRUDTable, DbBeforeSave, DbBeforeUpdate)]
pub struct MLocalTxLog {
    #[serde(default)]
    pub address_from: String,
    #[serde(default)]
    pub address_to: String,
    #[serde(default)]
    pub value: String,
    #[serde(default)]
    pub status: String,
}

impl MLocalTxLog {
    pub const fn create_table_script() -> &'static str {
        std::include_str!("../../../sql/m_local_tx_log.sql")
    }
}
//murmel end
//btc end

#[cfg(test)]
mod tests {
    use futures::executor::block_on;
    use rbatis::crud::CRUDTable;
    use rbatis::rbatis::Rbatis;
    use strum::IntoEnumIterator;

    use crate::kits::test::make_memory_rbatis_test;
    use crate::ma::{BtcTokenType, Dao, Db, DbCreateType, MBtcChainTokenAuth, MBtcChainTokenDefault, MBtcChainTokenShared};
    use crate::NetType;

    #[test]
    fn btc_token_type_test() {
        for it in BtcTokenType::iter() {
            assert_eq!(it, BtcTokenType::from(&it.to_string()).unwrap());
        }
    }

    #[test]
    fn m_btc_chain_token_default_test() {
        let rb = block_on(init_memory());
        let re = block_on(MBtcChainTokenDefault::list(&rb, ""));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let mut token = MBtcChainTokenDefault::default();
        token.chain_token_shared_id = "chain_token_shared_id".to_owned();
        token.net_type = NetType::Main.to_string();
        token.position = 1;

        let re = block_on(token.save(&rb, ""));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let re = block_on(MBtcChainTokenDefault::list(&rb, ""));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let tokens = re.unwrap();
        assert_eq!(1, tokens.len(), "{:?}", tokens);

        let db_token = &tokens.as_slice()[0];
        assert_eq!(&token, db_token);

        let re = block_on(MBtcChainTokenDefault::fetch_by_id(&rb, "", &token.id));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let db_token = re.unwrap().unwrap();
        assert_eq!(token, db_token);
    }

    #[test]
    fn m_btc_chain_token_shared_test() {
        let rb = block_on(init_memory());
        let re = block_on(MBtcChainTokenShared::list(&rb, ""));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let mut token = MBtcChainTokenShared::default();
        token.token_type = BtcTokenType::Btc.to_string();
        token.decimal = 18;
        token.token_shared.project_name = "test".to_owned();
        token.token_shared.project_home = "http://".to_owned();
        token.token_shared.project_note = "test".to_owned();
        token.token_shared.logo_bytes = "bytes".to_owned();
        token.token_shared.logo_url = "http://".to_owned();
        token.token_shared.symbol = "BTC".to_owned();
        token.token_shared.name = "BTC".to_owned();

        let re = block_on(token.save(&rb, ""));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let re = block_on(MBtcChainTokenShared::list(&rb, ""));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let tokens = re.unwrap();
        assert_eq!(1, tokens.len(), "{:?}", tokens);

        let db_token = &tokens.as_slice()[0];
        assert_eq!(&token, db_token);

        let re = block_on(MBtcChainTokenShared::fetch_by_id(&rb, "", &token.id));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let db_token = re.unwrap().unwrap();
        assert_eq!(token, db_token);
    }

    #[test]
    fn m_btc_chain_token_auth_test() {
        let rb = block_on(init_memory());
        let re = block_on(MBtcChainTokenAuth::list(&rb, ""));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let mut token = MBtcChainTokenAuth::default();
        token.chain_token_shared_id = "chain_token_shared_id".to_owned();
        token.net_type = NetType::Main.to_string();
        token.position = 1;

        let re = block_on(token.save(&rb, ""));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let re = block_on(MBtcChainTokenAuth::list(&rb, ""));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let tokens = re.unwrap();
        assert_eq!(1, tokens.len(), "{:?}", tokens);

        let db_token = &tokens.as_slice()[0];
        assert_eq!(&token, db_token);

        let re = block_on(MBtcChainTokenAuth::fetch_by_id(&rb, "", &token.id));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let db_token = re.unwrap().unwrap();
        assert_eq!(token, db_token);
    }

    async fn init_memory() -> Rbatis {
        let rb = make_memory_rbatis_test().await;
        let r = Db::create_table(&rb, MBtcChainTokenDefault::create_table_script(), &MBtcChainTokenDefault::table_name(), &DbCreateType::Drop).await;
        assert_eq!(false, r.is_err(), "{:?}", r);
        let r = Db::create_table(&rb, MBtcChainTokenShared::create_table_script(), &MBtcChainTokenShared::table_name(), &DbCreateType::Drop).await;
        assert_eq!(false, r.is_err(), "{:?}", r);
        let r = Db::create_table(&rb, MBtcChainTokenAuth::create_table_script(), &MBtcChainTokenAuth::table_name(), &DbCreateType::Drop).await;
        assert_eq!(false, r.is_err(), "{:?}", r);
        rb
    }
}