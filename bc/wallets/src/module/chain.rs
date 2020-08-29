use super::*;
use super::model::*;

use substratetx::Crypto;
use std::collections::HashMap;
use codec::{Encode, Decode};
use ethereum_types::{H160, U256, H256};

#[derive(Encode, Decode, Debug)]
struct RawTx {
    func_data: Vec<u8>,
    index: u32,
    genesis_hash: H256,
    spec_version: u32,
    tx_version:u32,
}

//Subsequent modification of the name to ScryX?, the current open source version does not yet support the function call of the module
pub struct EEE;

impl Chain for EEE {}

impl EEE {
    pub fn generate_transfer(&self, from: &str, to: &str, amount: &str, genesis_hash: &str, index: u32, runtime_version: u32, tx_version:u32,psw: &[u8]) -> WalletResult<String> {
        let keystore = find_keystore_wallet_from_address(from, ChainType::EEE)?;
        let mnemonic = substratetx::Sr25519::get_mnemonic_context(&keystore, psw)?;
        //Passed password verification
        let mn = String::from_utf8(mnemonic)?;
        let genesis_hash_bytes = hex::decode(genesis_hash.get(2..).unwrap())?;
        let mut genesis_h256 = [0u8; 32];
        genesis_h256.clone_from_slice(genesis_hash_bytes.as_slice());
        //let signed_data = substratetx::transfer(&mn, to, amount, H256(genesis_h256), index, runtime_version)?;
        let signed_data = substratetx::transfer(&mn, to, amount, &genesis_h256[..], index, runtime_version,tx_version)?;
        log::debug!("signed data is: {}", signed_data);
        Ok(signed_data)
    }

    pub fn save_tx_record(&self, account: &str, blockhash: &str, event_data: &str, extrinsics: &str) -> WalletResult<()> {
        let event_res = substratetx::event_decode(event_data, blockhash, account);
        let extrinsics_map = substratetx::decode_extrinsics(extrinsics, account)?;
        //Block transaction events There must be a time stamp setting
        let tx_time = extrinsics_map.get(&0).unwrap();//Get timestamp
        let instance = wallet_db::DataServiceProvider::instance()?;
        for index in 1..extrinsics_map.len() {
            let index = index as u32;
            let transfer_detail = extrinsics_map.get(&index).unwrap();
            let is_successful = event_res.get(&index).unwrap();
            instance.save_transfer_detail(account, blockhash, transfer_detail, tx_time.timestamp.unwrap(), *is_successful)?;
        }
        Ok(())
    }

    pub fn update_sync_record(&self, account: &str, chain_type: i32, block_num: u32, block_hash: &str) -> WalletResult<()> {
        let instance = wallet_db::DataServiceProvider::instance()?;
        instance.update_account_sync(account, chain_type, block_num, block_hash)
    }

    pub fn get_sync_status(&self) -> WalletResult<Vec<SyncStatus>> {
        let instance = wallet_db::DataServiceProvider::instance()?;
        //Whether to distinguish the chain type
        instance.get_sync_status()
    }

