use sp_core::{hexdisplay::HexDisplay, Public, Pair, crypto::Ss58Codec};
use bip39::{Mnemonic, MnemonicType, Language};
use rand::{RngCore, rngs::OsRng};
use scry_crypto::aes;
use scrypt::{ScryptParams, scrypt};
use tiny_keccak::Keccak;
use crate::error::Error;

pub const SCRYPT_LOG_N: u8 = 5;
//Debug Reduce the number of iterations
pub const SCRYPT_P: u32 = 1;
//The data type of u32 is defined in the library using scrypt
pub const SCRYPT_R: u32 = 8;
pub const SCRYPT_DKLEN: usize = 32;
pub const CIPHER_KEY_SIZE: &str = "aes-128-ctr";

//type Result<T> = Result<T,Error>;
//Define the input keystore file format, used to convert json format file
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
    //The kdf algorithm used now uses scrypt by default
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
    fn seed_from_phrase(phrase: &str, password: Option<&str>) -> Result<Self::Seed, Error>;
    fn pair_from_seed(seed: &Self::Seed) -> Self::Pair;
    fn pair_from_phrase(phrase: &str, password: Option<&str>) -> Result<Self::Pair, Error> {
        let seed = Self::seed_from_phrase(phrase, password)?;
        let pair = Self::pair_from_seed(&seed);
        Ok(pair)
    }
    fn pair_from_suri(suri: &str, password: Option<&str>) -> Result<Self::Pair, Error> {
        Ok(Self::Pair::from_string(suri, password)?)
    }
    fn ss58_from_pair(pair: &Self::Pair,ss58_version:u8) -> String;
    fn public_from_pair(pair: &Self::Pair) -> Vec<u8>;
    fn seed_from_pair(_pair: &Self::Pair) -> Option<&Self::Seed> { None }
    fn print_from_seed(seed: &Self::Seed,ss58_version:u8) {
        let pair = Self::pair_from_seed(seed);
        println!("Seed 0x{} is account:\n  Public key (hex): 0x{}\n  Address (SS58): {}",
                 HexDisplay::from(&seed.as_ref()),
                 HexDisplay::from(&Self::public_from_pair(&pair)),
                 Self::ss58_from_pair(&pair,ss58_version)
        );
    }
    fn print_from_phrase(phrase: &str, password: Option<&str>,ss58_version:u8) {
        match Self::seed_from_phrase(phrase, password) {
            Ok(seed) => {
                let pair = Self::pair_from_seed(&seed);
                println!("Phrase `{}` is account:\n  Seed: 0x{}\n  Public key (hex): 0x{}\n  Address (SS58): {}",
                         phrase,
                         HexDisplay::from(&seed.as_ref()),
                         HexDisplay::from(&Self::public_from_pair(&pair)),
                         Self::ss58_from_pair(&pair,ss58_version)
                );
            }
            Err(e) => {
                println!("print_from_phrase:{}", e)
            }
        }
    }
    fn print_from_uri(uri: &str, password: Option<&str>,ss58_version:u8) where <Self::Pair as Pair>::Public: Sized + Ss58Codec + AsRef<[u8]> {
        if let Ok(pair) = Self::Pair::from_string(uri, password) {
            let seed_text = Self::seed_from_pair(&pair)
                .map_or_else(Default::default, |s| format!("\n  Seed: 0x{}", HexDisplay::from(&s.as_ref())));
            println!("Secret Key URI `{}` is account:{}\n  Public key (hex): 0x{}\n  Address (SS58): {}",
                     uri,
                     seed_text,
                     HexDisplay::from(&Self::public_from_pair(&pair)),
                     Self::ss58_from_pair(&pair,ss58_version)
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
        let mut dk = [0u8; SCRYPT_DKLEN];
        {
            OsRng.fill_bytes(&mut salt);
            OsRng.fill_bytes(&mut iv);
            scrypt(password, &salt, &params, &mut dk).expect("32 bytes always satisfy output length requirements");
        }
        let ciphertext = aes::encrypt(aes::EncryptMethod::Aes128Ctr, mn, &dk, &iv).unwrap();
        //The 16- to 32-bit data of the derived key is concatenated with the encrypted content to calculate the digest value
        let mut hex_mac = [0u8; 32];
        {
            let mut keccak = tiny_keccak::Keccak::new_keccak256();
            keccak.update(&dk[16..]);
            keccak.update(&ciphertext[..]);
            keccak.finalize(&mut hex_mac);
        }

        let key_crypt = {
            let kdf_params = KdfParams {
                dklen: SCRYPT_DKLEN,
                salt: hex::encode(salt),
                n: SCRYPT_LOG_N,
                r: SCRYPT_R,
                p: SCRYPT_P,
            };

            let cipher_params = CipherParams { iv: hex::encode(iv), };
            KeyCrypto {
                ciphertext: hex::encode(ciphertext),
                cipher: CIPHER_KEY_SIZE.to_string(),
                cipherparams: cipher_params,
                kdf: "scrypt".to_string(),
                kdfparams: kdf_params,
                mac: hex::encode(hex_mac),
            }
        };

        let store_data = KeyStore {
            version: "0.1.0".to_string(),
            crypto: key_crypt,
        };
        serde_json::to_string(&store_data).unwrap()
    }

    fn get_mnemonic_context(keystore: &str, password: &[u8]) -> Result<Vec<u8>, Error> {
        let store: KeyStore = serde_json::from_str(keystore)?;
        let crypto = store.crypto;
        //Symmetric encryption key
        let mut key = vec![0u8; 32];
        {
            let kdfparams: KdfParams = crypto.kdfparams;
            let params = ScryptParams::new(kdfparams.n, kdfparams.r, kdfparams.p).unwrap();
            let salt = hex::decode(kdfparams.salt)?;
            scrypt(password, salt.as_slice(), &params, &mut key).expect("32 bytes always satisfy output length requirements");
        }

        let mut hex_mac_from_password = [0u8; 32];
        //Start constructing the parameters needed for symmetric decryption
        let ciphertext = hex::decode(&crypto.ciphertext)?;
        {
            let mut keccak = Keccak::new_keccak256();
            keccak.update(&key[16..]);
            keccak.update(&ciphertext[..]);
            keccak.finalize(&mut hex_mac_from_password);
        }

        if !crypto.mac.eq(&hex::encode(hex_mac_from_password)) {
            return Err(Error::Custom("input password is not correct!".to_owned()));
        }

        let iv = hex::decode(&crypto.cipherparams.iv)?;
        let cipher_method = match crypto.cipher.as_str() {
            "aes-128-ctr" => aes::EncryptMethod::Aes128Ctr,
            "aes-256-ctr" => aes::EncryptMethod::Aes256Ctr,
            _ => aes::EncryptMethod::Aes256Ctr,//Encrypted in this way by default
        };
        aes::decrypt(cipher_method, ciphertext.as_slice(), key.as_slice(), iv.as_slice()).map_err(|err|Error::Custom(err))
    }
    fn sign(phrase: &str, msg: &[u8]) -> Result<[u8; 64], Error>;
}

mod ed25519;
mod sr25519;

pub use sr25519::Sr25519;
pub use ed25519::Ed25519;
