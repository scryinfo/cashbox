pub mod error;


use bitcoin_wallet::account::{AccountAddressType, MasterAccount, Account, Unlocker};
use bitcoin::network::constants::Network;

pub use error::Error;
use bitcoin_wallet::mnemonic::Mnemonic;
use bitcoin::util::psbt::serialize::Serialize;

//Generate btc address from uncompressed public key
// bip39 44 32
pub fn generate_btc_address(
    mn: &[u8],
    chain_type: &str,
) -> Result<(String, String), error::Error> {
    let mn = String::from_utf8(mn.to_vec())?;
    let network = match chain_type {
        "BTC" => Network::Bitcoin,
        "BtcTest" => Network::Testnet,
        "BtcPrivate" => Network::Regtest,
        "BtcPrivateTest" => Network::Regtest,
        _ => Network::Testnet
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
    Ok((address,public_key))
}

#[cfg(test)]
mod tests {
    #[test]
    fn it_works() {
        assert_eq!(2 + 2, 4);
    }
}
