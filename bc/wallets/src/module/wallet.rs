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
                eee_chain: eee_data.get(&wallet_id).map(|data| data[0].clone()),//When Some happens, it means there must be a value and vec len is not 0
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
        //Query the mnemonic word corresponding to id
        if let Some(mn) = provider.query_by_wallet_id(wallet_id) {
            self.mnemonic_psd_update(&mn, old_pwd, new_pwd).map(|_| StatusCode::OK)
        } else {
            let msg = format!("wallet {} is not exist", wallet_id);
            Err(WalletError::Custom(msg))
        }
    }

    pub fn is_contain_wallet(&self) -> WalletResult<bool> {
        #[cfg(target_os="android")]crate::init_logger_once();
       wallet_db::DataServiceProvider::instance().map(|provider|{
           !provider.get_wallets().is_empty()
        })
    }
    //clear user download data
    pub fn clean_wallets_data(&self) -> WalletResult<()> {
        let instance = wallet_db::DataServiceProvider::instance()?;
        instance.delete_user_data()
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
        //ensure wallet exist
        if instance.query_by_wallet_id(walletid).is_some(){
            instance.tx_begin()?;
            instance.set_selected_wallet(walletid)
                .and_then(|_| instance.tx_commint())
                .map_err(|error| {
                    if let Err(rollback_err) = instance.tx_rollback() {
                        log::error!("rollback error:{}",rollback_err.to_string());
                    }
                    error
                })
        }else {
           Err(WalletError::NotExist)
        }
    }

    pub fn del_wallet(&self, walletid: &str, psd: &[u8]) -> WalletResult<()> {
        let provider = wallet_db::DataServiceProvider::instance()?;
        //Query the mnemonic word corresponding to id
        provider.query_by_wallet_id(walletid).ok_or_else(|| WalletError::NotExist)
            .and_then(|mn| substratetx::Sr25519::get_mnemonic_context(mn.mnemonic.as_str(), psd).map_err(|e| e.into()))
            .and_then(|_data| provider.tx_begin())
            .and_then(|()| {
                provider.del_mnemonic(walletid)
            })
            .and_then(|_| provider.tx_commint())
            .map_err(|err| {
                let _ = provider.tx_rollback();
                //Returns the error of any of the above chained calls
                err
            })
    }

    pub fn rename_wallet(&self, walletid: &str, wallet_name: &str) -> WalletResult<bool> {
        let instance = wallet_db::DataServiceProvider::instance()?;
        if instance.query_by_wallet_id(walletid).is_some(){
            instance.rename_mnemonic(walletid, wallet_name).map(|_| true)
        }else {
            Err(WalletError::NotExist)
        }

    }
    pub fn create_wallet(&self, wallet_name: &str, mn: &[u8], password: &[u8], wallet_type: i64) -> WalletResult<Wallet> {
        //Specify the default chain type
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
        //Official chain, mnemonic words can only be imported once, whether to import by hash exists
        if wallet_type == 1 && dbhelper.query_by_wallet_digest(hex_mn_digest.as_str(), wallet_type).is_some() {
            return Err(WalletError::Custom("this wallet is exist".to_string()));
        }

        let keystore = substratetx::Sr25519::encrypt_mnemonic(mn, password);
        let wallet_id = Uuid::new_v4().to_string();
        let address: Vec<TbAddress> = self.generate_address(&wallet_id, mn, wallet_type)?;

        //Construct a wallet saving structure
        let wallet_save = model::wallet_store::TbWallet {
            wallet_id: wallet_id.clone(),
            mn_digest: hex_mn_digest,
            full_name: Some(wallet_name.to_string()),
            mnemonic: keystore,
            display_chain_id: default_chain_type.clone() as i64,//Set the default display chain type
            wallet_type,
            ..Default::default()
        };

        // Start transaction
        dbhelper.tx_begin()?;
        //Save wallet information to database
        dbhelper.save_wallet_address(wallet_save, address)
            .map(|_| dbhelper.tx_commint()) //Commit transaction
            .map(|_| {
                Wallet {
                    status: StatusCode::OK,
                    wallet_id,
                    wallet_type,
                    wallet_name: Some(wallet_name.to_string()),
                    display_chain_id: default_chain_type as i64,//Set the default display chain type
                    ..Default::default()
                }
            }).map_err(|err| {
            let _ = dbhelper.tx_rollback();
            err
        })
    }
    pub fn export_mnemonic(&self, wallet_id: &str, password: &[u8]) -> WalletResult<Mnemonic> {
        let provider = wallet_db::DataServiceProvider::instance()?;
        //Query the mnemonic word corresponding to id
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
        //Get the original mnemonic
        let mnemonic = wallet.mnemonic.clone();
        let context = substratetx::Sr25519::get_mnemonic_context(mnemonic.as_str(), old_psd)?;
        //Encrypt with new password
        let new_encrypt_mn = substratetx::Sr25519::encrypt_mnemonic(&context[..], new_psd);
        //Construct the mnemonic object that needs to be upgraded, first only modify the specified field, and then perfect it according to the needs
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
        //Get which chains of the current wallet are available
        let instance = wallet_db::DataServiceProvider::instance()?;
        let chains = instance.get_available_chain()?;//Error handling
        let mut address_vec = vec![];
        for chain in chains {
            let chain_type = ChainType::from(chain);
            let address = match chain_type {
                ChainType::ETH | ChainType::EEE |ChainType::BTC => {
                    if wallet_type == 0 {
                        continue;
                    }
                    self.address_from_mnemonic(mn, chain_type)?
                }
                ChainType::EthTest | ChainType::EeeTest |ChainType::BtcTest => {
                    if wallet_type == 1 {
                        continue;
                    }
                    self.address_from_mnemonic(mn, chain_type)?
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
    //According to the type of wallet generated, the corresponding address needs to be created
    fn address_from_mnemonic(&self, mn: &[u8], wallet_type: ChainType) -> WalletResult<Address> {
        let phrase = String::from_utf8(mn.to_vec())?;
        match wallet_type {
            //The current version does not support features
            ChainType::EEE | ChainType::EeeTest => {
                let seed = substratetx::Sr25519::seed_from_phrase(&phrase, None).unwrap();
                let pair = substratetx::Sr25519::pair_from_seed(&seed);
                let address = substratetx::Sr25519::ss58_from_pair(&pair,DEFAULT_SS58_VERSION);
                let puk_key = substratetx::Sr25519::public_from_pair(&pair);
                let address = Address {
                    chain_type: wallet_type,
                    pubkey: format!("0x{}",hex::encode(puk_key)),
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
            ChainType::BTC | ChainType::BtcTest => {
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

    // Wallet structure description:
    // A mnemonic corresponds to a wallet, and multiple wallets can be managed simultaneously in the cashbox wallet software;
    // A mnemonic can be applied to multiple chains at the same time;
    // A chain, in chain-based applications, there may be multiple contract addresses
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
