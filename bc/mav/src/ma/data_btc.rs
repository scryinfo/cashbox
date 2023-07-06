use rbatis::crud::CRUDTable;
use rbatis_macro_driver::CRUDTable;
use serde::Deserialize;
use serde::Serialize;

use wallets_macro::{db_append_shared, DbBeforeSave, DbBeforeUpdate};

use crate::kits;
use crate::ma::dao::{self, Shared};
use crate::ma::TxShared;

//btc
#[db_append_shared]
#[derive(PartialEq, Serialize, Deserialize, Clone, Debug, Default, CRUDTable, DbBeforeSave, DbBeforeUpdate)]
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
    // #[serde(default, deserialize_with = "bool_from_u32", serialize_with = "bool_to_u32")]
    #[serde(default)]
    pub show: u32,
    /// 精度
    #[serde(default)]
    pub decimal: i32,
}

impl MBtcChainToken {
    pub const fn create_table_script() -> &'static str {
        std::include_str!("../../../sql/m_btc_chain_token.sql")
    }
}

#[db_append_shared(CRUDTable)]
#[derive(PartialEq, Serialize, Deserialize, Clone, Debug, Default, DbBeforeSave, DbBeforeUpdate)]
pub struct MBtcChainTx {
    #[serde(flatten)]
    pub tx_shared: TxShared,
    #[serde(default)]
    pub wallet_account: String,
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
#[derive(PartialEq, Serialize, Deserialize, Clone, Debug, Default, CRUDTable, DbBeforeSave, DbBeforeUpdate)]
pub struct MBtcInputTx {
    #[serde(default)]
    pub btc_chain_tx_foreign: String,
    #[serde(default)]
    // utxo
    pub tx_id: String,
    #[serde(default)]
    //utxo index
    pub vout: u32,
    #[serde(default)]
    pub sig_script: String,
    #[serde(default)]
    pub sequence: u32,
    // index
    #[serde(default)]
    pub idx: u32,
    // The tx hash value that include this Output unique
    #[serde(default)]
    pub btc_tx_hash: String,
    #[serde(default)]
    pub btc_tx_hexbytes: String,
    // ...
}

impl MBtcInputTx {
    pub const fn create_table_script() -> &'static str {
        std::include_str!("../../../sql/m_btc_input_tx.sql")
    }
}

#[db_append_shared]
#[derive(PartialEq, Serialize, Deserialize, Clone, Debug, Default, CRUDTable, DbBeforeSave, DbBeforeUpdate)]
pub struct MBtcOutputTx {
    #[serde(default)]
    pub btc_chain_tx_foreign: String,
    #[serde(default)]
    pub value: u64,
    #[serde(default)]
    pub pk_script: String,
    #[serde(default)]
    // The tx hash value that include this Output unique
    pub btc_tx_hash: String,
    #[serde(default)]
    pub idx: u32,
    #[serde(default)]
    pub btc_tx_hexbytes: String,
    // ...
}

impl MBtcOutputTx {
    pub const fn create_table_script() -> &'static str {
        std::include_str!("../../../sql/m_btc_output_tx.sql")
    }
}

#[db_append_shared]
#[derive(PartialEq, Serialize, Deserialize, Clone, Debug, Default, CRUDTable, DbBeforeSave, DbBeforeUpdate)]
pub struct MBtcUtxo {
    #[serde(default)]
    // satoshi 已花费的交易才有交易费
    pub fee: Option<u64>,
    #[serde(default)]
    //forgien, reference to btc tx state
    pub state: String,
    #[serde(default)]
    pub btc_tx_hash: String,
    #[serde(default)]
    pub idx: u32,
    #[serde(default)]
    pub btc_tx_hexbytes: String,
    #[serde(default)]
    // 和自己地址有关的那条output idx输出对应的value 计算交易的依据
    pub value: u64,
    #[serde(default)]
    // 如果是花费的  这一笔交易所有的花销，等于所有output 中的value之和
    pub spent_value: Option<u64>,
}

impl MBtcUtxo {
    pub const fn create_table_script() -> &'static str {
        std::include_str!("../../../sql/m_btc_utxo.sql")
    }
}

#[db_append_shared]
#[derive(PartialEq, Serialize, Deserialize, Clone, Debug, Default, CRUDTable, DbBeforeSave, DbBeforeUpdate)]
pub struct MBlockHeader {
    #[serde(default)]
    pub header: String,
    #[serde(default)]
    pub scanned: String,
    #[serde(default)]
    pub timestamp: String,
}

