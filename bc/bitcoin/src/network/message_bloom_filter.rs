//! mod for bloom filter message
use bitvec::prelude::*;
use consensus::Encodable;
use hashes::{sha256d, Hash};
use hex::decode as hex_decode;
use std::f64::consts::{E, LN_2};
use std::num::Wrapping;
use BitcoinHash;
use std::io::{Cursor, Read};

///the message filterload
/// n_flags
///     0: BLOOM_UPDATE_NONE
///     1: BLOOM_UPDATE_ALL
///     2: BLOOM_UPDATE_P2PUBKEY_ONLY
///
#[derive(PartialEq, Eq, Clone, Debug)]
pub struct FilterLoadMessage {
    ///The filter itself is simply a bit field of arbitrary byte-aligned size. The maximum size is 36,000 bytes.
    pub filter: Vec<u8>,
    ///The number of hash functions to use in this filter. The maximum value allowed in this field is 50.
    pub n_hash_functions: u32,
    ///A random value to add to the seed value in the hash function used by the bloom filter.
    pub n_tweak: u32,
    ///A set of flags that control how matched items are added to the filter.
    pub n_flags: u8,
}

impl_consensus_encoding!(
    FilterLoadMessage,
    filter,
    n_hash_functions,
    n_tweak,
    n_flags
);

/// The message "merkleblock"
/// https://en.bitcoin.it/wiki/Protocol_documentation#filterload.2C_filteradd.2C_filterclear.2C_merkleblock
#[derive(PartialEq, Eq, Clone, Debug)]
pub struct MerkleBlockMessage {
    ///version
    pub version: i32,
    ///prev_block
    pub prev_block: sha256d::Hash,
    ///merkleblock
    pub merkle_root: sha256d::Hash,
    ///timestamp
    pub timestamp: u32,
    ///nbits
    pub bits: u32,
    ///nonce
    pub nonce: u32,
    ///total_transactions
    pub total_transactions: u32,
    ///hashes in merkleblock
    pub hashes: Vec<sha256d::Hash>,
    ///flags vector
    pub flags: Vec<u8>,
}

impl_consensus_encoding!(
    MerkleBlockMessage,
    version,
    prev_block,
    merkle_root,
    timestamp,
    bits,
    nonce,
    total_transactions,
    hashes,
    flags
);

impl BitcoinHash for MerkleBlockMessage {
    fn bitcoin_hash(&self) -> sha256d::Hash {
        let mut enc = sha256d::Hash::engine();
        self.consensus_encode(&mut enc).unwrap();
        sha256d::Hash::from_engine(enc)
    }
}

/// max bytes in filter
pub const BYTES_MAX: f64 = 36000f64;
/// max function number in filter
pub const FUNCS_MAX: f64 = 50f64;
/// flg in bloom filter
pub const N_FLAGS: u32 = 0;
/// Value to add to Murmur3 hash seed when calculating hash
pub const N_TWEAK: u32 = 0;
/// Constant optimized to create large differences in the seed for different values of `calculate_filter`
pub const MAGIC: u32 = 0xFBA4C795;
/// Value used in murmur3 hash
pub const FFF: u32 = 0xffffffff;
/// a false positive rate
/// p in [https://bitcoin.org/en/developer-examples#creating-a-bloom-filter] 0.0001 --> examples  moved to p2p_network
/// p in [https://dashcore.readme.io/docs/core-examples-p2p-network-creating-a-bloom-filter]
pub const P: f64 = 0.00001;

/// calculate filter
/// The formula comes from the [https://github.com/bitcoin/bips/blob/master/bip-0037.mediawiki]
/// (-1 / pow(log(2), 2) * N * log(P)) / 8
/// the const value comes from the BIP37
impl FilterLoadMessage {
    /// calculate filter
    /// The bit_vec must be little-endian
    ///     n: n elements input into filter
    ///     elements: address, tx, block
    /// beacause we use SPV wallets we always have one input n == 1
    /// default n_flags 1
    pub fn calculate_filter(elements: &str) -> Self {
        let n = 1f64;
        let n_filter_bytes = (-1f64 / (LN_2 * LN_2) * n * P.log(E)) / 8f64;
        let n_filter_bytes = n_filter_bytes.min(BYTES_MAX) as u32;
        let n_hash_functions = (n_filter_bytes as f64) * 8f64 / n * LN_2;
        let n_hash_functions = n_hash_functions.min(FUNCS_MAX) as u32;

        // Lsb0 == little-endian in bitvec library
        let mut v_data = bitvec![Lsb0, u8; 0; (n_filter_bytes * 8) as usize];
        //019f5b01d4195ecbc9398fbf3c3b1fa9bb3183301d7a1fb3bd174fcfa40a2b65"
        //652b0aa4cf4f17bdb31f7a1d308331bba91f3b3cbf8f39c9cb5e19d4015b9f01 正
        let mut data_to_hash = hex_decode(elements).expect("parse hex error");
        //For big and little endian order, flip it
        data_to_hash.reverse();

        for i in 0..n_hash_functions {
            let n_index = FilterLoadMessage::bloom_hash(i, &mut data_to_hash, n_filter_bytes);
            // Set the bit at nIndex to 1
            v_data.set(n_index as usize, true);
        }

        Self {
            filter: v_data.into_vec(),
            n_hash_functions,
            n_tweak: 0,
            n_flags: 1,
        }
    }

