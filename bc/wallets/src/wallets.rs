use std::ops::Not;
use std::sync::atomic::AtomicBool;

use failure::_core::sync::atomic::Ordering;
use parking_lot::{RawMutex, RawThreadId};
use parking_lot::lock_api::RawReentrantMutex;

use mav::{ChainType, WalletType};
use mav::ma::{BeforeSave, Dao, Db, MAddress, MMnemonic, MWallet};
use substratetx::{Crypto, Keccak256};
use wallets_types::{Chain2WalletType, Context, ContextTrait, CreateWalletParameters, EeeChain, InitParameters, Load, Setting, Wallet, WalletError, WalletTrait};

pub struct Wallets {
    raw_reentrant: RawReentrantMutex<RawMutex, RawThreadId>,
    pub ctx: Context,
    pub db: Db,
    //for test, make it pub
    stopped: AtomicBool,

    wallet_trait: Box<dyn WalletTrait>,
}

impl Default for Wallets {
    fn default() -> Self {
        Self {
            ctx: Default::default(),
            db: Default::default(),
            raw_reentrant: RawReentrantMutex::INIT,
            stopped: AtomicBool::new(false),
            wallet_trait: crate::chain::Wallet::new(),
        }
    }
}

impl Wallets {
    pub fn lock_read(&mut self) -> bool {
        self.raw_reentrant.lock();
        return true;
    }
    pub fn unlock_read(&mut self) -> bool {
        unsafe {
            self.raw_reentrant.unlock();
        }
        return true;
    }
    pub fn lock_write(&mut self) -> bool {
        self.raw_reentrant.lock();
        return true;
    }
    pub fn unlock_write(&mut self) -> bool {
        unsafe {
            self.raw_reentrant.unlock();
        }
        return true;
    }

    pub async fn init(&mut self, parameters: &InitParameters) -> Result<(), WalletError> {
        self.ctx.context_note = parameters.context_note.clone();
        self.db.init(&parameters.db_name).await?;
        //todo
        Ok(())
    }

    pub async fn uninit(&mut self) -> Result<(), WalletError> {
        //todo
        Ok(())
    }

    pub async fn all(&mut self) -> Result<Vec<Wallet>, WalletError> {
        let ws = Wallet::all(self).await?;
        Ok(ws)
    }

    pub async fn has_any(&self) -> Result<bool, WalletError> {
        let context = self;
        let re = Wallet::has_any(context).await?;
        Ok(re)
    }

    pub async fn find_by_id(&self, wallet_id: &str) -> Result<Option<Wallet>, WalletError> {
        let context = self;
        let re = Wallet::find_by_id(context,wallet_id).await?;
        Ok(re)
    }
    ///注：只加载了wallet的id name等直接的基本数据，链数据没有加载
    pub async fn find_wallet_base_by_name(&self, name: &str) -> Result<Vec<Wallet>, WalletError> {
        let context = self;
        let ms = Wallet::m_wallet_by_name(context,name).await?;
        let re = Vec::new();
        for m in ms {
            let mut w = Wallet::default();
            w.m = m;
        }
        Ok(re)
    }
    pub async fn remove_by_id(&mut self, wallet_id: &str, tx_id: &str) -> Result<u64, WalletError> {
        let context = self;
        let re = Wallet::remove_by_id(context,wallet_id, tx_id).await?;
        Ok(re)
    }

    pub async fn re_name_wallet(&mut self, name: &str, wallet_id: &str, tx_id: &str) -> Result<u64, WalletError> {
        let context = self;
        match Wallet::m_wallet_by_id(context, wallet_id).await? {
            None => Err(WalletError::NoRecord("".to_owned())),
            Some(mut m_wallet) => {
                m_wallet.name = name.to_owned();
                let re = Wallet::update_by_id(context,&mut m_wallet, tx_id).await?;
                Ok(re)
            }
        }
    }
    pub async fn save_current_wallet_chain(&mut self, wallet_id: &str, chain_type: &ChainType) -> Result<(), WalletError> {
        let context = self;
        let re = Setting::save_current_wallet_chain(context, wallet_id, chain_type).await?;
        Ok(re)
    }
    pub async fn current_wallet_chain(&self) -> Result<Option<(String, ChainType)>, WalletError> {
        let context = self;
        let re = Setting::current_wallet_chain(context).await?;
        Ok(re)
    }
    pub fn generate_mnemonic() -> String {
        let mnemonic = substratetx::Sr25519::generate_phrase(15);
        mnemonic
    }