impl MBlockHeader {
    pub const fn create_table_script() -> &'static str {
        std::include_str!("../../../sql/m_block_header.sql")
    }
}
//btc end


#[cfg(test)]
mod tests {
    use futures::executor::block_on;
    use rbatis::crud::CRUDTable;
    use rbatis::rbatis::Rbatis;

    use crate::kits::test::make_memory_rbatis_test;
    use crate::ma::{Db, DbCreateType, MBtcChainToken, MBtcChainTx, MBtcInputTx, MBtcOutputTx};
    use crate::ma::dao::{BeforeSave, BeforeUpdate, Dao, Shared};

    #[test]
    #[allow(non_snake_case)]
    fn m_btc_chain_token_test() {
        let mut m = MBtcChainToken::default();
        assert_eq!("", Shared::get_id(&m));
        assert_eq!(0, m.get_create_time());
        assert_eq!(0, m.get_update_time());
        m.before_save();
        assert_ne!("", Shared::get_id(&m));
        assert_ne!(0, m.get_create_time());
        assert_ne!(0, m.get_update_time());
        assert_eq!(m.get_create_time(), m.get_update_time());

        let mut m = MBtcChainToken::default();
        m.before_update();
        assert_eq!("", Shared::get_id(&m));
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
        assert_eq!(m, m2);

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

    #[test]
    fn m_btc_chain_tx_test() {
        let rb = block_on(init_memory());
        let re = block_on(MBtcChainTx::list(&rb, ""));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let mut m = MBtcChainTx::default();
        m.fees = "fees".to_owned();

        let re = block_on(m.save(&rb, ""));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let re = block_on(MBtcChainTx::list(&rb, ""));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let ms = re.unwrap();
        assert_eq!(1, ms.len(), "{:?}", ms);

        let db_m = &ms.as_slice()[0];
        assert_eq!(&m, db_m);

        let re = block_on(MBtcChainTx::fetch_by_id(&rb, "", &m.id));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let db_m = re.unwrap().unwrap();
        assert_eq!(m, db_m);
    }

    #[test]
    fn m_btc_input_tx_test() {
        let rb = block_on(init_memory());
        let re = block_on(MBtcInputTx::list(&rb, ""));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let mut m = MBtcInputTx::default();
        m.tx_id = "tx_id".to_owned();

        let re = block_on(m.save(&rb, ""));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let re = block_on(MBtcInputTx::list(&rb, ""));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let ms = re.unwrap();
        assert_eq!(1, ms.len(), "{:?}", ms);

        let db_m = &ms.as_slice()[0];
        assert_eq!(&m, db_m);

        let re = block_on(MBtcInputTx::fetch_by_id(&rb, "", &m.id));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let db_m = re.unwrap().unwrap();
        assert_eq!(m, db_m);
    }

    #[test]
    fn m_btc_output_tx_test() {
        let rb = block_on(init_memory());
        let re = block_on(MBtcOutputTx::list(&rb, ""));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let mut m = MBtcOutputTx::default();
        m.pk_script = "pk_script".to_owned();

        let re = block_on(m.save(&rb, ""));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let re = block_on(MBtcOutputTx::list(&rb, ""));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let ms = re.unwrap();
        assert_eq!(1, ms.len(), "{:?}", ms);

        let db_m = &ms.as_slice()[0];
        assert_eq!(&m, db_m);

        let re = block_on(MBtcOutputTx::fetch_by_id(&rb, "", &m.id));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let db_m = re.unwrap().unwrap();
        assert_eq!(m, db_m);
    }


    async fn init_memory() -> Rbatis {
        let rb = make_memory_rbatis_test().await;
        let r = Db::create_table(&rb, MBtcChainToken::create_table_script(), &MBtcChainToken::table_name(), &DbCreateType::Drop).await;
        assert_eq!(false, r.is_err(), "{:?}", r);
        let r = Db::create_table(&rb, MBtcChainTx::create_table_script(), &MBtcChainTx::table_name(), &DbCreateType::Drop).await;
        assert_eq!(false, r.is_err(), "{:?}", r);
        let r = Db::create_table(&rb, MBtcInputTx::create_table_script(), &MBtcInputTx::table_name(), &DbCreateType::Drop).await;
        assert_eq!(false, r.is_err(), "{:?}", r);
        let r = Db::create_table(&rb, MBtcOutputTx::create_table_script(), &MBtcOutputTx::table_name(), &DbCreateType::Drop).await;
        assert_eq!(false, r.is_err(), "{:?}", r);

        rb
    }
}