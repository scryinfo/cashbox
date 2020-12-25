use rbatis::crud::CRUDEnable;
use rbatis_macro_driver::CRUDEnable;
use serde::Deserialize;
use serde::Serialize;

use wallets_macro::{db_append_shared, DbBeforeSave, DbBeforeUpdate};

use crate::kits;
use crate::ma::dao::{self, bool_from_int, Shared};
use crate::ma::TxShared;

//eee
#[db_append_shared]
#[derive(Serialize, Deserialize, Clone, Debug, Default, CRUDEnable, DbBeforeSave, DbBeforeUpdate)]
pub struct MEeeChainToken {
    #[serde(default)]
    pub next_id: String,
    /// 手动加入的token就没有token shared内容
    /// [crate::db::EeeChainTokenShared]
    #[serde(default)]
    pub chain_token_shared_id: String,
    /// [crate::db::Wallet]
    #[serde(default)]
    pub wallet_id: String,
    /// [crate::ChainType]
    #[serde(default)]
    pub chain_type: String,
    /// 是否显示
    #[serde(default, deserialize_with = "bool_from_int")]
    pub show: bool,
    /// 糖度
    #[serde(default)]
    pub decimal: i32,
}

impl MEeeChainToken {
    pub const fn create_table_script() -> &'static str {
        std::include_str!("../../../sql/m_eee_chain_token.sql")
    }
}

/// eee chain的交易
#[db_append_shared(CRUDEnable)]
#[derive(Serialize, Deserialize, Clone, Debug, Default, DbBeforeSave, DbBeforeUpdate)]
pub struct MEeeChainTx {
    #[serde(flatten)]
    pub tx_shared: TxShared,
    //from是数据库的关键字，所以加上 address
    #[serde(default)]
    pub from_address: String,
    #[serde(default)]
    pub to_address: String,
    #[serde(default)]
    pub value: String,

    // ....

    /// [crate::TxStatus]
    #[serde(default)]
    pub status: String,

    /// 扩展数据
    #[serde(default)]
    pub extension: String,
}

impl MEeeChainTx {
    pub const fn create_table_script() -> &'static str {
        std::include_str!("../../../sql/m_eee_chain_tx.sql")
    }
}

#[db_append_shared(CRUDEnable)]
#[derive(Serialize, Deserialize, Clone, Debug, Default, DbBeforeSave, DbBeforeUpdate)]
pub struct MEeeTokenxTx {
    #[serde(flatten)]
    pub tx_shared: TxShared,
    //from是数据库的关键字，所以加上 address
    #[serde(default)]
    pub from_address: String,
    #[serde(default)]
    pub to_address: String,
    #[serde(default)]
    pub value: String,

    // ....

    /// [crate::TxStatus]
    #[serde(default)]
    pub status: String,

    /// 扩展数据
    #[serde(default)]
    pub extension: String,
}

impl MEeeTokenxTx {
    pub const fn create_table_script() -> &'static str {
        std::include_str!("../../../sql/m_eee_tokenx_tx.sql")
    }
}

#[db_append_shared]
#[derive(Serialize, Deserialize, Clone, Debug, Default, CRUDEnable, DbBeforeSave, DbBeforeUpdate)]
pub struct MSubChainBasicInfo {
    #[serde(default)]
    genesis_hash: String,
    #[serde(default)]
    metadata: String,
    #[serde(default)]
    runtime_version: i32,
    #[serde(default)]
    tx_version: i32,
    #[serde(default)]
    ss58_format_prefix: i32,
    #[serde(default)]
    token_decimals: i32,
    #[serde(default)]
    token_symbol: String,
    #[serde(default)]
    is_default: bool,
    #[serde(default)]
    status: i32,
}

impl MSubChainBasicInfo {
    pub const fn create_table_script() -> &'static str {
        std::include_str!("../../../sql/m_sub_chain_basic_info.sql")
    }
}