    /// 如果是正式钱包，一个助记词只能创建一个钱包（test类型的钱包允许有重复的）
    pub async fn create_wallet(&self, parameters: CreateWalletParameters) -> Result<Wallet, WalletError> {
        let context = self;
        let rb = context.db.wallets_db();
        let hex_mn_digest = {
            let hash_first = parameters.mnemonic.as_bytes().keccak256();
            hex::encode((&hash_first[..]).keccak256())
        };

        let wallet_type = WalletType::from(&parameters.wallet_type);
        if wallet_type == WalletType::Normal {
            let ms = Wallet::wallet_type_mnemonic_digest(context, &hex_mn_digest, &wallet_type).await?;
            if ms.is_empty().not() {
                return Err(WalletError::Custom("this wallet is exist".to_owned()));
            }
        }


        let mut m_wallet = MWallet::default();
        {
            m_wallet.mnemonic_digest = hex_mn_digest;
            m_wallet.mnemonic = substratetx::Sr25519::encrypt_mnemonic(&parameters.mnemonic.as_bytes().to_vec(), &parameters.password.as_bytes().to_vec());
            m_wallet.wallet_type = wallet_type.to_string();
            m_wallet.name = parameters.name.clone();
        }
        let mut m_addresses = self.generate_address(&mut m_wallet, &parameters.mnemonic.as_bytes().to_vec())?;
        //todo default token

        {//save to database
            //tx 只处理异常情况下，事务的rollback，所以会在事务提交成功后，调用 tx.manager = None; 阻止 [rbatis::tx::TxGuard]再管理事务
            let mut tx = rb.begin_tx_defer(false).await?;
            {
                m_wallet.save(rb, &tx.tx_id).await?;
                MAddress::save_batch(rb, &tx.tx_id, &mut m_addresses).await?;

                let mut m_mnemonic = MMnemonic::default();
                m_mnemonic.from(&m_wallet);
                // 现在只出现了2个数据库，所以第二个可以不使用事务，最坏的情况出现助记词保存成功，而cashbox_wallet没有成功的情况，这时不会对程序
                m_mnemonic.save(self.db.mnemonic_db(), "").await?;
            }
            rb.commit(&tx.tx_id).await?;
            tx.manager = None;
        }
        {//是否为current wallet
            if Wallet::count(context).await? == 1 {
                let wallet_type = WalletType::from(&m_wallet.wallet_type);
                //创建的第一个钱包，的默认链是 eee
                Setting::save_current_wallet_chain(context, &m_wallet.id, &EeeChain::chain_type(&wallet_type)).await?;
            }
        }
        let mut wallet = Wallet::default();
        wallet.load(self, m_wallet).await?;

        return Ok(wallet);
    }


    fn generate_address(&self, wallet: &mut MWallet, mn: &[u8]) -> Result<Vec<MAddress>, WalletError> {
        if wallet.id.is_empty() {//make sure the id is not empty
            wallet.before_save();
        }

        let chains = self.wallet_trait.chains();
        let mut addrs = Vec::new();
        let wallet_type = WalletType::from(&wallet.wallet_type);
        for chain in chains {
            let mut addr = chain.generate_address(mn, &wallet_type)?;
            addr.wallet_id = wallet.id.clone();
            addr.wallet_address = true;
            addrs.push(addr);
        }
        Ok(addrs)
    }
}

impl ContextTrait for Wallets {
    fn db(&self) -> &Db {
        &self.db
    }

    fn stopped(&self) -> bool {
        self.stopped.load(Ordering::SeqCst) //todo
    }

    fn set_stopped(&mut self, s: bool) {
        self.stopped.store(s, Ordering::SeqCst);//todo
    }
}



