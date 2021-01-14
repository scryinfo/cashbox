use std::ops::Add;

use rbatis::crud::CRUDEnable;
use rbatis::rbatis::Rbatis;
use strum::IntoEnumIterator;
use strum_macros::EnumIter;

use crate::{kits, NetType};
use crate::kits::Error;
use crate::ma::{BtcTokenType, Dao, EeeTokenType, EthTokenType, MAccountInfoSyncProg, MAddress, MBtcChainToken, MBtcChainTokenAuth, MBtcChainTokenDefault, MBtcChainTokenShared, MBtcChainTx, MBtcInputTx, MBtcOutputTx, MChainTypeMeta, MEeeChainToken, MEeeChainTokenAuth, MEeeChainTokenDefault, MEeeChainTokenShared, MEeeChainTx, MEeeTokenxTx, MEthChainToken, MEthChainTokenAuth, MEthChainTokenDefault, MEthChainTokenShared, MEthChainTx, MMnemonic, MSetting, MSubChainBasicInfo, MTokenAddress, MWallet};

#[derive(Debug, Default, Clone)]
pub struct DbName {
    pub path: String,
    pub prefix: String,
    pub cashbox_wallets: String,
    pub cashbox_mnemonic: String,
    pub wallet_mainnet: String,
    pub wallet_private: String,
    pub wallet_testnet: String,
    pub wallet_testnet_private: String,
}

impl DbName {
    pub fn new(pre: &str, path: &str) -> DbName {
        let mut temp = DbName::default();
        temp.path = path.to_owned();
        temp.prefix = pre.to_owned();
        DbName::new_from(&temp)
    }

