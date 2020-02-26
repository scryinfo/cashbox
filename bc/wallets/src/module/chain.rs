use super::*;
use super::model::*;

use std::sync::mpsc;
use crate::wallet_crypto::Crypto;
use std::collections::HashMap;
use ethereum_types::{H160,U256, U128};

pub fn eee_tranfer_energy(from:&str,to:&str,amount:&str,psw: &[u8])->Result<String,String>{

    match module::wallet::find_keystore_wallet_from_address(from,ChainType::EEE) {
        Ok(keystore)=>{
            match wallet_crypto::Sr25519::get_mnemonic_context(&keystore, psw) {
                Ok(mnemonic) => {
                    //密码验证通过

                    let (send_tx, recv_tx) = mpsc::channel();
                    let mut substrate_client = wallet_rpc::substrate_thread(send_tx).unwrap();
                    let mn = String::from_utf8(mnemonic).unwrap();
                    let signed_data = wallet_rpc::transfer(&mut substrate_client,  &mn,to,amount);
                    match signed_data {
                        Ok(data)=>{
                            println!("signed data is: {}",data);
                           let ret_value  = wallet_rpc::submit_data(&mut substrate_client,data);
                           let str_value = format!("{}",ret_value);
                            Ok(str_value)
                        },
                        Err(msg)=>{
                            Err(msg)
                        }
                    }
                }
                Err(msg) => Err(msg),
            }
        },
       Err(msg)=>{Err(msg)}
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
//pub fn eth_raw_transfer_sign(from_account:&str, to_account:&str, amount:&str, psw: &[u8], nonce:&str, gas_limit:&str, gas_price:&str, data:Option<String>, eth_chain_id:u64) ->Result<String,String>{
pub fn eth_raw_transfer_sign(from_address:&str, to_address:Option<H160>, amount:U256, psw: &[u8], nonce:U256, gas_limit:U256, gas_price:U256, data:Option<String>, eth_chain_id:u64) ->Result<String,String>{
    //
    match module::wallet::find_keystore_wallet_from_address(from_address, ChainType::ETH) {
        Ok(keystore)=>{
            match wallet_crypto::Sr25519::get_mnemonic_context(&keystore, psw) {
                Ok(mnemonic) => {
                    //密码验证通过开始拼接交易签名数据
                    //todo 输入的数量都是整数？

                   /* let nonce = U256::from_dec_str(nonce).unwrap();
                    let amount = U256::from_dec_str(amount).unwrap();
                    let gas_limit = U256::from_dec_str(gas_limit).unwrap();*/
                   // let gas_price = U256::from_dec_str(gas_price).unwrap();
                  /*  let to = {
                        if to_address.is_empty() {
                            None
                        }else{
                            let to = H160::from_slice(hex::decode(to_address.get(2..).unwrap()).unwrap().as_slice());
                            Some(to)
                        }
                    };*/

                    let data =  match data {
                            Some(data)=>data.as_bytes().to_vec(),
                            None=>vec![]
                        };

                   let rawtx =  ethtx::RawTransaction{
                        nonce: nonce,
                        to: to_address,//针对转账操作,to不能为空,若为空表示发布合约
                        value: amount,
                        gas_price: gas_price,
                        gas: gas_limit,
                        data,
                    };
                    //todo 增加对错误的处理
                    let pri_key = ethtx::pri_from_mnemonic(&String::from_utf8(mnemonic).unwrap(),None).unwrap();

                    //todo 增加链id ,从助记词生成私钥 secp256k1
                   let tx_signed =  rawtx.sign(&pri_key,Some(eth_chain_id));
                    Ok(format!("0x{}",hex::encode(tx_signed)))
                }
                Err(msg) => Err(msg),
            }
        },
        Err(msg)=>{Err(msg)}
    }
}
/*fn eth_chain_type(chain_type:u64)->Option<u64>{
    if chain_type==3 {
        Some(1)
    }else {
        Some(3)
    }
}*/
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
//pub fn eth_raw_erc20_transfer_sign(from_account:&str, contract_address:&str, to_account:&str, amount:&str, psw: &[u8], nonce:&str, gas_limit:&str, gas_price:&str, data:Option<String>, eth_chain_id:u64) ->Result<String,String>{
pub fn eth_raw_erc20_transfer_sign(from_account:&str, contract_address:H160, to_account:Option<H160>, amount:U256, psw: &[u8], nonce:U256, gas_limit:U256, gas_price:U256, data:Option<String>, eth_chain_id:u64) ->Result<String,String>{

    match module::wallet::find_keystore_wallet_from_address(from_account,ChainType::ETH) {
        Ok(keystore)=>{
            match wallet_crypto::Sr25519::get_mnemonic_context(&keystore, psw) {
                Ok(mnemonic) => {
                    //密码验证通过
                    //todo 增加错误处理

                    //调用合约 是否允许transfer 目标地址为空?
                    let encode_data = ethtx::get_erc20_transfer_data(to_account.unwrap(),amount).unwrap();

                    let rawtx =  ethtx::RawTransaction{
                        nonce: nonce,
                        to: Some(contract_address),//针对调用合约,to不能为空
                        value: U256::from_dec_str("0").unwrap(),
                        gas_price: gas_price,
                        gas: gas_limit,
                        data:encode_data,
                    };
                    //todo 增加对错误的处理
                    let pri_key = ethtx::pri_from_mnemonic(&String::from_utf8(mnemonic).unwrap(),None).unwrap();
                    //todo 增加链id ,从助记词生成私钥 secp256k1
                    let tx_signed =  rawtx.sign(&pri_key,Some(eth_chain_id));
                    Ok(format!("0x{}",hex::encode(tx_signed)))
                }
                Err(msg) => Err(msg),
            }
        },
        Err(msg)=>{Err(msg)}
    }
}

pub fn get_eee_chain_data() -> Result<HashMap<String, Vec<EeeChain>>, String> {
    let instance = wallet_db::db_helper::DataServiceProvider::instance().unwrap();

    let eee_chain = instance.display_eee_chain();
    let mut last_wallet_id = String::from("-1");
    let mut chain_index = 0;
    let mut eee_map = HashMap::new();

    match eee_chain {
        Ok(tbwallets) => {
            for tbwallet in tbwallets {
                let wallet_id = tbwallet.wallet_id.unwrap();
                let chain_id = format!("{}", tbwallet.chain_id.unwrap());//chain id 不会存在为Null的情况
                // println!("chain id is {}",chain_id);
                //不同的钱包 具有相同的链id 要增加钱包的记录
                //同一个钱包 具有相同的链id  只要增加代币的记录
                //同一个钱包 具有不同的链id 要增加链的记录（这种情况 业务暂时不支持，代码保留在这）

                if last_wallet_id.ne(&wallet_id) {

                    //使用last_wallet_id 标识上一个钱包id,当钱包发生变化的时候，表示当前迭代的数据是新钱包 需要更新wallet_index，标识当前处理的是哪个钱包
                    last_wallet_id = wallet_id.clone();

                    let chain = EeeChain {
                        status: StatusCode::OK,
                        chain_id: chain_id.clone(),
                        wallet_id: wallet_id.clone(),
                        address: tbwallet.address.unwrap(),
                        domain:tbwallet.domain,
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
                    chain_index = 0;
                    //记录该链在钱包下的序号，因为usize 不能为负数，所有在这个地方先使用+1 来标识一个钱包下链的顺序
                    //  chain_index = chain_index + 1;
                    // last_chain_id = chain_id.clone();
                    eee_map.insert(wallet_id.clone(), vec![chain]);
                }
                let digit_id = format!("{}", tbwallet.digit_id.unwrap());
                // println!("digit id is {}",digit_id);
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

                let chain_list = vec_eee_chain.get_mut(chain_index).unwrap();
                chain_list.digit_list.push(digit);
            }
            Ok(eee_map)
        }
        Err(e) => Err(e)
    }
}

pub fn get_eth_chain_data() -> Result<HashMap<String, Vec<EthChain>>, String> {
    let instance = wallet_db::db_helper::DataServiceProvider::instance().unwrap();

    let eth_chain = instance.display_eth_chain();

    let mut last_wallet_id = String::from("-1");
    let mut chain_index = 0;

    let mut eth_map = HashMap::new();

    match eth_chain {
        Ok(tbwallets) => {
            for tbwallet in tbwallets {
                let wallet_id = tbwallet.wallet_id.unwrap();
                let chain_id = format!("{}", tbwallet.chain_id.unwrap());//chain id 不会存在为Null的情况
                //不同的钱包 具有相同的链id 要增加钱包的记录
                //同一个钱包 具有相同的链id  只要增加代币的记录
                //同一个钱包 具有不同的链id 要增加链的记录（这种情况 业务暂时不支持，代码保留在这）

                if last_wallet_id.ne(&wallet_id) {

                    //使用last_wallet_id 标识上一个钱包id,当钱包发生变化的时候，表示当前迭代的数据是新钱包 需要更新wallet_index，标识当前处理的是哪个钱包
                    last_wallet_id = wallet_id.clone();

                    //现在的业务是一个钱包，只有这一种类型的链，比如 Eth 只存在主链 没有另外的链，以下判断可以不需要
                    //这个地方需要重新来处理链的关系
                    let chain = EthChain {
                        status: StatusCode::OK,
                        chain_id: chain_id.clone(),
                        wallet_id: wallet_id.clone(),
                        address: tbwallet.address.unwrap(),
                        domain:tbwallet.domain,
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
                    chain_index = 0;
                    eth_map.insert(wallet_id.clone(), vec![chain]);
                }
                let digit_id = format!("{}", tbwallet.digit_id.unwrap());
                let digit = EthDigit {
                    status: StatusCode::OK,
                    digit_id: digit_id,
                    chain_id: chain_id,
                  //  address: tbwallet.address.clone(),
                    contract_address: tbwallet.contract_address.clone(),
                    fullname: tbwallet.full_name.clone(),
                    shortname: tbwallet.short_name.clone(),
                    balance: tbwallet.balance.clone(),
                    is_visible: tbwallet.digit_is_visible,
                    decimal: tbwallet.decimals,
                    imgurl: tbwallet.url_img,
                };
                let vec_eth_chain = eth_map.get_mut(wallet_id.as_str()).unwrap();

                let chain_list = vec_eth_chain.get_mut(chain_index).unwrap();
                chain_list.digit_list.push(digit);
            }
            Ok(eth_map)
        }
        Err(e) => Err(e)
    }
}

pub fn get_btc_chain_data() -> Result<HashMap<String, Vec<BtcChain>>, String> {
    let instance = wallet_db::db_helper::DataServiceProvider::instance().unwrap();

    let btc_chain = instance.display_btc_chain();

    let mut last_wallet_id = String::from("-1");
    let mut chain_index = 0;

    let mut btc_map = HashMap::new();

    match btc_chain {
        Ok(tbwallets) => {
            for tbwallet in tbwallets {
                let wallet_id = tbwallet.wallet_id.unwrap();
                let chain_id = format!("{}", tbwallet.chain_id.unwrap());//chain id 不会存在为Null的情况

                //不同的钱包 具有相同的链id 要增加钱包的记录
                //同一个钱包 具有相同的链id  只要增加代币的记录
                //同一个钱包 具有不同的链id 要增加链的记录（这种情况 业务暂时不支持，代码保留在这）

                if last_wallet_id.ne(&wallet_id) {

                    //使用last_wallet_id 标识上一个钱包id,当钱包发生变化的时候，表示当前迭代的数据是新钱包 需要更新wallet_index，标识当前处理的是哪个钱包
                    last_wallet_id = wallet_id.clone();
                    //开始新的钱包，记录链的标识需要重新开始计算
                    //这个地方需要重新来处理链的关系
                    let chain = BtcChain {
                        status: StatusCode::OK,
                        chain_id: chain_id.clone(),
                        wallet_id: wallet_id.clone(),
                        address: tbwallet.address.unwrap(),
                        domain:tbwallet.domain,
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
                    chain_index = 0;
                    btc_map.insert(wallet_id.clone(), vec![chain]);
                }
                let digit_id = format!("{}", tbwallet.digit_id.unwrap());
                let digit = BtcDigit {
                    status: StatusCode::OK,
                    digit_id: digit_id,
                    chain_id: chain_id,
                   // address: tbwallet.address.clone(),
                    contract_address: tbwallet.contract_address.clone(),
                    fullname: tbwallet.full_name.clone(),
                    shortname: tbwallet.short_name.clone(),
                    balance: tbwallet.balance.clone(),
                    is_visible: tbwallet.digit_is_visible,
                    decimal: tbwallet.decimals,
                    imgurl: tbwallet.url_img,
                };
                let vec_eth_chain = btc_map.get_mut(wallet_id.as_str()).unwrap();

                let chain_list = vec_eth_chain.get_mut(chain_index).unwrap();
                chain_list.digit_list.push(digit);
            }
            Ok(btc_map)
        }
        Err(e) => Err(e)
    }
}

pub fn show_chain(walletid: &str,wallet_type: i64) -> Result<bool, String> {
    let mut instance = wallet_db::db_helper::DataServiceProvider::instance().unwrap();
    match instance.show_chain(walletid,wallet_type) {
        Ok(_) => Ok(true),
        Err(error) => Err(error.to_string())
    }
}

pub fn hide_chain(walletid: &str,wallet_type: i64) -> Result<bool, String> {
    let mut instance = wallet_db::db_helper::DataServiceProvider::instance().unwrap();
    match instance.hide_chain(walletid,wallet_type) {
        Ok(_) => Ok(true),
        Err(error) => Err(error.to_string())
    }
}

pub fn get_now_chain_type(walletid: &str) -> Result<i64, String> {
    let mut instance = wallet_db::db_helper::DataServiceProvider::instance().unwrap();
    match instance.get_now_chain_type(walletid) {
        Ok(data) => Ok(data),
        Err(error) => Err(error.to_string())
    }
}

pub fn set_now_chain_type(walletid: &str,chain_type: i64) -> Result<bool, String> {
    let mut instance = wallet_db::db_helper::DataServiceProvider::instance().unwrap();
    match instance.set_now_chain_type(walletid,chain_type) {
        Ok(_) => Ok(true),
        Err(error) => Err(error.to_string())
    }
}
