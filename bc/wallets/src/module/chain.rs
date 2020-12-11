use super::*;
use super::model::*;

use substratetx::{Crypto, Token, EeeAccountInfo, EeeAccountInfoRefU8};
use std::collections::HashMap;
use codec::{Encode, Decode};
use ethereum_types::{H160, U256, H256};
use substratetx::Ss58Codec;

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

    fn decode_mnemonic_by_address(&self,address: &str,psw: &[u8])-> WalletResult<String>{
        let keystore = find_keystore_wallet_from_address(address, ChainType::EEE)?;
        let mnemonic = substratetx::Sr25519::get_mnemonic_context(&keystore, psw)?;
        //Passed password verification
        let mn = String::from_utf8(mnemonic)?;
        Ok(mn)
    }

    // fn convert_hash_to_byte(&self,hash: &str)-> WalletResult<[u8;32]>{
    //     let hash_vec = substratetx::hexstr_to_vec(hash)?;
    //     let mut h256 = [0u8; 32];
    //     h256.clone_from_slice(hash_vec.as_slice());
    //     Ok(h256)
    // }

    pub fn generate_eee_transfer(&self, from: &str, to: &str, amount: &str, index: u32, psw: &[u8]) -> WalletResult<String> {

        let mn = self.decode_mnemonic_by_address(from,psw)?;
        let instance = wallet_db::DataServiceProvider::instance()?;
        let chain_info = instance.get_sub_chain_info(None,0,0)?;
        if let Some(info) = chain_info.get(0){
            let genesis_hash = substratetx::hexstr_to_vec(&info.genesis_hash)?;
         /*   let genesis_hash =genesis_hash?;*/
            let decimal = if info.token_decimals == 0{15}else { info.token_decimals as usize};
            let transfer_amount = general::token_unit_convert(amount,decimal).map(|amount| amount.to_string())
                .ok_or_else(||WalletError::Custom("input amount is illegal".to_string()));
            log::info!("transfer eee amount is:{:?}",transfer_amount);
            let helper = substratetx::SubChainHelper::init(&info.metadata,&genesis_hash[..],info.runtime_version as u32,info.tx_version as u32,None)?;
            let signed_data = helper.token_transfer_sign(Token::EEE,&mn,to,&transfer_amount?,index,None)?;
            log::debug!("signed data is: {}", signed_data);
            Ok(signed_data)
        }else {
            Err(WalletError::NotExist)
        }
    }

    pub fn generate_tokenx_transfer(&self, from: &str, to: &str, amount: &str, ext_data:&str,index: u32, psw: &[u8]) -> WalletResult<String> {

        let mn = self.decode_mnemonic_by_address(from,psw)?;
        let ext_vec = substratetx::hexstr_to_vec(ext_data)?;
        let instance = wallet_db::DataServiceProvider::instance()?;
        //use default chain basic info;
        let chain_info = instance.get_sub_chain_info(None,0,0)
            .and_then(|mut chains| chains.pop().ok_or_else(|| WalletError::Custom(" default chain basic info isn't exist".to_string())));
        let decimal = instance.query_default_digit(1,Some("TokenX".to_string()))
            .and_then(|mut digits|  digits.pop().ok_or_else(|| WalletError::Custom("digit TokenX isn't exist".to_string())))
            .map(|digit| digit.decimal)
            .and_then(|d| d.parse::<usize>().map_err(WalletError::from));

        let transfer_amount = general::token_unit_convert(amount,decimal?).map(|amount| amount.to_string())
            .ok_or_else(||WalletError::Custom("input amount is illegal".to_string()));
        let chain_basic_info = chain_info?;
            let genesis_hash = substratetx::hexstr_to_vec(&chain_basic_info.genesis_hash)?;
            let helper = substratetx::SubChainHelper::init(&chain_basic_info.metadata,&genesis_hash[..],chain_basic_info.runtime_version as u32,chain_basic_info.tx_version as u32,None)?;
            let signed_data = helper.token_transfer_sign(Token::TokenX,&mn,to,&transfer_amount?,index,Some(ext_vec))?;
            log::debug!("signed data is: {}", signed_data);
            Ok(signed_data)
    }

    pub fn save_tx_record(&self, info_id:&str,account: &str, blockhash: &str, event_data: &str, extrinsics: &str) -> WalletResult<()> {
        let instance = wallet_db::DataServiceProvider::instance()?;
        let info = instance.query_chain_info(info_id)?;
        // default chain genesis hash  definitely exists
        let genesis_hash = substratetx::hexstr_to_vec(&info.genesis_hash)?;
        let helper = substratetx::SubChainHelper::init(&info.metadata,&genesis_hash,info.runtime_version as u32,info.tx_version as u32,None)?;
        let event_res =  helper.decode_events(event_data,None)?;
        let extrinsics_map = helper.decode_extrinsics(extrinsics, account)?;

        //Block transaction events There must be a time stamp setting
        let tx_time = extrinsics_map.get(&0).unwrap();//Get timestamp
        let instance = wallet_db::DataServiceProvider::instance()?;
        for (index ,transfer_detail) in extrinsics_map.iter() {
            if transfer_detail.signer.is_none(){
                continue;
            }
            log::info!("tx index:{}",index);
            if let  Some(is_successful) = event_res.get(index){
                instance.save_transfer_detail(account, blockhash, transfer_detail, tx_time.timestamp.unwrap(), *is_successful)?;
            }
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

    pub fn query_tx_record(&self,account:&str,token_name:&str,start_index:u32,offset:u32)->WalletResult<Vec<EeeTxRecord>>{
        let instance = wallet_db::DataServiceProvider::instance()?;
        instance.get_eee_tx_record(account,token_name,start_index,offset)
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
                            pub_key:tbwallet.pub_key.unwrap(),
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
        let tx_encode_data = substratetx::hexstr_to_vec(raw_tx)?;
        let tx = RawTx::decode(&mut &tx_encode_data[..]).expect("tx format");
        let wallet = module::wallet::WalletManager {};
        let mnemonic = wallet.export_mnemonic(wallet_id, psw)?;
        let mn = String::from_utf8(mnemonic.mn)?;
        let instance = wallet_db::DataServiceProvider::instance()?;
        let genesis_hash_str =format!("0x{}",hex::encode(tx.genesis_hash));
        let chain_infos= instance.get_sub_chain_info(Some(&genesis_hash_str),tx.spec_version,tx.tx_version)?;
        if let Some(chain_info) =chain_infos.get(0) {
            let chain_helper = substratetx::SubChainHelper::init(&chain_info.metadata,&tx.genesis_hash[..],chain_info.runtime_version as u32,chain_info.tx_version as u32,None)?;
            let sign_data =   chain_helper.tx_sign(&mn,  tx.index, &self.restore_func_data(&tx.func_data))?;
            Ok(sign_data)
        }else {
             Err(error::WalletError::NotExist)
        }
    }
    // when decode RawTx instance,the function data length info will be drop,this func is aim to restore the original structure
    fn restore_func_data(&self, func_data:&[u8]) ->Vec<u8>{
        let func_size = func_data.len();
        let reserve = match func_size {
            0..=0b0011_1111 => 1,
            0b0100_0000..=0b0011_1111_1111_1111 => 2,
            _ => 4,
        };
        let mut func_vec = vec![0u8;func_size+reserve];
        {
            let temp = &mut func_vec[reserve..];
            temp.copy_from_slice(func_data);
        }
        func_vec
    }
    //Used for signing ordinary data, incoming data, hex format data
    pub fn raw_sign(&self, raw_data: &str, wallet_id: &str, psw: &[u8]) -> WalletResult<String> {
        let tx_encode_data = substratetx::hexstr_to_vec(raw_data)?;
        let wallet = module::wallet::WalletManager {};
        let mnemonic = wallet.export_mnemonic(wallet_id, psw)?;
        let mn = String::from_utf8(mnemonic.mn)?;
        let sign_data = substratetx::Sr25519::sign(&mn, &tx_encode_data[..]).unwrap();
        let hex_data = format!("0x{}", hex::encode(&sign_data[..]));
        Ok(hex_data)
    }
    //update chain basic info,eg:metadata,genesis hash,runtime version tx version etc,which will be used to structure extrinsic encode or decode function
    pub fn update_chain_basic_info(&self,info:&SubChainBasicInfo,is_default:bool)->WalletResult<String> {
        let instance = wallet_db::DataServiceProvider::instance()?;
        instance.tx_begin()?;
        instance.update_sub_chain_info(info,is_default)
           .map(|id|{
               let _ = instance.tx_commint();
               id
           })
           .map_err(|err|{
               log::error!("update chain basic info:{}",err.to_string());
               let _ = instance.tx_rollback();
               err
           })
    }

    pub fn query_chain_basic_info(&self,genesis_hash:&str,spec_vers:u32,tx_vers:u32)->WalletResult<Vec<SubChainBasicInfo>>{
        let instance = wallet_db::DataServiceProvider::instance()?;
        log::info!("query genesis hash is{}",genesis_hash);
        let genesis_hash = genesis_hash.trim();
        let genesis_final = if genesis_hash.trim().is_empty() {
            None
        }else {
            Some(genesis_hash)
        };
        instance.get_sub_chain_info(genesis_final,spec_vers,tx_vers)
    }

    pub fn encode_account_storage_key(&self,module: &str, storage: &str, account: &str)->WalletResult<String> {
        let instance = wallet_db::DataServiceProvider::instance()?;
        let chain_infos = instance.get_sub_chain_info(None,0,0)?;
        if let Some(chain_info) = chain_infos.get(0){
            let genesis_hash = substratetx::hexstr_to_vec(&chain_info.genesis_hash)?;
            let account_id = substratetx::AccountId::from_ss58check(account).map_err(|err|WalletError::SubstrateTx(substratetx::error::Error::Public(err)))?;
            let chain_helper = substratetx::SubChainHelper::init(&chain_info.metadata, &genesis_hash[..], chain_info.runtime_version as u32, chain_info.tx_version as u32, None)?;
            chain_helper.get_storage_map_key::<substratetx::AccountId, u128>(&module, &storage, account_id)
                .map(|key|format!("0x{}",key))
                .map_err(|e| e.into())
        } else {
            Err(error::WalletError::NotExist)
        }
    }
    pub fn decode_account_info(&self,encode_info:&str)->WalletResult<EeeAccountInfo> {
        let instance = wallet_db::DataServiceProvider::instance()?;
        let chain_infos = instance.get_sub_chain_info(None,0,0)?;
        if let Some(chain_info) = chain_infos.get(0){
            let genesis_hash = substratetx::hexstr_to_vec(&chain_info.genesis_hash)?;
            let chain_helper = substratetx::SubChainHelper::init(&chain_info.metadata, &genesis_hash[..], chain_info.runtime_version as u32, chain_info.tx_version as u32, None)?;
           match chain_helper.get_storage_value_key("System","UpgradedToU32RefCount"){
               Ok(_)=>{substratetx::decode_account_info::<EeeAccountInfo>(encode_info).map_err(|error|error.into())}
               Err(_)=>{
                   substratetx::decode_account_info::<EeeAccountInfoRefU8>(encode_info).map_err(|error|error.into())
               }
           }
        } else {
            Err(error::WalletError::NotExist)
        }
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
    //pub fn raw_transfer_sign(&self, from_address: &str, to_address: Option<H160>, amount: U256, psw: &[u8], nonce: U256, gas_limit: U256, gas_price: U256, data: Option<String>, eth_chain_id: u64) -> WalletResult<String> {
    pub fn raw_transfer_sign(&self, from_address: &str,  psw: &[u8],raw_tx:RawTransaction, eth_chain_id: u64) -> WalletResult<String> {

        self.tx_sign(from_address, psw, raw_tx, eth_chain_id)
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
    //pub fn raw_erc20_transfer_sign(&self, from_address: &str, contract_address: H160, to_address: Option<H160>, amount: U256, psw: &[u8], nonce: U256, gas_limit: U256, gas_price: U256, data: Option<String>, eth_chain_id: u64) -> WalletResult<String> {
    pub fn raw_erc20_transfer_sign(&self, from_address: &str, contract_address: H160, to_address: Option<H160>, amount: U256, psw: &[u8], nonce: U256, gas_limit: U256, gas_price: U256, data: Vec<u8>, eth_chain_id: u64) -> WalletResult<String> {
        //Call erc20 contract to_account cannot be empty
        if to_address.is_none() {
            return Err(WalletError::Custom("to account is not allowed empty".to_string()));
        }
        //Does the calling contract allow the transfer destination address to be empty?
        let mut encode_data = ethtx::get_erc20_transfer_data(to_address.unwrap(), amount)?;
        //Add contract transaction remark information
        encode_data.extend_from_slice(&data);

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
                            pub_key:tbwallet.pub_key.unwrap(),
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
                            pub_key: tbwallet.pub_key.unwrap(),
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