    pub fn get_chain_data(&self) -> WalletResult<HashMap<String, Vec<EeeChain>>> {
        let instance = wallet_db::DataServiceProvider::instance()?;
        //The test chain and official chain of the data obtained here
        let eee_chain = instance.display_chain_detail(ChainType::EEE);
        let mut eee_map = HashMap::new();
        match eee_chain {
            Ok(tbwallets) => {
                for tbwallet in tbwallets {
                    let wallet_id = tbwallet.wallet_id.unwrap();
                    let chain_id = format!("{}", tbwallet.chain_id.unwrap());//The chain id will not be null

                    if !eee_map.contains_key(&wallet_id) {
                        let chain = EeeChain {
                            status: StatusCode::OK,
                            chain_id: chain_id.clone(),
                            wallet_id: wallet_id.clone(),
                            address: tbwallet.address.unwrap(),
                            domain: tbwallet.domain,
                            is_visible: {
                                tbwallet.chain_is_visible
                            },
                            chain_type: {
                                if tbwallet.chain_type.is_none() {
                                    None
                                } else {
                                    Some(ChainType::from(tbwallet.chain_type.unwrap()))
                                }
                            },
                            digit_list: Vec::new(),
                        };
                        //Now there is only one type of chain under a wallet
                        // chain_index = 0;
                        eee_map.insert(wallet_id.clone(), vec![chain]);
                    }
                    let digit_id = tbwallet.digit_id.unwrap().to_string();
                    let digit = EeeDigit {
                        status: StatusCode::OK,
                        digit_id,
                        chain_id,
                        contract_address: tbwallet.contract_address.clone(),
                        fullname: tbwallet.full_name.clone(),
                        shortname: tbwallet.short_name.clone(),
                        balance: tbwallet.balance.clone(),
                        is_visible: tbwallet.digit_is_visible,
                        decimal: tbwallet.decimals,
                        imgurl: tbwallet.url_img,
                    };
                    let vec_eee_chain = eee_map.get_mut(wallet_id.as_str()).unwrap();

                    let chain_list = vec_eee_chain.get_mut(0).unwrap();
                    chain_list.digit_list.push(digit);
                }
                Ok(eee_map)
            }
            Err(e) => Err(e)
        }
    }
    // This function is used for externally stitched transactions, such as transactions constructed by js
    pub fn raw_tx_sign(&self, raw_tx: &str, wallet_id: &str, psw: &[u8]) -> WalletResult<String> {
        let raw_tx = raw_tx.get(2..).unwrap();// remove `0x`
        let tx_encode_data = hex::decode(raw_tx)?;
        let tx = RawTx::decode(&mut &tx_encode_data[..]).expect("tx format");
        let wallet = module::wallet::WalletManager {};
        let mnemonic = wallet.export_mnemonic(wallet_id, psw)?;
        let mn = String::from_utf8(mnemonic.mn)?;
        let mut_data = &mut &tx_encode_data[0..tx_encode_data.len() - 40];//Direct use of tx.func_data in this place will cause an error, and the first byte of data will be missed.
        // let sign_data = substratetx::tx_sign(&mn, tx.genesis_hash, tx.index, mut_data, tx.version)?;
        let sign_data = substratetx::tx_sign(&mn, &tx.genesis_hash[..], tx.index, mut_data, tx.spec_version,tx.tx_version)?;
        Ok(sign_data)
    }

    //Used for signing ordinary data, incoming data, hex format data
    pub fn raw_sign(&self, raw_data: &str, wallet_id: &str, psw: &[u8]) -> WalletResult<String> {
        let raw_data = raw_data.get(2..).unwrap();// remove `0x`
        let tx_encode_data = hex::decode(raw_data)?;
        let wallet = module::wallet::WalletManager {};
        let mnemonic = wallet.export_mnemonic(wallet_id, psw)?;
        let mn = String::from_utf8(mnemonic.mn)?;
        let sign_data = substratetx::Sr25519::sign(&mn, &tx_encode_data[..]).unwrap();
        let hex_data = format!("0x{}", hex::encode(&sign_data[..]));
        Ok(hex_data)
    }
}

pub struct Ethereum;

impl Chain for Ethereum {}

impl Ethereum {
    ///ETH transaction signature
    /// from_account: transfer out of account
    /// to_account: transfer to account
    /// amount: the amount of ETH transferred out
    /// psw transfer out account wallet keystore decrypt password
    /// nonce transfer out the current nonce value of the account
    /// gasLimit the maximum gas consumption allowed for this transaction
    /// gasPrice specifies the price of gas
    /// data Remarks message (can be viewed on the block after the transaction is confirmed)
    /// chain_id: ETH chain type
    pub fn raw_transfer_sign(&self, from_address: &str, to_address: Option<H160>, amount: U256, psw: &[u8], nonce: U256, gas_limit: U256, gas_price: U256, data: Option<String>, eth_chain_id: u64) -> WalletResult<String> {
        // pub fn raw_transfer_sign(&self, from_address: &str, raw_tx:RawTransaction, psw: &[u8], eth_chain_id: u64) -> WalletResult<String> {
        let data = match data {
            Some(data) => data.as_bytes().to_vec(),
            None => vec![]
        };
        let rawtx = ethtx::RawTransaction {
            nonce,
            to: to_address,//For transfer operations, to cannot be empty.
            value: amount,
            gas_price,
            gas: gas_limit,
            data,
        };

        self.tx_sign(from_address, psw, rawtx, eth_chain_id)
    }
    ///ETH ERC20 transfer transaction signature The current wallet only provides the transfer function for ERC20
    /// from_account: transfer out of account
    /// contract_address: contract address (token contract address)
    /// to_account: transfer to account
    /// amount: the amount of erc20 token transferred out
    /// psw transfer out account wallet keystore decrypt password
    /// nonce transfer out the current nonce value of the account
    /// gasLimit the maximum gas consumption allowed for this transaction
    /// gasPrice specifies the price of gas
    /// data Remarks message (you need to confirm again, is this field still valid when transferring erc20 token?)
    pub fn raw_erc20_transfer_sign(&self, from_address: &str, contract_address: H160, to_address: Option<H160>, amount: U256, psw: &[u8], nonce: U256, gas_limit: U256, gas_price: U256, data: Option<String>, eth_chain_id: u64) -> WalletResult<String> {
        //Call erc20 contract to_account cannot be empty
        if to_address.is_none() {
            return Err(WalletError::Custom("to account is not allown empty".to_string()));
        }
        //Does the calling contract allow the transfer destination address to be empty?
        let mut encode_data = ethtx::get_erc20_transfer_data(to_address.unwrap(), amount)?;
        //Add contract transaction remark information
        if let Some(addition_str) = data {
            let mut addition = addition_str.as_bytes().to_vec();
            encode_data.append(&mut addition);
        }
        let rawtx = ethtx::RawTransaction {
            nonce,
            to: Some(contract_address),//For calling contract, to cannot be empty
            value: U256::from_dec_str("0").unwrap(),
            gas_price,
            gas: gas_limit,
            data: encode_data,
        };
        self.tx_sign(from_address, psw, rawtx, eth_chain_id)
    }

