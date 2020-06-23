use super::*;

mod chain;
mod digit;
pub mod wallet;

pub use chain::{Chain,Ethereum,EEE,Bitcoin};


#[test]
fn create_wallet_test() {
    let mnemonic = "swarm grace knock race flip unveil pyramid reveal shoot vehicle renew axis";
    wallet_db::init_wallet_database();
    let wallet = model::Wallet::default();
    let wallet = wallet.create_wallet("wallet test", mnemonic.as_bytes(), "123456".as_bytes(), 1);
    println!("{:?}", wallet);
}

#[test]
fn load_wallet_test(){
    let wallet = model::Wallet::default();
    let wallets =wallet.get_all();
    println!("load wallet:{:?}", wallets);
}

#[test]
fn update_default_digit_test() {
    let default = r#"[
{"contractAddress":"0x9f5f3cfd7a32700c93f971637407ff17b91c7342","shortName":"DDD","fullName":"DDD","urlImg":"locale://ic_ddd.png","id":"eth_token_pre_id_DDD","decimal":18,"chainType":"ETH"},
{"contractAddress":"0xaa638fca332190b63be1605baefde1df0b3b031e","shortName":"DDD","fullName":"DDD","urlImg":"locale://ic_ddd.png","id":"eth_test_token_pre_id_DDD","decimal":18,"chainType":"ETH_TEST"}
]"#;

    let digits =  serde_json::from_slice::<Vec<model::DefaultDigit>>(default.as_bytes()).unwrap();
    let helper = wallet_db::DataServiceProvider::instance().unwrap();
    helper.tx_begin();
    let _result = match helper.update_default_digits(digits) {
        Ok(_) => {
            helper.tx_commint();
            println!("update default basic data is over!");
        }
        Err(error) => {
            println!("{:?}", error.to_string());
            helper.tx_rollback();
        }
    };
}
