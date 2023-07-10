use mav::{NetType, WalletType};
use mav::ma::{MAddress, MWallet};

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
        let mut rb = context.db().wallets_db();
        let ws = MWallet::select_by_wallet_type(&mut rb, &WalletType::from(net_type).to_string()).await?;
        Ok(!ws.is_empty())
    }
    pub async fn count(context: &dyn ContextTrait, net_type: &NetType) -> Result<i64, WalletError> {
        let mut rb = context.db().wallets_db();
        let ws = MWallet::select_by_wallet_type(&mut rb, &WalletType::from(net_type).to_string()).await?;
        Ok(ws.len() as i64)
    }

    pub async fn all(context: &dyn ContextTrait, net_type: &NetType) -> Result<Vec<Wallet>, WalletError> {
        let mut wallets = Vec::new();
        let mut wallet_rb = context.db().wallets_db();
        let filter_value = if NetType::Main.eq(net_type) { WalletType::Normal.to_string() } else { WalletType::Test.to_string() };
        let dws = MWallet::select_by_wallet_type(&mut wallet_rb, filter_value.as_str()).await?;
        for dw in &dws {
            let mut wallet = Wallet::default();
            wallet.load(context, dw.clone(), net_type).await?;
            wallets.push(wallet);
        }
        Ok(wallets)
    }
    pub async fn m_wallet_all(context: &dyn ContextTrait) -> Result<Vec<MWallet>, WalletError> {
        let dws = MWallet::select_all(&mut context.db().wallets_db()).await?;
        Ok(dws)
    }
    pub async fn find_by_id(context: &dyn ContextTrait, wallet_id: &str, net_type: &NetType) -> Result<Option<Wallet>, WalletError> {
        let mut rb = context.db().wallets_db();
        let ws = MWallet::select_by_column(&mut rb, MWallet::id, wallet_id).await?;
        match ws.as_slice() {
            [w] => {
                let mut wallet = Wallet::default();
                wallet.load(context, w.clone(), net_type).await?;
                Ok(Some(wallet))
            }
            _ => Ok(None)
        }
    }
    //todo 当一个助记词在测试链下多次使用时，会造成一个地址对应多个测试钱包
    pub async fn find_by_address(context: &dyn ContextTrait, address: &str) -> Result<Option<Wallet>, WalletError> {
        let mut wallet_db = context.db().wallets_db();
        let m_address = {
            MAddress::select_by_column(&mut wallet_db, &MAddress::address, address).await?
        };
        if m_address.is_empty() {
            return Err(WalletError::Custom(format!("wallet address {} is not exist!", address)));
        }
        let address = m_address.get(0).unwrap();

        Self::find_by_id(context, &address.wallet_id.to_owned(), &NetType::from_chain_type(&address.chain_type)).await
    }
    pub async fn m_wallet_by_id(context: &dyn ContextTrait, wallet_id: &str) -> Result<Option<MWallet>, WalletError> {
        let mut rb = context.db().wallets_db();
        let ws = MWallet::select_by_column(&mut rb, MWallet::id, &wallet_id.to_owned()).await?;
        let w = ws.first().cloned();
        Ok(w)
    }
    pub async fn remove_by_id(context: &dyn ContextTrait, wallet_id: &str) -> Result<u64, WalletError> {
        let mut rb = context.db().wallets_db();
        let mut tx = rb.acquire_begin().await?;
        let re = MWallet::delete_by_column(&mut tx, MWallet::id, &wallet_id.to_owned()).await?;
        //todo 删除相关表
        tx.commit().await?;
        Ok(re.rows_affected)
    }

    pub async fn update_by_id(context: &dyn ContextTrait, m_wallet: &mut MWallet, tx_id: &str) -> Result<u64, WalletError> {
        let mut rb = context.db().wallets_db();
        let re = MWallet::update_by_column(&mut rb, &m_wallet, MWallet::id).await?;
        //todo 其它字段怎么处理？
        Ok(re.rows_affected)
    }

    pub async fn m_wallet_by_name(context: &dyn ContextTrait, name: &str) -> Result<Vec<MWallet>, WalletError> {
        let mut rb = context.db().wallets_db();
        let dws = MWallet::select_by_column(&mut rb, &MWallet::name, name).await?;
        Ok(dws)
    }

    pub async fn mnemonic_digest(context: &dyn ContextTrait, digest: &str) -> Result<Vec<MWallet>, WalletError> {
        let mut rb = context.db().wallets_db();
        let ms = MWallet::select_by_column(&mut rb, MWallet::mnemonic_digest, digest).await?;
        Ok(ms)
    }

    pub async fn check_duplicate_mnemonic(context: &dyn ContextTrait, digest: &str, wallet_type: &WalletType) -> Result<Vec<MWallet>, WalletError> {
        let mut rb = context.db().wallets_db();
        let ms = {
            if WalletType::Test.eq(wallet_type) {
                MWallet::select_by_mnemonic_digest_and_wallet_type(&mut rb, &digest, &WalletType::Normal.to_string()).await?
            } else {
                MWallet::select_by_column(&mut rb, MWallet::mnemonic_digest, &digest).await?
            }
        };
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