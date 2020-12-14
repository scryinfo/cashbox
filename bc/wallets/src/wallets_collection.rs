use std::cell::RefCell;
use std::collections::HashMap;

use once_cell::sync::OnceCell;
use parking_lot::{ReentrantMutex};

use wallets_types::{Context};

use crate::Wallets;


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
    use wallets_types::Context;

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
            let new_ctx = Context::new("test_ctx");
            let ws = ins.new(new_ctx).unwrap();
            ws.ctx.id = "".to_owned();
        }

        let lock = WalletsCollection::collection().lock();
        let mut ins = lock.borrow_mut();
        let new_ctx = Context::new("test_ctx");
        let _ = ins.new(new_ctx).unwrap();
    }
}
