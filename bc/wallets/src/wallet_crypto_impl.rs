use super::wallet_crypto::Crypto;
use substrate_primitives::Pair;

pub struct WalletCryptoUtil{

}


impl  WalletCryptoUtil{

    type Seed: AsRef<[u8]> + AsMut<[u8]> + Sized + Default;

    type Pair: Pair;

    pub fn generate_phrase<T>(num: u8) -> String where T: Crypto {
        T::generate_phrase(num)
    }

    pub fn generate_seed<T>() where T:Crypto{
        T::generate_seed()
    }

    pub fn seed_from_phrase<T>(phrase: &str, password: Option<&str>) -> Seed where T:Crypto{
        T::seed_from_phrase(phrase,password)
    }
    pub fn pair_from_seed<T>(seed: &Self::Seed) -> Self::Pair where T:Crypto{
        T::pair_from_seed(seed)
    }
    pub fn pair_from_suri<T>(phrase: &str, password: Option<&str>) -> Self::Pair where T:Crypto{
        T::pair_from_suri(phrase,password)
    }
    pub fn ss58_from_pair<T>(pair: &Self::Pair) -> String where T:Crypto{
        T::ss58_from_pair(pair)
    }
    pub fn public_from_pair<T>(pair: &Self::Pair) -> Vec<u8> where T:Crypto{
        T::public_from_pair(pair)
    }
    pub fn seed_from_pair<T>(_pair: &Self::Pair) -> Option<&Self::Seed> where T:Crypto{
        T::seed_from_pair(_pair)
    }
    pub fn encrypt_mnemonic<T>(mn: &[u8], password: &[u8]) -> String where T: Crypto {
        T::encrypt_mnemonic(mn, password)
    }

    fn get_mnemonic_context<T>(keystore: &str, password: &[u8]) -> Result<Vec<u8>, String> where T: Crypto {
        T::get_mnemonic_context(keystore, password)
    }
}


