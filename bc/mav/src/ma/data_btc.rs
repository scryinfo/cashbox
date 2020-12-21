use rbatis::crud::CRUDEnable;
use rbatis_macro_driver::CRUDEnable;
use serde::Deserialize;
use serde::Serialize;

use wallets_macro::{db_append_shared, DbBeforeSave, DbBeforeUpdate};

use crate::kits;
use crate::ma::dao::{self, bool_from_int, Shared};
use crate::ma::TxShared;

//btc
#[db_append_shared]
#[derive(Serialize, Deserialize, Clone, Debug, Default, CRUDEnable, DbBeforeSave, DbBeforeUpdate)]
pub struct MBtcChainToken {
    #[serde(default)]
    pub next_id: String,
    /// 手动加入的token就没有token shared内容
    /// [crate::db::BtcChainTokenShared]
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

impl MBtcChainToken {
    pub const fn create_table_script() -> &'static str {
        std::include_str!("../../../sql/m_btc_chain_token.sql")
    }
}

#[db_append_shared(CRUDEnable)]
#[derive(Serialize, Deserialize, Clone, Debug, Default, DbBeforeSave, DbBeforeUpdate)]
pub struct MBtcChainTx {
    #[serde(flatten)]
    pub tx_shared: TxShared,
    #[serde(default)]
    pub total_input: String,
    #[serde(default)]
    pub total_output: String,
    #[serde(default)]
    pub fees: String,
    /// 如果包含 OP_RETURN
    #[serde(default)]
    pub op_return: Option<String>,
    // ...
}

impl MBtcChainTx {
    pub const fn create_table_script() -> &'static str {
        std::include_str!("../../../sql/m_btc_chain_tx.sql")
    }
}

#[db_append_shared]
#[derive(Serialize, Deserialize, Clone, Debug, Default, CRUDEnable, DbBeforeSave, DbBeforeUpdate)]
pub struct MBtcInputTx {
    #[serde(default)]
    pub btc_chain_tx_id: String,
    #[serde(default)]
    pub tx_index: i64,
    #[serde(default)]
    pub address: String,
    #[serde(default)]
    pub pk_script: String,
    #[serde(default)]
    pub sig_script: String,
    #[serde(default)]
    pub value: String,
    // ...
}

impl MBtcInputTx {
    pub const fn create_table_script() -> &'static str {
        std::include_str!("../../../sql/m_btc_input_tx.sql")
    }
}

#[db_append_shared]
#[derive(Serialize, Deserialize, Clone, Debug, Default, CRUDEnable, DbBeforeSave, DbBeforeUpdate)]
pub struct MBtcOutputTx {
    #[serde(default)]
    pub btc_chain_tx_id: String,
    #[serde(default)]
    pub tx_index: i64,
    #[serde(default)]
    pub address: String,
    #[serde(default)]
    pub pk_script: String,
    #[serde(default)]
    pub value: String,
    // ...
}

impl MBtcOutputTx {
    pub const fn create_table_script() -> &'static str {
        std::include_str!("../../../sql/m_btc_output_tx.sql")
    }
}
//btc end


#[cfg(test)]
mod tests {
    use futures::executor::block_on;
    use rbatis::crud::CRUDEnable;
    use rbatis::rbatis::Rbatis;

    use crate::kits::test::make_memory_rbatis_test;
    use crate::ma::{Db, DbCreateType, MBtcChainToken};
    use crate::ma::dao::{BeforeSave, BeforeUpdate, Dao, Shared};

    #[test]
    #[allow(non_snake_case)]
    fn test_TokenAddress() {
        let mut m = MBtcChainToken::default();
        assert_eq!("", m.get_id());
        assert_eq!(0, m.get_create_time());
        assert_eq!(0, m.get_update_time());
        m.before_save();
        assert_ne!("", m.get_id());
        assert_ne!(0, m.get_create_time());
        assert_ne!(0, m.get_update_time());
        assert_eq!(m.get_create_time(), m.get_update_time());

        let mut m = MBtcChainToken::default();
        m.before_update();
        assert_eq!("", m.get_id());
        assert_eq!(0, m.get_create_time());
        assert_ne!(0, m.get_update_time());

        let rb = block_on(init_memory());
        let mut m = MBtcChainToken::default();
        m.wallet_id = "test".to_owned();
        m.show = false;
        let result = block_on(m.save(&rb, ""));
        assert_eq!(false, result.is_err(), "{:?}", result);
        let result = block_on(MBtcChainToken::fetch_by_id(&rb, "", &m.id));
        assert_eq!(false, result.is_err(), "{:?}", result);
        let m2 = result.unwrap().unwrap();
        assert_eq!(m.id, m2.id);
        assert_eq!(m.update_time, m2.update_time);
        assert_eq!(m.create_time, m2.create_time);
        assert_eq!(m.chain_type, m2.chain_type);
        assert_eq!(m.wallet_id, m2.wallet_id);
        assert_eq!(m.chain_token_shared_id, m2.chain_token_shared_id);
        assert_eq!(m.decimal, m2.decimal);
        assert_eq!(m.next_id, m2.next_id);
        assert_eq!(m.show, m2.show);

        m.wallet_id = "m3".to_owned();
        m.show = true;
        let result = block_on(m.update_by_id(&rb, ""));
        assert_eq!(false, result.is_err(), "{:?}", result);
        let result = block_on(MBtcChainToken::fetch_by_id(&rb, "", &m.id));
        assert_eq!(false, result.is_err(), "{:?}", result);
        let m2 = result.unwrap().unwrap();
        assert_eq!(m.id, m2.id);
        assert_eq!(m.show, m2.show);

        let result = block_on(MBtcChainToken::list(&rb, ""));
        assert_eq!(false, result.is_err(), "{:?}", result);
        let list = result.unwrap();
        assert_eq!(1, list.len());
    }

    async fn init_memory() -> Rbatis {
        let rb = make_memory_rbatis_test().await;
        let r = Db::create_table(&rb, MBtcChainToken::create_table_script(), &MBtcChainToken::table_name(), &DbCreateType::Drop).await;
        assert_eq!(false, r.is_err(), "{:?}", r);
        rb
    }
}
