use failure::_core::ops::{Deref, DerefMut};
use super::error::WalletError;
use mav::ma::{MEeeChainTx, MEeeTokenxTx};
use ethereum_types::U256;
use eth::RawTransaction;
use std::convert::TryInto;

#[derive(Debug, Default, Clone)]
pub struct InitParameters {
    pub db_name: DbName,
    pub is_memory_db:u32,
    pub context_note: String,
    //pub net_type:String,
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
  pub fn trim(& self)->Self{
        EthTransferPayload{
            from_address: self.from_address.trim().to_string(),
            to_address: self.to_address.trim().to_string(),
            contract_address: self.contract_address.trim().to_string(),
            value: self.value.trim().to_string(),
            nonce: self.nonce.trim().to_string(),
            gas_price: self.gas_price.trim().to_string(),
            gas_limit: self.gas_limit.trim().to_string(),
            decimal: self.decimal,
            ext_data: self.ext_data.trim().to_string(),
            password: self.password.clone()
        }
    }
    pub fn decode(&self) -> Result<eth::RawTransaction, WalletError> {
        if self.contract_address.is_empty() && self.to_address.is_empty() {
            return Err(WalletError::Custom("raw tx dest address in empty".into()));
        }
        let decimal = self.decimal as usize;

        let amount = eth::convert_token(&self.value, decimal);
        if amount.is_none(){
            let error_msg = format!("input value illegal:{}",&self.value);
            return Err(WalletError::Custom(error_msg));
        }
       let value = {
           if self.contract_address.trim().is_empty(){
               amount.unwrap()
           }else{
               U256::from(0)
           }
       };
        //Additional parameters
        let data = self.ext_data.as_str().as_bytes().to_vec();
        log::debug!("to address:{:?},contract_address:{:?}",self.to_address,self.contract_address);
        let (to_address, data) = {
            if self.to_address.trim().is_empty() {
                (None, data)
            } else if !self.contract_address.trim().is_empty() {
                let contract_address = ethereum_types::H160::from_slice(scry_crypto::hexstr_to_vec(&self.contract_address)?.as_slice());
                let to = ethereum_types::H160::from_slice(scry_crypto::hexstr_to_vec(&self.to_address)?.as_slice());
                let mut encode_data = eth::get_erc20_transfer_data(to, amount.unwrap())?;
                encode_data.extend_from_slice(&data);
                (Some(contract_address), encode_data)
            } else {
                let to = ethereum_types::H160::from_slice(scry_crypto::hexstr_to_vec(&self.to_address)?.as_slice());
                log::debug!("to address:{:?}",to);
                (Some(to), data)
            }
        };
        //gas price default input unit is gwei
        let gas_price = if let Some(gas_price) = eth::convert_token(&self.gas_price, 9){
            gas_price
        }else {
            let error_msg = format!("input gas_price illegal:{}",&self.gas_price);
            return Err(WalletError::Custom(error_msg));
        };

        //Allow maximum gas consumption
        if self.gas_limit.contains('.') {
            let error_msg = format!("input gas_limit illegal:{}",&self.gas_limit);
            return Err(WalletError::Custom(error_msg));
        }

      let gas_limit=  U256::from_dec_str(&self.gas_limit).map_err(|err|WalletError::Custom(err.to_string()))?;
        //Nonce value of the current transaction
        let nonce = {
            let nonce = if self.nonce.starts_with("0x") {
                format!("{}", u64::from_str_radix(&self.nonce[2..], 16)?)
            } else {
                self.nonce.clone()
            };
            ethereum_types::U256::from_dec_str(&nonce).map_err(|err|WalletError::Custom(err.to_string()))?
        };

        Ok(eth::RawTransaction {
            nonce,
            to: to_address,
            value,
            gas_price,
            gas: gas_limit,
            data,
        })
    }
}
#[derive(Debug,Clone,Default)]
pub struct EthWalletConnectTx{
    pub from: String,
    pub to:String,
    pub data:  String,
    pub gas_price: String,
    pub gas:String,
    pub value: String,
    pub nonce: String,
}

impl TryInto<RawTransaction> for EthWalletConnectTx{
    type Error = WalletError;

    fn try_into(self) -> Result<RawTransaction,Self::Error> {
        let to = self.to.trim();
        let to =if to.is_empty(){
            None
        }else{
            let to = ethereum_types::H160::from_slice(scry_crypto::hexstr_to_vec(to)?.as_slice());
            log::debug!("to address:{:?}",to);
            Some(to)
        };
        //wallet connect data format always is hex
        let nonce = ethereum_types::U256::from(scry_crypto::hexstr_to_vec(&self.nonce)?.as_slice());

        //user input gas price is decimal
        let gas_price =  ethereum_types::U256::from_dec_str(&self.gas_price).map_err(|err|WalletError::Custom(err.to_string()))?;

        //Allow maximum gas consumption
        if self.gas.contains('.') {
            let error_msg = format!("input gas_limit illegal:{}",&self.gas);
            return Err(WalletError::Custom(error_msg));
        }
        let gas=  U256::from_dec_str(&self.gas).map_err(|err|WalletError::Custom(err.to_string()))?;

        //Additional parameters
        let data = scry_crypto::hexstr_to_vec(&self.data)?;
        let value = U256::from(scry_crypto::hexstr_to_vec(&self.value)?.as_slice());

        Ok(eth::RawTransaction {
            nonce,
            to,
            value,
            gas_price,
            gas,
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

#[derive(Debug, Default, Clone)]
pub struct BtcTxParam {
    pub wallet_id: String,
    pub password: String,
    pub from_address: String,
    pub to_address: String,
    pub value: String,//unit Btc
    pub broadcast: u32,//broadcast or not (in CBtcTxParam it's CBool)
}