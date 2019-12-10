#[macro_use]
extern crate serde_derive;

pub mod wallet_crypto;
//pub mod wallet_crypto_impl;
pub mod model;
pub mod module;
pub mod wallet_db;
pub mod wallet_rpc;

#[derive(PartialEq,Clone)]
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
impl Default for StatusCode{
    fn default() -> Self { StatusCode::OK }
}

#[derive(PartialEq,Clone)]
pub enum ChainType {
    BTC = 1,
    BtcTest =2,
    ETH = 3,
    EthTest =4,
    EEE = 5,
    EeeTest =6,
    OTHER = 7,
}

impl Default for ChainType{
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
    use crate::wallet_crypto::Crypto;
    use hex;
    use std::sync::mpsc;
    use futures::Future;
    use jsonrpc_core::Notification;
    use sp_core::crypto::{Pair,AccountId32};

    #[test]
    fn verify_mnemonic_create() {
        let mnemonic = wallet_crypto::Sr25519::generate_phrase(18);
        let data = "substrate sign method test";
        println!("data length is:{}",data.len());
        let data = wallet_crypto::Ed25519::sign(&mnemonic,data.as_bytes());

        println!("{}",hex::encode(data.to_vec().as_slice()));
       // wallet_crypto::Sr25519::print_from_phrase(&mnemonic,None);
    }

    #[test]
    fn rpc_account_nonce_test(){
        let (send_tx, recv_tx) = mpsc::channel();
        let mut substrate_client = wallet_rpc::substrate_thread(send_tx).unwrap();
        let mnemonic = "swarm grace knock race flip unveil pyramid reveal shoot vehicle renew axis";
        let to = "5DATag245rFG8PvCHnSpntLMhF9xvKZQPyshaAFhSiMMcFpU";
      //  let seed =  wallet_crypto::Sr25519::seed_from_phrase(mnemonic,None);
        //let pair = wallet_crypto::Sr25519::pair_from_suri(&mnemonic,None);
        let pair = wallet_crypto::Sr25519::pair_from_suri("//Alice",None);
        println!("public:{}",&pair.public());

        let index = wallet_rpc::substrate::account_nonce(&mut substrate_client,AccountId32::from(pair.public().0));
        println!("index:{}",index);
        assert_eq!(index,0);
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
    fn rpc_func_test(){
        let (send_tx, recv_tx) = mpsc::channel();
        let mut substrate_client = wallet_rpc::substrate_thread(send_tx).unwrap();
        let mnemonic = "mirror craft oil voice there pizza quarter void inhale snack vacant kingdom force erupt congress wing correct bargain";
        let to = "5DAAnrj7VHTznn2AWBemMuyBwZWs6FNFjdyVXUeYum3PTXFy";
        let ret = wallet_rpc::transfer(&mut substrate_client,  mnemonic,to,"200");
        match ret {
            Ok(data)=>{
                println!("signed data is: {}",data);
                wallet_rpc::submit_data(&mut substrate_client,data);
            },
            Err(msg)=>{
                println!("error {}",msg);
            }
        }
    }

    #[test]
    fn wallet_tx_sign_test(){
        let msg = r#"0x7901041102ffb8abbe0682086df6012967b2f56aaa2e365d974c77414a34359cfbdd67ce01fe0082841e00d0270328c9d43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d6400000000000000000000000000000001000000f05f30efbfbdefbfbddf8defbfbdefbfbdcf80efbfbdefbfbd1855efbfbd1defbfbdc7b4efbfbdefbfbdefbfbd67efbfbdefbfbd4722522aefbfbd2627c6000000"#;
        //module::wallet::raw_tx_sign()
    }
}
