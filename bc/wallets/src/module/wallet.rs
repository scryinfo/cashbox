use super::*;

use crate::{StatusCode, wallet_db};
use super::model::{TbAddress,Address, Wallet, Mnemonic};
use std::collections::HashMap;
use uuid::Uuid;
use crate::model::wallet_store::TbWallet;
use codec::{Encode, Decode};
use ethereum_types::H256;
use secp256k1::{
    Secp256k1,
    key::{PublicKey, SecretKey},
};

use substratetx::Crypto;
use substratetx::Keccak256;

/// Wallet 结构说明：
///  一个助记词 对应的是一个钱包，在cashbox钱包软件中 可以同时管理多个钱包；
/// 一个助记词 可以同时应用于多条链；
///  一条链，在基于链的应用上，存在多个合约地址的可能

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
pub fn get_all_wallet() -> Result<Vec<Wallet>, WalletError> {
    let wallet_info_map = get_wallet_info();

    let eee_data = chain::get_eee_chain_data()?;
    let eth_data = chain::get_eth_chain_data()?;
    let btc_data = chain::get_btc_chain_data()?;
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
        Err(e) => Err(e.to_string())
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

pub fn del_wallet(walletid: &str, psd: &[u8]) -> Result<bool, WalletError> {
    let provider = wallet_db::db_helper::DataServiceProvider::instance()?;
    //查询出对应id的助记词
    match provider.query_by_wallet_id(walletid) {
        Some(mn) => {
            match substratetx::Sr25519::get_mnemonic_context(mn.mnemonic.as_str(), psd) {
                Ok(_) => {
                    //密码验证通过
                    match provider.del_mnemonic(walletid) {
                        Ok(_) => Ok(true),
                        Err(msg) => Err(msg),
                    }
                }
                Err(msg) => Err(msg.into()),
            }
        }
        None => {
            let msg = format!("wallet {} not found", walletid);
            Err(WalletError::Custom(msg))
        }
    }
}

pub fn rename_wallet(walletid: &str, wallet_name: &str) -> Result<bool, WalletError> {
    let instance = wallet_db::db_helper::DataServiceProvider::instance()?;
    instance.rename_mnemonic(walletid, wallet_name).map(|_| true)
}

//根据生成钱包的类型，需要创建对应的地址
pub fn address_from_mnemonic(mn: &[u8], wallet_type: ChainType) -> Result<Address, WalletError> {
    let phrase = String::from_utf8(mn.to_vec())?;
    // TODO 这个地方 根据支持链的种类 分别生成对应的地址
    match wallet_type {
        ChainType::EEE | ChainType::EeeTest => {
            let seed = substratetx::Sr25519::seed_from_phrase(&phrase, None).unwrap();
            let pair = substratetx::Sr25519::pair_from_seed(&seed);
            let address = substratetx::Sr25519::ss58_from_pair(&pair);
            let puk_key = substratetx::Sr25519::public_from_pair(&pair);
            let address = Address {
                chain_type: wallet_type,
                pubkey: hex::encode(puk_key),
                addr: address,
            };
            Ok(address)
        }
        ChainType::ETH | ChainType::EthTest => {
            //todo 错误处理
            let secret_byte = ethtx::pri_from_mnemonic(&phrase, None)?;
            let context = Secp256k1::new();
            let secret = SecretKey::from_slice(&secret_byte)?;
            let public_key = PublicKey::from_secret_key(&context, &secret);
            //一个是非压缩公钥 用于地址生成
            let puk_uncompressed = &public_key.serialize_uncompressed()[..];
            let address_final = generate_eth_address(&puk_uncompressed[1..]);
            let puk_compressed = hex::encode(&public_key.serialize()[..]);
            let address = Address {
                chain_type: wallet_type,
                pubkey: puk_compressed,
                addr: address_final,
            };
            Ok(address)
        }
        _ => Err(WalletError::Custom(String::from("default not impl!"))),
    }
}

//从非压缩公钥生成ETH地址
fn generate_eth_address(puk_byte: &[u8]) -> String {
    let public_key_hash = puk_byte.keccak256();
    let address_str = hex::encode(&public_key_hash[12..]);
    let address = format!("0x{}", address_str);
    address
}

pub fn find_keystore_wallet_from_address(address: &str, chain_type: ChainType) -> Result<String, WalletError> {
    let instance = wallet_db::db_helper::DataServiceProvider::instance()?;
    instance.get_wallet_by_address(address, chain_type).map(|tbwallet| tbwallet.mnemonic)
}

pub fn crate_mnemonic(num: u8) -> Mnemonic {
    let mnemonic = substratetx::Sr25519::generate_phrase(num);
    let mn_id_hash = mnemonic.as_bytes().keccak256();
    let mnemonic_id = mn_id_hash.keccak256();
    Mnemonic {
        status: StatusCode::OK,
        mn: mnemonic.as_bytes().to_vec(),
        mnid: hex::encode(mnemonic_id),
    }
}

pub fn export_mnemonic(wallet_id: &str, password: &[u8]) -> Result<Mnemonic, WalletError> {
    let provider = wallet_db::db_helper::DataServiceProvider::instance()?;
    //查询出对应id的助记词
    match provider.query_by_wallet_id(wallet_id) {
        Some(mn) => {
            substratetx::Sr25519::get_mnemonic_context(mn.mnemonic.as_str(), password).map(|mnemonic| Mnemonic {
                status: StatusCode::OK,
                mn: mnemonic,
                mnid: String::from(wallet_id),
            }).map_err(|e|e.into())
        }
        None => {
            let msg = format!("wallet {} not found", wallet_id);
            Err(WalletError::Custom(msg))
        }
    }
}

fn generate_chain_address(wallet_id: &str, mn: &[u8], wallet_type: i64) -> Result<Vec<TbAddress>,WalletError> {
    //获取当前钱包哪些链可用
    let instance = wallet_db::db_helper::DataServiceProvider::instance()?;
    let chains = instance.get_available_chain()?;//错误处理demo
    let mut address_vec = vec![];
    for chain in chains {
        let chian_type = ChainType::from(chain);
        let address = match chian_type {
            ChainType::ETH | ChainType::EEE => {
                if wallet_type == 0 {
                    continue;
                }
                address_from_mnemonic(mn, chian_type)?
            }
            ChainType::EthTest | ChainType::EeeTest => {
                if wallet_type == 1 {
                    continue;
                }
                address_from_mnemonic(mn, chian_type)?
            }
            _ => unimplemented!()
        };
        let address_temp = TbAddress {
            address_id: Uuid::new_v4().to_string(),
            wallet_id: wallet_id.to_string(),
            chain_id: address.chain_type as i16,
            address: address.addr,
            pub_key: address.pubkey,
            status: 1,
            ..Default::default()
        };
        address_vec.push(address_temp);
    }
    Ok(address_vec)
}

pub fn create_wallet(wallet_name: &str, mn: &[u8], password: &[u8], wallet_type: i64) -> Result<Wallet, WalletError> {
    let default_chain_type = if wallet_type == 1 {
        ChainType::ETH
    } else {
        ChainType::EthTest
    };

    //todo 数据库实例优化
    let mut dbhelper = wallet_db::db_helper::DataServiceProvider::instance()?;
    //正式链，助记词只能导入一次
    let hex_mn_digest = hex::encode(mn.keccak256());
    if wallet_type == 1 {
        if dbhelper.query_by_wallet_digest(hex_mn_digest.as_str(),wallet_type).is_some() {
            let msg = format!("this wallet is exist");
            return Err(WalletError::Custom(msg));
        }
    }

    let keystore = substratetx::Sr25519::encrypt_mnemonic(mn, password);
    let wallet_id = Uuid::new_v4().to_string();
    let address: Vec<TbAddress> = generate_chain_address(&wallet_id, mn, wallet_type)?;

    let wallet_save = model::wallet_store::TbWallet {
        wallet_id: wallet_id.clone(),
        mn_digest: hex_mn_digest,
        full_name: Some(wallet_name.to_string()),
        mnemonic: keystore,
        display_chain_id: default_chain_type.clone() as i64,//设置默认显示链类型
        wallet_type,
        ..Default::default()
    };
    //构造助记词保存结构
    // 开启事务
    //保存助记词到数据库
    //保存公钥，地址到数据库
    //关闭事务
    dbhelper.save_wallet_address(wallet_save, address)
        .map(|_| Wallet {
            status: StatusCode::OK,
            wallet_id,
            wallet_type,
            wallet_name: Some(wallet_name.to_string()),
            display_chain_id: default_chain_type as i64,//设置默认显示链类型
            ..Default::default()
        })
}

fn mnemonic_psd_update(wallet: &TbWallet, old_psd: &[u8], new_psd: &[u8]) -> Result<StatusCode, WalletError> {
    //获取原来的助记词
    let mnemonic = wallet.mnemonic.clone();
    let context = substratetx::Sr25519::get_mnemonic_context(mnemonic.as_str(), old_psd)?;
    //使用新的密码进行加密
    let new_encrypt_mn = substratetx::Sr25519::encrypt_mnemonic(&context[..], new_psd);

    //构造需要升级的助记词对象，先只修改指定的字段，后续再根据需求完善
    let wallet_update = TbWallet {
        wallet_id: wallet.wallet_id.clone(),
        full_name: wallet.full_name.clone(),
        mnemonic: new_encrypt_mn,
        ..Default::default()
    };
    let instance = wallet_db::db_helper::DataServiceProvider::instance()?;
    instance.update_wallet(wallet_update).map(|_| StatusCode::OK).map_err(|err| err.into())
}

pub fn reset_mnemonic_pwd(mn_id: &str, old_pwd: &[u8], new_pwd: &[u8]) -> Result<StatusCode, WalletError> {
    // TODO 检查密码规则是否满足要求
    // TODO 处理实例获取失败的异常
    let provider = wallet_db::db_helper::DataServiceProvider::instance()?;
    //查询出对应id的助记词
    let mnemonic = provider.query_by_wallet_id(mn_id);
    match mnemonic {
        Some(mn) => {
            mnemonic_psd_update(&mn, old_pwd, new_pwd).map(|_| StatusCode::OK)
        }
        None => {
            //针对错误信息 是否提示更多原因？
            let msg = format!("wallet {} is not exist", mn_id);
            Err(WalletError::Custom(msg))
        }
    }
}

#[derive(Encode, Decode,Debug)]
struct RawTx {
    func_data: Vec<u8>,
    index: u32,
    genesis_hash: H256,
    version: u32,
}

pub fn raw_tx_sign(raw_tx: &str, wallet_id: &str, psw: &[u8]) -> Result<String, WalletError> {
    //todo 交易构造接口重构
    let raw_tx = raw_tx.get(2..).unwrap();// remove `0x`
    let  tx_encode_data = hex::decode(raw_tx)?;
    // TODO 这个地方需要使用大小端编码？
    let tx = RawTx::decode(&mut &tx_encode_data[..]).expect("tx format");
    let mnemonic = module::wallet::export_mnemonic(wallet_id, psw);
    match mnemonic {
        Ok(mnemonic) => {
            let mn = String::from_utf8(mnemonic.mn)?;
            let mut_data = &mut &tx_encode_data[0..tx_encode_data.len() - 40];//这个地方直接使用 tx.func_data 会引起错误，会把首字节的数据漏掉，
          // let mut_data = &tx.func_data[..];//这个地方直接使用 tx.func_data 会引起错误，会把首字节的数据漏掉，
            /*let extrinsic = node_runtime::UncheckedExtrinsic::decode(&mut &mut_data[..])?;
            let sign_data = substratetx::tx_sign(&mn, tx.genesis_hash, tx.index, extrinsic.function,tx.version)?;*/
            let sign_data = substratetx::tx_sign(&mn, tx.genesis_hash, tx.index,mut_data,tx.version)?;
            // TODO 返回签名后的消息格式需要确定
            Ok(sign_data)
        }
        Err(info) => Err(info)
    }
}

//用于针对普通数据签名 传入的数据 hex格式数据
pub fn raw_sign(raw_data: &str, wallet_id: &str, psw: &[u8]) -> Result<String, WalletError> {
    let raw_data = raw_data.get(2..).unwrap();// remove `0x`
    let tx_encode_data = hex::decode(raw_data)?;
    // TODO 这个地方需要使用大小端编码？
    let mnemonic = module::wallet::export_mnemonic(wallet_id, psw);
    match mnemonic {
        Ok(mnemonic) => {
            let mn = String::from_utf8(mnemonic.mn)?;
            let sign_data = substratetx::Sr25519::sign(&mn, &tx_encode_data[..]).unwrap();
            // TODO 返回签名后的消息格式需要确定
            let hex_data = format!("0x{}", hex::encode(&sign_data[..]));
            Ok(hex_data)
        }
        Err(info) => Err(info)
    }
}

//todo 增加通过钱包id查询钱包的实现



