pub mod types;
mod types_eth;
mod types_eee;
mod types_btc;

pub mod wallets_c;
pub mod mem_c;
pub mod chain_eee_c;
pub mod parameters;

mod chain;
mod chain_eth;
mod chain_eee;
mod chain_btc;

mod kits;

pub use kits::{CR, CStruct, CU64, to_c_char, to_str};


#[cfg(test)]
mod tests {
    #[test]
    fn it_works() {
        assert_eq!(2 + 2, 4);
    }
}
