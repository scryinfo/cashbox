use super::*;
use super::model::*;

use substratetx::Crypto;
use std::collections::HashMap;
use ethereum_types::{H160, U256, H256};

// 转EEE链代币
pub fn eee_transfer(from: &str, to: &str, amount: &str, genesis_hash: &str, index: u32, runtime_version: u32, psw: &[u8]) -> WalletResult<String> {
    match module::wallet::find_keystore_wallet_from_address(from, ChainType::EEE) {
        Ok(keystore) => {
            //todo 使用优化的错误返回方式
            match substratetx::Sr25519::get_mnemonic_context(&keystore, psw) {
                Ok(mnemonic) => {
                    //密码验证通过
                    let mn = String::from_utf8(mnemonic)?;
                    let genesis_hash_bytes = hex::decode(genesis_hash.get(2..).unwrap())?;
                    let mut genesis_h256 = [0u8; 32];
                    genesis_h256.clone_from_slice(genesis_hash_bytes.as_slice());

                    let signed_data = substratetx::transfer(&mn, to, amount, H256(genesis_h256), index, runtime_version);
                    match signed_data {
                        Ok(data) => {
                            log::debug!("signed data is: {}", data);
                            Ok(data)
                        }
                        Err(msg) => {
                            Err(msg.into())
                        }
                    }
                }
                Err(msg) => Err(msg.into()),
            }
        }
        Err(msg) => { Err(msg.into()) }
    }
}


///ETH交易签名
/// from_account: 转出账户
/// to_account: 转入账户
/// amount：转出的ETH数量
/// psw 转出账户钱包keystore解密密码
///  nonce  转出账户当前的nonce值
/// gasLimit 这笔交易最大允许的gas消耗
/// gasPrice 指定gas的价格
/// data 备注消息（当交易确认后，能够在区块上查看到）
/// chain_id: ETH的链类型
pub fn eth_raw_transfer_sign(from_address: &str, to_address: Option<H160>, amount: U256, psw: &[u8], nonce: U256, gas_limit: U256, gas_price: U256, data: Option<String>, eth_chain_id: u64) -> WalletResult<String> {
    //由于在开发过程中会使用开发链做测试，当前钱包没有生成开发模式下的链地址，默认使用测试模式
    let chain_type = if eth_chain_id == 1 {
        ChainType::ETH
    } else {
        ChainType::EthTest
    };
    match module::wallet::find_keystore_wallet_from_address(from_address, chain_type) {
        Ok(keystore) => {
            match substratetx::Sr25519::get_mnemonic_context(&keystore, psw) {
                Ok(mnemonic) => {
                    //密码验证通过开始拼接交易签名数据
                    //todo 输入的数量都是整数？
                    let data = match data {
                        Some(data) => data.as_bytes().to_vec(),
                        None => vec![]
                    };

                    let rawtx = ethtx::RawTransaction {
                        nonce: nonce,
                        to: to_address,//针对转账操作,to不能为空,若为空表示发布合约
                        value: amount,
                        gas_price: gas_price,
                        gas: gas_limit,
                        data,
                    };
                    //todo 增加对错误的处理
                    let pri_key = ethtx::pri_from_mnemonic(&String::from_utf8(mnemonic)?, None)?;

                    //todo 增加链id ,从助记词生成私钥 secp256k1
                    let tx_signed = rawtx.sign(&pri_key, Some(eth_chain_id));
                    Ok(format!("0x{}", hex::encode(tx_signed)))
                }
                Err(msg) => Err(msg.into()),
            }
        }
        Err(msg) => { Err(msg) }
    }
}

///ETH ERC20 转账交易签名  当前钱包针对ERC20只提供转账功能
/// from_account: 转出账户
/// contract_address: 合约地址（代币合约地址）
/// to_account: 转入账户
/// amount：转出的erc20 token数量
/// psw 转出账户钱包keystore解密密码
///  nonce  转出账户当前的nonce值
/// gasLimit 这笔交易最大允许的gas消耗
/// gasPrice 指定gas的价格
/// data 备注消息（还需要再确认一下，当转erc20 token时 这个字段是否还有效？）
pub fn eth_raw_erc20_transfer_sign(from_account: &str, contract_address: H160, to_account: Option<H160>, amount: U256, psw: &[u8], nonce: U256, gas_limit: U256, gas_price: U256, data: Option<String>, eth_chain_id: u64) -> WalletResult<String> {
    //调用erc20合约 to_account 不能为空
    if to_account.is_none() {
        return Err(WalletError::Custom("to account is not allown empty".to_string()));
    }
    //由于在开发过程中会使用开发链做测试，当前钱包没有生成开发模式下的链地址，默认使用测试模式
    let chain_type = if eth_chain_id == 1 {
        ChainType::ETH
    } else {
        ChainType::EthTest
    };
    match module::wallet::find_keystore_wallet_from_address(from_account, chain_type) {
        Ok(keystore) => {
            //todo 使用?方式来处理错误
            match substratetx::Sr25519::get_mnemonic_context(&keystore, psw) {
                Ok(mnemonic) => {
                    //密码验证通过
                    //todo 增加错误处理
                    //调用合约 是否允许transfer 目标地址为空?
                    let mut encode_data = ethtx::get_erc20_transfer_data(to_account.unwrap(), amount)?;
                    //添加合约交易备注信息
                    if data.is_some() {
                        let mut addition = data.unwrap().as_bytes().to_vec();
                        encode_data.append(&mut addition);
                    }
                    let rawtx = ethtx::RawTransaction {
                        nonce: nonce,
                        to: Some(contract_address),//针对调用合约,to不能为空
                        value: U256::from_dec_str("0").unwrap(),
                        gas_price: gas_price,
                        gas: gas_limit,
                        data: encode_data,
                    };
                    //todo 增加对错误的处理
                    let pri_key = ethtx::pri_from_mnemonic(&String::from_utf8(mnemonic)?, None)?;
                    //todo 增加链id ,从助记词生成私钥 secp256k1
                    let tx_signed = rawtx.sign(&pri_key, Some(eth_chain_id));
                    Ok(format!("0x{}", hex::encode(tx_signed)))
                }
                Err(msg) => Err(msg.into()),
            }
        }
        Err(msg) => { Err(msg) }
    }
}

