use super::*;
use std::collections::HashMap;

use uuid::Uuid;

use substratetx::{Crypto, Keccak256};
use model::{wallet_store::TbWallet, TbAddress, Address, Wallet, Mnemonic};

pub struct WalletManager;

impl WalletManager {
    pub fn get_all(&self) -> WalletResult<Vec<Wallet>> {
        let wallet_info_map = self.get_wallet_info();
        let eee_obj = chain::EEE {};
        let eee_data = eee_obj.get_chain_data()?;
        let eth_obj = chain::Ethereum {};
        let eth_data = eth_obj.get_chain_data()?;
        let btc_obj = chain::Bitcoin {};
        let btc_data = btc_obj.get_chain_data()?;
        let mut target = vec![];

        for (wallet_id, wallet) in wallet_info_map {
            let wallet_obj = Wallet {
                status: wallet.status.clone(),
                wallet_id: wallet_id.clone(),
                wallet_name: wallet.wallet_name.clone(),
                wallet_type: wallet.wallet_type,
                display_chain_id: wallet.display_chain_id,
                selected: wallet.selected,
                create_time: wallet.create_time,
                eee_chain: eee_data.get(&wallet_id).map(|data| data[0].clone()),//当出现Some这种情况，表示肯定存在值且vec len 不为0
                eth_chain: eth_data.get(&wallet_id).map(|data| data[0].clone()),
                btc_chain: btc_data.get(&wallet_id).map(|data| data[0].clone()),
            };
            target.push(wallet_obj);
        }
        Ok(target)
    }

    pub fn crate_mnemonic(&self, num: u8) -> Mnemonic {
        let mnemonic = substratetx::Sr25519::generate_phrase(num);
        Mnemonic {
            status: StatusCode::OK,
            mn: mnemonic.as_bytes().to_vec(),
            mnid: "".into(),
        }
    }

    pub fn reset_mnemonic_pwd(&self, wallet_id: &str, old_pwd: &[u8], new_pwd: &[u8]) -> WalletResult<StatusCode> {
        let provider = wallet_db::DataServiceProvider::instance()?;
        //查询出对应id的助记词
        if let Some(mn) = provider.query_by_wallet_id(wallet_id) {
            self.mnemonic_psd_update(&mn, old_pwd, new_pwd).map(|_| StatusCode::OK)
        } else {
            let msg = format!("wallet {} is not exist", wallet_id);
            Err(WalletError::Custom(msg))
        }
    }

    pub fn is_contain_wallet(&self) -> Result<Vec<TbWallet>, String> {
        match wallet_db::DataServiceProvider::instance() {
            Ok(provider) => {
                Ok(provider.get_wallets())
            }
            Err(e) => Err(e.to_string())
        }
    }

    pub fn get_current_wallet(&self) -> WalletResult<Wallet> {
        let instance = wallet_db::DataServiceProvider::instance()?;
        instance.query_selected_wallet().map(|tb| Wallet {
            wallet_id: tb.wallet_id,
            wallet_name: tb.full_name,
            status: StatusCode::OK,
            ..Default::default()
        }).map_err(|msg| msg)
    }

    pub fn set_current_wallet(&self, walletid: &str) -> WalletResult<()> {
        let instance = wallet_db::DataServiceProvider::instance()?;
        instance.tx_begin()?;
        instance.set_selected_wallet(walletid)
            .and_then(|_| instance.tx_commint())
            .map_err(|error| {
                if let Err(rollback_err) = instance.tx_rollback() {
                    log::error!("rollback error:{}",rollback_err.to_string());
                }
                error
            })
    }

    pub fn del_wallet(&self, walletid: &str, psd: &[u8]) -> WalletResult<()> {
        let provider = wallet_db::DataServiceProvider::instance()?;
        //查询出对应id的助记词
        provider.query_by_wallet_id(walletid).ok_or_else(|| WalletError::NotExist)
            .and_then(|mn| substratetx::Sr25519::get_mnemonic_context(mn.mnemonic.as_str(), psd).map_err(|e| e.into()))
            .and_then(|_data| provider.tx_begin())
            .and_then(|()| {
                provider.del_mnemonic(walletid)
            })
            .and_then(|_| provider.tx_commint())
            .map_err(|err| {
                let _ = provider.tx_rollback();
                //返回以上任意一个链式调用发生的错误
                err
            })
    }

