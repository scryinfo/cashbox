use std::ops::Add;

use rbatis::crud::CRUDEnable;
use rbatis::rbatis::Rbatis;
use strum_macros::EnumIter;

use crate::{kits, NetType};
use crate::kits::Error;
use crate::ma::{MAddress, MBtcChainToken, MBtcChainTokenAuth, MBtcChainTokenDefault, MBtcChainTokenShared, MBtcChainTx, MBtcInputTx, MBtcOutputTx, MChainTypeMeta, MEeeChainToken, MEeeChainTokenAuth, MEeeChainTokenDefault, MEeeChainTokenShared, MEeeChainTx, MEeeTokenxTx, MEthChainToken, MEthChainTokenAuth, MEthChainTokenDefault, MEthChainTokenShared, MEthChainTx, MMnemonic, MSetting, MTokenAddress, MWallet};

#[derive(Debug, Default, Clone)]
pub struct DbNames {
    pub path: String,
    pub prefix: String,
    pub cashbox_wallets: String,
    pub cashbox_mnemonic: String,
    pub wallet_mainnet: String,
    pub wallet_private: String,
    pub wallet_testnet: String,
    pub wallet_testnet_private: String,
}

impl DbNames {
    pub fn new(pre: &str, path: &str) -> DbNames {
        let path = {
            if path.ends_with("/") {
                path.to_owned()
            } else if path.ends_with("\\") {
                path.replace("\\", "/")
            } else if !path.is_empty() {
                path.to_owned().add("/")
            } else {
                path.to_owned()
            }
        };
        DbNames {
            path: path.to_owned(),
            prefix: pre.to_owned(),
            cashbox_wallets: format!("{}{}{}", path, pre, DbNameType::cashbox_wallets.to_string()),
            cashbox_mnemonic: format!("{}{}{}", path, pre, DbNameType::cashbox_mnemonic.to_string()),
            wallet_mainnet: format!("{}{}{}", path, pre, DbNameType::wallet_mainnet.to_string()),
            wallet_private: format!("{}{}{}", path, pre, DbNameType::wallet_private.to_string()),
            wallet_testnet: format!("{}{}{}", path, pre, DbNameType::wallet_testnet.to_string()),
            wallet_testnet_private: format!("{}{}{}", path, pre, DbNameType::wallet_testnet_private.to_string()),
        }
    }

    pub fn db_name(&self, db_type: &DbNameType) -> String {
        let t = match db_type {
            DbNameType::cashbox_wallets => &self.cashbox_wallets,
            DbNameType::cashbox_mnemonic => &self.cashbox_mnemonic,
            DbNameType::wallet_mainnet => &self.wallet_mainnet,
            DbNameType::wallet_private => &self.wallet_private,
            DbNameType::wallet_testnet => &self.wallet_testnet,
            DbNameType::wallet_testnet_private => &self.wallet_testnet_private,
        };
        t.clone()
    }
    pub fn db_name_type(&self, db_name: &str) -> Option<DbNameType> {
        match &db_name.to_owned() {
            k if k == &self.cashbox_wallets => Some(DbNameType::cashbox_wallets),
            k if k == &self.cashbox_mnemonic => Some(DbNameType::cashbox_mnemonic),
            k if k == &self.wallet_mainnet => Some(DbNameType::wallet_mainnet),
            k if k == &self.wallet_private => Some(DbNameType::wallet_private),
            k if k == &self.wallet_testnet => Some(DbNameType::wallet_testnet),
            k if k == &self.wallet_testnet_private => Some(DbNameType::wallet_testnet_private),
            _ => None
        }
    }
}

#[allow(non_camel_case_types)]
#[derive(Debug, PartialEq, EnumIter)]
pub enum DbNameType {
    cashbox_wallets,
    cashbox_mnemonic,
    wallet_mainnet,
    wallet_private,
    wallet_testnet,
    wallet_testnet_private,
}