    pub fn raw_tx_sign(&self, raw_tx: &str, chain_id: u64, from_address: &str, psw: &[u8]) -> WalletResult<String> {
        let raw_tx = raw_tx.get(2..).unwrap();// remove `0x`
        let tx_encode_data = hex::decode(raw_tx)?;
        let mut rawtx = ethtx::RawTransaction::default();
        log::debug!("raw_tx_sign before decode");
        rawtx.decode(&tx_encode_data)?;
        self.tx_sign(from_address, psw, rawtx, chain_id)
    }

    fn tx_sign(&self, from_address: &str, psw: &[u8], raw_transaction: ethtx::RawTransaction, eth_chain_id: u64) -> WalletResult<String> {
        //Since the development chain will be used for testing during the development process, the current wallet does not generate a chain address in development mode, and the test mode is used by default
        let chain_type = if eth_chain_id == 1 {
            ChainType::ETH
        } else {
            ChainType::EthTest
        };

        let keystore = find_keystore_wallet_from_address(from_address, chain_type)?;
        log::debug!("tx_sign before get_mnemonic_context");
        //Password validation
        let mnemonic = substratetx::Sr25519::get_mnemonic_context(&keystore, psw)?;
        //Return the private key used for signature
        let pri_key = ethtx::pri_from_mnemonic(&String::from_utf8(mnemonic)?, None)?;
        log::debug!("raw_tx_sign before raw_transaction.sign");
        let tx_signed = raw_transaction.sign(&pri_key, Some(eth_chain_id));
        Ok(format!("0x{}", hex::encode(tx_signed)))
    }
    //Parsing additional information added by eth transactions
    pub fn decode_data(&self, input: &str) -> WalletResult<String> {
        if input.is_empty() {
            return Ok("".to_string());
        }
        ethtx::decode_tranfer_data(input).map_err(|error| error.into())
    }

    pub fn get_chain_data(&self) -> WalletResult<HashMap<String, Vec<EthChain>>> {
        let instance = wallet_db::DataServiceProvider::instance()?;
        let eth_chain = instance.display_chain_detail(ChainType::ETH);
        // let mut chain_index = 0;
        let mut eth_map = HashMap::new();
        match eth_chain {
            Ok(tbwallets) => {
                for tbwallet in tbwallets {
                    let wallet_id = tbwallet.wallet_id.unwrap();
                    let chain_id = format!("{}", tbwallet.chain_id.unwrap());//The chain id will not be null

                    if !eth_map.contains_key(&wallet_id) {
                        let chain = EthChain {
                            status: StatusCode::OK,
                            chain_id: chain_id.clone(),
                            wallet_id: wallet_id.clone(),
                            address: tbwallet.address.unwrap(),
                            domain: tbwallet.domain,
                            is_visible: tbwallet.chain_is_visible,
                            chain_type: {
                                if tbwallet.chain_type.is_none() {
                                    None
                                } else {
                                    Some(ChainType::from(tbwallet.chain_type.unwrap()))
                                }
                            },
                            digit_list: Vec::new(),
                        };
                        eth_map.insert(wallet_id.clone(), vec![chain]);
                    }

                    let digit_id = tbwallet.digit_id.unwrap().to_string();
                    let digit = EthDigit {
                        status: StatusCode::OK,
                        digit_id,
                        chain_id,
                        contract_address: tbwallet.contract_address.clone(),
                        fullname: tbwallet.full_name.clone(),
                        shortname: tbwallet.short_name.clone(),
                        balance: tbwallet.balance.clone(),
                        is_visible: tbwallet.digit_is_visible,
                        decimal: tbwallet.decimals,
                        imgurl: tbwallet.url_img,
                    };
                    let vec_eth_chain = eth_map.get_mut(wallet_id.as_str()).unwrap();
                    //In the current design, there is no test chain and main chain for the same chain type under one wallet;
                    let chain_list = vec_eth_chain.get_mut(0).unwrap();
                    chain_list.digit_list.push(digit);
                }
                Ok(eth_map)
            }
            Err(e) => Err(e)
        }
    }
}

