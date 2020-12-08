use rbatis_macro_driver::CRUDEnable;
use serde::{Deserialize, Serialize};

use wallets_macro::{db_append_shared, db_sub_struct, DbBeforeSave, DbBeforeUpdate};

use crate::kits;
use crate::ma::dao::{self, Shared};

/// 地址与token对应的balance
#[db_append_shared]
#[derive(Serialize, Deserialize, Clone, Debug, Default, CRUDEnable, DbBeforeSave, DbBeforeUpdate)]
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
}

#[db_sub_struct]
#[derive(Serialize, Deserialize, Clone, Debug, Default)]
pub struct TxShared {
    #[serde(default)]
    pub tx_hash: String,
    #[serde(default)]
    pub block_hash: String,
    #[serde(default)]
    pub block_number: String,
    /// 交易的byte数据，不同链格式不一样
    #[serde(default)]
    pub tx_bytes: String,
}

#[cfg(test)]
mod tests {
    use async_std::task::block_on;
    use rbatis::rbatis::Rbatis;

    use crate::ma::{db_dest, MTokenAddress};
    use crate::ma::dao::{BeforeSave, BeforeUpdate, Dao, Shared};

    const TABLE: &str = "
-- TokenAddress
CREATE TABLE IF NOT EXISTS token_address (
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );";
    const TABLE_NAME: &str = "token_address";

    #[test]
    #[allow(non_snake_case)]
    fn test_TokenAddress() {
        let mut m = MTokenAddress::default();
        assert_eq!("", m.get_id());
        assert_eq!(0, m.get_create_time());
        assert_eq!(0, m.get_update_time());
        m.before_save();
        assert_ne!("", m.get_id());
        assert_ne!(0, m.get_create_time());
        assert_ne!(0, m.get_update_time());
        assert_eq!(m.get_create_time(), m.get_update_time());

        let mut m = MTokenAddress::default();
        m.before_update();
        assert_eq!("", m.get_id());
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
        let m2 = result.unwrap();
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
        assert_eq!(false, re.is_err());
        let re = block_on(MTokenAddress::list(&rb, ""));
        assert_eq!(false, re.is_err());
        let list = re.unwrap();
        assert_eq!(2, list.len());
    }

    async fn init_memory() -> Rbatis {
        let rb = db_dest::init_memory(None).await;
        let _ = rb.exec("", format!("drop table {}", TABLE_NAME).as_str()).await;
        let r = rb.exec("", TABLE).await;
        assert_eq!(false, r.is_err(), "{:?}", r);
        rb
    }
}

