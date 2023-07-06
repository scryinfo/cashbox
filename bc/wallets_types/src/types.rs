use mav::ma::{MAddress, MChainShared, MTokenAddress, MTokenShared, MWallet};
use mav::ma::Dao;

use crate::{ContextTrait, deref_type, WalletError};

#[derive(Debug, Clone, Default)]
pub struct Address {
    pub m: MAddress,
}
deref_type!(Address,MAddress);

impl Address {
    pub async fn load(&mut self, context: &dyn ContextTrait, wallet_id: &str, chain_type: &str) -> Result<(), WalletError> {
        let wallet_rb = context.db().wallets_db();
        let wrapper = wallet_rb.new_wrapper()
            .eq(MAddress::wallet_id, wallet_id)
            .eq(MAddress::chain_type, chain_type);
        let address = MAddress::fetch_by_wrapper(&wallet_rb, "", &wrapper).await?;
        if let Some(address) = address {
            self.m = address;
        }
        Ok(())
    }
}

pub type TokenShared = MTokenShared;

#[derive(Debug, Clone, Default)]
pub struct ChainShared {
    pub m: MChainShared,
    /// 钱包地址
    pub wallet_address: Address,
}

impl ChainShared {
    pub fn set_m(&mut self, mw: &MWallet) {
        self.m.wallet_id = mw.id.clone();
    }

    pub async fn set_addr(&mut self, context: &dyn ContextTrait, wallet_id: &str, chain_type: &str) -> Result<(), WalletError> {
        let wallet_rb = context.db().wallets_db();
        let wrapper = wallet_rb.new_wrapper()
            .eq(MAddress::wallet_id, wallet_id)
            .eq(MAddress::chain_type, chain_type);
        let address = MAddress::fetch_by_wrapper(&wallet_rb, "", &wrapper).await?;

        if let Some(address) = address {
            let addr = Address { m: address };
            self.wallet_address = addr;
        }
        Ok(())
    }
}

deref_type!(ChainShared,MChainShared);

#[derive(Debug, Clone, Default)]
pub struct TokenAddress {
    pub m: MTokenAddress,
}
deref_type!(TokenAddress,MTokenAddress);