    /// calc bloom hash
    /// Protect calc from overflow for using Wrapping
    fn bloom_hash(n_hash_num: u32, data: &mut Vec<u8>, n_filter_bytes: u32) -> u32 {
        let seed = ((Wrapping(n_hash_num) * Wrapping(MAGIC) + Wrapping(N_TWEAK)) & Wrapping(FFF)).0;
        // murmur3::hash32_with_seed(data, seed) % (n_filter_bytes * 8)
        murmur3::murmur3_32(Cursor::new(data).by_ref(), seed).unwrap() % (n_filter_bytes * 8)
    }
}

#[cfg(test)]
mod test {
    use consensus::{deserialize, serialize};
    use network::message::{NetworkMessage, RawNetworkMessage};
    use network::message_bloom_filter::{FilterLoadMessage, MerkleBlockMessage};

    #[test]
    fn serialize_filterload_test() {
        let data = vec![
            0xf9, 0xbe, 0xb4, 0xd9, 0x66, 0x69, 0x6c, 0x74, 0x65, 0x72, 0x6c, 0x6f, 0x61, 0x64,
            0x00, 0x00, 0x0c, 0x00, 0x00, 0x00, 0x8b, 0x7f, 0x50, 0x7b, 0x02, 0xb5, 0x0f, 0x0b,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        ];

        let filterload = FilterLoadMessage {
            filter: vec![0xb5, 0x0f],
            n_hash_functions: 11,
            n_tweak: 0,
            n_flags: 0,
        };

        let raw_filterload = RawNetworkMessage {
            magic: 0xd9b4bef9,
            payload: NetworkMessage::FilterLoad(filterload),
        };

        let raw_data = deserialize::<RawNetworkMessage>(&data);
        assert!(&raw_data.is_ok());
        assert_eq!(data, serialize(&raw_filterload));
    }

    #[test]
    fn deserialize_merkerblock_test() {
        let data = vec![
            0x01, 0x00, 0x00, 0x00, 0x82, 0xbb, 0x86, 0x9c, 0xf3, 0xa7, 0x93, 0x43, 0x2a, 0x66,
            0xe8, 0x26, 0xe0, 0x5a, 0x6f, 0xc3, 0x74, 0x69, 0xf8, 0xef, 0xb7, 0x42, 0x1d, 0xc8,
            0x80, 0x67, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x7f, 0x16, 0xc5, 0x96, 0x2e, 0x8b,
            0xd9, 0x63, 0x65, 0x9c, 0x79, 0x3c, 0xe3, 0x70, 0xd9, 0x5f, 0x09, 0x3b, 0xc7, 0xe3,
            0x67, 0x11, 0x7b, 0x3c, 0x30, 0xc1, 0xf8, 0xfd, 0xd0, 0xd9, 0x72, 0x87, 0x76, 0x38,
            0x1b, 0x4d, 0x4c, 0x86, 0x04, 0x1b, 0x55, 0x4b, 0x85, 0x29, 0x07, 0x00, 0x00, 0x00,
            0x04, 0x36, 0x12, 0x26, 0x26, 0x24, 0x04, 0x7e, 0xe8, 0x76, 0x60, 0xbe, 0x1a, 0x70,
            0x75, 0x19, 0xa4, 0x43, 0xb1, 0xc1, 0xce, 0x3d, 0x24, 0x8c, 0xbf, 0xc6, 0xc1, 0x58,
            0x70, 0xf6, 0xc5, 0xda, 0xa2, 0x01, 0x9f, 0x5b, 0x01, 0xd4, 0x19, 0x5e, 0xcb, 0xc9,
            0x39, 0x8f, 0xbf, 0x3c, 0x3b, 0x1f, 0xa9, 0xbb, 0x31, 0x83, 0x30, 0x1d, 0x7a, 0x1f,
            0xb3, 0xbd, 0x17, 0x4f, 0xcf, 0xa4, 0x0a, 0x2b, 0x65, 0x41, 0xed, 0x70, 0x55, 0x1d,
            0xd7, 0xe8, 0x41, 0x88, 0x3a, 0xb8, 0xf0, 0xb1, 0x6b, 0xf0, 0x41, 0x76, 0xb7, 0xd1,
            0x48, 0x0e, 0x4f, 0x0a, 0xf9, 0xf3, 0xd4, 0xc3, 0x59, 0x57, 0x68, 0xd0, 0x68, 0x20,
            0xd2, 0xa7, 0xbc, 0x99, 0x49, 0x87, 0x30, 0x2e, 0x5b, 0x1a, 0xc8, 0x0f, 0xc4, 0x25,
            0xfe, 0x25, 0xf8, 0xb6, 0x31, 0x69, 0xea, 0x78, 0xe6, 0x8f, 0xba, 0xae, 0xfa, 0x59,
            0x37, 0x9b, 0xbf, 0x01, 0x1d,
        ];

        let des: Result<MerkleBlockMessage, _> = deserialize(&data);
        assert!(des.is_ok());
        println!("{:#?}", des.unwrap());
    }

    #[test]
    fn calculate_filter_test() {
        let filterload = FilterLoadMessage::calculate_filter(
            "652b0aa4cf4f17bdb31f7a1d308331bba91f3b3cbf8f39c9cb5e19d4015b9f01",
        );
        println!("{:0x?}", filterload);
    }
}
