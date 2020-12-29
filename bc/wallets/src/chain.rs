use async_trait::async_trait;
use strum::IntoEnumIterator;

use eee::{Crypto, EeeAccountInfo, EeeAccountInfoRefU8, Ss58Codec};
use mav::ma::{
    Dao, MAccountInfoSyncProg, MAddress, MBtcChainToken, MEeeChainToken, MEthChainToken, MWallet,
};
use mav::{NetType, WalletType};
use wallets_types::{
    AccountInfo, AccountInfoSyncProg, BtcChainTokenDefault, Chain2WalletType, ChainTrait,
    ContextTrait, DecodeAccountInfoParameters, EeeChainTokenDefault, EeeChainTrait,
    EthChainTokenDefault, RawTxParam, StorageKeyParameters, SubChainBasicInfo, TransferPayload,
    WalletError, WalletTrait,
};

use codec::Decode;

#[derive(Default)]
struct EthChain();

#[derive(Default)]
struct EeeChain();

#[derive(Default)]
struct BtcChain();

pub(crate) struct Wallet {
    chains: Vec<Box<dyn ChainTrait>>,
    eee: Box<dyn EeeChainTrait>,
}

#[async_trait]
impl ChainTrait for EthChain {
    fn generate_address(&self, mn: &[u8], wallet_type: &WalletType) -> Result<MAddress, WalletError> {
        let mut m_address = MAddress::default();
        m_address.chain_type = wallets_types::EthChain::chain_type(wallet_type).to_string();
        let phrase = String::from_utf8(mn.to_vec())?;
        let secret_byte = ethtx::pri_from_mnemonic(&phrase, None)?;
        let (addr, puk) = ethtx::generate_eth_address(&secret_byte)?;
        m_address.address = addr;
        m_address.public_key = puk;
        Ok(m_address)
    }

    async fn generate_default_token(&self, context: &dyn ContextTrait, wallet: &MWallet, address: &MAddress) -> Result<(), WalletError> {
        let wallet_type = WalletType::from(&wallet.wallet_type);
        //这里如果实现并行就好了
        for net_type in NetType::iter() {
            let token_rb = context.db().data_db(&net_type);
            let mut tx = token_rb.begin_tx_defer(false).await?;
            let default_tokens = EthChainTokenDefault::list_by_net_type(context, &net_type).await?;
            let mut tokens = Vec::new();
            for it in default_tokens {
                let mut token = MEthChainToken::default();
                token.chain_token_shared_id = it.chain_token_shared_id.clone();
                token.wallet_id = wallet.id.clone();
                token.chain_type = wallets_types::EthChain::chain_type(&wallet_type).to_string();
                token.show = true;
                //todo how to
                // gas_limit: 0,
                // gas_price: "".to_string(),
                // decimal: 0
                tokens.push(token);
            }
            MEthChainToken::save_batch(token_rb, &tx.tx_id, &mut tokens).await?;

            token_rb.commit(&tx.tx_id).await?;
            tx.manager = None;
        }
        Ok(())
    }
}

const DEFAULT_SS58_VERSION: u8 = 42;

#[async_trait]
impl ChainTrait for EeeChain {
    fn generate_address(&self, mn: &[u8], wallet_type: &WalletType) -> Result<MAddress, WalletError> {
        let mut addr = MAddress::default();
        addr.chain_type = wallets_types::EeeChain::chain_type(wallet_type).to_string();
        {
            let phrase = String::from_utf8(mn.to_vec())?;
            let seed = eee::Sr25519::seed_from_phrase(&phrase, None).unwrap();
            let pair = eee::Sr25519::pair_from_seed(&seed);
            let puk_key = eee::Sr25519::public_from_pair(&pair);

            addr.address = eee::Sr25519::ss58_from_pair(&pair, DEFAULT_SS58_VERSION);
            addr.public_key = format!("0x{}", hex::encode(puk_key));
        }
        Ok(addr)
    }

