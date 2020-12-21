pub use chain::*;
pub use chain_btc::*;
pub use chain_eee::*;
pub use chain_eth::*;
pub use error::*;
pub use parameters::*;
pub use setting::*;
pub use traits::*;
pub use types::*;
pub use wallet::*;

mod types;
mod wallet;
mod parameters;
mod chain;
mod chain_eth;
mod chain_eee;
mod chain_btc;
mod error;
mod traits;
mod setting;

/// Sample code: deref_type!(Data,MData)
/// ````
/// use std::ops::{DerefMut,Deref};
/// struct MData{}
/// struct Data{
///     pub m: MData,
/// }
///
/// impl Deref for Data {
///     type Target = MData;
///
///     fn deref(&self) -> &Self::Target {
///         &self.m
///     }
/// }
///
/// impl DerefMut for Data{
///     fn deref_mut(&mut self) -> &mut Self::Target {
///         &mut self.m
///     }
/// }
/// ````
#[macro_export]
macro_rules! deref_type {
    ($t:ident,$mt:ident) => {
        impl std::ops::Deref for $t {
            type Target = $mt;
            fn deref(&self) -> &Self::Target {
                &self.m
            }
        }

        impl std::ops::DerefMut for $t{
            fn deref_mut(&mut self) -> &mut Self::Target {
                &mut self.m
            }
        }
    };
}

#[cfg(test)]
pub mod tests {
    use std::sync::atomic::Ordering;

    use failure::_core::sync::atomic::AtomicBool;
    use futures::executor::block_on;

    use mav::kits::test::{mock_files_db, mock_memory_db};
    use mav::ma::{Db, DbNames};

    use crate::ContextTrait;

    struct WalletsMock {
        db: Db,
        stopped: AtomicBool,
    }

    impl ContextTrait for WalletsMock {
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

    pub fn mock_memory_context() -> Box<dyn ContextTrait> {
        let mut t = WalletsMock {
            db: mock_memory_db(),
            stopped: Default::default(),
        };
        Box::new(t)
    }

    pub fn mock_files_context() -> Box<dyn ContextTrait> {
        let mut t = WalletsMock {
            db: mock_files_db(),
            stopped: Default::default(),
        };
        Box::new(t)
    }
}
