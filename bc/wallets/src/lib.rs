// #[macro_use]
// extern crate serde_derive;

#[cfg(target_os = "android")]
pub use logger::init_logger_once;
pub use wallets::{Wallets, WalletsCollection};

mod wallets;
mod db;

#[cfg(target_os = "android")]
mod logger;

