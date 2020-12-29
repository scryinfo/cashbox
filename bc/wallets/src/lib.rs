#[cfg(target_os = "android")]
pub use logger::init_logger_once;

pub use crate::contexts::Contexts;
pub use crate::wallets::Wallets;

mod chain;
mod contexts;
mod kits;
mod wallets;

#[cfg(target_os = "android")]
mod logger;
