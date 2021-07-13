pub mod error;

use bip39::{Mnemonic, Language, Seed};
use tiny_hderive::bip32::ExtendedPrivKey;
use secp256k1::{Secp256k1, key::{PublicKey, SecretKey}};

pub use error::Error;

// private key
pub fn pri_from_mnemonic(phrase: &str, psd: Option<Vec<u8>>) -> Result<Vec<u8>, error::Error> {
    let mnemonic = Mnemonic::from_phrase(phrase, Language::English)?;
    let psd = {
        match psd {
            Some(data) => String::from_utf8(data)?,
            None => String::from(""),
        }
    };
    let seed = Seed::new(&mnemonic, &psd);//
    let ext_key = ExtendedPrivKey::derive(&seed.as_bytes(), "m/44'/1'/0'/0/0")?;
    Ok(ext_key.secret().to_vec())
}

//Generate btc address from uncompressed public key
pub fn generate_btc_address(secret_byte: &[u8]) -> Result<(String, String), error::Error> {
    let context = Secp256k1::new();
    let secret = SecretKey::from_slice(&secret_byte)?;
    let public_key = PublicKey::from_secret_key(&context, &secret);
    //the uncompressed public key used for address generation
    let puk_uncompressed = &public_key.serialize_uncompressed()[..];
    let public_key_hash = keccak(&puk_uncompressed[1..]);
    let address_str = hex::encode(&public_key_hash[12..]);
    let puk_str = hex::encode(&public_key.serialize()[..]);
    Ok((format!("0x{}", address_str), format!("0x{}", puk_str)))
}


fn keccak(s: &[u8]) -> [u8; 32] {
    let mut result = [0u8; 32];
    tiny_keccak::Keccak::keccak256(s, &mut result);
    result
}


#[cfg(test)]
mod tests {
    #[test]
    fn it_works() {
        assert_eq!(2 + 2, 4);
    }
}
