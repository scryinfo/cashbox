use mav::ma::{MAddress, MChainShared, MTokenAddress, MTokenShared, MWallet};

use crate::{ContextTrait, deref_type, WalletError};

#[derive(Debug, Clone, Default)]
pub struct Address {
    pub m: MAddress,
}
deref_type!(Address,MAddress);

impl Address {
    pub async fn load(&mut self, context: &dyn ContextTrait, wallet_id: &str, chain_type: &str) -> Result<(), WalletError> {
        let mut wallet_rb = context.db().wallets_db();
        let address = MAddress::select_by_wallet_id_and_chain_type(&mut wallet_rb, wallet_id, chain_type).await?;
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
        let mut wallet_rb = context.db().wallets_db();
        let address = MAddress::select_by_wallet_id_and_chain_type(&mut wallet_rb, wallet_id, chain_type).await?;

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