    async fn generate_default_token(&self, context: &dyn ContextTrait, wallet: &MWallet, address: &MAddress) -> Result<(), WalletError> {
        let wallet_type = WalletType::from(&wallet.wallet_type);
        //这里如果实现并行就好了
        for net_type in NetType::iter() {
            let token_rb = context.db().data_db(&net_type);
            let mut tx = token_rb.begin_tx_defer(false).await?;
            let default_tokens = EeeChainTokenDefault::list_by_net_type(context, &net_type).await?;
            let mut tokens = Vec::new();
            for it in default_tokens {
                let mut token = MEeeChainToken::default();
                token.chain_token_shared_id = it.chain_token_shared_id.clone();
                token.wallet_id = wallet.id.clone();
                token.chain_type = wallets_types::EeeChain::chain_type(&wallet_type).to_string();
                token.show = true;
                //todo how to
                // decimal: 0
                tokens.push(token);
            }
            MEeeChainToken::save_batch(token_rb, &tx.tx_id, &mut tokens).await?;

            token_rb.commit(&tx.tx_id).await?;
            tx.manager = None;
        }
        Ok(())
    }
}

#[async_trait]
impl ChainTrait for BtcChain {
    fn generate_address(&self, _mn: &[u8], wallet_type: &WalletType) -> Result<MAddress, WalletError> {
        let mut addr = MAddress::default();
        addr.chain_type = wallets_types::BtcChain::chain_type(wallet_type).to_string();
        //todo
        Ok(addr)
    }

    async fn generate_default_token(&self, context: &dyn ContextTrait, wallet: &MWallet, address: &MAddress) -> Result<(), WalletError> {
        let wallet_type = WalletType::from(&wallet.wallet_type);
        //这里如果实现并行就好了
        for net_type in NetType::iter() {
            let token_rb = context.db().data_db(&net_type);
            let mut tx = token_rb.begin_tx_defer(false).await?;
            let default_tokens = BtcChainTokenDefault::list_by_net_type(context, &net_type).await?;
            let mut tokens = Vec::new();
            for it in default_tokens {
                let mut token = MBtcChainToken::default();
                token.chain_token_shared_id = it.chain_token_shared_id.clone();
                token.wallet_id = wallet.id.clone();
                token.chain_type = wallets_types::EeeChain::chain_type(&wallet_type).to_string();
                token.show = true;
                //todo how to
                // decimal: 0
                tokens.push(token);
            }
            MBtcChainToken::save_batch(token_rb, &tx.tx_id, &mut tokens).await?;

            token_rb.commit(&tx.tx_id).await?;
            tx.manager = None;
        }
        Ok(())
    }
}

impl Wallet {
    pub fn new() -> Box<dyn WalletTrait> {
        let mut w = Wallet {
            chains: Default::default(),
            eee: Box::new(EeeChain::default()),
        };

        w.chains.push(Box::new(EthChain::default()));
        w.chains.push(Box::new(EeeChain::default()));
        w.chains.push(Box::new(BtcChain::default()));
        Box::new(w)
    }
}

impl WalletTrait for Wallet {
    fn chains(&self) -> &Vec<Box<dyn ChainTrait>> {
        &self.chains
    }
    fn eee_chain(&self) -> &Box<dyn EeeChainTrait> {
        &self.eee
    }
}

#[async_trait]
impl EeeChainTrait for EeeChain {
    async fn update_basic_info(
        &self,
        context: &dyn ContextTrait,
        net_type: &NetType,
        basic_info: &mut SubChainBasicInfo,
    ) -> Result<(), WalletError> {
        let rb = context.db().data_db(net_type);
        basic_info.save(rb, "").await?;
        Ok(())
    }
    async fn get_basic_info(
        &self,
        context: &dyn ContextTrait,
        net_type: &NetType,
        genesis_hash: &str,
        runtime_version: i32,
        tx_version: i32,
    ) -> Result<SubChainBasicInfo, WalletError> {
        let rb = context.db().data_db(net_type);
        if let Some(info) =
        SubChainBasicInfo::find_by_version(rb, genesis_hash, runtime_version, tx_version).await?
        {
            Ok(info)
        } else {
            Err(WalletError::NotExist)
        }
    }

