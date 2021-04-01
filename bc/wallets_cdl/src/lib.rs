pub use kits::{to_c_char, to_str, CArray, CStruct, CR, CU64};

pub mod types;
mod types_btc;
mod types_eee;
mod types_eth;

pub mod mem_c;
pub mod parameters;
pub mod wallets_c;

pub mod chain_btc_c;
pub mod chain_eee_c;
pub mod chain_eth_c;



mod chain;
mod chain_btc;
mod chain_eee;
mod chain_eth;

pub mod kits;
