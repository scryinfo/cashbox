// #[macro_use]
// extern crate serde_derive;

pub use contexts::Contexts;
#[cfg(target_os = "android")]
pub use logger::init_logger_once;
pub use wallets::Wallets;

mod wallets;
mod contexts;
mod chain;

#[cfg(target_os = "android")]
mod logger;

