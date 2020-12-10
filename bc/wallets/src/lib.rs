#[macro_use]
extern crate serde_derive;

mod error;
mod wallets;

pub mod model;
pub mod module;
pub mod wallet_db;

pub use error::WalletError;
pub use ethtx::{RawTransaction, convert_token, address_legal as eth_address_legal};
pub use wallets::Wallets;
pub use substratetx::decode_account_info;
pub type WalletResult<T> = std::result::Result<T, WalletError>;

const DEFAULT_SS58_VERSION:u8 = 42;

#[derive(PartialEq, Clone)]
pub enum StatusCode {
    DylibError = -1,//Errors caused by external input parameters
    FailToGenerateMnemonic = 100,//Failed to generate mnemonic
    OK = 200, // normal
    PwdIsWrong,//Wrong password
    ParameterFormatWrong,
}

impl Default for StatusCode {
    fn default() -> Self { StatusCode::OK }
}

#[derive(PartialEq, Clone)]
pub enum EthChainId {
    //Ethernet chain type number, used in the signing process
    MAIN = 1,
    ROPSTEN = 3,
    RINKEBY = 4,
}

#[derive(PartialEq, Clone, Debug)]
pub enum ChainType {
    //Used to distinguish the chain types supported by the wallet
    BTC = 1,
    BtcTest = 2,
    ETH = 3,
    EthTest = 4,
    EEE = 5,
    EeeTest = 6,
    OTHER = 7,
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

pub enum WalletType {
    Normal,//钱包
    Test,  //测试钱包，对应的链为测试链
}

/// 用来切换钱包的网络时使用的
///
/// [WalletType.Test] 可以切换为 [NetType.Test]， [NetType.Test] ，[NetType.PrivateTest]
///
/// [WalletType.Normal] 只能为 [NetType.Main]
///
/// 测试钱包不能切换到主网，这样做是为了避免用户弄错了
///
/// [WalletType.Test]:WalletType::TEST
/// [WalletType.Normal]:WalletType::Normal
/// [NetType.Main]:NetType::Main
/// [NetType.Test]:NetType::Test
/// [NetType.Test]:NetType::Test
/// [NetType.PrivateTest]:NetType::PrivateTest
pub enum NetType {
    Main,
    Test,
    Private,
    PrivateTest,
}

pub enum TxStatus {
    /// 交易在链上确认成功
    Success,
    /// 交易在链上失败
    Fail,
    /// 新创建的交易
    New,
    /// 进入Pending中的交易
    Pending,
    /// 开始打包的交易
    Packing,
}

#[cfg(target_os="android")]
fn init_logger_once() {
    android_logger::init_once(
        android_logger::Config::default()
            .with_min_level(log::Level::Trace) // limit log level
            .with_tag("rust") // logs will show under mytag tag
            .with_filter( // configure messages for specific crate
                          android_logger::FilterBuilder::new()
                              .parse("debug,hello::crate=error")
                              .build())
    );
    log::trace!("init logger");
}

#[cfg(test)]
mod tests {
    use super::*;
    use substratetx:: Crypto;
    use hex;

    const MNEMONIC :&'static str = "alarm lottery circle settle account member deliver buffalo reason sunny size tongue";

    #[test]
    fn mnemonic_create_test() {
        //Mnemonic word creation test, signature test
        let mnemonic = substratetx::Sr25519::generate_phrase(18);
        let seed = substratetx::Sr25519::seed_from_phrase(&mnemonic, None).unwrap();
        let pair = substratetx::Sr25519::pair_from_seed(&seed);
        let address = substratetx::Sr25519::ss58_from_pair(&pair,64);
        println!("address:{}",address);
        let data = "substrate sign method test";
        match substratetx::Ed25519::sign(&mnemonic, data.as_bytes()) {
            Ok(signed_data) => println!("0x{}", hex::encode(&signed_data[..])),
            Err(e) => println!("{}", e.to_string()),
        }
    }

    #[test]
    fn func_sign_test() {
        //Initialize the database
        if let Err(err) = wallet_db::init_wallet_database(){
            println!("error detail info:{}",err.to_string());
        }
        //Create a wallet instance
        let manager = module::wallet::WalletManager{};
        let wallet = manager.create_wallet("foo",MNEMONIC.as_bytes(),"123456".as_bytes(),0).expect("save wallet");
        let rawtx = "0xc804080254065129457ea102a3d978e78c88c93e7e9298d06378874b7206e43cf4c6f67f0f0000c16ff2862318e68993e8bda6000000006cec71473c1b8d2295541cb5c21edc4fdb1926375413bb28f78793978229cf480600000001000000";
        let eee = module::EEE {};
        match eee.raw_tx_sign(rawtx, &wallet.wallet_id, "123456".as_bytes()) {
            Ok(signed_data) => println!("tx sign result {}", signed_data),
            Err(e) => println!("{}", e.to_string()),
        }
    }


    #[test]
    fn eth_raw_tx_sign_test() {
        let address = {
            //Initialize the database
            wallet_db::init_wallet_database().expect("init database error");
            //Create a wallet instance
            let manager = module::wallet::WalletManager {};
            let mnemonic = manager.crate_mnemonic(15);
            let mut wallet = manager.create_wallet("eth_raw_tx_sign_test", &mnemonic.mn, "123456".as_bytes(), 1).unwrap();
            for it in manager.get_all().unwrap() {
                if it.wallet_id == wallet.wallet_id {
                    wallet = it;
                    break;
                }
            }
            wallet.eth_chain.unwrap().address
        };

        let rawtx = "0xf86a808301000082010094dac17f958d2ee523a2206206994597c13d831ec780b847565c93e3000000000000000000000000d132abb434b7fe9aca4b24e3f0ef6fdeeeaf87920000000000000000000000000000000000000000000000000000000000000064636268808080";
        let ethereum = module::Ethereum {};
        match ethereum.raw_tx_sign(rawtx, 1, address.as_str(), "123456".as_bytes()) {
            Ok(signed_data) => {
                println!("tx sign result {}", signed_data)
            }
            Err(e) => {
                assert_eq!("", e.to_string())
            }
        }
    }

    #[test]
    fn transfer_test() {
       // let mnemonic = "settle essay unique empty neutral pistol essence monkey combine service gun burden";
        let from = "5HmDfrMF62f1CDHXYcZ3G3vnKbu14HvzTkisnRU5oa7YZDff";
        let to = "5GGzGJR54YNjMKhaYt6hHV3o99FZ6JKYEDCrzUg1HCz1tWPa";
        let value = "5.";
        let genesis_hash = "0xabb0f2e62dfab481623438e14b5e1d4114a6e9a2f0d3f5e83f9192276e50cf34";
        let index = 0;
        let runtime_version = 1;
        let tx_version =1 ;
        let genesis_hash_bytes = hex::decode(genesis_hash.get(2..).unwrap()).unwrap();
        let mut genesis_h256 = [0u8; 32];
        genesis_h256.clone_from_slice(genesis_hash_bytes.as_slice());
        // Involving database access requires a series of data preparations for normal testing
        let eee = module::EEE {};
        match eee.generate_eee_transfer(from, to, value, index, "123456".as_bytes()) {
            Ok(sign_str) => {
                println!("{}", sign_str);
            }
            Err(err) => println!("{}", err)
        }
    }

    #[test]
    fn get_all_test(){
        let manager = module::wallet::WalletManager {};
        let res = manager.get_all();
        assert_eq!(res.is_ok(),true);
    }
}
