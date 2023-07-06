use std::collections::HashMap;
use std::convert::TryFrom;

use codec::{Compact, Decode, Encode};
use sp_core::crypto::Ss58Codec;
use sp_core::Pair;
use sp_runtime::generic::Era;
use sp_runtime::MultiSignature;
// use sp_runtime::MultiSignature;
use system::Phase;

use frame_metadata::RuntimeMetadataPrefixed;

use crate::{AccountId, compose_call, compose_extrinsic_offline, Crypto, EeeAccountInfo, EeeAccountInfoRefU8, error, extrinsic, Hash, keyring, Token, TransferDetail};
// use node_metadata::Metadata;
use crate::events::{EventsDecoder, RuntimeEvent, SystemEvent};
use crate::extrinsic::GenericExtra;
use crate::extrinsic::xt_primitives::GenericAddress;
use crate::node_metadata::Metadata;

// use super::*;

pub struct ChainHelper {
    metadata: Metadata,
    event_decode: EventsDecoder,
    runtime_version: u32,
    tx_version: u32,
    decimal: u32,
    genesis_hash: Hash,
}

impl ChainHelper {
    pub fn init(metadata_hex_str: &str, genesis_hash: &[u8], runtime_version: u32, tx_version: u32, decimal: Option<u32>) -> Result<Self, error::Error> {
        let metadata = Self::get_chain_runtime_metadata(metadata_hex_str)?;
        if genesis_hash.len() != 32 {
            return Err(error::Error::Custom("input genesis hash invalid".to_string()));
        }
        let genesis_hash = Hash::from_slice(genesis_hash);
        let decimal = if let Some(val) = decimal { val } else { 12 };
        let event_decode = EventsDecoder::try_from(metadata.clone())?;
        Ok(ChainHelper {
            metadata,
            event_decode,
            runtime_version,
            tx_version,
            decimal,
            genesis_hash,
        })
    }
    // transfer amount is the basic unit （smallest unit)
    pub fn token_transfer_sign(&self, token_name: Token, mnemonic: &str, to: &str, amount: &str, index: u32, ext_data: Option<Vec<u8>>) -> Result<String, error::Error> {
        if let Some(token_func) = self.convert_token_name(token_name) {
            self.transfer(token_func.0, token_func.1, mnemonic, to, amount, index, ext_data)
        } else {
            Err(error::Error::Custom("token not support".to_string()))
        }
    }

    //todo add sign preview func
    pub fn tx_sign(&self, mnemonic: &str, index: u32, func_data: &[u8], is_submittable: bool) -> Result<String, error::Error> {
        // let signer = keyring::Sr25519::pair_from_phrase(mnemonic, None)?;
        let signer = keyring::Sr25519::pair_from_phrase(mnemonic, None)?;
        let prefix_len = extrinsic::get_func_prefix_len(func_data);
        let func_data = &func_data[prefix_len..];
        let playload = {
            let mut temp = vec![];
            temp.extend_from_slice(func_data);
            temp.extend_from_slice(&GenericExtra::new(Era::Immortal, index).encode()[..]);
            temp.extend_from_slice(self.runtime_version.encode().as_slice());
            temp.extend_from_slice(self.tx_version.encode().as_slice());
            temp.extend_from_slice(self.genesis_hash.as_bytes());
            temp.extend_from_slice(self.genesis_hash.as_bytes());
            temp
        };
        let sign_data = {
            if playload.len() > 256 {
                let hash = sp_core::blake2_256(&playload);
                hash[..].to_vec()
            } else {
                playload
            }
        };
        let signature = signer.sign(&sign_data);
        if !is_submittable {
            Ok(format!("0x01{}", hex::encode(&signature.0[..])))
        } else {
            let xt = extrinsic::UncheckedExtrinsicFromOuter::new_signed(
                func_data.to_vec(),
                GenericAddress::from(signer.public().0),
                MultiSignature::Sr25519(signature),
                GenericExtra::new(Era::Immortal, index),
            );
            Ok(xt.hex_encode())
        }
    }

