use async_trait::async_trait;

use mav::ma::{Dao, MWallet};
use mav::WalletType;

use crate::{BtcChain, ContextTrait, EeeChain, EthChain, Load, WalletError};
use crate::deref_type;

#[derive(Debug, Default)]
pub struct Wallet {
    pub m: MWallet,
    pub eth_chain: EthChain,
    pub eee_chain: EeeChain,
    pub btc_chain: BtcChain,
}
deref_type!(Wallet,MWallet);

impl Wallet {
    pub async fn has_any(context: &dyn ContextTrait) -> Result<bool, WalletError> {
        let rb = context.db().wallets_db();
        let r = MWallet::exist_by_wrapper(rb, "", &rb.new_wrapper()).await?;
        Ok(r)
    }
    pub async fn count(context: &dyn ContextTrait) -> Result<i64, WalletError> {
        let rb = context.db().wallets_db();
        let count = MWallet::count_by_wrapper(rb, "", &rb.new_wrapper()).await?;
        Ok(count)
    }

    pub async fn all(context: &dyn ContextTrait) -> Result<Vec<Wallet>, WalletError> {
        let mut ws = Vec::new();
        let dws = MWallet::list(context.db().wallets_db(), "").await?;
        for dw in &dws {
            let mut w = Wallet::default();
            w.load(context, dw.clone()).await?;
            ws.push(w);
        }
        Ok(ws)
    }

    pub async fn mnemonic_digest(context: &dyn ContextTrait, digest: &str) -> Result<Vec<MWallet>, WalletError> {
        let rb = context.db().wallets_db();
        let mut wrapper = rb.new_wrapper();
        wrapper.eq(MWallet::mnemonic_digest, digest);
        let ms = MWallet::list_by_wrapper(rb, "", &wrapper).await?;
        Ok(ms)
    }

    pub async fn wallet_type_mnemonic_digest(context: &dyn ContextTrait, digest: &str, wallet_type: &WalletType) -> Result<Vec<MWallet>, WalletError> {
        let rb = context.db().wallets_db();
        let mut wrapper = rb.new_wrapper();
        wrapper.eq(MWallet::mnemonic_digest, digest.to_owned());
        wrapper.eq(MWallet::wallet_type, wallet_type.to_string());
        let ms = MWallet::list_by_wrapper(rb, "", &wrapper).await?;
        Ok(ms)
    }
}

#[async_trait]
impl Load for Wallet {
    type MType = MWallet;
    async fn load(&mut self, context: &dyn ContextTrait, mw: MWallet) -> Result<(), WalletError> {
        self.m = mw;
        {
            self.eth_chain.load(context, self.m.clone()).await?;
            //todo wallet address
        }
        {
            self.eee_chain.load(context, self.m.clone()).await?;
            //todo wallet address
        }
        {
            self.btc_chain.load(context, self.m.clone()).await?;
            //todo wallet address
        }

        Ok(())
    }
}
