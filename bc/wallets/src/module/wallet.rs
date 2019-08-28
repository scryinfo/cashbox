use super::*;
use log::error;

use crate::{StatusCode, wallet_db};
use crate::model::Address;
use crate::wallet_crypto::{Crypto, Sr25519};
use super::model::{EeeChain, EeeDigit, TbWallet, TbMnemonic, TbAddress, Wallet, Mnemonic};


/**
  Wallet 结构说明：
    一个助记词 对应的是一个钱包，在cashbox钱包软件中 可以同时管理多个钱包；
    一个助记词 可以同时应用于多条链；
    一条链，在基于链的应用上，存在多个合约地址的可能
*/
fn tbwallet_convert_to_wallet(tbwallets: Vec<TbWallet>) -> Vec<Wallet> {
    let mut ret_data = Vec::new();

    let mut last_wallet_id = String::from("-1");
    let mut last_chain_id = String::new();
    let mut wallet_index = 0;
    let mut chain_index = 0;
    //使用这种查询数据遍历方式 是依赖于查询出来的数据结构，数据库在做多表的级联时，会按照表的顺序来进行连接，
    // 若要是在查询的时候 使用了某种字段排序，会将此结构打乱，后期可以考虑优化为使用MAP的方式来避免这个问题
    for tbwallet in tbwallets {
        let wallet_id = tbwallet.wallet_id.unwrap();
        let chain_id = format!("{}", tbwallet.chain_id.unwrap());//chain id 不会存在为Null的情况
        println!("tbwallet_convert_to_wallet wallet name:{:?}", tbwallet.wallet_name);
        if last_wallet_id.ne(&wallet_id) {
            let wallet = Wallet {
                status: StatusCode::OK,
                wallet_id: wallet_id.clone(),
                wallet_name: tbwallet.wallet_name.clone(),
                eee_chain: Vec::new(),
                eth_chain: Vec::new(),
                btc_chain: Vec::new(),
            };
            //使用last_wallet_id 标识上一个钱包id,当钱包发生变化的时候，表示当前迭代的数据是新钱包 需要更新wallet_index，标识当前处理的是哪个钱包
            if last_wallet_id.ne("-1") {
                //更新下一次需要
                wallet_index = wallet_index + 1;
            }
            last_wallet_id = wallet_id.clone();

            //开始新的钱包，记录链的标识需要重新开始计算
            last_chain_id = String::new();

            ret_data.push(wallet);
        }

        if last_chain_id.ne(&chain_id) {
            //这个地方需要重新来处理链的关系
            let chain = EeeChain {
                status: StatusCode::OK,
                chain_id: chain_id.clone(),
                wallet_id: wallet_id,
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
            //获取当前的钱包序号
            let wallet = ret_data.get_mut(wallet_index).unwrap();

            last_chain_id = chain_id.clone();

            wallet.eee_chain.push(chain);
            chain_index = 0;
        }
        let digit_id = format!("{}", tbwallet.digit_id.unwrap());
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
        let wallet = ret_data.get_mut(wallet_index).unwrap();
        let chain_list = wallet.eee_chain.get_mut(chain_index).unwrap();
        chain_list.digit_list.push(digit);
        chain_index = chain_index + 1;
    }
    ret_data
}

//query all 满足条件的助记词（wallet）
pub fn get_all_wallet() -> Result<Vec<Wallet>, String> {
    match wallet_db::db_helper::DataServiceProvider::instance() {
        Ok(provider) => {
            let wallet = provider.display_mnemonic_list();
            match wallet {
                Ok(data) => {
                    let data = tbwallet_convert_to_wallet(data);
                    Ok(data)
                }
                Err(e) => Err(e),
            }
        }
        Err(e) => Err(e)
    }
}

pub fn is_contain_wallet() -> Result<Vec<TbMnemonic>, String> {
    match wallet_db::db_helper::DataServiceProvider::instance() {
        Ok(provider) => {
            Ok(provider.get_mnemonics())
        }
        Err(e) => Err(e)
    }
}

pub fn get_current_wallet() -> Result<Mnemonic, String> {
    let instance = wallet_db::db_helper::DataServiceProvider::instance().unwrap();
    instance.query_selected_mnemonic().map(|tb| Mnemonic {
        mnid: tb.id.unwrap(),
        status: StatusCode::OK,
        mn: vec![],
    }).map_err(|msg| msg)
}

pub fn set_current_wallet(walletid: &str) -> Result<bool, String> {
    let instance = wallet_db::db_helper::DataServiceProvider::instance().unwrap();
    match instance.set_selected_mnemonic(walletid) {
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


fn address_from_mnemonic<T>(mn: &[u8]) -> Address where T: Crypto {
    let phrase = String::from_utf8(mn.to_vec()).expect("mn byte format convert to string is error!");
    let seed = T::seed_from_phrase(&phrase, None);
    let pair = T::pair_from_seed(&seed);
    let address = T::ss58_from_pair(&pair);
    let puk_key = T::public_from_pair(&pair);
    Address {
        chain_type: ChainType::EEE,
        pubkey: hex::encode(puk_key),
        addr: address,
    }
}

pub fn crate_mnemonic<T>(num: u8) -> Mnemonic where T: Crypto {
    let mnemonic = T::generate_phrase(num);
    let mut kecck = tiny_keccak::Keccak::new_keccak256();
    kecck.update(mnemonic.as_bytes());
    let mut mnemonic_id = [0u8; 32];
    kecck.finalize(&mut mnemonic_id);
    Mnemonic {
        status: StatusCode::OK,
        mn: mnemonic.as_bytes().to_vec(),
        mnid: hex::encode(mnemonic_id),
    }
}

pub fn save_mnemonic<T>(wallet_name: &str, mn: &[u8], password: &[u8]) -> Result<Wallet, String> where T: Crypto {

    //获取助记词对应链的地址、公钥
    let address = address_from_mnemonic::<Sr25519>(mn);

    let mut mnemonic_id = [0u8; 32];
    {
        let mut keccak = tiny_keccak::Keccak::new_keccak256();
        keccak.update(mn);
        keccak.finalize(&mut mnemonic_id);
    }

    let keystore = T::encrypt_mnemonic(mn, password);

    println!("key store detail is:{}", keystore);
    let hex_mnemonic_id = hex::encode(mnemonic_id);
    let address_save = TbAddress {
        id: 0,
        mnemonic_id: hex_mnemonic_id.clone(),
        chain_id: address.chain_type as i16,
        address: address.addr,
        pub_key: address.pubkey,
        status: 1,
        ..Default::default()
    };
    let mnemonic_save = model::wallet_store::TbMnemonic {
        id: Some(hex_mnemonic_id.clone()),
        full_name: Some(wallet_name.to_string()),
        mnemonic: Some(keystore),
        ..Default::default()
    };

    //构造助记词保存结构
    // 开启事务
    //保存助记词到数据库
    //保存公钥，地址到数据库
    //关闭事务
    let instance = wallet_db::db_helper::DataServiceProvider::instance();
    match instance {
        Ok(mut dataservice) => {
            match dataservice.save_mnemonic_address(mnemonic_save, address_save) {
                Ok(_) => {
                    Ok(Wallet {
                        status: StatusCode::OK,
                        wallet_id: hex_mnemonic_id,
                        wallet_name: Some(wallet_name.to_string()),
                        eee_chain: vec![],
                        eth_chain: vec![],
                        btc_chain: vec![],
                    })
                }
                Err(e) => {
                    Err(e.to_string())
                }
            }
        }
        Err(e) => {
            Err(e)
        }
    }
}


fn mnemonic_psd_update<T>(mn: &TbMnemonic, old_psd: &[u8], new_psd: &[u8]) -> StatusCode where T: Crypto {
    //获取原来的助记词
    let mnemonic = mn.mnemonic.clone().unwrap();
    let context = T::get_mnemonic_context(mnemonic.as_str(), old_psd);
    match context {
        Ok(data) => {
            //使用新的密码进行加密
            let new_encrypt_mn = T::encrypt_mnemonic(&data[..], new_psd);
            let instance = wallet_db::db_helper::DataServiceProvider::instance().unwrap();
            //构造需要升级的助记词对象，先只修改指定的字段，后续再根据需求完善
            let mnemonic_update = TbMnemonic {
                id: mn.id.clone(),
                full_name: None,
                mnemonic: Some(new_encrypt_mn),
                ..Default::default()
            };
            match instance.update_mnemonic(mnemonic_update) {
                Ok(_) => {
                    StatusCode::OK
                }
                Err(msg) => {
                    error!("update error,{}:", msg);
                    StatusCode::FailToRestPwd
                }
            }
        }
        Err(msg) => {
            error!("update error,{}:", msg);
            StatusCode::FailToRestPwd
        }
    }
}

pub fn reset_mnemonic_pwd<T>(mn_id: &str, old_pwd: &[u8], new_pwd: &[u8]) -> StatusCode where T: Crypto {
    // TODO 检查密码规则是否满足要求
    // TODO 处理实例获取失败的异常
    let provider = wallet_db::db_helper::DataServiceProvider::instance().unwrap();
    //查询出对应id的助记词
    let mnemonic = provider.query_by_mnemonic_id(mn_id);
    match mnemonic {
        Some(mn) => {
            mnemonic_psd_update::<T>(&mn, old_pwd, new_pwd)
            //开始处理助记词逻辑
        }
        None => {
            //针对错误信息 是否提示更多原因？
            StatusCode::FailToRestPwd
        }
    }
}