pub fn get_eee_chain_data() -> WalletResult<HashMap<String, Vec<EeeChain>>> {
    let instance = wallet_db::DataServiceProvider::instance()?;
    let eee_chain = instance.display_eee_chain();
    //let mut chain_index = 0;
    let mut eee_map = HashMap::new();
    match eee_chain {
        Ok(tbwallets) => {
            for tbwallet in tbwallets {
                let wallet_id = tbwallet.wallet_id.unwrap();
                let chain_id = format!("{}", tbwallet.chain_id.unwrap());//chain id 不会存在为Null的情况

                if !eee_map.contains_key(&wallet_id){
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
                    //现在一个钱包下 一种类型的链 只有一条
                   // chain_index = 0;
                    eee_map.insert(wallet_id.clone(), vec![chain]);
                }
                let digit_id = format!("{}", tbwallet.digit_id.unwrap());
                let digit = EeeDigit {
                    status: StatusCode::OK,
                    digit_id: digit_id,
                    chain_id: chain_id,
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

pub fn get_eth_chain_data() -> WalletResult<HashMap<String, Vec<EthChain>>> {
    let instance = wallet_db::DataServiceProvider::instance()?;
    let eth_chain = instance.display_eth_chain();
   // let mut chain_index = 0;
    let mut eth_map = HashMap::new();
    match eth_chain {
        Ok(tbwallets) => {
            for tbwallet in tbwallets {
                let wallet_id = tbwallet.wallet_id.unwrap();
                let chain_id = format!("{}", tbwallet.chain_id.unwrap());//chain id 不会存在为Null的情况

               if !eth_map.contains_key(&wallet_id){
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

                let digit_id = format!("{}", tbwallet.digit_id.unwrap());
                let digit = EthDigit {
                    status: StatusCode::OK,
                    digit_id: digit_id,
                    chain_id: chain_id,
                    contract_address: tbwallet.contract_address.clone(),
                    fullname: tbwallet.full_name.clone(),
                    shortname: tbwallet.short_name.clone(),
                    balance: tbwallet.balance.clone(),
                    is_visible: tbwallet.digit_is_visible,
                    decimal: tbwallet.decimals,
                    imgurl: tbwallet.url_img,
                };
                let vec_eth_chain = eth_map.get_mut(wallet_id.as_str()).unwrap();
                //当前的设计，一个钱包下针对同一种链类型，不存在测试链和主链；
                let chain_list = vec_eth_chain.get_mut(0).unwrap();
                chain_list.digit_list.push(digit);
            }
            Ok(eth_map)
        }
        Err(e) => Err(e.into())
    }
}

pub fn get_btc_chain_data() -> WalletResult<HashMap<String, Vec<BtcChain>>> {
    let instance = wallet_db::DataServiceProvider::instance()?;
    let btc_chain = instance.display_btc_chain();
   // let mut chain_index = 0;

    let mut btc_map = HashMap::new();
    match btc_chain {
        Ok(tbwallets) => {
            for tbwallet in tbwallets {
                let wallet_id = tbwallet.wallet_id.unwrap();
                let chain_id = format!("{}", tbwallet.chain_id.unwrap());//chain id 不会存在为Null的情况
                if !btc_map.contains_key(&wallet_id){
                    //这个地方需要重新来处理链的关系
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
                    //记录该链在钱包下的序号，因为usize 不能为负数，所有在这个地方先使用+1 来标识一个钱包下链的顺序
                    btc_map.insert(wallet_id.clone(), vec![chain]);
                }
                let digit_id = format!("{}", tbwallet.digit_id.unwrap());
                let digit = BtcDigit {
                    status: StatusCode::OK,
                    digit_id: digit_id,
                    chain_id: chain_id,
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
        Err(e) => Err(e.into())
    }
}

pub fn show_chain(walletid: &str, wallet_type: i64) -> WalletResult<bool> {
    let instance = wallet_db::DataServiceProvider::instance()?;
    instance.show_chain(walletid, wallet_type)
}

pub fn hide_chain(walletid: &str, wallet_type: i64) -> WalletResult<bool> {
    let instance = wallet_db::DataServiceProvider::instance()?;
    instance.hide_chain(walletid, wallet_type)
}

pub fn get_now_chain_type(walletid: &str) -> WalletResult<i64> {
    let instance = wallet_db::DataServiceProvider::instance()?;
    instance.get_now_chain_type(walletid)
}

pub fn set_now_chain_type(walletid: &str, chain_type: i64) -> WalletResult<bool> {
    let instance = wallet_db::DataServiceProvider::instance()?;
    instance.set_now_chain_type(walletid, chain_type)
}

//解析eth交易添加的附加信息
pub fn decode_eth_data(input: &str) -> WalletResult<String> {
    if input.is_empty() {
        return Ok("".to_string());
    }
    ethtx::decode_tranfer_data(input).map_err(|error| error.into())
}


