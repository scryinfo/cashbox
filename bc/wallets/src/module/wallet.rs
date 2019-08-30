use super::*;
use log::error;

use crate::{StatusCode, wallet_db};
use crate::model::Address;
use super::model::{EeeChain, EeeDigit, TbAddress, Wallet, Mnemonic};
use std::collections::HashMap;
use crate::wallet_crypto::{Crypto};
use uuid::Uuid;
use crate::model::wallet_store::TbWallet;

/**
  Wallet 结构说明：
    一个助记词 对应的是一个钱包，在cashbox钱包软件中 可以同时管理多个钱包；
    一个助记词 可以同时应用于多条链；
    一条链，在基于链的应用上，存在多个合约地址的可能
*/

fn get_wallet_info() -> HashMap<String, Wallet> {
    let instance = wallet_db::db_helper::DataServiceProvider::instance().unwrap();
    let mn = instance.get_wallets();
    let mut wallet_map = HashMap::new();
    for item in mn {
        let wallet = Wallet {
            status: StatusCode::OK,
            wallet_id: item.wallet_id.clone(),
            wallet_name: item.full_name,
            wallet_type:item.wallet_type,
            ..Default::default()
        };
        wallet_map.insert(item.wallet_id, wallet);
    }
    wallet_map
}

fn get_eee_chain_data() -> Result<HashMap<String, Vec<EeeChain>>, String> {
    let instance = wallet_db::db_helper::DataServiceProvider::instance().unwrap();

    let eee_chain = instance.display_eee_chain();
    //println!("return eee chain data");
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
                        chain_address: tbwallet.chain_address,
                        is_visible: tbwallet.isvisible,
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
                    address: tbwallet.address.clone(),
                    contract_address: tbwallet.contract_address.clone(),
                    fullname: tbwallet.full_name.clone(),
                    shortname: tbwallet.short_name.clone(),
                    balance: tbwallet.balance.clone(),
                    is_visible: tbwallet.isvisible,
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

//query all 满足条件的助记词（wallet）
pub fn get_all_wallet() -> Result<Vec<Wallet>, String> {
    let  wallet_info_map = get_wallet_info();

    let eee_data = get_eee_chain_data().expect("get eee data");
    let eth_data = chain::get_eth_chain_data().expect("get eth data");
    let btc_data = chain::get_btc_chain_data().expect("get eth data");
    let mut target = vec![];

    for (wallet_id,wallet) in wallet_info_map {
        let wallet_obj = Wallet{
          status:wallet.status.clone(),
            wallet_id:wallet_id.clone(),
            wallet_name:wallet.wallet_name.clone(),
            wallet_type:wallet.wallet_type.clone(),
            eee_chain:{
                let eee_option = eee_data.get(wallet_id.as_str());
                if eee_option.is_some() {
                    let eee_chain = eee_option.unwrap()[0].clone();
                    Some(eee_chain)
                }else {
                    None
                }
            },
            eth_chain:{
                let eth_option = eth_data.get(wallet_id.as_str());
                if eth_option.is_some() {
                    let eee_chain = eth_option.unwrap()[0].clone();
                    Some(eee_chain)
                }else {
                    None
                }
            },
            btc_chain:{
                let btc_option = btc_data.get(wallet_id.as_str());
                if btc_option.is_some() {
                    let btc_chain = btc_option.unwrap()[0].clone();
                    Some(btc_chain)
                }else {
                    None
                }
            },
        };
        target.push(wallet_obj);
    }
    Ok(target)

}

pub fn is_contain_wallet() -> Result<Vec<TbWallet>, String> {
    match wallet_db::db_helper::DataServiceProvider::instance() {
        Ok(provider) => {
            Ok(provider.get_wallets())
        }
        Err(e) => Err(e)
    }
}

pub fn get_current_wallet() -> Result<Wallet, String> {
    let instance = wallet_db::db_helper::DataServiceProvider::instance().unwrap();
    instance.query_selected_wallet().map(|tb| Wallet {
        wallet_id: tb.wallet_id,
        wallet_name:tb.full_name,
        status:StatusCode::OK,
        ..Default::default()
    }).map_err(|msg| msg)
}

pub fn set_current_wallet(walletid: &str) -> Result<bool, String> {
    let instance = wallet_db::db_helper::DataServiceProvider::instance().unwrap();
    match instance.set_selected_wallet(walletid) {
        Ok(_) => Ok(true),
        Err(error) => Err(error.to_string())
    }
}

pub fn del_wallet(walletid: &str) -> Result<bool, String> {
    let instance = wallet_db::db_helper::DataServiceProvider::instance().unwrap();
    match instance.del_mnemonic(walletid) {
        Ok(_) => Ok(true),
        Err(error) => Err(error.to_string())
    }
}

pub fn rename_wallet(walletid: &str, wallet_name: &str) -> Result<bool, String> {
    let instance = wallet_db::db_helper::DataServiceProvider::instance().unwrap();
    match instance.rename_mnemonic(walletid, wallet_name) {
        Ok(_) => Ok(true),
        Err(error) => Err(error.to_string())
    }
}

//根据生成钱包的类型，需要创建对应的地址
fn address_from_mnemonic(mn: &[u8],wallet_type:i64) -> Address {
    let phrase = String::from_utf8(mn.to_vec()).expect("mn byte format convert to string is error!");
    // TODO 这个地方 根据支持链的种类 分别生成对应的地址
    println!("will create wallet type is:{}",wallet_type);

    let seed = wallet_crypto::Sr25519::seed_from_phrase(&phrase, None);
    let pair =wallet_crypto::Sr25519::pair_from_seed(&seed);
    let address = wallet_crypto::Sr25519::ss58_from_pair(&pair);
    let puk_key = wallet_crypto::Sr25519::public_from_pair(&pair);
    Address {
        chain_type: ChainType::EEE,
        pubkey: hex::encode(puk_key),
        addr: address,
    }
}

pub fn crate_mnemonic(num: u8) -> Mnemonic{
    let mnemonic = wallet_crypto::Sr25519::generate_phrase(num);
    let mut kecck = tiny_keccak::Keccak::new_keccak256();
    let mut mnemonic_id_first = [0u8; 32];
    kecck.update(mnemonic.as_bytes());
    kecck.finalize(&mut mnemonic_id_first);
    //针对助记词id 做两次hash
    let mut kecck = tiny_keccak::Keccak::new_keccak256();
    let mut mnemonic_id = [0u8; 32];
    kecck.update(&mnemonic_id_first);
    kecck.finalize(&mut mnemonic_id);

    Mnemonic {
        status: StatusCode::OK,
        mn: mnemonic.as_bytes().to_vec(),
        mnid: hex::encode(mnemonic_id),
    }
}

//pub fn save_mnemonic(wallet_name: &str, mn: &[u8], password: &[u8]) -> Result<Wallet, String> {
pub fn create_wallet(wallet_name: &str, mn: &[u8], password: &[u8],wallet_type:i64) -> Result<Wallet, String> {

    //获取助记词对应链的地址、公钥
    let address = address_from_mnemonic(mn,wallet_type);

    let mut mnd_digest = [0u8; 32];
    {
        let mut keccak = tiny_keccak::Keccak::new_keccak256();
        keccak.update(mn);
        keccak.finalize(&mut mnd_digest);
    }
    let hex_mnd_digest = hex::encode(mnd_digest);
    let instance = wallet_db::db_helper::DataServiceProvider::instance();
    let mut dbhelper=  match instance {
        Ok(dbhelper)=>dbhelper,
        Err(e)=> return Err(e)
    };

    if wallet_type==1 {
        if dbhelper.query_by_wallet_digest(hex_mnd_digest.as_str()).is_some(){
            let msg = format!("this wallet is exist");
            return Err(msg)
        }
    }

    let keystore = wallet_crypto::Sr25519::encrypt_mnemonic(mn, password);

    println!("key store detail is:{}", keystore);


    let wallet_id = Uuid::new_v4().to_string();
    //用于存放构造完成的地址对象
    let mut address_vec = vec![];
    //需要根据链 构造不同的地址
    let address_save = TbAddress {
        address_id: Uuid::new_v4().to_string(),
        wallet_id: wallet_id.clone(),
        chain_id: address.chain_type as i16,
        address: address.addr,
        pub_key: address.pubkey,
        status: 1,
        ..Default::default()
    };

    address_vec.push(address_save);

    let wallet_save = model::wallet_store::TbWallet {
        wallet_id: wallet_id.clone(),
        mn_digest:hex_mnd_digest,
        full_name: Some(wallet_name.to_string()),
        mnemonic: keystore,
        wallet_type,
        ..Default::default()
    };

    //构造助记词保存结构
    // 开启事务
    //保存助记词到数据库
    //保存公钥，地址到数据库
    //关闭事务

    match dbhelper.save_wallet_address(wallet_save, address_vec) {
        Ok(_) => {
            //在保存成功后，需要将钱包数据返回回去
            Ok(Wallet {
                status: StatusCode::OK,
                wallet_id: wallet_id,
                wallet_type:wallet_type,
                wallet_name: Some(wallet_name.to_string()),
                ..Default::default()
            })
        }
        Err(e) => {
            Err(e.to_string())
        }
    }
}

fn mnemonic_psd_update(wallet: &TbWallet, old_psd: &[u8], new_psd: &[u8]) -> Result<StatusCode,String> {
    //获取原来的助记词
    let mnemonic = wallet.mnemonic.clone();
    let context = wallet_crypto::Sr25519::get_mnemonic_context(mnemonic.as_str(), old_psd);
    match context {
        Ok(data) => {
            //使用新的密码进行加密
            let new_encrypt_mn = wallet_crypto::Sr25519::encrypt_mnemonic(&data[..], new_psd);
            let instance = wallet_db::db_helper::DataServiceProvider::instance().unwrap();
            //构造需要升级的助记词对象，先只修改指定的字段，后续再根据需求完善
            let wallet_update = TbWallet {
                wallet_id: wallet.wallet_id.clone(),
                full_name: wallet.full_name.clone(),
                mnemonic: new_encrypt_mn,
                ..Default::default()
            };
            match instance.update_wallet(wallet_update) {
                Ok(_) => {
                    Ok(StatusCode::OK)
                }
                Err(msg) => {
                    error!("update error,{}:", msg);
                    Err(msg)
                }
            }
        }
        Err(msg) => {
            error!("update error,{}:", msg);
            Err(msg)
        }
    }
}

pub fn reset_mnemonic_pwd(mn_id: &str, old_pwd: &[u8], new_pwd: &[u8]) -> Result<StatusCode,String>{
    // TODO 检查密码规则是否满足要求
    // TODO 处理实例获取失败的异常
    let provider = wallet_db::db_helper::DataServiceProvider::instance().unwrap();
    //查询出对应id的助记词
    let mnemonic = provider.query_by_wallet_id(mn_id);
    match mnemonic {
        Some(mn) => {
           match mnemonic_psd_update(&mn, old_pwd, new_pwd){
               Ok(_)=>Ok(StatusCode::OK),
               Err(msg)=>Err(msg),
           }
        }
        None => {
            //针对错误信息 是否提示更多原因？
           let msg = format!("wallet {} is not exist",mn_id);
            Err(msg)
        }
    }
}
