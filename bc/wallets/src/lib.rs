#[cfg(target_os = "android")]
pub use logger::init_logger_once;

pub use crate::contexts::Contexts;
pub use crate::wallets::Wallets;

mod wallets;
mod contexts;
mod chain;

#[cfg(target_os = "android")]
mod logger;

