// use rbatis_macro_driver::CRUDTable;
use serde::{Deserialize, Serialize};

use wallets_macro::{db_append_shared, db_sub_struct, DbBeforeSave, DbBeforeUpdate};
use async_trait::async_trait;

use crate::kits;
use crate::ma::dao::{self, Shared};

/// 地址与token对应的balance
#[allow(non_upper_case_globals)]
#[db_append_shared]
#[derive(PartialEq, Serialize, Deserialize, Clone, Debug, Default, DbBeforeSave, DbBeforeUpdate)]
pub struct MTokenAddress {
    #[serde(default)]
    pub wallet_id: String,
    /// [crate::ChainType]
    #[serde(default)]
    pub chain_type: String,
    #[serde(default)]
    pub token_id: String,
    #[serde(default)]
    pub address_id: String,
    #[serde(default)]
    pub balance: String,
    #[serde(default)]
    pub status: i64,//set this row whether visible, 0 hide,1 display
}

impl MTokenAddress {
    pub const fn create_table_script() -> &'static str {
        std::include_str!("../../../sql/m_token_address.sql")
    }
}

#[db_sub_struct]
#[derive(PartialEq, Serialize, Deserialize, Clone, Debug, Default)]
pub struct TxShared {
    #[serde(default)]
    pub tx_hash: String,
    #[serde(default)]
    pub block_hash: String,
    #[serde(default)]
    pub block_number: String,
    #[serde(default)]
    pub signer: String,
    /// 交易的byte数据，不同链格式不一样
    #[serde(default)]
    pub tx_bytes: String,
    #[serde(default)]
    pub tx_timestamp: i64,
}

#[cfg(test)]
mod tests {
    use futures::executor::block_on;
    use rbatis::crud::CRUDTable;
    use rbatis::rbatis::Rbatis;

    use crate::kits::test::make_memory_rbatis_test;
    use crate::ma::{Db, DbCreateType, MTokenAddress};
    use crate::ma::dao::{BeforeSave, BeforeUpdate, Dao, Shared};

    #[test]
    #[allow(non_snake_case)]
    fn m_token_address_test() {
        let mut m = MTokenAddress::default();
        assert_eq!("", Shared::get_id(&m));
        assert_eq!(0, m.get_create_time());
        assert_eq!(0, m.get_update_time());
        m.before_save();
        assert_ne!("", Shared::get_id(&m));
        assert_ne!(0, m.get_create_time());
        assert_ne!(0, m.get_update_time());
        assert_eq!(m.get_create_time(), m.get_update_time());

        let mut m = MTokenAddress::default();
        m.before_update();
        assert_eq!("", Shared::get_id(&m));
        assert_eq!(0, m.get_create_time());
        assert_ne!(0, m.get_update_time());

        let rb = block_on(init_memory());
        let mut m = MTokenAddress::default();
        m.wallet_id = "test".to_owned();
        m.token_id = "eee".to_owned();
        let result = block_on(m.save(&rb, ""));
        assert_eq!(false, result.is_err(), "{:?}", result);
        let result = block_on(MTokenAddress::fetch_by_id(&rb, "", &m.id));
        assert_eq!(false, result.is_err(), "{:?}", result);
        let m2 = result.unwrap().unwrap();
        assert_eq!(m.id, m2.id);
        assert_eq!(m.update_time, m2.update_time);
        assert_eq!(m.create_time, m2.create_time);
        assert_eq!(m.token_id, m2.token_id);
        assert_eq!(m.wallet_id, m2.wallet_id);
        assert_eq!(m.address_id, m2.address_id);
        assert_eq!(m.balance, m2.balance);
        assert_eq!(m.chain_type, m2.chain_type);

        let mut m3 = MTokenAddress::default();
        m3.token_id = "m3".to_owned();
        let re = block_on(m3.save(&rb, ""));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let re = block_on(MTokenAddress::list(&rb, ""));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let list = re.unwrap();
        assert_eq!(2, list.len());
    }

    async fn init_memory() -> Rbatis {
        let rb = make_memory_rbatis_test().await;
        let r = Db::create_table(&rb, MTokenAddress::create_table_script(), &MTokenAddress::table_name(), &DbCreateType::Drop).await;
        assert_eq!(false, r.is_err(), "{:?}", r);
        rb
    }
}