    async fn update_sync_record(
        &self,
        context: &dyn ContextTrait,
        net_type: &NetType,
        sync_record: &AccountInfoSyncProg,
    ) -> Result<(), WalletError> {
        let rb = context.db().data_db(net_type);
        let mut record = {
            match AccountInfoSyncProg::find_by_account(rb, &sync_record.account).await? {
                Some(record) => record,
                None => MAccountInfoSyncProg::default(),
            }
        };
        record.block_hash = sync_record.block_hash.clone();
        record.block_no = sync_record.block_no.clone();
        record.save_update(rb, "").await?;
        Ok(())
    }
    async fn get_sync_record(
        &self,
        context: &dyn ContextTrait,
        net_type: &NetType,
        account: &str,
    ) -> Result<AccountInfoSyncProg, WalletError> {
        let rb = context.db().data_db(net_type);
        if let Some(info) = AccountInfoSyncProg::find_by_account(rb, account).await? {
            Ok(info.into())
        } else {
            Err(WalletError::NotExist)
        }
    }
    async fn decode_account_info(
        &self,
        context: &dyn ContextTrait,
        net_type: &NetType,
        parameters: DecodeAccountInfoParameters,
    ) -> Result<AccountInfo, WalletError> {
        let rb = context.db().data_db(net_type);
        if let Some(chain_info) = SubChainBasicInfo::find_by_version(
            rb,
            &parameters.chain_version.genesis_hash,
            parameters.chain_version.runtime_version,
            parameters.chain_version.tx_version,
        ).await?
        {
            let genesis_hash = scry_crypto::hexstr_to_vec(&chain_info.genesis_hash)?;
            // let account_id = eee::AccountId::from_ss58check(account).map_err(|err|WalletError::SubstrateTx(substratetx::error::Error::Public(err)))?;
            let chain_helper = eee::SubChainHelper::init(
                &chain_info.metadata,
                &genesis_hash[..],
                chain_info.runtime_version as u32,
                chain_info.tx_version as u32,
                None,
            )?;
            let account_info =
                match chain_helper.get_storage_value_key("System", "UpgradedToU32RefCount") {
                    Ok(_) => eee::SubChainHelper::decode_account_info::<EeeAccountInfo>(
                        &parameters.encode_data,
                    )
                        .map_err(|error| error.into()),
                    Err(_) => eee::SubChainHelper::decode_account_info::<EeeAccountInfoRefU8>(
                        &parameters.encode_data,
                    )
                        .map_err(|error| error.into()),
                };
            account_info.map(|info| AccountInfo {
                nonce: info.nonce,
                ref_count: info.refcount,
                free: info.free.to_string(),
                reserved: info.reserved.to_string(),
                misc_frozen: info.misc_frozen.to_string(),
                fee_frozen: info.fee_frozen.to_string(),
            })
        } else {
            Err(WalletError::NotExist)
        }
    }
    async fn get_storage_key(
        &self,
        context: &dyn ContextTrait,
        net_type: &NetType,
        parameters: StorageKeyParameters,
    ) -> Result<String, WalletError> {
        let rb = context.db().data_db(net_type);
        if let Some(chain_info) = SubChainBasicInfo::find_by_version(rb, &parameters.chain_version.genesis_hash, parameters.chain_version.runtime_version, parameters.chain_version.tx_version).await?
        {
            let genesis_hash = scry_crypto::hexstr_to_vec(&chain_info.genesis_hash)?;
            let account_id = eee::AccountId::from_ss58check(&parameters.pub_key)
                .map_err(|err| WalletError::SubstrateTx(eee::error::Error::Public(err)))?;
            let chain_helper = eee::SubChainHelper::init(
                &chain_info.metadata,
                &genesis_hash[..],
                chain_info.runtime_version as u32,
                chain_info.tx_version as u32,
                None,
            )?;
            chain_helper
                .get_storage_map_key::<eee::AccountId, u128>(&parameters.module, &parameters.storage_item, account_id)
                .map(|key| format!("0x{}", key))
                .map_err(|e| e.into())
        } else {
            Err(WalletError::NotExist)
        }
    }
    async fn eee_transfer(
        &self,
        context: &dyn ContextTrait,
        net_type: &NetType,
        transfer_payload: &TransferPayload,
    ) -> Result<String, WalletError> {
        let data_rb = context.db().data_db(net_type);
        //todo 调整通过wallet　id查询wallet的功能
        let wallet_db = context.db().wallets_db();
        // get token decimal by account address
        let m_address = {
            let mut addr_wrapper = wallet_db.new_wrapper();
            addr_wrapper.eq(&MAddress::address, &transfer_payload.from_account);
            MAddress::fetch_by_wrapper(wallet_db, "", &addr_wrapper).await?
        };

        if m_address.is_none() {
            return Err(WalletError::Custom(format!(
                "wallet address {} is not exist!",
                &transfer_payload.from_account
            )));
        }
        let address = m_address.unwrap();
        let m_wallet = MWallet::fetch_by_id(wallet_db, "", &address.wallet_id.to_owned()).await?;
        if m_wallet.is_none() {
            return Err(WalletError::Custom(format!(
                "wallet {} is not exist!",
                &address.wallet_id
            )));
        }
        let mnemonic = eee::Sr25519::get_mnemonic_context(
            &m_wallet.unwrap().mnemonic,
            transfer_payload.password.as_bytes(),
        )?;
        let mn = String::from_utf8(mnemonic)?;

        if let Some(chain_info) = SubChainBasicInfo::find_by_version(
            data_rb,
            &transfer_payload.chain_version.genesis_hash,
            transfer_payload.chain_version.runtime_version as i32,
            transfer_payload.chain_version.tx_version as i32,
        ).await?
        {
            let genesis_hash = scry_crypto::hexstr_to_vec(&chain_info.genesis_hash)?;
            let decimal = if chain_info.token_decimals == 0 {
                15
            } else {
                chain_info.token_decimals as usize
            };
            let transfer_amount = crate::kits::token_unit_convert(&transfer_payload.value, decimal)
                .map(|amount| amount.to_string())
                .ok_or_else(|| WalletError::Custom("input amount is illegal".to_string()));
            log::info!("transfer eee amount is:{:?}", transfer_amount);
            let chain_helper = eee::SubChainHelper::init(
                &chain_info.metadata,
                &genesis_hash[..],
                chain_info.runtime_version as u32,
                chain_info.tx_version as u32,
                None,
            )?;
            let sign_data = chain_helper.token_transfer_sign(
                eee::Token::EEE,
                &mn,
                &transfer_payload.to_account,
                &transfer_amount?,
                transfer_payload.index,
                None,
            )?;
            Ok(sign_data)
        } else {
            Err(WalletError::Custom(format!(
                "chain info {} is not exist!",
                transfer_payload.chain_version.genesis_hash
            )))
        }
    }
    async fn tokenx_transfer(
        &self,
        context: &dyn ContextTrait,
        net_type: &NetType,
        transfer_payload: &TransferPayload,
    ) -> Result<String, WalletError> {
        let data_rb = context.db().data_db(net_type);
        //todo 调整通过wallet　id查询wallet的功能
        let wallet_db = context.db().wallets_db();
        // get token decimal by account address
        let m_address = {
            let mut addr_wrapper = wallet_db.new_wrapper();
            addr_wrapper.eq(&MAddress::address, &transfer_payload.from_account);
            MAddress::fetch_by_wrapper(wallet_db, "", &addr_wrapper).await?
        };

        if m_address.is_none() {
            return Err(WalletError::Custom(format!(
                "wallet address {} is not exist!",
                &transfer_payload.from_account
            )));
        }
        let address = m_address.unwrap();
        //query token decimal by address
        let chain_token = {
            let mut token_wrapper = wallet_db.new_wrapper();
            token_wrapper.eq(&MEeeChainToken::wallet_id, &address.wallet_id.to_owned());
            MEeeChainToken::fetch_by_wrapper(wallet_db, "", &token_wrapper).await?
        };

        if chain_token.is_none() {
            return Err(WalletError::Custom(format!(
                "wallet {} is not exist!",
                &address.wallet_id
            )));
        }
        let decimal = chain_token.unwrap().decimal;

        let m_wallet = MWallet::fetch_by_id(wallet_db, "", &address.wallet_id.to_owned()).await?;
        if m_wallet.is_none() {
            return Err(WalletError::Custom(format!(
                "wallet {} is not exist!",
                &address.wallet_id
            )));
        }
        let mnemonic = eee::Sr25519::get_mnemonic_context(
            &m_wallet.unwrap().mnemonic,
            transfer_payload.password.as_bytes(),
        )?;
        let mn = String::from_utf8(mnemonic)?;

        let ext_vec = scry_crypto::hexstr_to_vec(&transfer_payload.chain_version.genesis_hash)?;

        let transfer_amount = crate::kits::token_unit_convert(&transfer_payload.value, decimal as usize)
            .map(|amount| amount.to_string())
            .ok_or_else(|| WalletError::Custom("input amount is illegal".to_string()));

        if let Some(chain_info) = SubChainBasicInfo::find_by_version(
            data_rb,
            &transfer_payload.chain_version.genesis_hash,
            transfer_payload.chain_version.runtime_version as i32,
            transfer_payload.chain_version.tx_version as i32,
        ).await?
        {
            let chain_helper = eee::SubChainHelper::init(
                &chain_info.metadata,
                &chain_info.genesis_hash.as_bytes(),
                chain_info.runtime_version as u32,
                chain_info.tx_version as u32,
                None,
            )?;
            let sign_data = chain_helper.token_transfer_sign(
                eee::Token::TokenX,
                &mn,
                &transfer_payload.to_account,
                &transfer_amount?,
                transfer_payload.index,
                Some(ext_vec),
            )?;
            Ok(sign_data)
        } else {
            Err(WalletError::Custom(format!(
                "chain info {} is not exist!",
                transfer_payload.chain_version.genesis_hash
            )))
        }
    }

