pub use chain::*;
pub use chain_btc::*;
pub use chain_eee::*;
pub use chain_eth::*;
pub use error::*;
pub use parameters::*;
pub use traits::*;
pub use types::*;

mod types;
mod parameters;
mod chain;
mod chain_eth;
mod chain_eee;
mod chain_btc;
mod error;
mod traits;

/// Sample code: deref_type!(Wallet,MWallet)
/// ````
/// impl std::ops::Deref for Wallet {
///     type Target = MWallet;
///
///     fn deref(&self) -> &Self::Target {
///         &self.m
///     }
/// }
///
/// impl std::ops::DerefMut for Wallet{
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
mod tests {
    #[test]
    fn it_works() {
        assert_eq!(2 + 2, 4);
    }
}
