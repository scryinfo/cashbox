use substrate_primitives::{ hexdisplay::HexDisplay, Pair,crypto::Ss58Codec};
use bip39::{Mnemonic, MnemonicType, Language};
use rand::{RngCore, rngs::OsRng};

pub trait Crypto {
    type Seed: AsRef<[u8]> + AsMut<[u8]> + Sized + Default;
    type Pair: Pair;
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
    fn pair_from_suri(phrase: &str, password: Option<&str>) -> Self::Pair {
        Self::pair_from_seed(&Self::seed_from_phrase(phrase, password))
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
}
mod ed25519;
mod sr25519;
pub use sr25519::Sr25519;
pub use ed25519::Ed25519;
