use mav::{NetType, WalletType};
//use async_trait::async_trait;
use mav::ma::{Dao, MAddress, MWallet};

use crate::{BtcChain, ContextTrait, EeeChain, EthChain, WalletError};
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
    pub async fn has_any(context: &dyn ContextTrait, net_type: &NetType) -> Result<bool, WalletError> {
        let rb = context.db().wallets_db();
        let wrapper = rb.new_wrapper().eq(MWallet::wallet_type, &WalletType::from(net_type).to_string());
        let r = MWallet::exist_by_wrapper(rb, "", &wrapper).await?;
        Ok(r)
    }
    pub async fn count(context: &dyn ContextTrait, net_type: &NetType) -> Result<i64, WalletError> {
        let rb = context.db().wallets_db();
        let wrapper = rb.new_wrapper().eq(MWallet::wallet_type, &WalletType::from(net_type).to_string());
        let count = MWallet::count_by_wrapper(rb, "", &wrapper).await?;
        Ok(count)
    }

    pub async fn all(context: &dyn ContextTrait, net_type: &NetType) -> Result<Vec<Wallet>, WalletError> {
        let mut wallets = Vec::new();
        let wallet_rb = context.db().wallets_db();
        let filter_value = if NetType::Main.eq(net_type) { WalletType::Normal.to_string() } else { WalletType::Test.to_string() };
        let wrapper = wallet_rb.new_wrapper().eq(MWallet::wallet_type, filter_value.as_str());
        let dws = MWallet::list_by_wrapper(wallet_rb, "", &wrapper).await?;
        for dw in &dws {
            let mut wallet = Wallet::default();
            wallet.load(context, dw.clone(), net_type).await?;
            wallets.push(wallet);
        }
        Ok(wallets)
    }
    pub async fn m_wallet_all(context: &dyn ContextTrait) -> Result<Vec<MWallet>, WalletError> {
        let dws = MWallet::list(context.db().wallets_db(), "").await?;
        Ok(dws)
    }
    pub async fn find_by_id(context: &dyn ContextTrait, wallet_id: &str, net_type: &NetType) -> Result<Option<Wallet>, WalletError> {
        let rb = context.db().wallets_db();
        let m_wallet = MWallet::fetch_by_id(rb, "", &wallet_id.to_owned()).await?;
        match m_wallet {
            Some(m) => {
                let mut wallet = Wallet::default();
                wallet.load(context, m, net_type).await?;
                Ok(Some(wallet))
            }
            None => Ok(None)
        }
    }
    //todo 当一个助记词在测试链下多次使用时，会造成一个地址对应多个测试钱包
    pub async fn find_by_address(context: &dyn ContextTrait, address: &str) -> Result<Option<Wallet>, WalletError> {
        let wallet_db = context.db().wallets_db();
        let m_address = {
            let addr_wrapper = wallet_db.new_wrapper().eq(&MAddress::address, address);
            MAddress::list_by_wrapper(wallet_db, "", &addr_wrapper).await?
        };
        if m_address.is_empty() {
            return Err(WalletError::Custom(format!("wallet address {} is not exist!", address)));
        }
        let address = m_address.get(0).unwrap();

        Self::find_by_id(context, &address.wallet_id.to_owned(), &NetType::from_chain_type(&address.chain_type)).await
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
        let wrapper = rb.new_wrapper().eq(&MWallet::name, name);
        let dws = MWallet::list_by_wrapper(rb, "", &wrapper).await?;
        Ok(dws)
    }

    pub async fn mnemonic_digest(context: &dyn ContextTrait, digest: &str) -> Result<Vec<MWallet>, WalletError> {
        let rb = context.db().wallets_db();
        let wrapper = rb.new_wrapper().eq(MWallet::mnemonic_digest, digest);
        let ms = MWallet::list_by_wrapper(rb, "", &wrapper).await?;
        Ok(ms)
    }

    pub async fn check_duplicate_mnemonic(context: &dyn ContextTrait, digest: &str, wallet_type: &WalletType) -> Result<Vec<MWallet>, WalletError> {
        let rb = context.db().wallets_db();
        let wrapper = {
            let wrapper = rb.new_wrapper().eq(MWallet::mnemonic_digest, digest.to_owned());
            if WalletType::Test.eq(wallet_type) {
                //check test wallet mnemonic whether used in normal wallet
                wrapper.eq(MWallet::wallet_type, WalletType::Normal.to_string())
            } else {
                wrapper
            }
        };
        let ms = MWallet::list_by_wrapper(rb, "", &wrapper).await?;
        Ok(ms)
    }
}

/*#[async_trait]*/
impl Wallet {
    pub async fn load(&mut self, context: &dyn ContextTrait, mw: MWallet, net_type: &NetType) -> Result<(), WalletError> {
        self.m = mw;
        {
            self.eth_chain.load(context, self.m.clone(), net_type).await?;
        }
        {
            self.eee_chain.load(context, self.m.clone(), net_type).await?;
        }
        {
            self.btc_chain.load(context, self.m.clone(), net_type).await?;
        }

        Ok(())
    }
}