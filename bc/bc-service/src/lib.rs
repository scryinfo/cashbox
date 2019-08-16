#[macro_use]
extern crate serde_derive;

use crate::account_crypto::{Crypto, Sr25519};
use scrypt::{ScryptParams, scrypt};
use rand::rngs::OsRng;
use rand::RngCore;
use scry_crypto::aes;
use log::info;
use tiny_keccak::Keccak;
use crate::dataservice::TbMnemonic;

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
    pub mnid: String,
    pub mn: Vec<u8>,
    pub chain_list: Vec<Chain>,

}


#[repr(C)]
pub struct Address {
    pub chain_type: ChainType,
    pub pubkey: String,
    pub addr: String,
    pub pri_key: Vec<u8>,
}

#[repr(C)]
pub struct Chain {
    pub status: StatusCode,
    pub chain_id: u16,
    pub wallet_id: String,
    pub chain_address: String,
    pub is_visible: bool,
    pub chain_type: ChainType,
    pub digit_list: Vec<Digit>,
}

#[repr(C)]
pub struct Digit {
    pub status: StatusCode,
    pub digit_id: String,
    pub chain_id: u16,
    pub address: String,
    pub contract_address: String,
    pub fullname: String,
    pub shortname:String,
    pub balance: String,
    pub is_visible: bool,
    pub decimal: i8,
    pub imgurl: String,
}

#[repr(C)]
pub struct Wallet {
    pub status: StatusCode,
    pub wallet_id: String,
    pub wallet_name: String,
    pub chain_list: Vec<Chain>,
}

//query all 满足条件的助记词（wallet）
pub fn get_all_wallet() -> Vec<TbMnemonic> {
    let instance = dataservice::DataServiceProvider::instance().unwrap();
    instance.get_mnemonics()
}

pub fn get_current_wallet() -> Result<Mnemonic, String> {
    let instance = dataservice::DataServiceProvider::instance().unwrap();
    instance.query_selected_mnemonic().map(|tb| Mnemonic {
        mnid: tb.id,
        status: StatusCode::OK,
        mn: vec![],
        chain_list: vec![],
    }).map_err(|msg| msg)
}

pub fn set_current_wallet(walletid: &str) {
    let instance = dataservice::DataServiceProvider::instance().unwrap();
}

pub fn del_wallet(walletid: &str) {
    let instance = dataservice::DataServiceProvider::instance().unwrap();
}

fn address_from_mnemonic<T>(mn: &[u8]) -> Address where T: Crypto {
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
        chain_list: Vec::new(),
    }
}

pub fn save_mnemonic(wallet_name: &str, mn: &[u8], password: &[u8]) -> Result<Wallet, String> {

    //获取助记词对应链的地址、公钥
    let address = address_from_mnemonic::<Sr25519>(mn);

    let mut mnemonic_id = [0u8; 32];
    {
        let mut keccak = tiny_keccak::Keccak::new_keccak256();
        keccak.update(mn);
        keccak.finalize(&mut mnemonic_id);
    }

    let keystore = encrypt_mnemonic(mn, password);
    println!("key store detail is:{}", keystore);
    let hex_mnemonic_id = hex::encode(mnemonic_id);
    let address_save = dataservice::TbAddress {
        id: 0,
        mnemonic_id: hex_mnemonic_id.clone(),
        chain_id: address.chain_type as i16,
        address: address.addr,
        pub_key: address.pubkey,
        status: 1,
        ..Default::default()
    };
    let mnemonic_save = dataservice::TbMnemonic {
        id: hex_mnemonic_id.clone(),
        full_name: Some(wallet_name.to_string()),
        mnemonic: keystore,
        ..Default::default()
    };

    //构造助记词保存结构
    // 开启事务
    //保存助记词到数据库
    //保存公钥，地址到数据库
    //关闭事务
    let instance = dataservice::DataServiceProvider::instance();
    match instance {
        Ok(mut dataservice) => {
            match dataservice.save_mnemonic_address(mnemonic_save, address_save){
                Ok(_)=>{
                    Ok(Wallet {
                        status: StatusCode::OK,
                        wallet_id:hex_mnemonic_id,
                        wallet_name: wallet_name.to_string(),
                        chain_list: Vec::new(),
                    })
                },
                Err(e)=>{
                    Err(e.to_string())
                }
            }
        },
        Err(e) => {
            Err(e)
        }
    }
}

