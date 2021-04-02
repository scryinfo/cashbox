use rbatis_macro_driver::CRUDTable;
use serde::Deserialize;
use serde::Serialize;

use wallets_macro::{db_append_shared, db_sub_struct, DbBeforeSave, DbBeforeUpdate};

use crate::kits;
use crate::ma::dao::{self, Shared};

#[db_append_shared]
#[derive(PartialEq, Serialize, Deserialize, Clone, Debug, Default, CRUDTable, DbBeforeSave, DbBeforeUpdate)]
pub struct MWallet {
    //下一个显示顺序的 wallet_id
    #[serde(default)]
    pub next_id: String,
    #[serde(default)]
    pub name: String,
    //由助记词生成的唯一摘要，用于检测是否有重复的助记词
    #[serde(default)]
    pub mnemonic_digest: String,
    //加密后的助记词
    #[serde(default)]
    pub mnemonic: String,
    /// [crate::WalletType]
    #[serde(default)]
    pub wallet_type: String,
    /// [crate::NetType]
    //todo 钱包的网络类型需要吗？
    #[serde(default)]
    pub net_type: String,
    #[serde(default)]
    pub show:u32,
}

impl MWallet {
    pub const fn create_table_script() -> &'static str {
        std::include_str!("../../../sql/m_wallet.sql")
    }
}

//每一种链类型一条记录，实现时可以不写入数据库
#[db_append_shared]
#[derive(PartialEq, Serialize, Deserialize, Clone, Debug, Default, CRUDTable, DbBeforeSave, DbBeforeUpdate)]
pub struct MChainTypeMeta {
    /// [crate::ChainType]
    #[serde(default)]
    pub chain_type: String,
    #[serde(default)]
    pub short_name: String,
    #[serde(default)]
    pub full_name: String,
}

impl MChainTypeMeta {
    pub const fn create_table_script() -> &'static str {
        std::include_str!("../../../sql/m_chain_type_meta.sql")
    }
}

#[db_append_shared]
#[derive(PartialEq, Serialize, Deserialize, Clone, Debug, Default, CRUDTable, DbBeforeSave, DbBeforeUpdate)]
pub struct MAddress {
    /// [Wallet]
    #[serde(default)]
    pub wallet_id: String,
    /// [crate::ChainType]
    #[serde(default)]
    pub chain_type: String,
    #[serde(default)]
    pub address: String,
    #[serde(default)]
    pub public_key: String,
    /// 是否为钱包地址
    #[serde(default)]
    pub is_wallet_address: u32,
    #[serde(default)]
    pub show: u32,
}

impl MAddress {
    pub const fn create_table_script() -> &'static str {
        std::include_str!("../../../sql/m_address.sql")
    }
}

#[db_sub_struct]
#[derive(PartialEq, Serialize, Deserialize, Clone, Debug, Default)]
pub struct MTokenShared {
    #[serde(default)]
    pub name: String,
    #[serde(default)]
    pub symbol: String,
    #[serde(default)]
    pub logo_url: String,
    /// base 64编码
    #[serde(default)]
    pub logo_bytes: String,
    #[serde(default)]
    pub project_name: String,
    #[serde(default)]
    pub project_home: String,
    #[serde(default)]
    pub project_note: String,
}

#[db_sub_struct]
#[derive(Serialize, Deserialize, Clone, Debug, Default)]
pub struct MChainShared {
    #[serde(default)]
    pub wallet_id: String,
    #[serde(default)]
    pub chain_type: String,
    /// 钱包地址
    #[serde(default)]
    pub address_id: String,
}

#[cfg(test)]
mod tests {
    use futures::executor::block_on;
    use rbatis::crud::CRUDTable;
    use rbatis::rbatis::Rbatis;

    use crate::{ChainType, CTrue};
    use crate::kits::test::make_memory_rbatis_test;
    use crate::ma::{Dao, Db, DbCreateType, MAddress};

    #[test]
    fn m_address_test() {
        let rb = block_on(init_memory());
        let re = block_on(MAddress::list(&rb, ""));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let mut m = MAddress::default();
        m.chain_type = ChainType::EEE.to_string();
        m.wallet_id = "wallet_id".to_owned();
        m.public_key = "public_key".to_owned();
        m.address = "address".to_owned();
        m.wallet_address = CTrue;

        let re = block_on(m.save(&rb, ""));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let re = block_on(MAddress::list(&rb, ""));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let tokens = re.unwrap();
        assert_eq!(1, tokens.len(), "{:?}", tokens);

        let db_m = &tokens.as_slice()[0];
        assert_eq!(&m, db_m);

        let re = block_on(MAddress::fetch_by_id(&rb, "", &m.id));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let db_m = re.unwrap().unwrap();
        assert_eq!(m, db_m);
    }


    async fn init_memory() -> Rbatis {
        let rb = make_memory_rbatis_test().await;
        let r = Db::create_table(&rb, MAddress::create_table_script(), &MAddress::table_name(), &DbCreateType::Drop).await;
        assert_eq!(false, r.is_err(), "{:?}", r);
        rb
    }
}







