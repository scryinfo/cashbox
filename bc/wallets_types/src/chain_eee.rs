use async_trait::async_trait;
use rbatis::rbatis::Rbatis;

use mav::{ChainType, WalletType};
use mav::ma::{MEeeChainToken, MEeeChainTokenShared, MWallet};

use crate::{Address, Chain2WalletType, ChainShared, deref_type, Load, TokenShared, WalletError};

#[derive(Debug, Default)]
pub struct EeeChainToken {
    pub m: MEeeChainToken,
    pub eee_chain_token_shared: EeeChainTokenShared,
}
deref_type!(EeeChainToken,MEeeChainToken);

#[derive(Debug, Default)]
pub struct EeeChainTokenShared {
    pub m: MEeeChainTokenShared,
    pub token_shared: TokenShared,
}
deref_type!(EeeChainTokenShared,MEeeChainTokenShared);

#[derive(Debug, Default)]
pub struct EeeChain {
    pub chain_shared: ChainShared,
    pub address: Address,
    pub tokens: Vec<EeeChainToken>,
}

impl Chain2WalletType for EeeChain {
    fn chain_type(wallet_type: &WalletType) -> ChainType {
        match wallet_type {
            WalletType::Normal => ChainType::EEE,
            _ => ChainType::EeeTest,
        }
    }

    fn to_chain_type(&self, wallet_type: &WalletType) -> ChainType {
        EeeChain::chain_type(wallet_type)
    }
}

#[async_trait]
impl Load for EeeChain {
    type MType = MWallet;
    async fn load(&mut self, rb: &Rbatis, mw: MWallet) -> Result<(), WalletError> {
        self.chain_shared.set_m(&mw);
        let wallet_type = WalletType::from(&mw.wallet_type);
        self.chain_shared.m.chain_type = self.to_chain_type(&wallet_type).to_string();
        //todo

        Ok(())
    }
}