//定义输入keystore文件格式，用于转换json格式文件
#[derive(Serialize, Deserialize)]
struct KeyStore {
    version: String,
    crypto: KeyCrypto,
}

#[derive(Serialize, Debug, Deserialize)]
struct KeyCrypto {
    ciphertext: String,
    cipher: String,
    cipherparams: CipherParams,
    kdf: String,
    //使用的kdf算法 现在默认使用scrypt
    kdfparams: KdfParams,
    mac: String,
}

#[derive(Serialize, Debug, Deserialize)]
struct CipherParams {
    iv: String,
}

#[derive(Serialize, Debug, Deserialize)]
struct KdfParams {
    dklen: usize,
    salt: String,
    n: u8,
    r: u32,
    p: u32,
}


fn encrypt_mnemonic(mn: &[u8], password: &[u8]) -> String {
    let params = ScryptParams::new(SCRYPT_LOG_N, SCRYPT_R, SCRYPT_P).unwrap();
    let mut salt = [0u8; 32];
    let mut iv = [0u8; 16];

    OsRng.fill_bytes(&mut salt);
    OsRng.fill_bytes(&mut iv);

    let mut dk = [0u8; SCRYPT_DKLEN];
    let str_salt = hex::encode(salt);
    let str_iv = hex::encode(iv);
    scrypt(password, &salt, &params, &mut dk).expect("32 bytes always satisfy output length requirements");

    let kdf_params = KdfParams {
        dklen: SCRYPT_DKLEN,
        salt: str_salt,
        n: SCRYPT_LOG_N,
        r: SCRYPT_R,
        p: SCRYPT_P,
    };
    let cipher_params = CipherParams {
        iv: str_iv,
    };

    let ciphertext = aes::encrypt(aes::EncryptMethod::Aes128Ctr, mn, &dk, &iv).unwrap();
    //将导出密钥的16到32位数据，与加密后的内容拼接，计算出的摘要值
    let mut hex_mac = [0u8; 32];
    {
        let mut keccak = tiny_keccak::Keccak::new_keccak256();
        keccak.update(&dk[16..]);
        keccak.update(&ciphertext[..]);
        keccak.finalize(&mut hex_mac);
    }

    let hex_enc_mn_data = hex::encode(ciphertext);
    let key_crypt = KeyCrypto {
        ciphertext: hex_enc_mn_data,
        cipher: CIPHER_KEY_SIZE.to_string(),
        cipherparams: cipher_params,
        kdf: "scrypt".to_string(),
        kdfparams: kdf_params,
        mac: hex::encode(hex_mac),
    };

    let store_data = KeyStore {
        version: "0.1.0".to_string(),
        crypto: key_crypt,
    };
    serde_json::to_string(&store_data).unwrap()
}

