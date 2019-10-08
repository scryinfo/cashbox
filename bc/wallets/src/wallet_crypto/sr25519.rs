use super::*;
use substrate_primitives::{crypto::Ss58Codec};
use substrate_primitives::sr25519;
use bip39::{Mnemonic, Language};
use substrate_bip39::mini_secret_from_entropy;

pub struct Sr25519;

impl Crypto for Sr25519 {
    type Seed = [u8; 32];
    type Pair = sr25519::Pair;
    type Public = sr25519::Public;

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
    fn pair_from_seed(seed: &Self::Seed) -> Self::Pair {
        Pair::from_seed_slice(seed).expect("key is always the correct size; qed")

    }
    fn pair_from_suri(suri: &str, password: Option<&str>) -> Self::Pair {
        sr25519::Pair::from_string(suri, password).expect("Invalid phrase")
    }
    fn ss58_from_pair(pair: &Self::Pair) -> String { pair.public().to_ss58check() }
    fn public_from_pair(pair: &Self::Pair) -> Vec<u8> { (&pair.public().0[..]).to_owned() }

    fn sign(phrase: &str,msg:&[u8])->[u8;64]{
        let seed = Self::seed_from_phrase(phrase,None);
        let pair = Self::pair_from_seed(&seed);
        pair.sign(msg).0
    }
}