#[db_append_shared]
#[derive(Serialize, Deserialize, Clone, Debug, Default, CRUDEnable, DbBeforeSave, DbBeforeUpdate)]
pub struct MAccountInfoSyncProg {
    #[serde(default)]
    account: String,
    #[serde(default)]
    block_no: String,
    #[serde(default)]
    block_hash: String,
}

impl MAccountInfoSyncProg {
    pub const fn create_table_script() -> &'static str {
        std::include_str!("../../../sql/m_account_info_sync_prog.sql")
    }
}
//eee end


#[cfg(test)]
mod tests {
    use futures::executor::block_on;
    use rbatis::crud::CRUDEnable;
    use rbatis::rbatis::Rbatis;

    use crate::kits::test::make_memory_rbatis_test;
    use crate::ma::{Db, DbCreateType};
    use crate::ma::dao::{BeforeSave, BeforeUpdate, Dao, Shared};
    use crate::ma::data_eee::MEeeChainTx;

    #[test]
    #[allow(non_snake_case)]
    fn test_EeeChainTx() {
        // let colx = EeeChainTx::table_columns();
        let mut m = MEeeChainTx::default();
        assert_eq!("", m.get_id());
        assert_eq!(0, m.get_create_time());
        assert_eq!(0, m.get_update_time());
        assert_eq!("", m.status);
        assert_eq!("", m.extension);
        assert_eq!("", m.from_address);
        assert_eq!("", m.to_address);
        assert_eq!("", m.value);
        assert_eq!("", m.tx_shared.block_hash);
        assert_eq!("", m.tx_shared.block_number);
        assert_eq!("", m.tx_shared.tx_bytes);
        assert_eq!("", m.tx_shared.tx_hash);

        m.before_save();
        assert_ne!("", m.get_id());
        assert_ne!(0, m.get_create_time());
        assert_ne!(0, m.get_update_time());
        assert_eq!(m.get_create_time(), m.get_update_time());

        let mut m = MEeeChainTx::default();
        m.before_update();
        assert_eq!("", m.get_id());
        assert_eq!(0, m.get_create_time());
        assert_ne!(0, m.get_update_time());

        let rb = block_on(init_memory());
        let mut m = MEeeChainTx::default();
        m.from_address = "test".to_owned();
        m.extension = "eee".to_owned();
        m.status = String::new();
        m.tx_shared.tx_hash = "hash".to_owned();
        let err = block_on(m.save(&rb, ""));
        if let Err(e) = &err {
            let s = e.to_string();
            println!("{}", s);
            assert!(e.to_string().is_empty());
        }

        let re = block_on(MEeeChainTx::fetch_by_id(&rb, "", &m.id));
        if let Err(e) = &re {
            println!("{}", e);
        }

        assert_eq!(false, re.is_err(), "{:?}", re);
        let m2 = re.unwrap().unwrap();
        assert_eq!(m.id, m2.id);
        assert_eq!(m.update_time, m2.update_time);
        assert_eq!(m.create_time, m2.create_time);

        assert_eq!(m.from_address, m2.from_address);
        assert_eq!(m.extension, m2.extension);
        assert_eq!(m.status, m2.status);

        assert_eq!(m.tx_shared.tx_hash, m2.tx_shared.tx_hash);


        let mut m3 = MEeeChainTx::default();
        m3.tx_shared.tx_hash = "m3".to_owned();
        let re = block_on(m3.save(&rb, ""));

        assert_eq!(false, re.is_err(), "{:?}", re);
        let re = block_on(MEeeChainTx::list(&rb, ""));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let list = re.unwrap();
        assert_eq!(2, list.len());
    }

    async fn init_memory() -> Rbatis {
        let rb = make_memory_rbatis_test().await;
        let r = Db::create_table(&rb, MEeeChainTx::create_table_script(), &MEeeChainTx::table_name(), &DbCreateType::Drop).await;
        assert_eq!(false, r.is_err(), "{:?}", r);
        rb
    }
}
