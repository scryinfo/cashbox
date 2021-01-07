use failure::_core::ops::{Deref, DerefMut};

#[derive(Debug, Default, Clone)]
pub struct InitParameters {
    pub db_name: DbName,
    pub context_note: String,
}

// #[derive(Debug, Default)]
// pub struct UnInitParameters {}

#[derive(Debug, Default, Clone)]
pub struct DbName(pub mav::ma::DbName);

impl Deref for DbName {
    type Target = mav::ma::DbName;

    fn deref(&self) -> &Self::Target {
        &self.0
    }
}

impl DerefMut for DbName {
    fn deref_mut(&mut self) -> &mut Self::Target {
        &mut self.0
    }
}

#[derive(Debug, Default)]
pub struct CreateWalletParameters {
    pub name: String,
    pub password: String,
    pub mnemonic: String,
    pub wallet_type: String,
}

#[derive(Debug, Clone)]
pub struct Context {
    pub id: String,
    pub context_note: String,
}

impl Context {
    pub fn new(context_note: &str) -> Self {
        Self {
            id: uuid::Uuid::new_v4().to_string(),
            context_note: context_note.to_owned(),
        }
    }
}

impl Default for Context {
    fn default() -> Self {
        Self {
            id: uuid::Uuid::new_v4().to_string(),
            context_note: "".to_owned(),
        }
    }
}

#[derive(Debug, Default, Clone)]
pub struct RawTxParam {
    pub raw_tx: String,
    pub wallet_id: String,
    pub password: String,
}

#[derive(Debug, Default, Clone)]
pub struct TransferPayload {
    pub from_account: String,
    pub to_account: String,
    pub value: String,
    pub index: u32,
    pub chain_version:ChainVersion,
    pub ext_data: String,
    pub password: String,
}

#[derive(Debug, Default,Clone)]
pub struct AccountInfo {
    pub nonce: u32,
    pub ref_count: u32,
    pub free_: String,//todo rename
    pub reserved: String,
    pub misc_frozen: String,
    pub fee_frozen: String,
}


#[derive(Debug, Clone,Default)]
pub struct DecodeAccountInfoParameters {
    pub encode_data:String,
    pub chain_version:ChainVersion,
}

#[derive(Debug, Clone, Default,)]
pub struct StorageKeyParameters {
    pub chain_version:ChainVersion,
    pub module: String,
    pub storage_item:String,
    pub account:String,
}

#[derive(Debug, Clone, Default,)]
pub struct ChainVersion{
    pub genesis_hash: String,
    pub runtime_version: i32,
    pub tx_version: i32,
}


