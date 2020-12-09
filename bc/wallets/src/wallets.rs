use std::cell::RefCell;
use std::collections::HashMap;

use once_cell::sync::OnceCell;
use parking_lot::{RawMutex, RawThreadId, ReentrantMutex};
use parking_lot::lock_api::RawReentrantMutex;

use wallets_types::{Context, Error, InitParameters, UnInitParameters, Wallet};

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
}

///处理所有的wallets实例，
#[derive(Default)]
pub struct WalletsCollection {
    w_map: HashMap<String, Wallets>,
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

    pub fn new(&mut self) -> Option<&mut Wallets> {
        let ws = Wallets::default();
        let id = ws.ctx.id.clone();
        self.w_map.insert(id.clone(), ws);
        self.w_map.get_mut(&id)
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
