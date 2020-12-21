use std::cell::RefCell;
use std::collections::HashMap;

use once_cell::sync::OnceCell;
use parking_lot::ReentrantMutex;

use wallets_types::{Context, WalletError};

use crate::Wallets;

///处理所有的wallets实例，
#[derive(Default)]
pub struct Contexts {
    w_map: HashMap<String, Wallets>,
    last_context: Option<Context>,
    first_context: Option<Context>,
}

impl Contexts {
    pub fn collection() -> &'static ReentrantMutex<RefCell<Contexts>> {
        static mut INSTANCE: OnceCell<ReentrantMutex<RefCell<Contexts>>> = OnceCell::new();
        unsafe {
            INSTANCE.get_or_init(|| {
                #[cfg(target_os = "android")]crate::init_logger_once();
                ReentrantMutex::new(RefCell::new(Contexts::default()))
            })
        }
    }

    pub fn get_mut(&mut self, key: &str) -> Option<&mut Wallets> {
        self.w_map.get_mut(key)
    }

    pub fn get(&mut self, key: &str) -> Option<&Wallets> {
        self.w_map.get(key)
    }
    pub fn remove(&mut self, key: &str) -> Option<Wallets> {
        self.w_map.remove(key)
    }

    pub fn clean(&mut self) -> Result<(), WalletError> {
        self.last_context = None;
        self.first_context = None;
        for (_, it) in self.w_map.iter_mut() {
            let _ = futures::executor::block_on(it.uninit())?;
        }
        self.w_map.clear();

        Ok(())
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

    use wallets_types::Context;

    use crate::Contexts;

    #[test]
    fn one_cell_try() {
        {
            let f = || {
                static mut T_INS: OnceCell<ReentrantMutex<RefCell<Contexts>>> = OnceCell::new();
                // let mut t = unsafe { INSTANCE .get().unwrap().lock()};
                // t.borrow_mut().get("");
                unsafe {
                    T_INS.get_or_init(|| {
                        ReentrantMutex::new(RefCell::new(Contexts::default()))
                    })
                }
            };
            let lock = f().lock();
            let mut ins = lock.borrow_mut();
            let new_ctx = Context::new("test_ctx");
            let ws = ins.new(new_ctx).unwrap();
            ws.ctx.id = "".to_owned();
        }

        let lock = Contexts::collection().lock();
        let mut ins = lock.borrow_mut();
        let new_ctx = Context::new("test_ctx");
        let _ = ins.new(new_ctx).unwrap();
    }
}
