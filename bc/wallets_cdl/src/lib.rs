pub mod types;
mod types_eth;
mod types_eee;
mod types_btc;

pub mod wallets_c;
pub mod mem_c;
pub mod parameters;

mod chain;
mod chain_eth;
mod chain_eee;
mod chain_btc;

mod kits;
mod wallets_c_test;

#[cfg(test)]
mod tests {
    #[test]
    fn it_works() {
        assert_eq!(2 + 2, 4);
    }
}
