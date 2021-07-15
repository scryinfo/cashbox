pub mod error;

use bitcoin::network::constants::Network;
use bitcoin_wallet::account::{Account, AccountAddressType, MasterAccount, Unlocker};

use bip39::Language;
use bitcoin::secp256k1::{PublicKey, SecretKey};
use bitcoin::util::psbt::serialize::Serialize;
use bitcoin_wallet::mnemonic::Mnemonic;
pub use error::Error;
use secp256k1::Secp256k1;
use ripemd160::{Ripemd160, Digest};
use sha2::Sha256;
use base58::{ToBase58};

//Generate btc address from uncompressed public key
// bip39 44 32
pub fn generate_btc_address(mn: &[u8], chain_type: &str) -> Result<(String, String), error::Error> {
    let mn = String::from_utf8(mn.to_vec())?;
    let network = match chain_type {
        "BTC" => Network::Bitcoin,
        "BtcTest" => Network::Testnet,
        "BtcPrivate" => Network::Regtest,
        "BtcPrivateTest" => Network::Regtest,
        _ => Network::Testnet,
    };
    let mnemonic = Mnemonic::from_str(&mn)?;
    let mut master = MasterAccount::from_mnemonic(&mnemonic, 0, network, "", None)?;
    let mut unlocker = Unlocker::new_for_master(&master, "")?;
    // path(0,0)
    let account = Account::new(&mut unlocker, AccountAddressType::P2PKH, 0, 0, 10)?;
    master.add_account(account);
    let account = master.get_mut((0, 0)).unwrap();
    let instance_key = account.next_key().unwrap();
    let address = instance_key.address.clone().to_string();
    let public_key = instance_key.public.clone();
    let ser = public_key.serialize();
    let public_key = format!("0x{}", hex::encode(ser));
    Ok((address, public_key))
}

pub fn generate_btc_address2(chain_type: &str) {
    let network = match chain_type {
        "BTC" => Network::Bitcoin,
        "BtcTest" => Network::Testnet,
        "BtcPrivate" => Network::Regtest,
        "BtcPrivateTest" => Network::Regtest,
        _ => Network::Testnet,
    };

    let phrase = "lawn duty beauty guilt sample fiction name zero demise disagree cram hand";
    let mnemonic = bip39::Mnemonic::from_phrase(phrase, Language::English).unwrap();
    let seed = bip39::Seed::new(&mnemonic, ""); //
    println!("{:?}", &seed);
    // mainnet "m/44'/0'/0'/0/0"
    let ext_private =
        tiny_hderive::bip32::ExtendedPrivKey::derive(seed.as_bytes(), "m/44'/1'/0'/0/0").unwrap();

    let context = Secp256k1::new();
    let secret = SecretKey::from_slice(&ext_private.secret().to_vec()).unwrap();
    let public_key = PublicKey::from_secret_key(&context, &secret);
    let puk_compressed = &public_key.serialize()[..];
    println!("{:02x?}", puk_compressed);

    let mut address = [0u8; 25];
    // mainnet 0x00
    // testnet 0x6f
    address[0] = 0x6F;
    address[1..21].copy_from_slice(&hash160(puk_compressed));
    let sum = &checksum(&address[0..21])[0..4];
    address[21..25].copy_from_slice(sum);
    println!("{:02x?}", address.to_base58());
}

pub fn hash160(bytes: &[u8]) -> Vec<u8> {
    Ripemd160::digest(&Sha256::digest(&bytes)).to_vec()
}

pub fn checksum(data: &[u8]) -> Vec<u8> {
    Sha256::digest(&Sha256::digest(&data)).to_vec()
}

#[cfg(test)]
mod tests {
    use crate::generate_btc_address2;

    #[test]
    fn it_works() {
        assert_eq!(2 + 2, 4);
    }

    #[test]
    fn test_genera() {
        generate_btc_address2("BtcTest");
    }
}