//Bitcoin related functions have not been integrated yet
pub struct Bitcoin;

impl Chain for Bitcoin {}

impl Bitcoin {
    pub fn get_chain_data(&self) -> WalletResult<HashMap<String, Vec<BtcChain>>> {
        let instance = wallet_db::DataServiceProvider::instance()?;
        let btc_chain = instance.display_chain_detail(ChainType::BTC);
        let mut btc_map = HashMap::new();
        match btc_chain {
            Ok(tbwallets) => {
                for tbwallet in tbwallets {
                    let wallet_id = tbwallet.wallet_id.unwrap();
                    let chain_id = format!("{}", tbwallet.chain_id.unwrap());//The chain id will not be null
                    if !btc_map.contains_key(&wallet_id) {
                        //This place needs to deal with the chain relationship again
                        let chain = BtcChain {
                            status: StatusCode::OK,
                            chain_id: chain_id.clone(),
                            wallet_id: wallet_id.clone(),
                            address: tbwallet.address.unwrap(),
                            domain: tbwallet.domain,
                            is_visible: tbwallet.chain_is_visible,
                            chain_type: {
                                if tbwallet.chain_type.is_none() {
                                    None
                                } else {
                                    Some(ChainType::from(tbwallet.chain_type.unwrap()))
                                }
                            },
                            digit_list: Vec::new(),
                        };
                        //Record the serial number of the chain under the wallet, because usize cannot be a negative number, so use +1 to identify the order in which a wallet goes down
                        btc_map.insert(wallet_id.clone(), vec![chain]);
                    }
                    let digit_id = tbwallet.digit_id.unwrap().to_string();
                    let digit = BtcDigit {
                        status: StatusCode::OK,
                        digit_id,
                        chain_id,
                        contract_address: tbwallet.contract_address.clone(),
                        fullname: tbwallet.full_name.clone(),
                        shortname: tbwallet.short_name.clone(),
                        balance: tbwallet.balance.clone(),
                        is_visible: tbwallet.digit_is_visible,
                        decimal: tbwallet.decimals,
                        imgurl: tbwallet.url_img,
                    };
                    let vec_eth_chain = btc_map.get_mut(wallet_id.as_str()).unwrap();

                    let chain_list = vec_eth_chain.get_mut(0).unwrap();
                    chain_list.digit_list.push(digit);
                }
                Ok(btc_map)
            }
            Err(e) => Err(e)
        }
    }
}

pub trait Chain {
    fn show_chain(walletid: &str, wallet_type: i64) -> WalletResult<bool> {
        let instance = wallet_db::DataServiceProvider::instance()?;
        instance.show_chain(walletid, wallet_type)
    }

    fn hide_chain(walletid: &str, wallet_type: i64) -> WalletResult<bool> {
        let instance = wallet_db::DataServiceProvider::instance()?;
        instance.hide_chain(walletid, wallet_type)
    }

    fn get_now_chain_type(walletid: &str) -> WalletResult<i64> {
        let instance = wallet_db::DataServiceProvider::instance()?;
        instance.get_now_chain_type(walletid)
    }

    fn set_now_chain_type(walletid: &str, chain_type: i64) -> WalletResult<bool> {
        let instance = wallet_db::DataServiceProvider::instance()?;
        instance.set_now_chain_type(walletid, chain_type)
    }
}

pub fn find_keystore_wallet_from_address(address: &str, chain_type: ChainType) -> WalletResult<String> {
    let instance = wallet_db::DataServiceProvider::instance()?;
    instance.get_wallet_by_address(address, chain_type).map(|tbwallet| tbwallet.mnemonic)
}






