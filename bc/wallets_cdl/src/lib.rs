
mod types;
mod types_eth;
mod types_eee;
mod types_btc;

mod wallets;
mod wallets_c;

mod chain;
mod chain_eth;
mod chain_eee;
mod chain_btc;

pub use crate::wallets_c::{Wallet, Address, TokenShared, ChainShared,EthChain,EeeChain,BtcChain};

#[cfg(test)]
mod tests {
    #[test]
    fn it_works() {
        assert_eq!(2 + 2, 4);
    }
}
