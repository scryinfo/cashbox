use failure::_core::ops::{Deref, DerefMut};
use super::error::WalletError;
use mav::ma::{MEeeChainTx, MEeeTokenxTx};

#[derive(Debug, Default, Clone)]
pub struct InitParameters {
    pub db_name: DbName,
    pub is_memory_db:u32,
    pub context_note: String,
    pub net_type:String,
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
pub struct EeeTransferPayload {
    pub from_account: String,
    pub to_account: String,
    pub value: String,
    pub index: u32,
    pub chain_version: ChainVersion,
    pub ext_data: String,
    pub password: String,
}
#[derive(Debug, Default, Clone)]
pub struct ExtrinsicContext {
    pub chain_version: ChainVersion,
    pub account: String,
    pub block_hash: String,
    pub block_number: String,
    pub event: String,
    pub extrinsics: Vec<String>,
}

#[derive(Debug, Default, Clone)]
pub struct AccountInfo {
    pub nonce: u32,
    pub ref_count: u32,
    pub free_balance: String,
    pub reserved: String,
    pub misc_frozen: String,
    pub fee_frozen: String,
}


#[repr(C)]
#[derive(Debug, Default, Clone)]
pub struct WalletTokenStatus{
    pub wallet_id: String,
    pub chain_type: String,
    pub token_id: String,
    pub is_show: u32,
}

#[derive(Debug, Clone, Default)]
pub struct DecodeAccountInfoParameters {
    pub encode_data: String,
    pub chain_version: ChainVersion,
}

#[derive(Debug, Clone, Default, )]
pub struct StorageKeyParameters {
    pub chain_version: ChainVersion,
    pub module: String,
    pub storage_item: String,
    pub account: String,
}

#[derive(Debug, Clone, Default, )]
pub struct ChainVersion {
    pub genesis_hash: String,
    pub runtime_version: i32,
    pub tx_version: i32,
}

#[derive(Debug, Clone, Default, )]
pub struct EthTransferPayload {
    pub from_address: String,
    pub to_address: String,
    pub contract_address: String,
    pub value: String,//unit ETH
    pub nonce: String,
    pub gas_price: String,
    pub gas_limit: String,
    pub decimal: u32,
    pub ext_data: String,
    pub password: String,
}

impl EthTransferPayload {
    pub fn decode(&self) -> Result<eth::RawTransaction, WalletError> {
        if self.contract_address.is_empty() && self.to_address.is_empty() {
            return Err(WalletError::Custom("raw tx dest address in empty".into()));
        }
        let decimal = self.decimal as usize;
        let amount = eth::convert_token(&self.value, decimal).unwrap();
        //Additional parameters
        let data = self.ext_data.as_str().as_bytes().to_vec();
        let (to_address, data) = {
            if self.to_address.is_empty() {
                (None, data)
            } else if !self.contract_address.is_empty() {
                let contract_address = ethereum_types::H160::from_slice(scry_crypto::hexstr_to_vec(&self.contract_address)?.as_slice());
                let to = ethereum_types::H160::from_slice(scry_crypto::hexstr_to_vec(&self.to_address)?.as_slice());
                let mut encode_data = eth::get_erc20_transfer_data(to, amount)?;
                encode_data.extend_from_slice(&data);
                (Some(contract_address), encode_data)
            } else {
                let to = ethereum_types::H160::from_slice(scry_crypto::hexstr_to_vec(&self.to_address)?.as_slice());
                (Some(to), data)
            }
        };
        //gas price
        let gas_price = eth::convert_token(&self.gas_price, decimal).unwrap();
        //Allow maximum gas consumption
        let gas_limit = ethereum_types::U256::from_dec_str(&self.gas_limit).unwrap();
        //Nonce value of the current transaction
        let nonce = {
            let nonce = if self.nonce.starts_with("0x") {
                let nonce_u64 = u64::from_str_radix(&self.nonce[2..], 16);
                format!("{}", nonce_u64.unwrap())
            } else {
                self.nonce.clone()
            };
            ethereum_types::U256::from_dec_str(&nonce).unwrap()
        };

        Ok(eth::RawTransaction {
            nonce,
            to: to_address,
            value: amount,
            gas_price,
            gas: gas_limit,
            data,
        })
    }
}

#[derive(Debug, Clone, Default, )]
pub struct EthRawTxPayload {
    pub from_address: String,
    pub raw_tx: String,
}

#[derive(Debug, Clone, Default)]
pub struct  EeeChainTx{
    pub tx_hash:String,
    pub block_hash:String,
    pub block_number:String,
    pub signer:String,
    pub wallet_account:String,
    pub from_address:String,
    pub to_address:String,
    pub value:String,
    pub extension:String,
    pub status:u32,
    pub tx_timestamp:i64,
    pub tx_bytes:String,
}

impl From<MEeeChainTx> for EeeChainTx{
    fn from(chain_tx: MEeeChainTx) -> Self {
        Self{
            tx_hash: chain_tx.tx_shared.tx_hash.clone(),
            block_hash: chain_tx.tx_shared.block_hash.clone(),
            block_number: chain_tx.tx_shared.block_number.clone(),
            signer: chain_tx.tx_shared.signer.clone(),
            wallet_account: chain_tx.wallet_account.clone(),
            from_address: chain_tx.from_address.clone(),
            to_address: chain_tx.to_address.clone(),
            value: chain_tx.value.clone(),
            extension: chain_tx.extension.clone(),
            status: chain_tx.status as u32,
            tx_timestamp: chain_tx.tx_shared.tx_timestamp,
            tx_bytes: chain_tx.tx_shared.tx_bytes
        }
    }
}

impl From<MEeeTokenxTx> for EeeChainTx{
    fn from(chain_tx: MEeeTokenxTx) -> Self {
        Self{
            tx_hash: chain_tx.tx_shared.tx_hash.clone(),
            block_hash: chain_tx.tx_shared.block_hash.clone(),
            block_number: chain_tx.tx_shared.block_number.clone(),
            signer: chain_tx.tx_shared.signer.clone(),
            wallet_account: chain_tx.wallet_account.clone(),
            from_address: chain_tx.from_address.clone(),
            to_address: chain_tx.to_address.clone(),
            value: chain_tx.value.clone(),
            extension: chain_tx.extension.clone(),
            status: chain_tx.status,
            tx_timestamp: chain_tx.tx_shared.tx_timestamp,
            tx_bytes: chain_tx.tx_shared.tx_bytes
        }
    }
}
