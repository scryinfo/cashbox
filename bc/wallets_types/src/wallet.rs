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
    pub async fn m_wallet_all(context: &dyn ContextTrait) -> Result<Vec<MWallet>, WalletError> {
        let dws = MWallet::list(context.db().wallets_db(), "").await?;
        Ok(dws)
    }
    pub async fn find_by_id(context: &dyn ContextTrait, wallet_id: &str) -> Result<Option<Wallet>, WalletError> {
        let rb = context.db().wallets_db();
        let m_wallet = MWallet::fetch_by_id(rb, "", &wallet_id.to_owned()).await?;
        match m_wallet {
            Some(m) => {
                let mut wallet = Wallet::default();
                wallet.load(context, m).await?;
                Ok(Some(wallet))
            }
            None => Ok(None)
        }
    }
    pub async fn m_wallet_by_id(context: &dyn ContextTrait, wallet_id: &str) -> Result<Option<MWallet>, WalletError> {
        let rb = context.db().wallets_db();
        let m_wallet = MWallet::fetch_by_id(rb, "", &wallet_id.to_owned()).await?;
        Ok(m_wallet)
    }
    pub async fn remove_by_id(context: &dyn ContextTrait, wallet_id: &str, tx_id: &str) -> Result<u64, WalletError> {
        let rb = context.db().wallets_db();
        let re = MWallet::remove_by_id(rb, tx_id, &wallet_id.to_owned()).await?;
        Ok(re)
    }

    pub async fn update_by_id(context: &dyn ContextTrait, m_wallet: &mut MWallet, tx_id: &str) -> Result<u64, WalletError> {
        let rb = context.db().wallets_db();
        let re = m_wallet.update_by_id(rb, tx_id).await?;
        Ok(re)
    }

    pub async fn m_wallet_by_name(context: &dyn ContextTrait, name: &str) -> Result<Vec<MWallet>, WalletError> {
        let rb = context.db().wallets_db();
        let mut wrapper = rb.new_wrapper();
        wrapper.eq(&MWallet::name, name);
        let dws = MWallet::list_by_wrapper(rb, "", &wrapper).await?;
        Ok(dws)
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
