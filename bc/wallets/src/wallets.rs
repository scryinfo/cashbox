use std::collections::HashMap;
use std::sync::Mutex;

use once_cell::sync::OnceCell;

use wallets_types::{Context, Error, InitParameters, UnInitParameters, Wallet};

#[derive(Default)]
pub struct Wallets {
    pub ctx: Context,
}

impl Wallets {
    pub fn lock_read(&mut self) -> bool {
        return true;
    }
    pub fn unlock_read(&mut self) -> bool {
        return true;
    }
    pub fn lock_write(&mut self) -> bool {
        return true;
    }
    pub fn unlock_write(&mut self) -> bool {
        return true;
    }

    pub fn init(&mut self, parameters: &InitParameters) -> Error {
        let err = Error {};

        err
    }

    pub fn uninit(&mut self, parameters: &UnInitParameters) -> Error {
        Error {}
    }

    pub fn all(&mut self, array_wallet: &mut Vec::<Wallet>) -> Error {
        Error {}
    }
}

///处理所有的wallets实例，
#[derive(Default)]
pub struct WalletsInstances {
    w_map: HashMap<String, Box::<Wallets>>,
}

impl WalletsInstances {
    pub fn instances() -> &'static Mutex<WalletsInstances> {
        static mut INSTANCE: OnceCell<Mutex<WalletsInstances>> = OnceCell::new();
        unsafe {
            INSTANCE.get_or_init(|| {
                Mutex::new(WalletsInstances::default())
            })
        }
    }

    pub fn get(&mut self, key: &str) -> Option<&mut Box<Wallets>> {
        self.w_map.get_mut(key)
    }

    pub fn new(&mut self) -> Option<&mut Box<Wallets>> {
        let ws = Box::new(Wallets::default());
        let id = ws.ctx.id.clone();
        self.w_map.insert(id.clone(), ws);
        // self.w_map[&id] = ws;
        self.get(&id)
    }
}