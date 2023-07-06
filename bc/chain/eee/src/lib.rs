#[macro_use]
extern crate serde_derive;

use codec::{Compact, Decode, Encode};
pub use sp_core::{
    crypto::{AccountId32 as AccountId, Pair, Ss58Codec},
    H256 as Hash,
};
use sp_core::H256;
use sp_runtime::{
    generic::Era,
    MultiSignature,
};
use system::Phase;

//AdditionalSigned
pub use chain_helper::ChainHelper as SubChainHelper;
use events::{EventsDecoder, RuntimeEvent, SystemEvent};
use extrinsic::xt_primitives::{GenericAddress, GenericExtra};
pub use keyring::{Crypto, Ed25519, Sr25519};

mod keyring;
pub mod extrinsic;
pub mod error;
pub mod events;
pub mod chain_helper;
pub mod node_metadata;

/// The block number type used in this runtime.
pub type BlockNumber = u64;
/// The timestamp moment type used in this runtime.
pub type Moment = u64;
pub type Balance = u128;


#[derive(Clone, Debug, Decode)]
pub enum Token {
    EEE,
    TokenX,
}

impl ToString for Token {
    fn to_string(&self) -> String {
        match &self {
            Token::EEE => "EEE".to_owned(),
            Token::TokenX => "TokenX".to_owned(),
        }
    }
}

#[derive(Encode, Decode, Debug)]
pub struct RawTx {
    pub func_data: Vec<u8>,
    pub index: u32,
    pub genesis_hash: H256,
    pub spec_version: u32,
    pub tx_version: u32,
}

/// Used to transfer the decoded result of account information, use the default unit here?
#[derive(Clone, Debug, Default, Decode)]
pub struct EeeAccountInfo {
    pub nonce: u32,
    pub refcount: u32,
    pub free: u128,
    //To avoid java does not support u128 type format, all converted to String format
    pub reserved: u128,
    pub misc_frozen: u128,
    pub fee_frozen: u128,
}

#[derive(Clone, Debug, Default, Decode)]
pub struct EeeAccountInfoRefU8 {
    pub nonce: u32,
    pub refcount: u8,
    pub free: u128,
    //To avoid java does not support u128 type format, all converted to String format
    pub reserved: u128,
    pub misc_frozen: u128,
    pub fee_frozen: u128,
}

//Designed as an option, when the transaction is a transaction that sets the block time, there is no signature
#[derive(Default, Debug)]
pub struct TransferDetail {
    pub index: Option<u32>,
    //The transaction nonce corresponding to the signed account
    pub from: Option<String>,
    //Signature account from which account is transferred out of balance
    pub to: Option<String>,
    pub signer: Option<String>,
    //Destination account, balance account
    pub value: Option<u128>,
    pub hash: Option<String>,
    pub timestamp: Option<u64>,
    pub token_name: String,
    pub method_name: String,
    pub ext_data: Option<String>,
}



