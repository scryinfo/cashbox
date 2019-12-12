use super::*;
use log::error;

use crate::{StatusCode, wallet_db};
use crate::model::Address;
use super::model::{TbAddress, Wallet, Mnemonic};
use std::collections::HashMap;
use crate::wallet_crypto::Crypto;
use uuid::Uuid;
use crate::model::wallet_store::TbWallet;
use codec::{Encode,Decode};
use sp_core::H256;
//use node_runtime::Call;

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
            wallet_type: item.wallet_type,
            selected: item.selected.unwrap(),
            display_chain_id: item.display_chain_id,
            create_time: item.create_time,
            ..Default::default()
        };
        wallet_map.insert(item.wallet_id, wallet);
    }
    wallet_map
}


//query all 满足条件的助记词（wallet）
pub fn get_all_wallet() -> Result<Vec<Wallet>, String> {
    let wallet_info_map = get_wallet_info();

    let eee_data = chain::get_eee_chain_data().expect("get eee data");
    let eth_data = chain::get_eth_chain_data().expect("get eth data");
    let btc_data = chain::get_btc_chain_data().expect("get eth data");
    let mut target = vec![];

    for (wallet_id, wallet) in wallet_info_map {
        let wallet_obj = Wallet {
            status: wallet.status.clone(),
            wallet_id: wallet_id.clone(),
            wallet_name: wallet.wallet_name.clone(),
            wallet_type: wallet.wallet_type.clone(),
            display_chain_id: wallet.display_chain_id,
            selected: wallet.selected,
            create_time: wallet.create_time,
            eee_chain: {
                let eee_option = eee_data.get(wallet_id.as_str());
                if eee_option.is_some() {
                    let eee_chain = eee_option.unwrap()[0].clone();
                    Some(eee_chain)
                } else {
                    None
                }
            },
            eth_chain: {
                let eth_option = eth_data.get(wallet_id.as_str());
                if eth_option.is_some() {
                    let eth_chain = eth_option.unwrap()[0].clone();
                    Some(eth_chain)
                } else {
                    None
                }
            },
            btc_chain: {
                let btc_option = btc_data.get(wallet_id.as_str());
                if btc_option.is_some() {
                    let btc_chain = btc_option.unwrap()[0].clone();
                    Some(btc_chain)
                } else {
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
        wallet_name: tb.full_name,
        status: StatusCode::OK,
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

pub fn del_wallet(walletid: &str, psd: &[u8]) -> Result<bool, String> {
    let provider = wallet_db::db_helper::DataServiceProvider::instance().unwrap();
    //查询出对应id的助记词
    match provider.query_by_wallet_id(walletid) {
        Some(mn) => {
            match wallet_crypto::Sr25519::get_mnemonic_context(mn.mnemonic.as_str(), psd) {
                Ok(_) => {
                    //密码验证通过
                    match provider.del_mnemonic(walletid) {
                        Ok(_) => Ok(true),
                        Err(msg) => Err(msg),
                    }
                }
                Err(msg) => Err(msg),
            }
        }
        None => {
            let msg = format!("wallet {} not found",walletid);
            Err(msg)
        }
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
fn address_from_mnemonic(mn: &[u8], wallet_type: i64) -> Address {
    let phrase = String::from_utf8(mn.to_vec()).expect("mn byte format convert to string is error!");
    // TODO 这个地方 根据支持链的种类 分别生成对应的地址
    let seed = wallet_crypto::Sr25519::seed_from_phrase(&phrase, None);
    let pair = wallet_crypto::Sr25519::pair_from_seed(&seed);
    let address = wallet_crypto::Sr25519::ss58_from_pair(&pair);
    let puk_key = wallet_crypto::Sr25519::public_from_pair(&pair);
    Address {
        chain_type: ChainType::EEE,
        pubkey: hex::encode(puk_key),
        addr: address,
    }
}

pub fn find_keystore_wallet_from_address(address:&str,chain_type:ChainType)-> Result<String,String>{
    let instance = wallet_db::db_helper::DataServiceProvider::instance().unwrap();
    let tbwallet = instance.get_wallet_by_address(address,chain_type);
   match tbwallet {
     Some(tbwallet) => {
         Ok(tbwallet.mnemonic)
        }
        None => {
            let msg = format!("keystore {} not found",address);
            Err(msg)
        }

   }
}

pub fn crate_mnemonic(num: u8) -> Mnemonic {
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



pub fn export_mnemonic(wallet_id:&str,password: &[u8]) -> Result<Mnemonic,String>{
    let provider = wallet_db::db_helper::DataServiceProvider::instance().unwrap();
    //查询出对应id的助记词
    match provider.query_by_wallet_id(wallet_id) {
        Some(mn) => {
            match wallet_crypto::Sr25519::get_mnemonic_context(mn.mnemonic.as_str(), password) {
                Ok(mnemonic) => {
                    //密码验证通过
                    let mn = Mnemonic {
                        status: StatusCode::OK,
                        mn: mnemonic,
                        mnid: String::from(wallet_id),
                    };
                    Ok(mn)
                }
                Err(msg) => Err(msg),
            }
        }
        None => {
            let msg = format!("wallet {} not found",wallet_id);
            Err(msg)
        }
    }
}



pub fn create_wallet(wallet_name: &str, mn: &[u8], password: &[u8], wallet_type: i64) -> Result<Wallet, String> {

    //获取助记词对应链的地址、公钥
    let address = address_from_mnemonic(mn, wallet_type);

    let mut mnd_digest = [0u8; 32];
    {
        let mut keccak = tiny_keccak::Keccak::new_keccak256();
        keccak.update(mn);
        keccak.finalize(&mut mnd_digest);
    }
    let hex_mnd_digest = hex::encode(mnd_digest);
    let instance = wallet_db::db_helper::DataServiceProvider::instance();
    let mut dbhelper = match instance {
        Ok(dbhelper) => dbhelper,
        Err(e) => return Err(e)
    };

    if wallet_type == 1 {
        if dbhelper.query_by_wallet_digest(hex_mnd_digest.as_str()).is_some() {
            let msg = format!("this wallet is exist");
            return Err(msg);
        }
    }

    let keystore = wallet_crypto::Sr25519::encrypt_mnemonic(mn, password);

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
        mn_digest: hex_mnd_digest,
        full_name: Some(wallet_name.to_string()),
        mnemonic: keystore,
        display_chain_id: ChainType::EEE as i64,
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
            let wallet = dbhelper.query_by_wallet_id(wallet_id.as_str()).unwrap();
            //在保存成功后，需要将钱包数据返回回去
            Ok(Wallet {
                status: StatusCode::OK,
                wallet_id: wallet.wallet_id,
                wallet_type: wallet.wallet_type,
                wallet_name: Some(wallet_name.to_string()),
                display_chain_id: wallet.display_chain_id,
                create_time: wallet.create_time,
                ..Default::default()
            })
        }
        Err(e) => {
            Err(e.to_string())
        }
    }
}

fn mnemonic_psd_update(wallet: &TbWallet, old_psd: &[u8], new_psd: &[u8]) -> Result<StatusCode, String> {
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

pub fn reset_mnemonic_pwd(mn_id: &str, old_pwd: &[u8], new_pwd: &[u8]) -> Result<StatusCode, String> {
    // TODO 检查密码规则是否满足要求
    // TODO 处理实例获取失败的异常
    let provider = wallet_db::db_helper::DataServiceProvider::instance().unwrap();
    //查询出对应id的助记词
    let mnemonic = provider.query_by_wallet_id(mn_id);
    match mnemonic {
        Some(mn) => {
            match mnemonic_psd_update(&mn, old_pwd, new_pwd) {
                Ok(_) => Ok(StatusCode::OK),
                Err(msg) => Err(msg),
            }
        }
        None => {
            //针对错误信息 是否提示更多原因？
            let msg = format!("wallet {} is not exist", mn_id);
            Err(msg)
        }
    }
}

#[derive(Encode, Decode)]
struct RawTx{
    func_data:Vec<u8>,
    index:u32,
    genesis_hash:H256,
    version:u32,
}

pub fn raw_tx_sign(raw_tx:&str,wallet_id:&str,psw:&[u8])->Result<String,String>{
    let raw_tx = raw_tx.get(2..).unwrap();// remove `0x`

    let tx_encode_data = hex::decode(raw_tx).unwrap();
    // TODO 这个地方需要使用大小端编码？
    let tx = RawTx::decode(&mut &tx_encode_data[..]).expect("tx format");

    let mnemonic = module::wallet::export_mnemonic(wallet_id,psw);
    match mnemonic {
        Ok(mnemonic)=>{
            let mn = String::from_utf8(mnemonic.mn).unwrap();
            let mut_data = &mut &tx_encode_data[0..tx_encode_data.len()-40];
            let extrinsic = node_runtime::UncheckedExtrinsic::decode(mut_data).unwrap();
            let sign_data = wallet_rpc::tx_sign(&mn,tx.genesis_hash,tx.index,extrinsic.function);
            // TODO 返回签名后的消息格式需要确定
           // Ok(hex::encode(&sign_data[..]))
            Ok(sign_data)
        },
        Err(info)=>Err(info)
    }
}
//用于针对普通数据签名 传入的数据 hex格式数据
pub fn raw_sign(raw_data:&str,wallet_id:&str,psw:&[u8])->Result<String,String> {
    let raw_data = raw_data.get(2..).unwrap();// remove `0x`
    let tx_encode_data = hex::decode(raw_data).unwrap();
    // TODO 这个地方需要使用大小端编码？
    let mnemonic = module::wallet::export_mnemonic(wallet_id, psw);
    match mnemonic {
        Ok(mnemonic) => {
            let mn = String::from_utf8(mnemonic.mn).unwrap();
            let sign_data = wallet_crypto::Sr25519::sign(&mn, &tx_encode_data[..]);
            // TODO 返回签名后的消息格式需要确定
            let hex_data =  format!("0x{}",hex::encode(&sign_data[..]));
            Ok(hex_data)
        },
        Err(info) => Err(info)
    }
}



