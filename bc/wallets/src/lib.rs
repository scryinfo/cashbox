// #[macro_use]
// extern crate serde_derive;

#[cfg(target_os = "android")]
pub use logger::init_logger_once;
pub use wallets::{Wallets};
pub use wallets_collection::WalletsCollection;

mod wallets;
mod wallets_collection;

#[cfg(target_os = "android")]
mod logger;