fn get_mnemonic_context(keystore: &str, old_psd: &[u8]) -> Result<Vec<u8>, String> {
    let store: Result<KeyStore, _> = serde_json::from_str(keystore);
    if store.is_err() {
        return Err("keystore convert serde_json error".into());
    }
    //对称加密密钥
    let mut key = vec![0u8; 32];

    let store = store.unwrap();
    let crypto = store.crypto;
    let cipher = crypto.cipher;
    let kdfparams: KdfParams = crypto.kdfparams;

    // let log_n = kdfparams.n.log2() as u8;
    let log_n = kdfparams.n;

    let p = kdfparams.p;
    let r = kdfparams.r;

    let params = ScryptParams::new(log_n, r, p).unwrap();
    let hex_salt = kdfparams.salt;

    let salt = hex::decode(hex_salt).unwrap();
    scrypt(old_psd, salt.as_slice(), &params, &mut key)
        .expect("32 bytes always satisfy output length requirements");

    //开始构造对称解密所需要的参数
    let hex_ciphertext: &str = &crypto.ciphertext;

    let ciphertext = hex::decode(hex_ciphertext).unwrap();

    //要校验输入的密钥导出的对称密钥是否正确，将导出密钥的16到32位数据，与加密后的内容拼接，计算出的摘要值与文本中保存的hash进行对比
    let mut keccak = Keccak::new_keccak256();
    keccak.update(&key[16..]);
    keccak.update(&ciphertext[..]);
    let mut hex_mac_from_password = [0u8; 32];

    keccak.finalize(&mut hex_mac_from_password);

    let hex_mac = crypto.mac;
    if !hex_mac.eq(&hex::encode(hex_mac_from_password)) {
        return Err("input password is not correct!".to_owned());
    }

    let cipherparams = &crypto.cipherparams;
    let hex_iv = &cipherparams.iv;
    let iv = hex::decode(hex_iv).unwrap();

    let cipher_method = match cipher.as_str() {
        "aes-128-ctr" => aes::EncryptMethod::Aes128Ctr,
        "aes-256-ctr" => aes::EncryptMethod::Aes256Ctr,
        _ => aes::EncryptMethod::Aes256Ctr,//默认使用这种方式加密
    };
    //TODO 针对解密出现的异常还需要进一步的处理
    let mnemonic_content = aes::decrypt(cipher_method, ciphertext.as_slice(), key.as_slice(), iv.as_slice());
    match mnemonic_content {
        Ok(mnemonic_content) => Ok(mnemonic_content),
        Err(e) => {
            Err(e)
        }
    }
}

fn mnemonic_psd_update(mn: &TbMnemonic, old_psd: &[u8], new_psd: &[u8]) -> StatusCode {
    //获取原来的助记词
    let context = get_mnemonic_context(mn.mnemonic.as_str(), old_psd);
    match context {
        Ok(data) => {
            //使用新的密码进行加密
            let new_encrypt_mn = encrypt_mnemonic(&data[..], new_psd);
            let instance = dataservice::DataServiceProvider::instance().unwrap();
            //构造需要升级的助记词对象，先只修改指定的字段，后续再根据需求完善
            let mnemonic_update = TbMnemonic {
                id: mn.id.clone(),
                full_name: None,
                mnemonic: new_encrypt_mn,
                ..Default::default()
            };
            match instance.update_mnemonic(mnemonic_update) {
                Ok(num) => {
                    println!("update mnemonic is over");
                    StatusCode::OK
                }
                Err(msg) => {
                    println!("update error,{}:", msg);
                    StatusCode::FailToRestPwd
                }
            }
        }
        Err(msg) => {
            StatusCode::FailToRestPwd
        }
    }
}

pub fn reset_mnemonic_pwd(mn_id: &str, old_pwd: &[u8], new_pwd: &[u8]) -> StatusCode {
    // TODO 检查密码规则是否满足要求
    // TODO 处理实例获取失败的异常
    let provider = dataservice::DataServiceProvider::instance().unwrap();
    //查询出对应id的助记词
    let mnemonic = provider.query_by_mnemonic_id(mn_id);
    match mnemonic {
        Ok(mn) => {
            //开始处理助记词逻辑
            mnemonic_psd_update(&mn, old_pwd, new_pwd)
        }
        Err(e) => {
            //针对错误信息 是否提示更多原因？
            StatusCode::FailToRestPwd
        }
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


/*let params = ScryptParams::new(SCRYPT_LOG_N, SCRYPT_R, SCRYPT_P).unwrap();
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
});*/
