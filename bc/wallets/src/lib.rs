#[macro_use]
extern crate serde_derive;

pub mod model;
pub mod module;
pub mod wallet_db;

mod error;

pub use error::WalletError;

pub use ethtx::convert_token;

#[derive(PartialEq, Clone)]
pub enum StatusCode {
    DylibError = -1,
    OK = 200,
    //正常
    FailToGenerateMnemonic = 100,
    //生成助记词失败
    PwdIsWrong,
    //密码错误
    FailToRestPwd,
    //重置密码失败
    GasNotEnough,
    //GAS费不足
    BroadcastOk,
    //广播上链成功
    BroadcastFailure,  //广播上链失败
}

impl Default for StatusCode {
    fn default() -> Self { StatusCode::OK }
}

#[derive(PartialEq, Clone)]
pub enum EthChainId {
    MAIN = 1,
    ROPSTEN = 3,
    RINKEBY = 4,
}

#[derive(PartialEq, Clone, Debug)]
pub enum ChainType {
    BTC = 1,
    BtcTest = 2,
    ETH = 3,
    EthTest = 4,
    EEE = 5,
    EeeTest = 6,
    OTHER = 7,
}

impl Default for ChainType {
    fn default() -> Self { ChainType::OTHER }
}

impl From<i64> for ChainType {
    fn from(chain_type: i64) -> Self {
        match chain_type {
            1 => ChainType::BTC,
            2 => ChainType::BtcTest,
            3 => ChainType::ETH,
            4 => ChainType::EthTest,
            5 => ChainType::EEE,
            6 => ChainType::EeeTest,
            _ => ChainType::OTHER,
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use substratetx::{Keccak256, Crypto};
    use hex;

    #[test]
    fn verify_mnemonic_create() {
        let mnemonic = substratetx::Sr25519::generate_phrase(18);
        let data = "substrate sign method test";
        let s = String::new();
        match substratetx::Ed25519::sign(&mnemonic, data.as_bytes()) {
            Ok(signed_data) => println!("{}", hex::encode(&signed_data[..])),
            Err(e) => println!("{}", e.to_string()),
        }
    }

    #[test]
    fn func_sign_test() {
        let rawtx = "0xac040600ff0a146e76bbdc381bd77bb55ec45c8bef5f52e2909114d632967683ec1eb4ea300b0040e59c301200000000979d3bb306ed9fbd5d6ae1eade033b81ae12a5c5d5aa32781153579d7f6d5504ed000000";
        match module::wallet::raw_tx_sign(rawtx, "9328ebd6-c205-439d-a016-ebe6ab1e5408", "123456".as_bytes()) {
            Ok(signed_data) => println!("tx sign result {}", signed_data),
            Err(e) => println!("{}", e.to_string()),
        }
    }

    #[test]
    fn generate_address_from_mnemonic_test() {
        let mnemonic = "cost impact napkin never sword civil shell tank sibling steel certain valve";
        let address = module::wallet::address_from_mnemonic(mnemonic.as_bytes(), ChainType::ETH);
        assert_eq!("0x2f96570cf17258de7562b91c0ddd1ee7b95542ef", address.unwrap().addr);
    }

    #[test]
    fn hash_test() {
        let value = b"hello test";
        let data = value.as_ref();
        println!("{:?}", data.keccak256());
    }
}