    pub fn get_storage_map_key<K: Encode, V: Decode + Clone>(&self, storage_prefix: &str, storage_key_name: &str, map_key: K) -> Result<String, error::Error> {
        self.metadata.storage_map_key::<K, V>(storage_prefix, storage_key_name, map_key).map(|key| hex::encode(&key.0)).map_err(|err| err.into())
    }

    pub fn get_storage_value_key(&self, storage_prefix: &str, storage_key_name: &str) -> Result<String, error::Error> {
        self.metadata.storage_value_key(storage_prefix, storage_key_name).map(|key| hex::encode(&key.0)).map_err(|err| err.into())
    }

    pub fn decode_events(&self, event_str: &str, decoder: Option<EventsDecoder>) -> Result<HashMap<usize, bool>, error::Error> {
        let unhex = scry_crypto::hexstr_to_vec(event_str)?;
        let mut tx_result = HashMap::new();
        let event_decoder =
            decoder.unwrap_or_else(|| self.event_decode.clone());
        let events = event_decoder.decode_events(&mut &unhex[..])?;
        for (phase, event) in events {
            let index: usize = if let Phase::ApplyExtrinsic(index) = phase { index as usize } else { 0 };
            match event {
                RuntimeEvent::System(sys) => {
                    match sys {
                        SystemEvent::ExtrinsicSuccess(_dispatch_info) => {
                            tx_result.insert(index, true);
                        }
                        // An extrinsic failed.
                        SystemEvent::ExtrinsicFailed(_dispatch_error, _dispatch_info) => {
                            tx_result.insert(index, false);
                        }
                        _ => {
                            log::info!("this event info is ignore")
                        }
                    }
                }
                RuntimeEvent::Raw(raw)
                if raw.module == "Balances" => {
                    log::info!("runtime event detail:{:?}", raw);
                }
                _ => log::debug!("ignoring unsupported module event: {:?}", event),
            }
        }
        Ok(tx_result)
    }

    pub fn decode_extrinsics(&self, extrinsics: &[String], target_account: &str) -> Result<HashMap<usize, TransferDetail>, error::Error> {
        let target_account = AccountId::from_ss58check(target_account)?;
        let mut map = HashMap::new();
        for (index, tx_str) in extrinsics.iter().enumerate() {
            let tx = scry_crypto::hexstr_to_vec(tx_str)?;
            let checked_tx = extrinsic::CheckedExtrinsic::decode(&mut &tx[..])?;
            let tx_hash = sp_core::blake2_256(&tx[..]);
            let mut tx_transfer_detail = TransferDetail {
                hash: Some(hex::encode(&tx_hash[..])),
                ..Default::default()
            };
            let target_module = self.metadata.modules_with_calls().
                find(|&module| module.index == checked_tx.function.module_index);
            if let Some(target_module) = target_module {
                let call = target_module.calls.clone().into_iter().find(|call| call.1 == checked_tx.function.call_index);
                if let Some(target_call) = call {
                    match (target_module.name.as_str(), target_call.0.as_str()) {
                        ("Timestamp", "set") => {
                            let timestamp = Compact::<u64>::decode(&mut &checked_tx.function.args[..]).map(|value| value.0).ok();
                            tx_transfer_detail.timestamp = timestamp;
                        }
                        ("Balances", "transfer") | ("Balances", "transfer_keep_alive") => {
                            self.decode_balance_transfer_tx(&target_account, &checked_tx, &mut tx_transfer_detail)?;
                        }
                        ("TokenX", "transfer") => {
                            self.decode_tokenx_transfer_tx(&target_account, &checked_tx, &mut tx_transfer_detail)?;
                        }
                        ("TokenX", "transfer_from") => {
                            self.decode_tokenx_transfer_from_tx(&target_account, &checked_tx, &mut tx_transfer_detail)?;
                        }
                        _ => log::info!("module {} current not decode", target_module.name)
                    }
                }
            }
            if tx_transfer_detail.timestamp.is_some() || tx_transfer_detail.signer.is_some() {
                map.insert(index, tx_transfer_detail);
            }
        }
        Ok(map)
    }
    pub fn decode_account_info<T>(info: &str) -> Result<EeeAccountInfo, error::Error> {
        let state_vec = scry_crypto::hexstr_to_vec(info)?;
        let type_name = std::any::type_name::<T>();
        match type_name {
            "eee::EeeAccountInfoRefU8" => {
                EeeAccountInfoRefU8::decode(&mut state_vec.as_slice()).map(|account| {
                    EeeAccountInfo {
                        nonce: account.nonce,
                        refcount: account.refcount as u32,
                        free: account.free,
                        reserved: account.reserved,
                        misc_frozen: account.misc_frozen,
                        fee_frozen: account.fee_frozen,
                    }
                }).map_err(|err| err.into())
            }
            "eee::EeeAccountInfo" => {
                EeeAccountInfo::decode(&mut state_vec.as_slice()).map_err(|err| err.into())
            }
            _ => {
                Err(error::Error::Custom(format!("decode type {} not support!", type_name)))
            }
        }
    }
    // when decode RawTx instance,the function data length info will be drop,this func is aim to restore the original structure
    pub fn restore_func_data(func_data: &[u8]) -> Vec<u8> {
        let func_size = func_data.len();
        let reserve = match func_size {
            0..=0b0011_1111 => 1,
            0b0100_0000..=0b0011_1111_1111_1111 => 2,
            _ => 4,
        };
        let mut func_vec = vec![0u8; func_size + reserve];
        {
            let temp = &mut func_vec[reserve..];
            temp.copy_from_slice(func_data);
        }
        func_vec
    }
}

