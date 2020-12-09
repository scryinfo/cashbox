use async_trait::async_trait;
use rbatis::rbatis::Rbatis;

use mav::{ChainType, WalletType};
use mav::ma::{Dao, MBtcChainToken, MBtcChainTokenShared, MWallet};

use crate::{Chain2WalletType, ChainShared, deref_type, Load, TokenShared, WalletError};

#[derive(Debug, Default)]
pub struct BtcChainToken {
    pub m: MBtcChainToken,
    pub btc_chain_token_shared: BtcChainTokenShared,
}
deref_type!(BtcChainToken,MBtcChainToken);

#[async_trait]
impl Load for BtcChainToken {
    type MType = MBtcChainToken;
    async fn load(&mut self, rb: &Rbatis, m: Self::MType) -> Result<(), WalletError> {
        self.m = m;
        let token_shared = MBtcChainTokenShared::fetch_by_id(rb, "", &self.m.chain_token_shared_id).await?;
        self.btc_chain_token_shared.load(rb, token_shared).await?;
        Ok(())
    }
}

#[derive(Debug, Default)]
pub struct BtcChainTokenShared {
    pub m: MBtcChainTokenShared,
    pub token_shared: TokenShared,
}
deref_type!(BtcChainTokenShared,MBtcChainTokenShared);

#[async_trait]
impl Load for BtcChainTokenShared {
    type MType = MBtcChainTokenShared;
    async fn load(&mut self, _: &Rbatis, m: Self::MType) -> Result<(), WalletError> {
        self.m = m;
        self.token_shared.m = self.m.token_shared.clone();
        Ok(())
    }
}

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
    async fn load(&mut self, rb: &Rbatis, mw: MWallet) -> Result<(), WalletError> {
        self.chain_shared.set_m(&mw);
        let wallet_type = WalletType::from(&mw.wallet_type);
        self.chain_shared.m.chain_type = self.to_chain_type(&wallet_type).to_string();

        {//load token
            let mut wrapper = rb.new_wrapper();
            wrapper.eq(MBtcChainToken::wallet_id, mw.id.clone()).eq(MBtcChainToken::chain_type, self.chain_shared.chain_type.clone());
            let ms = MBtcChainToken::list_by_wrapper(&rb, "", &wrapper).await?;
            self.tokens.clear();
            for it in ms {
                let mut token = BtcChainToken::default();
                token.load(rb, it).await?;
                self.tokens.push(token);
            }
        }
        Ok(())
    }
}