impl DbNameType {
    pub fn from(db_name: &str) -> Result<Self, Error> {
        match db_name {
            "cashbox_wallets.db" => Ok(DbNameType::cashbox_wallets),
            "cashbox_mnemonic.db" => Ok(DbNameType::cashbox_mnemonic),
            "wallet_mainnet.db" => Ok(DbNameType::wallet_mainnet),
            "wallet_private.db" => Ok(DbNameType::wallet_private),
            "wallet_testnet.db" => Ok(DbNameType::wallet_testnet),
            "wallet_testnet_private.db" => Ok(DbNameType::wallet_testnet_private),
            _ => {
                let err = format!("the str:{} can not to DbName", db_name);
                log::error!("{}",err);
                Err(Error::from(err.as_str()))
            }
        }
    }
}

impl ToString for DbNameType {
    fn to_string(&self) -> String {
        match &self {
            DbNameType::cashbox_wallets => "cashbox_wallets.db".to_owned(),
            DbNameType::cashbox_mnemonic => "cashbox_mnemonic.db".to_owned(),
            DbNameType::wallet_mainnet => "wallet_mainnet.db".to_owned(),
            DbNameType::wallet_private => "wallet_private.db".to_owned(),
            DbNameType::wallet_testnet => "wallet_testnet.db".to_owned(),
            DbNameType::wallet_testnet_private => "wallet_testnet_private.db".to_owned(),
        }
    }
}

pub enum DbCreateType {
    NotExists,
    CleanData,
    //call delete from table
    Drop,
}


#[derive(Default)]
pub struct Db {
    cashbox_wallets: Rbatis,
    cashbox_mnemonic: Rbatis,
    wallet_mainnet: Rbatis,
    wallet_private: Rbatis,
    wallet_testnet: Rbatis,
    wallet_testnet_private: Rbatis,
    pub db_name: DbNames,
}

impl Db {
    ///链数据的数据据库
    pub fn data_db(&self, net_type: &NetType) -> &Rbatis {
        match net_type {
            NetType::Main => &self.wallet_mainnet,
            NetType::Test => &self.wallet_testnet,
            NetType::Private => &self.wallet_private,
            NetType::PrivateTest => &self.wallet_testnet_private,
        }
    }
    ///钱包名等信息的数据库
    pub fn wallets_db(&self) -> &Rbatis {
        &self.cashbox_wallets
    }
    ///助记词的数据库
    pub fn mnemonic_db(&self) -> &Rbatis {
        &self.cashbox_mnemonic
    }

    pub async fn init(&mut self, name: &DbNames) -> Result<(), Error> {
        self.db_name = name.clone();
        self.cashbox_wallets = kits::make_rbatis(&self.db_name.cashbox_wallets).await?;
        self.cashbox_mnemonic = kits::make_rbatis(&self.db_name.cashbox_mnemonic).await?;
        self.wallet_mainnet = kits::make_rbatis(&self.db_name.wallet_mainnet).await?;
        self.wallet_private = kits::make_rbatis(&self.db_name.wallet_private).await?;
        self.wallet_testnet = kits::make_rbatis(&self.db_name.wallet_testnet).await?;
        self.wallet_testnet_private = kits::make_rbatis(&self.db_name.wallet_testnet_private).await?;
        Ok(())
    }
    pub async fn init_memory_sql(&mut self, name: &DbNames) -> Result<(), Error> {
        self.db_name = name.clone();
        self.cashbox_wallets = kits::make_memory_rbatis().await?;
        self.cashbox_mnemonic = kits::make_memory_rbatis().await?;
        self.wallet_mainnet = kits::make_memory_rbatis().await?;
        self.wallet_private = kits::make_memory_rbatis().await?;
        self.wallet_testnet = kits::make_memory_rbatis().await?;
        self.wallet_testnet_private = kits::make_memory_rbatis().await?;
        Ok(())
    }
    pub async fn init_tables(db_name: &DbNames, create_type: &DbCreateType) -> Result<(), Error> {
        let rb = &kits::make_rbatis(&db_name.cashbox_mnemonic).await?;
        Db::create_table_mnemonic(rb, create_type).await?;
        let rb = &kits::make_rbatis(&db_name.cashbox_wallets).await?;
        Db::create_table_wallets(rb, create_type).await?;

        let rb = &kits::make_rbatis(&db_name.wallet_mainnet).await?;
        Db::create_table_data(rb, create_type).await?;
        let rb = &kits::make_rbatis(&db_name.wallet_private).await?;
        Db::create_table_data(rb, create_type).await?;
        let rb = &kits::make_rbatis(&db_name.wallet_testnet).await?;
        Db::create_table_data(rb, create_type).await?;
        let rb = &kits::make_rbatis(&db_name.wallet_testnet_private).await?;
        Db::create_table_data(rb, create_type).await?;
        Ok(())
    }
    pub async fn create_table(rb: &Rbatis, sql: &str, name: &str, create_type: &DbCreateType) -> Result<(), Error> {
        match create_type {
            DbCreateType::NotExists => {
                rb.exec("", sql).await?;
            }
            DbCreateType::CleanData => {
                rb.exec("", sql).await?;
                rb.exec("", &format!("delete from {};", name)).await?;
            }
            DbCreateType::Drop => {
                rb.exec("", &format!("drop table if exists {};", name)).await?;
                rb.exec("", sql).await?;
            }
        }
        Ok(())
    }