    async fn tx_sign(
        &self,
        context: &dyn ContextTrait,
        net_type: &NetType,
        raw_tx_param: &RawTxParam,
        is_submittable: bool,
    ) -> Result<String, WalletError> {
        let data_rb = context.db().data_db(net_type);
        let tx_encode_data = scry_crypto::hexstr_to_vec(&raw_tx_param.raw_tx)?;
        let tx = eee::RawTx::decode(&mut &tx_encode_data[..])?;
        //todo 调整通过wallet　id查询wallet的功能
        let wallet_db = context.db().wallets_db();
        let m_wallet =
            MWallet::fetch_by_id(wallet_db, "", &raw_tx_param.wallet_id.to_owned()).await?;
        if m_wallet.is_none() {
            return Err(WalletError::Custom(format!(
                "wallet {} is not exist!",
                &raw_tx_param.wallet_id
            )));
        }
        let mnemonic = eee::Sr25519::get_mnemonic_context(
            &m_wallet.unwrap().mnemonic,
            raw_tx_param.password.as_bytes(),
        )?;
        let mn = String::from_utf8(mnemonic)?;
        let genesis_hash_str = format!("0x{}", hex::encode(tx.genesis_hash));
        if let Some(chain_info) = SubChainBasicInfo::find_by_version(
            data_rb,
            &genesis_hash_str,
            tx.spec_version as i32,
            tx.tx_version as i32,
        )
            .await?
        {
            let chain_helper = eee::SubChainHelper::init(
                &chain_info.metadata,
                &tx.genesis_hash[..],
                chain_info.runtime_version as u32,
                chain_info.tx_version as u32,
                None,
            )?;
            let sign_data = chain_helper.tx_sign(
                &mn,
                tx.index,
                eee::SubChainHelper::restore_func_data(&tx.func_data).as_slice(),
                is_submittable,
            )?;
            Ok(sign_data)
        } else {
            Err(WalletError::Custom(format!(
                "chain info {} is not exist!",
                genesis_hash_str
            )))
        }
    }
}
