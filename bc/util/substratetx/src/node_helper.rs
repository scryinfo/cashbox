use super::*;
use std::convert::TryFrom;
use frame_metadata::RuntimeMetadataPrefixed;
use node_metadata::Metadata;

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
    pub fn token_transfer_sign(&self, token_name: &str, mnemonic: &str, to: &str, amount: &str, index: u32,ext_data:Option<Vec<u8>>) -> Result<String, error::Error> {
        if let Some(token_func) = self.convert_token_name(token_name) {
            self.transfer(token_func.0, token_func.1, mnemonic, to, amount, index,ext_data)
        } else {
            Err(error::Error::Custom("token not support".to_string()))
        }
    }

    //todo add sign preview func
    pub fn tx_sign(&self, mnemonic: &str, index: u32, func_data: &[u8]) -> Result<String, error::Error> {
        let signer = crypto::Sr25519::pair_from_phrase(mnemonic, None)?;
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
        let xt = extrinsic::UncheckedExtrinsicFromOuter::new_signed(
            func_data.to_vec(),
            GenericAddress::from(signer.public().0),
            MultiSignature::from(signature),
            GenericExtra::new(Era::Immortal, index),
        );
        Ok(xt.hex_encode())
    }

    pub fn get_storage_map_key<K: Encode, V: Decode + Clone>(&self, storage_prefix: &str, storage_key_name: &str, map_key: K) -> Result<String, error::Error> {
        self.metadata.storage_map_key::<K, V>(storage_prefix, storage_key_name, map_key).map(|key| hex::encode(&key.0)).map_err(|err| err.into())
    }

    pub fn decode_events(&self, event_str: &str, decoder: Option<EventsDecoder>) -> Result<HashMap<usize, bool>, error::Error> {
        let unhex = hexstr_to_vec(event_str)?;
        let mut tx_result = HashMap::new();
        let event_decoder =
            decoder.unwrap_or_else(|| self.event_decode.clone());
        let events = event_decoder.decode_events(&mut &unhex[..])?;
        for (phase, event) in events {
            let index:usize = if let Phase::ApplyExtrinsic(index) = phase { index as usize } else { 0 };
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
                    }
                }
                RuntimeEvent::Raw(raw)
                if raw.module == "Balances" => {
                    println!("runtime event detail:{:?}", raw);
                }
                _ => log::debug!("ignoring unsupported module event: {:?}", event),
            }
        }
        Ok(tx_result)
    }

    // decode etransfer extrinsic,check if the extrinsic is related to the target account
    fn decode_balance_transfer_tx(&self, target_account: &AccountId, checked_extrinsic: &extrinsic::CheckedExtrinsic, detail: &mut TransferDetail) -> Result<(), error::Error> {
        let func_args: (AccountId, Compact<u128>) = Decode::decode(&mut &checked_extrinsic.function.args[..])?;
        println!("decode args detail is:{:?}", func_args);
        if let Some((account, _signature, extra)) = &checked_extrinsic.signature {
            if target_account.eq(&func_args.0) || target_account.eq(&account) {
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
            if target_account.eq(&func_args.0) || target_account.eq(&account) {
                detail.value = Some(func_args.1.0);
                detail.to = Some(func_args.0.to_ss58check());
                detail.signer = Some(account.to_ss58check());
                detail.index = Some(extra.get_nonce());
                detail.token_name = "TokenX".to_string();
                detail.method_name = "transfer".to_string();

                let ext_str = {
                    let ext_data_len = func_args.2.len();
                    let temp_array = vec![0u8; ext_data_len];
                    println!("func args:{:?},temp_array:{:?}",func_args,temp_array);
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
            if target_account.eq(&func_args.0) || target_account.eq(&account) {
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
                println!("TokenX transfer_from extrinsic");
            }
        }
        Ok(())
    }

    pub fn decode_extrinsics(&self, extrinsics_json: &str, target_account: &str) -> Result<HashMap<usize, TransferDetail>, error::Error> {
        let target_account = AccountId::from_ss58check(target_account)?;
        let json_data: Vec<String> = serde_json::from_str(extrinsics_json)?;
        let mut map = HashMap::new();

        for index in 0..json_data.len() {
            let tx = hexstr_to_vec(&json_data[index])?;
            let checked_tx = extrinsic::CheckedExtrinsic::decode(&mut &tx[..])?;

            let tx_hash = sp_core::blake2_256(&tx[..]);
            let mut tx_transfer_detail = TransferDetail::default();
            tx_transfer_detail.hash = Some(hex::encode(&tx_hash[..]));
            let target_module = self.metadata.modules_with_calls().
                find(|&module| module.index == checked_tx.function.module_index);
            if let Some(target_module) = target_module {
                let call = target_module.calls.clone().into_iter().find(|call| call.1 == checked_tx.function.call_index);
                if let Some(target_call) = call {
                    match (target_module.name.as_str(), target_call.0.as_str()) {
                        ("Timestamp", "set") => {
                            println!("Timestamp set extrinsic");
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
            if tx_transfer_detail.timestamp.is_some()||tx_transfer_detail.signer.is_some(){
                map.insert(index, tx_transfer_detail);
            }
        }
        Ok(map)
    }
    fn transfer(&self, module_name: &str, call_name: &str, mnemonic: &str, to: &str, amount: &str, index: u32,ext_data:Option<Vec<u8>>) -> Result<String, error::Error> {
        let to = AccountId::from_ss58check(to)?;

        if self.is_module_call_exist(module_name, call_name).is_none() {
            return Err(error::Error::Custom("module call is not exist".to_string()));
        }
        let signer = crypto::Sr25519::pair_from_phrase(mnemonic, None)?;
        if let Ok(amount) = str::parse::<u128>(amount) {
            let encode_str = if let Some(ext_data) = ext_data{
                let call = compose_call!(self.metadata,  module_name, call_name, to, Compact(amount ),ext_data);
                let xt: extrinsic::UncheckedExtrinsicV4<_> = compose_extrinsic_offline!(signer,call,index,Era::Immortal,self.genesis_hash,self.genesis_hash,self.runtime_version,self.tx_version);
                xt.hex_encode()
            }else{
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
    fn convert_token_name(&self, token_name: &str) -> Option<(&str, &str)> {
        let funcs = match token_name.to_lowercase().as_str() {
            "eee" => {
                let moudule_name = "Balances";
                let call_name = "transfer";
                if self.is_module_call_exist(moudule_name, call_name).is_some() {
                    Some((moudule_name, call_name))
                } else {
                    None
                }
            }
            "tokenx" => {
                let moudule_name = "TokenX";
                let call_name = "transfer";
                if self.is_module_call_exist(moudule_name, call_name).is_some() {
                    Some(("TokenX", "transfer"))
                } else {
                    None
                }
            }
            _ => None
        };
        funcs
    }

     fn get_chain_runtime_metadata(hex_str: &str) -> Result<Metadata, error::Error> {
        let runtime_vec = hexstr_to_vec(hex_str)?;
        let prefixed = RuntimeMetadataPrefixed::decode(&mut &runtime_vec[..])?;
        Metadata::try_from(prefixed).map_err(|err| err.into())
    }
}


