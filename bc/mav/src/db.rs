use wallets_types::{DbName,WalletError};

use rbatis::rbatis::Rbatis;
use async_std::task::block_on;

use crate::kits;

#[derive(Default)]
pub struct Db {
    cashbox_wallets: Rbatis,
    cashbox_mnemonic: Rbatis,
    wallet_mainnet: Rbatis,
    wallet_private: Rbatis,
    wallet_testnet: Rbatis,
    wallet_testnet_private: Rbatis,
    db_name: DbName,
}

impl Db {
    pub fn init(&mut self, name: &DbName) -> Result<(), WalletError> {
        self.db_name = name.clone();
        self.cashbox_wallets = block_on(kits::make_rbatis(&self.db_name.cashbox_wallets))?;
        self.cashbox_mnemonic = block_on(kits::make_rbatis(&self.db_name.cashbox_mnemonic))?;
        self.wallet_mainnet = block_on(kits::make_rbatis(&self.db_name.wallet_mainnet))?;
        self.wallet_private = block_on(kits::make_rbatis(&self.db_name.wallet_private))?;
        self.wallet_testnet = block_on(kits::make_rbatis(&self.db_name.wallet_testnet))?;
        self.wallet_testnet_private = block_on(kits::make_rbatis(&self.db_name.wallet_testnet_private))?;

        Ok(())
    }
}