impl ChainHelper {
    // decode etransfer extrinsic,check if the extrinsic is related to the target account
    fn decode_balance_transfer_tx(&self, target_account: &AccountId, checked_extrinsic: &extrinsic::CheckedExtrinsic, detail: &mut TransferDetail) -> Result<(), error::Error> {
        let func_args: (AccountId, Compact<u128>) = Decode::decode(&mut &checked_extrinsic.function.args[..])?;
        if let Some((account, _signature, extra)) = &checked_extrinsic.signature {
            if target_account.eq(&func_args.0) || target_account.eq(account) {
                detail.value = Some(func_args.1.0);
                detail.to = Some(func_args.0.to_ss58check());
                detail.signer = Some(account.to_ss58check());
                detail.index = Some(extra.get_nonce());//todo
                detail.token_name = "EEE".to_string();
                detail.method_name = "transfer".to_string();
            }
        }
        Ok(())
    }
    fn decode_tokenx_transfer_tx(&self, target_account: &AccountId, checked_extrinsic: &extrinsic::CheckedExtrinsic, detail: &mut TransferDetail) -> Result<(), error::Error> {
        let func_args: (AccountId, Compact<u128>, Vec<u8>) = Decode::decode(&mut &checked_extrinsic.function.args[..])?;
        if let Some((account, _signature, extra)) = &checked_extrinsic.signature {
            if target_account.eq(&func_args.0) || target_account.eq(account) {
                detail.value = Some(func_args.1.0);
                detail.to = Some(func_args.0.to_ss58check());
                detail.signer = Some(account.to_ss58check());
                detail.index = Some(extra.get_nonce());
                detail.token_name = "TokenX".to_string();
                detail.method_name = "transfer".to_string();

                let ext_str = {
                    let ext_data_len = func_args.2.len();
                    let temp_array = vec![0u8; ext_data_len];
                    if !temp_array.as_slice().eq(&func_args.2[..]) {
                        Some(format!("0x{}", hex::encode(func_args.2.as_slice())))
                    } else {
                        None
                    }
                };
                detail.ext_data = ext_str;
            }
        }
        Ok(())
    }