    pub async fn create_table_mnemonic(rb: &Rbatis, create_type: &DbCreateType) -> Result<(), Error> {
        Db::create_table(rb, MMnemonic::create_table_script(), &MMnemonic::table_name(), create_type).await?;
        Ok(())
    }

    pub async fn create_table_wallets(rb: &Rbatis, create_type: &DbCreateType) -> Result<(), Error> {
        Db::create_table(rb, MWallet::create_table_script(), &MWallet::table_name(), create_type).await?;
        Db::create_table(rb, MChainTypeMeta::create_table_script(), &MChainTypeMeta::table_name(), create_type).await?;
        Db::create_table(rb, MAddress::create_table_script(), &MAddress::table_name(), create_type).await?;
        Db::create_table(rb, MSetting::create_table_script(), &MSetting::table_name(), create_type).await?;
        Db::create_table(rb, MEthChainToken::create_table_script(), &MEthChainToken::table_name(), create_type).await?;
        Db::create_table(rb, MEthChainTokenShared::create_table_script(), &MEthChainTokenShared::table_name(), create_type).await?;
        Db::create_table(rb, MEthChainTokenAuth::create_table_script(), &MEthChainTokenAuth::table_name(), create_type).await?;
        Db::create_table(rb, MEthChainTokenDefault::create_table_script(), &MEthChainTokenDefault::table_name(), create_type).await?;
        Db::create_table(rb, MEeeChainToken::create_table_script(), &MEeeChainToken::table_name(), create_type).await?;
        Db::create_table(rb, MEeeChainTokenShared::create_table_script(), &MEeeChainTokenShared::table_name(), create_type).await?;
        Db::create_table(rb, MEeeChainTokenAuth::create_table_script(), &MEeeChainTokenAuth::table_name(), create_type).await?;
        Db::create_table(rb, MEeeChainTokenDefault::create_table_script(), &MEeeChainTokenDefault::table_name(), create_type).await?;
        Db::create_table(rb, MBtcChainToken::create_table_script(), &MBtcChainToken::table_name(), create_type).await?;
        Db::create_table(rb, MBtcChainTokenShared::create_table_script(), &MBtcChainTokenShared::table_name(), create_type).await?;
        Db::create_table(rb, MBtcChainTokenAuth::create_table_script(), &MBtcChainTokenAuth::table_name(), create_type).await?;
        Db::create_table(rb, MBtcChainTokenDefault::create_table_script(), &MBtcChainTokenDefault::table_name(), create_type).await?;
        Ok(())
    }
    pub async fn create_table_data(rb: &Rbatis, create_type: &DbCreateType) -> Result<(), Error> {
        Db::create_table(rb, MTokenAddress::create_table_script(), &MTokenAddress::table_name(), create_type).await?;
        Db::create_table(rb, MEthChainToken::create_table_script(), &MEthChainToken::table_name(), create_type).await?;
        Db::create_table(rb, MEthChainTx::create_table_script(), &MEthChainTx::table_name(), create_type).await?;
        Db::create_table(rb, MEeeChainToken::create_table_script(), &MEeeChainToken::table_name(), create_type).await?;
        Db::create_table(rb, MEeeChainTx::create_table_script(), &MEeeChainTx::table_name(), create_type).await?;
        Db::create_table(rb, MEeeTokenxTx::create_table_script(), &MEeeTokenxTx::table_name(), create_type).await?;
        Db::create_table(rb, MBtcChainToken::create_table_script(), &MBtcChainToken::table_name(), create_type).await?;
        Db::create_table(rb, MBtcChainTx::create_table_script(), &MBtcChainTx::table_name(), create_type).await?;
        Db::create_table(rb, MBtcInputTx::create_table_script(), &MBtcInputTx::table_name(), create_type).await?;
        Db::create_table(rb, MBtcOutputTx::create_table_script(), &MBtcOutputTx::table_name(), create_type).await?;
        Ok(())
    }
}

