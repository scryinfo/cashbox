use std::ops::Add;

use rbatis::crud::CRUDEnable;
use rbatis::rbatis::Rbatis;

use crate::kits;
use crate::kits::Error;
use crate::ma::{MAddress, MBtcChainToken, MBtcChainTokenAuth, MBtcChainTokenDefault, MBtcChainTokenShared, MBtcChainTx, MBtcInputTx, MBtcOutputTx, MChainTypeMeta, MEeeChainToken, MEeeChainTokenAuth, MEeeChainTokenDefault, MEeeChainTokenShared, MEeeChainTx, MEeeTokenxTx, MEthChainToken, MEthChainTokenAuth, MEthChainTokenDefault, MEthChainTokenShared, MEthChainTx, MMnemonic, MSetting, MTokenAddress, MWallet};

#[derive(Debug, Default, Clone)]
pub struct DbName {
    pub cashbox_wallets: String,
    pub cashbox_mnemonic: String,
    pub wallet_mainnet: String,
    pub wallet_private: String,
    pub wallet_testnet: String,
    pub wallet_testnet_private: String,
}

impl DbName {
    pub fn new(pre: &str, path: &str) -> DbName {
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
        DbName {
            cashbox_wallets: format!("{}{}{}", path, pre, "cashbox_wallets.db"),
            cashbox_mnemonic: format!("{}{}{}", path, pre, "cashbox_mnemonic.db"),
            wallet_mainnet: format!("{}{}{}", path, pre, "wallet_mainnet.db"),
            wallet_private: format!("{}{}{}", path, pre, "wallet_private.db"),
            wallet_testnet: format!("{}{}{}", path, pre, "wallet_testnet.db"),
            wallet_testnet_private: format!("{}{}{}", path, pre, "wallet_testnet_private.db"),
        }
    }
}

pub enum DbCreateType {
    NotExists,
    CleanData,
    //call delete from table
    Drop,
}

pub struct Db {}

impl Db {
    pub async fn init_db(db_name: &DbName, create_type: &DbCreateType) -> Result<(), Error> {
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