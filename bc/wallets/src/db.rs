use rbatis::rbatis::Rbatis;

use mav::kits;
use wallets_types::{DbName, WalletError};

#[derive(Default)]
pub struct Db {
    pub cashbox_wallets: Rbatis,
    pub cashbox_mnemonic: Rbatis,
    pub wallet_mainnet: Rbatis,
    pub wallet_private: Rbatis,
    pub wallet_testnet: Rbatis,
    pub wallet_testnet_private: Rbatis,
    pub db_name: DbName,
}

impl Db {
    pub async fn init(&mut self, name: &DbName) -> Result<(), WalletError> {
        self.db_name = name.clone();
        self.cashbox_wallets = kits::make_rbatis(&self.db_name.cashbox_wallets).await?;
        self.cashbox_mnemonic = kits::make_rbatis(&self.db_name.cashbox_mnemonic).await?;
        self.wallet_mainnet = kits::make_rbatis(&self.db_name.wallet_mainnet).await?;
        self.wallet_private = kits::make_rbatis(&self.db_name.wallet_private).await?;
        self.wallet_testnet = kits::make_rbatis(&self.db_name.wallet_testnet).await?;
        self.wallet_testnet_private = kits::make_rbatis(&self.db_name.wallet_testnet_private).await?;

        Ok(())
    }
}