    pub fn new_from(names: &DbName) -> DbName {
        let path = {
            let path = names.path.clone();
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
        let pre = names.prefix.clone();
        DbName {
            path: path.to_owned(),
            prefix: pre.to_owned(),
            cashbox_wallets: if names.cashbox_wallets.is_empty() {
                format!("{}{}{}", path, pre, DbNameType::cashbox_wallets.to_string())
            } else { names.cashbox_wallets.clone() },
            cashbox_mnemonic: if names.cashbox_mnemonic.is_empty() {
                format!("{}{}{}", path, pre, DbNameType::cashbox_mnemonic.to_string())
            }else{names.cashbox_mnemonic.clone()},
            wallet_mainnet: if names.wallet_mainnet.is_empty(){
                format!("{}{}{}", path, pre, DbNameType::wallet_mainnet.to_string())
            }else{names.wallet_mainnet.clone()},
            wallet_private: if names.wallet_private.is_empty(){
                format!("{}{}{}", path, pre, DbNameType::wallet_private.to_string())
            }else{names.wallet_private.clone()},
            wallet_testnet: if names.wallet_testnet.is_empty(){
                format!("{}{}{}", path, pre, DbNameType::wallet_testnet.to_string())
            }else{names.wallet_testnet.clone()},
            wallet_testnet_private: if names.wallet_testnet_private.is_empty(){
                format!("{}{}{}", path, pre, DbNameType::wallet_testnet_private.to_string())
            }else{names.wallet_testnet_private.clone()},
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
                log::error!("{}", err);
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
    pub db_name: DbName,
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

    pub async fn init(&mut self, name: &DbName) -> Result<(), Error> {
        self.db_name = name.clone();
        self.cashbox_wallets = kits::make_rbatis(&self.db_name.cashbox_wallets).await?;
        self.cashbox_mnemonic = kits::make_rbatis(&self.db_name.cashbox_mnemonic).await?;
        self.wallet_mainnet = kits::make_rbatis(&self.db_name.wallet_mainnet).await?;
        self.wallet_private = kits::make_rbatis(&self.db_name.wallet_private).await?;
        self.wallet_testnet = kits::make_rbatis(&self.db_name.wallet_testnet).await?;
        self.wallet_testnet_private = kits::make_rbatis(&self.db_name.wallet_testnet_private).await?;
        Ok(())
    }
    pub async fn init_memory_sql(&mut self, name: &DbName) -> Result<(), Error> {
        self.db_name = name.clone();
        self.cashbox_wallets = kits::make_memory_rbatis().await?;
        self.cashbox_mnemonic = kits::make_memory_rbatis().await?;
        self.wallet_mainnet = kits::make_memory_rbatis().await?;
        self.wallet_private = kits::make_memory_rbatis().await?;
        self.wallet_testnet = kits::make_memory_rbatis().await?;
        self.wallet_testnet_private = kits::make_memory_rbatis().await?;
        Ok(())
    }
    pub async fn init_tables(&self, create_type: &DbCreateType) -> Result<(), Error> {
        let rb = self.mnemonic_db();
        Db::create_table_mnemonic(rb, create_type).await?;
        let rb = self.wallets_db();
        Db::create_table_wallets(rb, create_type).await?;

        for net_type in NetType::iter() {
            let rb = self.data_db(&net_type);
            Db::create_table_data(rb, create_type).await?;
        }

        Db::insert_chain_token(self).await?;
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

    ///total: 16
    pub async fn create_table_wallets(rb: &Rbatis, create_type: &DbCreateType) -> Result<(), Error> {
        Db::create_table(rb, MWallet::create_table_script(), &MWallet::table_name(), create_type).await?;
        Db::create_table(rb, MChainTypeMeta::create_table_script(), &MChainTypeMeta::table_name(), create_type).await?;
        Db::create_table(rb, MAddress::create_table_script(), &MAddress::table_name(), create_type).await?;
        Db::create_table(rb, MSetting::create_table_script(), &MSetting::table_name(), create_type).await?;
        // Db::create_table(rb, MEthChainToken::create_table_script(), &MEthChainToken::table_name(), create_type).await?;
        Db::create_table(rb, MEthChainTokenShared::create_table_script(), &MEthChainTokenShared::table_name(), create_type).await?;
        Db::create_table(rb, MEthChainTokenAuth::create_table_script(), &MEthChainTokenAuth::table_name(), create_type).await?;
        Db::create_table(rb, MEthChainTokenDefault::create_table_script(), &MEthChainTokenDefault::table_name(), create_type).await?;
        // Db::create_table(rb, MEeeChainToken::create_table_script(), &MEeeChainToken::table_name(), create_type).await?;
        Db::create_table(rb, MEeeChainTokenShared::create_table_script(), &MEeeChainTokenShared::table_name(), create_type).await?;
        Db::create_table(rb, MEeeChainTokenAuth::create_table_script(), &MEeeChainTokenAuth::table_name(), create_type).await?;
        Db::create_table(rb, MEeeChainTokenDefault::create_table_script(), &MEeeChainTokenDefault::table_name(), create_type).await?;
        // Db::create_table(rb, MBtcChainToken::create_table_script(), &MBtcChainToken::table_name(), create_type).await?;
        Db::create_table(rb, MBtcChainTokenShared::create_table_script(), &MBtcChainTokenShared::table_name(), create_type).await?;
        Db::create_table(rb, MBtcChainTokenAuth::create_table_script(), &MBtcChainTokenAuth::table_name(), create_type).await?;
        Db::create_table(rb, MBtcChainTokenDefault::create_table_script(), &MBtcChainTokenDefault::table_name(), create_type).await?;
        Ok(())
    }
    ///total: 12
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
        Db::create_table(rb, MSubChainBasicInfo::create_table_script(), &MSubChainBasicInfo::table_name(), create_type).await?;
        Db::create_table(rb, MAccountInfoSyncProg::create_table_script(), &MAccountInfoSyncProg::table_name(), create_type).await?;
        Ok(())
    }
    /// such as: eth,eee,btc
    pub async fn insert_chain_token(db: &Db) -> Result<(), Error> {
        {//eth
            let rb = db.wallets_db();
            let token_shared = {
                let mut eth = MEthChainTokenShared::default();
                eth.token_type = EthTokenType::Eth.to_string();
                eth.contract_address = "".to_owned();
                eth.decimal = 18;
                eth.gas_limit = 0; //todo
                eth.gas_price = "".to_owned(); //todo

                eth.token_shared.name = "Ethereum".to_owned();
                eth.token_shared.symbol = "ETH".to_owned();
                eth.token_shared.logo_url = "".to_owned();//todo
                eth.token_shared.logo_bytes = "".to_owned();
                eth.token_shared.project_name = "ethereum".to_owned();
                eth.token_shared.project_home = "https://ethereum.org/zh/".to_owned();
                eth.token_shared.project_note = "Ethereum is a global, open-source platform for decentralized applications.".to_owned();

                let old_eth = {
                    let mut wrapper = rb.new_wrapper();
                    wrapper.eq(MEthChainTokenShared::token_type, &eth.token_type);
                    MEthChainTokenShared::fetch_by_wrapper(rb, "", &wrapper).await?
                };
                if let Some(t) = old_eth {
                    eth = t;
                } else {
                    eth.save(rb, "").await?;
                }
                eth
            };
            {//token_default
                for net_type in NetType::iter() {
                    let mut wrapper = rb.new_wrapper();
                    wrapper.eq(MEthChainTokenDefault::chain_token_shared_id, token_shared.id.clone());
                    wrapper.eq(MEthChainTokenDefault::net_type, net_type.to_string());
                    let old = MEthChainTokenDefault::exist_by_wrapper(rb, "", &wrapper).await?;
                    if !old {
                        let mut token_default = MEthChainTokenDefault::default();
                        token_default.net_type = net_type.to_string();
                        token_default.chain_token_shared_id = token_shared.id.clone();
                        token_default.position = 0;
                        token_default.save(rb, "").await?;
                    }
                }
            }
        }
        {//eee
            let rb = db.wallets_db();
            let token_shared = {
                let mut eee = MEeeChainTokenShared::default();
                eee.token_type = EeeTokenType::Eee.to_string();
                eee.decimal = 15;
                eee.gas = 0; //todo

                eee.token_shared.name = "EEE".to_owned();
                eee.token_shared.symbol = "EEE".to_owned();
                eee.token_shared.logo_url = "".to_owned();//todo
                eee.token_shared.logo_bytes = "".to_owned();
                eee.token_shared.project_name = "EEE".to_owned();
                eee.token_shared.project_home = "https://scry.info".to_owned();
                eee.token_shared.project_note = "EEE is a global".to_owned();

                let old_eth = {
                    let mut wrapper = rb.new_wrapper();
                    wrapper.eq(MEeeChainTokenShared::token_type, &eee.token_type);
                    MEeeChainTokenShared::fetch_by_wrapper(rb, "", &wrapper).await?
                };
                if let Some(t) = old_eth {
                    eee = t;
                } else {
                    eee.save(rb, "").await?;
                }
                eee
            };
            {//token_default
                for net_type in NetType::iter() {
                    let mut wrapper = rb.new_wrapper();
                    wrapper.eq(MEeeChainTokenDefault::chain_token_shared_id, token_shared.id.clone());
                    wrapper.eq(MEeeChainTokenDefault::net_type, net_type.to_string());
                    let old = MEeeChainTokenDefault::exist_by_wrapper(rb, "", &wrapper).await?;
                    if !old {
                        let mut token_default = MEeeChainTokenDefault::default();
                        token_default.net_type = net_type.to_string();
                        token_default.chain_token_shared_id = token_shared.id.clone();
                        token_default.position = 0;
                        token_default.save(rb, "").await?;
                    }
                }
            }
        }
        {//btc
            let rb = db.wallets_db();
            let token_shared = {
                let mut btc = MBtcChainTokenShared::default();
                btc.token_type = BtcTokenType::Btc.to_string();
                btc.decimal = 18;
                btc.gas = 0; //todo

                btc.token_shared.name = "Bitcoin".to_owned();
                btc.token_shared.symbol = "BTC".to_owned();
                btc.token_shared.logo_url = "".to_owned();//todo
                btc.token_shared.logo_bytes = "".to_owned();
                btc.token_shared.project_name = "Bitcoin".to_owned();
                btc.token_shared.project_home = "https://bitcoin.org/en/".to_owned();
                btc.token_shared.project_note = "Bitcoin is a global, open-source platform for decentralized applications.".to_owned();

                let old_eth = {
                    let mut wrapper = rb.new_wrapper();
                    wrapper.eq(MBtcChainTokenShared::token_type, &btc.token_type);
                    MBtcChainTokenShared::fetch_by_wrapper(rb, "", &wrapper).await?
                };
                if let Some(t) = old_eth {
                    btc = t;
                } else {
                    btc.save(rb, "").await?;
                }
                btc
            };
            {//token_default
                for net_type in NetType::iter() {
                    let mut wrapper = rb.new_wrapper();
                    wrapper.eq(MBtcChainTokenDefault::chain_token_shared_id, token_shared.id.clone());
                    wrapper.eq(MBtcChainTokenDefault::net_type, net_type.to_string());
                    let old = MBtcChainTokenDefault::exist_by_wrapper(rb, "", &wrapper).await?;
                    if !old {
                        let mut token_default = MBtcChainTokenDefault::default();
                        token_default.net_type = net_type.to_string();
                        token_default.chain_token_shared_id = token_shared.id.clone();
                        token_default.position = 0;
                        token_default.save(rb, "").await?;
                    }
                }
            }
        }

        Ok(())
    }
}

#[cfg(test)]
mod tests {
    use futures::executor::block_on;
    use rbatis::rbatis::Rbatis;
    use strum::IntoEnumIterator;

    use crate::ma::{Db, DbName, DbNameType};
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
            let db = DbName::new(pre, "");
            for it in DbNameType::iter() {
                let name = db.db_name(&it);
                assert_eq!(name, pre.to_owned() + &it.to_string());
                let db_type = db.db_name_type(&name).expect(&format!("can not find name: {}", &name));
                assert_eq!(db_type, it);
            }
        }
        {
            let pre = "test";
            let db = DbName::new(pre, "");
            for it in DbNameType::iter() {
                let name = db.db_name(&it);
                assert_eq!(name, pre.to_owned() + &it.to_string());
                let db_type = db.db_name_type(&name).expect(&format!("can not find name: {}", &name));
                assert_eq!(db_type, it);
            }
        }
        {
            let pre = "test";
            let db = DbName::new(pre, "/");
            for it in DbNameType::iter() {
                let name = db.db_name(&it);
                assert_eq!(name, format!("/{}{}", pre, it.to_string()));
                let db_type = db.db_name_type(&name).expect(&format!("can not find name: {}", &name));
                assert_eq!(db_type, it);
            }
        }
        {
            let pre = "test";
            let db = DbName::new(pre, "/user");
            for it in DbNameType::iter() {
                let name = db.db_name(&it);
                assert_eq!(name, format!("/user/{}{}", pre, it.to_string()));
                let db_type = db.db_name_type(&name).expect(&format!("can not find name: {}", &name));
                assert_eq!(db_type, it);
            }
        }
        {
            let pre = "test";
            let db = DbName::new(pre, "/user/");
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
        let re = block_on(db.init(&DbName::new("test_", "./temp")));
        assert_eq!(false, re.is_err(), "{:?}", re);

        assert_eq!(&db.cashbox_wallets as *const Rbatis, db.wallets_db() as *const Rbatis);
        assert_eq!(&db.cashbox_mnemonic as *const Rbatis, db.mnemonic_db() as *const Rbatis);
        assert_eq!(&db.wallet_mainnet as *const Rbatis, db.data_db(&NetType::Main) as *const Rbatis);
        assert_eq!(&db.wallet_testnet as *const Rbatis, db.data_db(&NetType::Test) as *const Rbatis);
        assert_eq!(&db.wallet_private as *const Rbatis, db.data_db(&NetType::Private) as *const Rbatis);
        assert_eq!(&db.wallet_testnet_private as *const Rbatis, db.data_db(&NetType::PrivateTest) as *const Rbatis);
    }
}