use std::cell::RefCell;
use std::collections::HashMap;
use std::rc::Rc;

use once_cell::sync::OnceCell;
use parking_lot::{RawMutex, RawThreadId, ReentrantMutex};
use parking_lot::lock_api::RawReentrantMutex;

use mav::db::Db;
use wallets_types::{Context, Error, InitParameters, UnInitParameters, Wallet};

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

    pub fn init(&mut self, parameters: &InitParameters) -> Error {
        let err = Error::default();
        let r = self.db.init(&parameters.db_name);

        err
    }

    pub fn uninit(&mut self, parameters: &UnInitParameters) -> Error {
        Error::default()
    }

    pub fn all(&mut self, array_wallet: &mut Vec::<Wallet>) -> Error {
        Error::default()
    }
}

///处理所有的wallets实例，
#[derive(Default)]
pub struct WalletsInstances {
    w_map: HashMap<String, Rc<RefCell<Wallets>>>,
}

impl WalletsInstances {
    pub fn instances() -> &'static ReentrantMutex<RefCell<WalletsInstances>> {
        static mut INSTANCE: OnceCell<ReentrantMutex<RefCell<WalletsInstances>>> = OnceCell::new();
        // let mut t = unsafe { INSTANCE .get().unwrap().lock()};
        // t.borrow_mut().get("");
        unsafe {
            INSTANCE.get_or_init(|| {
                ReentrantMutex::new(RefCell::new(WalletsInstances::default()))
            })
        }
    }

    pub fn get(&self, key: &str) -> Option<&Rc<RefCell<Wallets>>> {
        self.w_map.get(key)
    }

    pub fn new(&mut self) -> Option<&Rc<RefCell<Wallets>>> {
        let ws = Rc::new(RefCell::new(Wallets::default()));
        let id = ws.borrow().ctx.id.clone();
        self.w_map.insert(id.clone(), ws.clone());
        self.w_map.get(&id)
        // self.w_map[&id] = ws;
        // Some(ws.clone())
    }
}


#[cfg(test)]
mod tests {
    use std::cell::RefCell;

    use once_cell::sync::OnceCell;
    use parking_lot::ReentrantMutex;

    use crate::WalletsInstances;

    #[test]
    fn one_cell_try() {
        // let f = ||{
        //     static mut INSTANCE: OnceCell<ReentrantMutex<RefCell<WalletsInstances>>> = OnceCell::new();
        //     // let mut t = unsafe { INSTANCE .get().unwrap().lock()};
        //     // t.borrow_mut().get("");
        //     unsafe {
        //         INSTANCE.get_or_init(|| {
        //             ReentrantMutex::new(RefCell::new(WalletsInstances::default()))
        //         })
        //     }
        // };
        //
        // let t = f();
        // let wallet = t.lock().borrow_mut().new().unwrap();
        let ins = WalletsInstances::instances();

        let ws = ins.lock().borrow_mut().new().unwrap().clone();
        ws.borrow_mut().ctx.id = "".to_owned();
        // ws.ctx.id = "".to_owned();
    }
}
