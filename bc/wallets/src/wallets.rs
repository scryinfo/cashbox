use std::ops::Not;
use std::sync::atomic::AtomicBool;

use failure::_core::sync::atomic::Ordering;
use parking_lot::{RawMutex, RawThreadId};
use parking_lot::lock_api::RawReentrantMutex;

use mav::ma::{BeforeSave, Dao, Db, MAddress, MMnemonic, MWallet};
use mav::WalletType;
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

    pub async fn all(&mut self, array_wallet: &mut Vec::<Wallet>) -> Result<(), WalletError> {
        let mut ws = Wallet::all(self).await?;
        array_wallet.clear();
        array_wallet.append(&mut ws);
        Ok(())
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
            let mut tx_wallets = rb.begin_tx_defer(false).await?;
            {
                m_wallet.save(rb, &tx_wallets.tx_id).await?;
                MAddress::save_batch(rb, &tx_wallets.tx_id, &mut m_addresses).await?;

                let mut m_mnemonic = MMnemonic::default();
                m_mnemonic.from(&m_wallet);
                // 现在只出现了2个数据库，所以第二个可以不使用事务，最坏的情况出现助记词保存成功，而cashbox_wallet没有成功的情况，这时不会对程序
                m_mnemonic.save(self.db.mnemonic_db(), "").await?;
            }
            tx_wallets.is_drop_commit = true; //todo 怎么处理事务提交失败
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



