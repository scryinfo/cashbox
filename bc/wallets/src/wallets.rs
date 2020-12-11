use std::cell::RefCell;
use std::collections::HashMap;
use std::ops::Not;

use once_cell::sync::OnceCell;
use parking_lot::{RawMutex, RawThreadId, ReentrantMutex};
use parking_lot::lock_api::RawReentrantMutex;

use mav::ma::{Dao, MMnemonic, MWallet};
use mav::WalletType;
use substratetx::{Crypto, Keccak256};
use wallets_types::{Context, CreateWalletParameters, Error, InitParameters, Load, UnInitParameters, Wallet, WalletError};

use crate::db::Db;

pub struct Wallets {
    raw_reentrant: RawReentrantMutex<RawMutex, RawThreadId>,
    pub ctx: Context,
    db: Db,
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

    pub async fn init(&mut self, parameters: &InitParameters) -> Result<(), Error> {
        self.ctx.context_note = parameters.context_note.clone();
        self.db.init(&parameters.db_name).await?;
        //todo
        Ok(())
    }

    pub async fn uninit(&mut self, _: &UnInitParameters) -> Result<(), Error> {
        //todo
        Ok(())
    }

    pub async fn all(&mut self, array_wallet: &mut Vec::<Wallet>) -> Result<(), Error> {
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

///处理所有的wallets实例，
#[derive(Default)]
pub struct WalletsCollection {
    w_map: HashMap<String, Wallets>,
    last_context: Option<Context>,
    first_context: Option<Context>,
}

impl WalletsCollection {
    pub fn collection() -> &'static ReentrantMutex<RefCell<WalletsCollection>> {
        static mut INSTANCE: OnceCell<ReentrantMutex<RefCell<WalletsCollection>>> = OnceCell::new();
        unsafe {
            INSTANCE.get_or_init(|| {
                #[cfg(target_os = "android")]crate::init_logger_once();
                ReentrantMutex::new(RefCell::new(WalletsCollection::default()))
            })
        }
    }

    pub fn get_mut(&mut self, key: &str) -> Option<&mut Wallets> {
        self.w_map.get_mut(key)
    }

    pub fn remove(&mut self, key: &str) -> Option<Wallets> {
        self.w_map.remove(key)
    }

    pub fn new(&mut self, ctx: Context) -> Option<&mut Wallets> {
        let mut ws = Wallets::default();
        ws.ctx = ctx;
        if self.first_context.is_none() {
            self.first_context = Some(ws.ctx.clone());
        }
        self.last_context = Some(ws.ctx.clone());
        let id = ws.ctx.id.clone();
        self.w_map.insert(id.clone(), ws);
        self.w_map.get_mut(&id)
    }

    pub fn contexts(&self) -> Option<Vec<Context>> {
        let cts = self.w_map.values().into_iter().map(|w| w.ctx.clone()).collect();
        Some(cts)
    }

    pub fn first_context(&self) -> Option<Context> {
        self.first_context.clone()
    }

    pub fn last_context(&self) -> Option<Context> {
        self.last_context.clone()
    }
}


#[cfg(test)]
mod tests {
    use std::cell::RefCell;

    use once_cell::sync::OnceCell;
    use parking_lot::ReentrantMutex;

    use crate::WalletsCollection;

    #[test]
    fn one_cell_try() {
        {
            let f = || {
                static mut T_INS: OnceCell<ReentrantMutex<RefCell<WalletsCollection>>> = OnceCell::new();
                // let mut t = unsafe { INSTANCE .get().unwrap().lock()};
                // t.borrow_mut().get("");
                unsafe {
                    T_INS.get_or_init(|| {
                        ReentrantMutex::new(RefCell::new(WalletsCollection::default()))
                    })
                }
            };
            let lock = f().lock();
            let mut ins = lock.borrow_mut();
            let ws = ins.new().unwrap();
            ws.ctx.id = "".to_owned();
        }

        let lock = WalletsCollection::collection().lock();
        let mut ins = lock.borrow_mut();
        let ws = ins.new().unwrap();
    }
}
