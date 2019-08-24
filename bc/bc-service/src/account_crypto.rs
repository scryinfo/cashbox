use substrate_primitives::{ed25519, sr25519, hexdisplay::HexDisplay, Pair, crypto::Ss58Codec};
use bip39::{Mnemonic, MnemonicType, Language};
use substrate_bip39::mini_secret_from_entropy;
use schnorrkel::keys::MiniSecretKey;
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

pub struct Ed25519;
impl Crypto for Ed25519 {
    type Seed = [u8; 32];
    type Pair = ed25519::Pair;

    fn seed_from_phrase(phrase: &str, password: Option<&str>) -> Self::Seed {
        Sr25519::seed_from_phrase(phrase, password)
    }
    fn pair_from_suri(suri: &str, password_override: Option<&str>) -> Self::Pair {
        ed25519::Pair::from_legacy_string(suri, password_override)
    }
    fn pair_from_seed(seed: &Self::Seed) -> Self::Pair { ed25519::Pair::from_seed(&seed.clone()) }
    fn ss58_from_pair(pair: &Self::Pair) -> String { pair.public().to_ss58check() }
    fn public_from_pair(pair: &Self::Pair) -> Vec<u8> { (&pair.public().0[..]).to_owned() }
    fn seed_from_pair(pair: &Self::Pair) -> Option<&Self::Seed> { Some(pair.seed()) }
}


pub struct Sr25519;

impl Crypto for Sr25519 {
    type Seed = [u8; 32];
    type Pair = sr25519::Pair;

    fn seed_from_phrase(phrase: &str, password: Option<&str>) -> Self::Seed {
        mini_secret_from_entropy(
            Mnemonic::from_phrase(phrase, Language::English)
                .unwrap_or_else(|_|
                    panic!("Phrase is not a valid BIP-39 phrase: \n    {}", phrase)
                )
                .entropy(),
            password.unwrap_or(""),
        )
            .expect("32 bytes can always build a key; qed")
            .to_bytes()
    }

    fn pair_from_suri(suri: &str, password: Option<&str>) -> Self::Pair {
        sr25519::Pair::from_string(suri, password).expect("Invalid phrase")
    }

    fn pair_from_seed(seed: &Self::Seed) -> Self::Pair {
        MiniSecretKey::from_bytes(seed)
            .expect("32 bytes can always build a key; qed")
            .into()
    }
    fn ss58_from_pair(pair: &Self::Pair) -> String { pair.public().to_ss58check() }
    fn public_from_pair(pair: &Self::Pair) -> Vec<u8> { (&pair.public().0[..]).to_owned() }
}
