use std::ops::Not;

use parking_lot::{RawMutex, RawThreadId};
use parking_lot::lock_api::RawReentrantMutex;

use mav::ma::{Dao, Db, MMnemonic, MWallet};
use mav::WalletType;
use substratetx::{Crypto, Keccak256};
use wallets_types::{Context, CreateWalletParameters, InitParameters, Load, Wallet, WalletError};

pub struct Wallets {
    raw_reentrant: RawReentrantMutex<RawMutex, RawThreadId>,
    pub ctx: Context,
    pub db: Db, //for test, make it pub
}

impl Default for Wallets {
    fn default() -> Self {
        Self {
            ctx: Default::default(),
            db: Default::default(),
            raw_reentrant: RawReentrantMutex::INIT,
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
        let mut ws = Wallet::all(&self.db.cashbox_wallets).await?;
        array_wallet.clear();
        array_wallet.append(&mut ws);
        Ok(())
    }

    pub fn generate_mnemonic() -> String {
        let mnemonic = substratetx::Sr25519::generate_phrase(15);
        mnemonic
    }

    pub async fn create_wallet(&self, parameters: CreateWalletParameters) -> Result<Wallet, WalletError> {
        let rb = &self.db.cashbox_wallets;
        let hex_mn_digest = {
            let hash_first = parameters.mnemonic.as_bytes().keccak256();
            hex::encode((&hash_first[..]).keccak256())
        };
        //Official chain, mnemonic words can only be imported once, whether to import by hash exists
        let wallet_type = WalletType::from(&parameters.wallet_type);
        if wallet_type == WalletType::Normal {
            let ms = Wallet::wallet_type_mnemonic_digest(rb, &hex_mn_digest, &wallet_type).await?;
            if ms.is_empty().not() {
                return Err(WalletError::Custom("this wallet is exist".to_owned()));
            }
        }

        let keystore = substratetx::Sr25519::encrypt_mnemonic(&parameters.mnemonic.as_bytes().to_vec(), &parameters.password.as_bytes().to_vec());
        //todo address

        let mut mw = MWallet::default();
        {
            mw.mnemonic_digest = hex_mn_digest;
            mw.mnemonic = keystore;
            mw.wallet_type = wallet_type.to_string();
            mw.name = parameters.name.clone();
            let mut tx_guard = rb.begin_tx_defer(false).await?;
            mw.save(rb, &tx_guard.tx_id).await?;

            let mut mm = MMnemonic::default();
            mm.from(&mw);
            // 现在只出现了2个数据库，所以第二个可以不使用事务，整个事务也是正确的，
            // 但如果有三个数据库，这时事务就会有问题（需要做特别处理才能正常，如二阶段提交等）
            mm.save(&self.db.cashbox_mnemonic, "").await?;
            tx_guard.is_drop_commit = true; //all success, set true to commit the tx
        }
        let mut w = Wallet::default();
        w.load(rb, mw).await?;

        return Ok(w);
    }
}



