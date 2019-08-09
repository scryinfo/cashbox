use crate::account_crypto::{Crypto,Sr25519};
use scrypt::{ScryptParams, scrypt};
use rand::rngs::OsRng;
use rand::RngCore;
use scry_crypto::aes;
use log::info;
use serde_json::json;

pub mod account_crypto;
pub mod dataservice;

pub enum StatusCode {
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

pub enum ChainType {
    BTC = 1,
    BtcTest,
    ETH,
    EthTest,
    EEE,
    EeeTest,
}

const SCRYPT_LOG_N: u8 = 18;
const SCRYPT_P: u32 = 1;
//u32 的数据类型为使用scrypt这个库中定义
const SCRYPT_R: u32 = 8;
const SCRYPT_DKLEN: usize = 32;
const CIPHER_KEY_SIZE: &'static str = "aes-128-ctr";

#[repr(C)]
pub struct Mnemonic {
    pub status: StatusCode,
    pub mn: Vec<u8>,
    pub mnid: String,
}

#[repr(C)]
pub struct Address {
    pub chain_type: ChainType,
    pub pubkey: String,
    pub addr: String,
    pub pri_key: Vec<u8>,
}

fn address_from_mnemonic<T>(mn: &[u8]) -> Address where T: Crypto{
    let phrase = String::from_utf8(mn.to_vec()).expect("mn byte format convert to string is error!");
    info!("phrase is:{}", phrase);
    let seed = T::seed_from_phrase(&phrase, None);
    let pair = T::pair_from_seed(&seed);
    let address = T::ss58_from_pair(&pair);
    let puk_key = T::public_from_pair(&pair);
    Address {
        chain_type: ChainType::EEE,
        pubkey: hex::encode(puk_key),
        addr: address,
        pri_key: vec![],
    }
}

pub fn crate_mnemonic<T>(num: u8) -> Mnemonic where T: Crypto {
    let mnemonic = T::generate_phrase(num);
    let mut kecck = tiny_keccak::Keccak::new_keccak256();
    kecck.update(mnemonic.as_bytes());
    let mut mnemonic_id = [0u8; 32];
    kecck.finalize(&mut mnemonic_id);
    Mnemonic {
        status: StatusCode::OK,
        mn: mnemonic.as_bytes().to_vec(),
        mnid: hex::encode(mnemonic_id),
    }
}

pub fn save_mnemonic(mn: &[u8], password: &[u8]) -> Mnemonic {

    let provider = dataservice::DataServiceProvider::instance("wallet.mnemonic");
    //获取助记词对应链的地址、公钥
    let address = address_from_mnemonic::<Sr25519>(mn);

    let mut mnemonic_id = [0u8; 32];
    {
        let mut keccak = tiny_keccak::Keccak::new_keccak256();
        keccak.update(mn);
        keccak.finalize(&mut mnemonic_id);
    }

    let params = ScryptParams::new(SCRYPT_LOG_N, SCRYPT_R, SCRYPT_P).unwrap();
    let mut salt = [0u8; 32];
    let mut iv = [0u8; 16];

    OsRng.fill_bytes(&mut salt);
    OsRng.fill_bytes(&mut iv);

    let mut dk = [0u8; SCRYPT_DKLEN];
    let str_salt = hex::encode(salt);
    let str_iv = hex::encode(iv);
    scrypt(password, &salt, &params, &mut dk).expect("32 bytes always satisfy output length requirements");

    let ciphertext = aes::encrypt(aes::EncryptMethod::Aes128Ctr,mn,&dk,&iv).unwrap();


    //将导出密钥的16到32位数据，与加密后的内容拼接，计算出的摘要值
    let mut hex_mac = [0u8; 32];
    {
        let mut keccak = tiny_keccak::Keccak::new_keccak256();
        keccak.update(&dk[16..]);
        keccak.update(&ciphertext[..]);
        keccak.finalize(&mut hex_mac);
    }

    let hex_enc_mn_data = hex::encode(ciphertext);
    let key_store = json!({
        "version":"0.1.0",
        "cipher":CIPHER_KEY_SIZE,
        "cipherparams":json!({
            "iv":str_iv
         }),
         "ciphertext": hex_enc_mn_data,
        "kdf":"scrypt",
        "kdfparams":json!({
        "dklen":SCRYPT_DKLEN,
        "log_n":SCRYPT_LOG_N,
         "r":SCRYPT_R,
         "p": SCRYPT_P,
         "salt":str_salt
        }),
        "mac":hex::encode(hex_mac)
    });
    //info!("key store detail is:{}",key_store.to_string());
    println!("key store detail is:{}",key_store.to_string());
    //构造助记词保存结构
    // 开启事务
    //保存助记词到数据库
    //保存公钥，地址到数据库
    //关闭事务
    // let instance = dataservice::getinstance();
    Mnemonic {
        status: StatusCode::OK,
        mn: "12315646".as_bytes().to_vec(),
        mnid: "123456".to_string(),
    }
}

#[cfg(test)]
mod tests {
    use crate::crate_mnemonic;
    use crate::account_crypto::Ed25519;
    use crate::account_crypto::Sr25519;


    #[test]
    fn verify_mnemonic_create() {
        println!("{}", crate_mnemonic::<Ed25519>(18));
        println!("{}", crate_mnemonic::<Sr25519>(18));
    }
}