    pub fn rename_wallet(&self, walletid: &str, wallet_name: &str) -> WalletResult<bool> {
        let instance = wallet_db::DataServiceProvider::instance()?;
        instance.rename_mnemonic(walletid, wallet_name).map(|_| true)
    }
    pub fn create_wallet(&self, wallet_name: &str, mn: &[u8], password: &[u8], wallet_type: i64) -> WalletResult<Wallet> {
        //指定默认链类型
        let default_chain_type = if wallet_type == 1 {
            ChainType::ETH
        } else {
            ChainType::EthTest
        };

        let mut dbhelper = wallet_db::DataServiceProvider::instance()?;
        let hex_mn_digest = {
            let hash_first = mn.keccak256();
            hex::encode((&hash_first[..]).keccak256())
        };
        //正式链，助记词只能导入一次,通过hash是否存在判断是否导入
        if wallet_type == 1 && dbhelper.query_by_wallet_digest(hex_mn_digest.as_str(), wallet_type).is_some() {
            return Err(WalletError::Custom("this wallet is exist".to_string()));
        }

        let keystore = substratetx::Sr25519::encrypt_mnemonic(mn, password);
        let wallet_id = Uuid::new_v4().to_string();
        let address: Vec<TbAddress> = self.generate_address(&wallet_id, mn, wallet_type)?;

        //构造钱包保存结构
        let wallet_save = model::wallet_store::TbWallet {
            wallet_id: wallet_id.clone(),
            mn_digest: hex_mn_digest,
            full_name: Some(wallet_name.to_string()),
            mnemonic: keystore,
            display_chain_id: default_chain_type.clone() as i64,//设置默认显示链类型
            wallet_type,
            ..Default::default()
        };

        // 开启事务
        dbhelper.tx_begin()?;
        //保存钱包信息到数据库
        dbhelper.save_wallet_address(wallet_save, address)
            .map(|_| dbhelper.tx_commint()) //提交事务
            .map(|_| {
                Wallet {
                    status: StatusCode::OK,
                    wallet_id,
                    wallet_type,
                    wallet_name: Some(wallet_name.to_string()),
                    display_chain_id: default_chain_type as i64,//设置默认显示链类型
                    ..Default::default()
                }
            }).map_err(|err| {
            let _ = dbhelper.tx_rollback();
            err
        })
    }
    pub fn export_mnemonic(&self, wallet_id: &str, password: &[u8]) -> WalletResult<Mnemonic> {
        let provider = wallet_db::DataServiceProvider::instance()?;
        //查询出对应id的助记词
        match provider.query_by_wallet_id(wallet_id) {
            Some(mn) => {
                substratetx::Sr25519::get_mnemonic_context(mn.mnemonic.as_str(), password).map(|mnemonic| Mnemonic {
                    status: StatusCode::OK,
                    mn: mnemonic,
                    mnid: String::from(wallet_id),
                }).map_err(|e| e.into())
            }
            None => {
                let msg = format!("wallet {} not found", wallet_id);
                Err(WalletError::Custom(msg))
            }
        }
    }
    fn mnemonic_psd_update(&self, wallet: &TbWallet, old_psd: &[u8], new_psd: &[u8]) -> WalletResult<StatusCode> {
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
        let instance = wallet_db::DataServiceProvider::instance()?;
        instance.update_wallet(wallet_update).map(|_| StatusCode::OK).map_err(|err| err)
    }

    fn generate_address(&self, wallet_id: &str, mn: &[u8], wallet_type: i64) -> WalletResult<Vec<TbAddress>> {
        //获取当前钱包哪些链可用
        let instance = wallet_db::DataServiceProvider::instance()?;
        let chains = instance.get_available_chain()?;//错误处理demo
        let mut address_vec = vec![];
        for chain in chains {
            let chian_type = ChainType::from(chain);
            let address = match chian_type {
                ChainType::ETH | ChainType::EEE => {
                    if wallet_type == 0 {
                        continue;
                    }
                    self.address_from_mnemonic(mn, chian_type)?
                }
                ChainType::EthTest | ChainType::EeeTest => {
                    if wallet_type == 1 {
                        continue;
                    }
                    self.address_from_mnemonic(mn, chian_type)?
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
    //根据生成钱包的类型，需要创建对应的地址
    fn address_from_mnemonic(&self, mn: &[u8], wallet_type: ChainType) -> WalletResult<Address> {
        let phrase = String::from_utf8(mn.to_vec())?;
        match wallet_type {
            //当前版本不支持功能
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
                let secret_byte = ethtx::pri_from_mnemonic(&phrase, None)?;
                let (address, puk) = ethtx::generate_eth_address(&secret_byte)?;
                let address = Address {
                    chain_type: wallet_type,
                    pubkey: puk,
                    addr: address,
                };
                Ok(address)
            }
            _ => Err(WalletError::Custom(String::from("default not impl!"))),
        }
    }

    // Wallet 结构说明：
    //  一个助记词 对应的是一个钱包，在cashbox钱包软件中 可以同时管理多个钱包；
    // 一个助记词 可以同时应用于多条链；
    //  一条链，在基于链的应用上，存在多个合约地址的可能
    fn get_wallet_info(&self) -> HashMap<String, Wallet> {
        let instance = wallet_db::DataServiceProvider::instance().unwrap();
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
}
