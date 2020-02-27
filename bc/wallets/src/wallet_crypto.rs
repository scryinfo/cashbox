use sp_core::{hexdisplay::HexDisplay,Public,Pair, crypto::Ss58Codec};
use bip39::{Mnemonic, MnemonicType, Language};
use rand::{RngCore, rngs::OsRng};
use scry_crypto::aes;
use scrypt::{ScryptParams, scrypt};
use tiny_keccak::Keccak;

pub const SCRYPT_LOG_N: u8 = 5;
//调试 将迭代次数降低
pub const SCRYPT_P: u32 = 1;
//u32 的数据类型为使用scrypt这个库中定义
pub const SCRYPT_R: u32 = 8;
pub const SCRYPT_DKLEN: usize = 32;
pub const CIPHER_KEY_SIZE: &'static str = "aes-128-ctr";


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

pub trait  Keccak256<T>{
    fn keccak256(&self) -> T
        where T: Sized;
}

impl <T> Keccak256<[u8;32]> for T where T:AsRef<[u8]>{
    fn keccak256(&self)->[u8;32]{
        let mut keccak = Keccak::new_keccak256();
        let mut result = [0u8; 32];
        keccak.update(self.as_ref());
        keccak.finalize(&mut result);
        result
    }
}

pub trait Crypto {
    type Seed: AsRef<[u8]> + AsMut<[u8]> + Sized + Default;
    type Pair: Pair<Public=Self::Public>;
    type Public: Public + Ss58Codec + AsRef<[u8]> + std::hash::Hash;

    fn generate_phrase(num: u8) -> String {
        let mn_type = match num {
            12 => MnemonicType::Words12,
            15 => MnemonicType::Words15,
            18 => MnemonicType::Words18,
            21 => MnemonicType::Words21,
            24 => MnemonicType::Words24,
            _ => MnemonicType::Words15,
        };
        Mnemonic::new(mn_type, Language::English).phrase().to_owned()
    }
    fn generate_seed() -> Self::Seed {
        let mut seed: Self::Seed = Default::default();
        OsRng.fill_bytes(seed.as_mut());
        seed
    }
    fn seed_from_phrase(phrase: &str, password: Option<&str>) -> Self::Seed;
    fn pair_from_seed(seed: &Self::Seed) -> Self::Pair;
    fn pair_from_phrase(phrase: &str, password: Option<&str>) -> Self::Pair{
        let seed = Self::seed_from_phrase(phrase, password);
        let pair = Self::pair_from_seed(&seed);
        pair
    }
    fn pair_from_suri(suri: &str, password: Option<&str>) -> Self::Pair {
        Self::Pair::from_string(suri, password).expect("Invalid phrase")
        //Self::pair_from_seed(&Self::seed_from_phrase(phrase, password))
    }
    fn ss58_from_pair(pair: &Self::Pair) -> String;
    fn public_from_pair(pair: &Self::Pair) -> Vec<u8>;
    fn seed_from_pair(_pair: &Self::Pair) -> Option<&Self::Seed> { None }
    fn print_from_seed(seed: &Self::Seed) {
        let pair = Self::pair_from_seed(seed);
        println!("Seed 0x{} is account:\n  Public key (hex): 0x{}\n  Address (SS58): {}",
                 HexDisplay::from(&seed.as_ref()),
                 HexDisplay::from(&Self::public_from_pair(&pair)),
                 Self::ss58_from_pair(&pair)
        );
    }
    fn print_from_phrase(phrase: &str, password: Option<&str>) {
        let seed = Self::seed_from_phrase(phrase, password);
        let pair = Self::pair_from_seed(&seed);
        println!("Phrase `{}` is account:\n  Seed: 0x{}\n  Public key (hex): 0x{}\n  Address (SS58): {}",
                 phrase,
                 HexDisplay::from(&seed.as_ref()),
                 HexDisplay::from(&Self::public_from_pair(&pair)),
                 Self::ss58_from_pair(&pair)
        );
    }
    fn print_from_uri(uri: &str, password: Option<&str>) where <Self::Pair as Pair>::Public: Sized + Ss58Codec + AsRef<[u8]> {
        if let Ok(pair) = Self::Pair::from_string(uri, password) {
            let seed_text = Self::seed_from_pair(&pair)
                .map_or_else(Default::default, |s| format!("\n  Seed: 0x{}", HexDisplay::from(&s.as_ref())));
            println!("Secret Key URI `{}` is account:{}\n  Public key (hex): 0x{}\n  Address (SS58): {}",
                     uri,
                     seed_text,
                     HexDisplay::from(&Self::public_from_pair(&pair)),
                     Self::ss58_from_pair(&pair)
            );
        }
        if let Ok(public) = <Self::Pair as Pair>::Public::from_string(uri) {
            println!("Public Key URI `{}` is account:\n  Public key (hex): 0x{}\n  Address (SS58): {}",
                     uri,
                     HexDisplay::from(&public.as_ref()),
                     public.to_ss58check()
            );
        }
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

    fn get_mnemonic_context(keystore: &str, password: &[u8]) -> Result<Vec<u8>, String> {
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
        scrypt(password, salt.as_slice(), &params, &mut key)
            .expect("32 bytes always satisfy output length requirements");

        //开始构造对称解密所需要的参数
        let hex_ciphertext: &str = &crypto.ciphertext;

        let ciphertext = hex::decode(hex_ciphertext).unwrap();

        //要校验输入的密钥导出的对称密钥是否正确，将导出密钥的16到32位数据，与加密后的内容拼接，计算出的摘要值与文本中保存的hash进行对比
        //let mut account_msg = [0u8;16+ciphertext.len()];
       /* let mut account_msg =Vec::new();
            account_msg.clone_from_slice(&key[16..]);
        //account_msg.clone_from_slice(&key[16..]);
        account_msg.append(&ciphertext[..]);
        let hex_mac_from_password =  account_msg.keccak256();*/

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
    fn sign(phrase:&str,msg:&[u8])->[u8;64];
}

mod ed25519;
mod sr25519;

pub use sr25519::Sr25519;
pub use ed25519::Ed25519;
