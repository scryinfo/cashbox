use rbatis::rbatis::Rbatis;
use async_trait::async_trait;
use mav::{ChainType, WalletType};
use mav::ma::{MBtcChainToken, MBtcChainTokenShared, MWallet};

use crate::{Chain2WalletType, ChainShared, deref_type, TokenShared, Load, WalletError};

#[derive(Debug, Default)]
pub struct BtcChainToken {
    pub m: MBtcChainToken,
    pub token_shared: BtcChainTokenShared,
}
deref_type!(BtcChainToken,MBtcChainToken);

#[derive(Debug, Default)]
pub struct BtcChainTokenShared {
    pub m: MBtcChainTokenShared,
    pub token_shared: TokenShared,
}
deref_type!(BtcChainTokenShared,MBtcChainTokenShared);
#[derive(Debug, Default)]
pub struct BtcChain {
    pub chain_shared: ChainShared,
    pub tokens: Vec<BtcChainToken>,
}

impl Chain2WalletType for BtcChain {
    fn chain_type(wallet_type: &WalletType) -> ChainType {
        match wallet_type {
            WalletType::Normal => ChainType::BTC,
            _ => ChainType::BtcTest,
        }
    }

    fn to_chain_type(&self, wallet_type: &WalletType) -> ChainType {
        BtcChain::chain_type(wallet_type)
    }
}
#[async_trait]
impl Load for BtcChain {
    type MType = MWallet;
    async fn load(&mut self, rb: &Rbatis, mw: &MWallet) -> Result<(), WalletError> {
        self.chain_shared.set_m(mw);
        let wallet_type = WalletType::from(&mw.wallet_type);
        self.chain_shared.m.chain_type = self.to_chain_type(&wallet_type).to_string();
        //todo
        Ok(())
    }
}