    fn decode_tokenx_transfer_from_tx(&self, target_account: &AccountId, checked_extrinsic: &extrinsic::CheckedExtrinsic, detail: &mut TransferDetail) -> Result<(), error::Error> {
        let func_args: (AccountId, AccountId, Compact<u128>, Vec<u8>) = Decode::decode(&mut &checked_extrinsic.function.args[..])?;
        if let Some((account, _signature, extra)) = &checked_extrinsic.signature {
            if target_account.eq(&func_args.0) || target_account.eq(account) {
                detail.value = Some(func_args.2.0);
                detail.to = Some(func_args.1.to_ss58check());
                detail.from = Some(func_args.0.to_ss58check());
                detail.signer = Some(account.to_ss58check());
                detail.index = Some(extra.get_nonce());
                detail.token_name = "TokenX".to_string();
                detail.method_name = "transfer_from".to_string();
                let ext_str = {
                    let ext_data_len = func_args.3.len();
                    let temp_array = vec![0u8; ext_data_len];
                    if !temp_array.as_slice().eq(&func_args.3[..]) {
                        Some(format!("0x{}", hex::encode(func_args.3.as_slice())))
                    } else {
                        None
                    }
                };
                detail.ext_data = ext_str;
                log::info!("TokenX transfer_from extrinsic");
            }
        }
        Ok(())
    }


    fn transfer(&self, module_name: &str, call_name: &str, mnemonic: &str, to: &str, amount: &str, index: u32, ext_data: Option<Vec<u8>>) -> Result<String, error::Error> {
        let to = AccountId::from_ss58check(to)?;

        if self.is_module_call_exist(module_name, call_name).is_none() {
            return Err(error::Error::Custom("module call is not exist".to_string()));
        }
        let signer = keyring::Sr25519::pair_from_phrase(mnemonic, None)?;
        if let Ok(amount) = str::parse::<u128>(amount) {
            let encode_str = if let Some(ext_data) = ext_data {
                let call = compose_call!(self.metadata,  module_name, call_name, to, Compact(amount ),ext_data);
                let xt: extrinsic::UncheckedExtrinsicV4<_> = compose_extrinsic_offline!(signer,call,index,Era::Immortal,self.genesis_hash,self.genesis_hash,self.runtime_version,self.tx_version);
                xt.hex_encode()
            } else {
                //todo when balances pallet transfer function have ext data,the following code can be removed
                let call = compose_call!(self.metadata,  module_name, call_name, to, Compact(amount ));
                let xt: extrinsic::UncheckedExtrinsicV4<_> = compose_extrinsic_offline!(signer,call,index,Era::Immortal,self.genesis_hash,self.genesis_hash,self.runtime_version,self.tx_version);
                xt.hex_encode()
            };
            Ok(encode_str)
        } else {
            Err(error::Error::Custom("amount format is not invalid".to_string()))
        }
    }
    fn is_module_call_exist(&self, module_name: &str, call_name: &str) -> Option<bool> {
        if let Ok(calls) = self.metadata.module_with_calls(module_name) {
            if !calls.calls.contains_key(call_name) {
                return None;
            }
            Some(true)
        } else {
            None
        }
    }
    fn convert_token_name(&self, token_name: Token) -> Option<(&str, &str)> {
        match token_name {
            Token::EEE => {
                let moudule_name = "Balances";
                let call_name = "transfer";
                if self.is_module_call_exist(moudule_name, call_name).is_some() {
                    Some((moudule_name, call_name))
                } else {
                    None
                }
            }
            Token::TokenX => {
                let moudule_name = "TokenX";
                let call_name = "transfer";
                if self.is_module_call_exist(moudule_name, call_name).is_some() {
                    Some(("TokenX", "transfer"))
                } else {
                    None
                }
            }
        }
    }

    fn get_chain_runtime_metadata(hex_str: &str) -> Result<Metadata, error::Error> {
        let runtime_vec = scry_crypto::hexstr_to_vec(hex_str)?;
        let prefixed = RuntimeMetadataPrefixed::decode(&mut &runtime_vec[..])?;
        Metadata::try_from(prefixed).map_err(|err| err.into())
    }
}