#[cfg(test)]
mod tests {
    use futures::executor::block_on;
    use rbatis::rbatis::Rbatis;
    use strum::IntoEnumIterator;

    use crate::ma::{Db, DbNames, DbNameType};
    use crate::NetType;

    #[test]
    fn db_name_type_test() {
        for it in DbNameType::iter() {
            assert_eq!(it, DbNameType::from(&it.to_string()).unwrap());
        }
    }

    #[test]
    fn db_names_test() {
        {
            let pre = "";
            let db = DbNames::new(pre, "");
            for it in DbNameType::iter() {
                let name = db.db_name(&it);
                assert_eq!(name, pre.to_owned() + &it.to_string());
                let db_type = db.db_name_type(&name).expect(&format!("can not find name: {}", &name));
                assert_eq!(db_type, it);
            }
        }
        {
            let pre = "test";
            let db = DbNames::new(pre, "");
            for it in DbNameType::iter() {
                let name = db.db_name(&it);
                assert_eq!(name, pre.to_owned() + &it.to_string());
                let db_type = db.db_name_type(&name).expect(&format!("can not find name: {}", &name));
                assert_eq!(db_type, it);
            }
        }
        {
            let pre = "test";
            let db = DbNames::new(pre, "/");
            for it in DbNameType::iter() {
                let name = db.db_name(&it);
                assert_eq!(name, format!("/{}{}", pre, it.to_string()));
                let db_type = db.db_name_type(&name).expect(&format!("can not find name: {}", &name));
                assert_eq!(db_type, it);
            }
        }
        {
            let pre = "test";
            let db = DbNames::new(pre, "/user");
            for it in DbNameType::iter() {
                let name = db.db_name(&it);
                assert_eq!(name, format!("/user/{}{}", pre, it.to_string()));
                let db_type = db.db_name_type(&name).expect(&format!("can not find name: {}", &name));
                assert_eq!(db_type, it);
            }
        }
        {
            let pre = "test";
            let db = DbNames::new(pre, "/user/");
            for it in DbNameType::iter() {
                let name = db.db_name(&it);
                assert_eq!(name, format!("/user/{}{}", pre, it.to_string()));
                let db_type = db.db_name_type(&name).expect(&format!("can not find name: {}", &name));
                assert_eq!(db_type, it);
            }
        }
    }

    #[test]
    fn db_test() {
        let mut db = Db::default();
        let re = block_on(db.init(&DbNames::new("", "")));
        assert_eq!(false, re.is_err(), "{:?}", re.unwrap_err());

        assert_eq!(&db.cashbox_wallets as *const Rbatis, db.wallets_db() as *const Rbatis);
        assert_eq!(&db.cashbox_mnemonic as *const Rbatis, db.mnemonic_db() as *const Rbatis);
        assert_eq!(&db.wallet_mainnet as *const Rbatis, db.data_db(&NetType::Main) as *const Rbatis);
        assert_eq!(&db.wallet_testnet as *const Rbatis, db.data_db(&NetType::Test) as *const Rbatis);
        assert_eq!(&db.wallet_private as *const Rbatis, db.data_db(&NetType::Private) as *const Rbatis);
        assert_eq!(&db.wallet_testnet_private as *const Rbatis, db.data_db(&NetType::PrivateTest) as *const Rbatis);
    }
}