use async_trait::async_trait;

use mav::ma::{Dao, MWallet, MAddress};
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
        log::debug!("log output test,wallet size: 1");
        log::debug!("wallet size:{}",dws.len());
        for dw in &dws {
            let mut w = Wallet::default();
            w.load(context, dw.clone()).await?;
            log::debug!("wallet detail is {:?}",w);
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
    pub async fn find_by_address(context: &dyn ContextTrait, address: &str) -> Result<Option<Wallet>, WalletError> {
        let wallet_db = context.db().wallets_db();
        let m_address = {
            let addr_wrapper = wallet_db.new_wrapper().eq(&MAddress::address, address);
            MAddress::fetch_by_wrapper(wallet_db, "", &addr_wrapper).await?
        };
        if m_address.is_none() {
            return Err(WalletError::Custom(format!("wallet address {} is not exist!", address)));
        }
        let address = m_address.unwrap();
        Self::find_by_id(context,&address.wallet_id.to_owned()).await
    }
    pub async fn m_wallet_by_id(context: &dyn ContextTrait, wallet_id: &str) -> Result<Option<MWallet>, WalletError> {
        let rb = context.db().wallets_db();
        let m_wallet = MWallet::fetch_by_id(rb, "", &wallet_id.to_owned()).await?;
        Ok(m_wallet)
    }
    pub async fn remove_by_id(context: &dyn ContextTrait, wallet_id: &str) -> Result<u64, WalletError> {
        let rb = context.db().wallets_db();
        let mut tx = rb.begin_tx_defer(false).await?;
        let re = MWallet::remove_by_id(rb, &tx.tx_id, &wallet_id.to_owned()).await?;
        //todo 删除相关表
        rb.commit(&tx.tx_id).await?;
        tx.manager = None;
        Ok(re)
    }

    pub async fn update_by_id(context: &dyn ContextTrait, m_wallet: &mut MWallet, tx_id: &str) -> Result<u64, WalletError> {
        let rb = context.db().wallets_db();
        let re = m_wallet.update_by_id(rb, tx_id).await?;
        //todo 其它字段怎么处理？
        Ok(re)
    }

    pub async fn m_wallet_by_name(context: &dyn ContextTrait, name: &str) -> Result<Vec<MWallet>, WalletError> {
        let rb = context.db().wallets_db();
        let  wrapper = rb.new_wrapper().eq(&MWallet::name, name);
        let dws = MWallet::list_by_wrapper(rb, "", &wrapper).await?;
        Ok(dws)
    }

    pub async fn mnemonic_digest(context: &dyn ContextTrait, digest: &str) -> Result<Vec<MWallet>, WalletError> {
        let rb = context.db().wallets_db();
        let  wrapper = rb.new_wrapper().eq(MWallet::mnemonic_digest, digest);
        let ms = MWallet::list_by_wrapper(rb, "", &wrapper).await?;
        Ok(ms)
    }

    pub async fn wallet_type_mnemonic_digest(context: &dyn ContextTrait, digest: &str, wallet_type: &WalletType) -> Result<Vec<MWallet>, WalletError> {
        let rb = context.db().wallets_db();
        let wrapper = rb.new_wrapper()
        .eq(MWallet::mnemonic_digest, digest.to_owned())
        .eq(MWallet::wallet_type, wallet_type.to_string());
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
        }
        {
            self.eee_chain.load(context, self.m.clone()).await?;
        }
        {
            self.btc_chain.load(context, self.m.clone()).await?;
        }

        Ok(())
    }
}
