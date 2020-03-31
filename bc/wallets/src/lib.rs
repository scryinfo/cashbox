#[macro_use]
extern crate serde_derive;

pub mod wallet_crypto;
pub mod model;
pub mod module;
pub mod wallet_db;
pub mod wallet_rpc;

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
    use crate::wallet_crypto::{Crypto, Keccak256};
    use hex;
    use std::sync::mpsc;
    use futures::Future;
    use jsonrpc_core::Notification;
    use sp_core::crypto::{Pair, AccountId32};

    #[test]
    fn verify_mnemonic_create() {
        let mnemonic = wallet_crypto::Sr25519::generate_phrase(18);
        let data = "substrate sign method test";
        println!("data length is:{}", data.len());
        let s = String::new();
        let data = wallet_crypto::Ed25519::sign(&mnemonic, data.as_bytes());
        println!("{}", hex::encode(data.to_vec().as_slice()));
    }

    #[test]
    fn rpc_account_nonce_test() {
        let (send_tx, recv_tx) = mpsc::channel();
        let mut substrate_client = wallet_rpc::substrate_thread(send_tx).unwrap();
        let mnemonic = "swarm grace knock race flip unveil pyramid reveal shoot vehicle renew axis";
        let _to = "5DATag245rFG8PvCHnSpntLMhF9xvKZQPyshaAFhSiMMcFpU";
        //  let seed =  wallet_crypto::Sr25519::seed_from_phrase(mnemonic,None);
        //let pair = wallet_crypto::Sr25519::pair_from_suri(&mnemonic,None);
        let pair = wallet_crypto::Sr25519::pair_from_suri("//Alice", None);
        println!("public:{}", &pair.public());

        let index = wallet_rpc::substrate::account_nonce(&mut substrate_client, AccountId32::from(pair.public().0));
        println!("index:{}", index);
        assert_eq!(index, 0);
        // 用于保持连接，接收从链上返回来的数据
        let msg = recv_tx.recv().unwrap();
        let msg = msg.into_text().unwrap();
        let des: Notification = serde_json::from_str(&msg).unwrap();
        let des: serde_json::Map<String, serde_json::Value> = des.params.parse().unwrap();
        let sub_id = &des["subscription"];
        println!(
            "----subscribe extrinsic return sub_id:{:?}----result:{:?}---",
            sub_id, des["result"]
        );
    }

    #[test]
    fn rpc_func_test() {
        let (send_tx, recv_tx) = mpsc::channel();
        let mut substrate_client = wallet_rpc::substrate_thread(send_tx).unwrap();
        let mnemonic = "mirror craft oil voice there pizza quarter void inhale snack vacant kingdom force erupt congress wing correct bargain";
        let to = "5DAAnrj7VHTznn2AWBemMuyBwZWs6FNFjdyVXUeYum3PTXFy";
        let ret = wallet_rpc::transfer(&mut substrate_client, mnemonic, to, "200000000000000");
        match ret {
            Ok(data) => {
                println!("signed data is: {}", data);
                wallet_rpc::submit_data(&mut substrate_client, data);
            }
            Err(msg) => {
                println!("error {}", msg);
            }
        }
    }

    #[test]
    fn get_runtime_version_test() {
        let (send_tx, recv_tx) = mpsc::channel();
        let mut substrate_client = wallet_rpc::substrate_thread(send_tx).unwrap();
        let runtime_version = wallet_rpc::substrate::runtime_version(&mut substrate_client);
        println!("runtime_version:{:?}", runtime_version);
    }

    #[test]
    fn func_sign_test() {
        let rawtx = "0xac040600ff0a146e76bbdc381bd77bb55ec45c8bef5f52e2909114d632967683ec1eb4ea300b0040e59c301200000000979d3bb306ed9fbd5d6ae1eade033b81ae12a5c5d5aa32781153579d7f6d5504ed000000";
        module::wallet::raw_tx_sign(rawtx, "9328ebd6-c205-439d-a016-ebe6ab1e5408", "123456".as_bytes());
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
