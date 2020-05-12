#[macro_use]
extern crate serde_derive;

mod crypto;
mod transaction;
pub mod error;
pub use crypto::Sr25519;
pub use crypto::Ed25519;
pub use crypto::Keccak256;
pub use crypto::Crypto;
pub use transaction::tx_sign;
pub use transaction::transfer;

#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn transfer_test() {
        let mnemonic = "settle essay unique empty neutral pistol essence monkey combine service gun burden";
        let  to = "5GGzGJR54YNjMKhaYt6hHV3o99FZ6JKYEDCrzUg1HCz1tWPa";
        let value = "200000000000000";
        let genesis_hash = "0xabb0f2e62dfab481623438e14b5e1d4114a6e9a2f0d3f5e83f9192276e50cf34";
        let index = 0;
        let runtime_version = 1;

        let genesis_hash_bytes = hex::decode(genesis_hash.get(2..).unwrap())?;
        let mut genesis_h256 = [0u8;32];
        genesis_h256.clone_from_slice( genesis_hash_bytes.as_slice());

        transfer(mnemonic,to,value,H256(genesis_h256),index,runtime_version);
        assert_eq!(2 + 2, 4);
    }
}
