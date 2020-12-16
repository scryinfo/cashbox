use async_trait::async_trait;

use mav::{ChainType, WalletType};
use mav::ma::{Dao, MEeeChainToken, MEeeChainTokenShared, MWallet};

use crate::{Address, Chain2WalletType, ChainShared, ContextTrait, deref_type, Load, TokenShared, WalletError};

#[derive(Debug, Default)]
pub struct EeeChainToken {
    pub m: MEeeChainToken,
    pub eee_chain_token_shared: EeeChainTokenShared,
}
deref_type!(EeeChainToken,MEeeChainToken);

#[async_trait]
impl Load for EeeChainToken {
    type MType = MEeeChainToken;
    async fn load(&mut self, context: &dyn ContextTrait, m: Self::MType) -> Result<(), WalletError> {
        self.m = m;
        let rb = context.db().wallets_db();
        let token_shared = MEeeChainTokenShared::fetch_by_id(rb, "", &self.m.chain_token_shared_id).await?;
        self.eee_chain_token_shared.load(context, token_shared).await?;
        Ok(())
    }
}

#[derive(Debug, Default)]
pub struct EeeChainTokenShared {
    pub m: MEeeChainTokenShared,
    pub token_shared: TokenShared,
}
deref_type!(EeeChainTokenShared,MEeeChainTokenShared);

#[async_trait]
impl Load for EeeChainTokenShared {
    type MType = MEeeChainTokenShared;
    async fn load(&mut self, _: &dyn ContextTrait, m: Self::MType) -> Result<(), WalletError> {
        self.m = m;
        self.token_shared.m = self.m.token_shared.clone();
        Ok(())
    }
}

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
    async fn load(&mut self, context: &dyn ContextTrait, mw: MWallet) -> Result<(), WalletError> {
        self.chain_shared.set_m(&mw);
        let wallet_type = WalletType::from(&mw.wallet_type);
        self.chain_shared.m.chain_type = self.to_chain_type(&wallet_type).to_string();

        {//load token
            let rb = context.db().wallets_db();
            let mut wrapper = rb.new_wrapper();
            wrapper.eq(MEeeChainToken::wallet_id, mw.id.clone()).eq(MEeeChainToken::chain_type, self.chain_shared.chain_type.clone());
            let ms = MEeeChainToken::list_by_wrapper(&rb, "", &wrapper).await?;
            self.tokens.clear();
            for it in ms {
                let mut token = EeeChainToken::default();
                token.load(context, it).await?;
                self.tokens.push(token);
            }
        }
        Ok(())
    }
}
