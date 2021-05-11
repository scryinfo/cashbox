use async_trait::async_trait;

use eee::{Crypto, EeeAccountInfo, EeeAccountInfoRefU8, Ss58Codec, Token};
use mav::ma::{Dao, MAccountInfoSyncProg, MAddress, MBtcChainToken, MBtcChainTokenDefault, MBtcChainTokenShared, MEeeChainToken, MEeeChainTokenAuth, MEeeChainTokenDefault, MEeeChainTokenShared, MEeeChainTx, MEthChainToken, MEthChainTokenAuth, MEthChainTokenDefault, MEthChainTokenShared, MTokenShared, MWallet, MEeeTokenxTx, EeeTokenType, MEthChainTokenNonAuth, MTokenAddress, MBtcChainTokenAuth};
use mav::{NetType, WalletType, CTrue, CFalse, ChainType};
use wallets_types::{AccountInfo, AccountInfoSyncProg, BtcChainTokenAuth, BtcChainTokenDefault, BtcChainTrait, Chain2WalletType, ChainTrait, ContextTrait, DecodeAccountInfoParameters, EeeChainTokenAuth, EeeChainTokenDefault, EeeChainTrait, EeeTransferPayload, EthChainTokenAuth, EthChainTokenDefault, EthChainTrait, EthRawTxPayload, EthTransferPayload, ExtrinsicContext, RawTxParam, StorageKeyParameters, SubChainBasicInfo, WalletError, WalletTrait, EeeChainTx, EthChainTokenNonAuth, BtcNowLoadBlock};

use codec::Decode;
use rbatis::plugin::page::PageRequest;
use bitcoin_wallet::account::AccountAddressType;
use bitcoin::util::psbt::serialize::Serialize;
use rbatis::crud::CRUDTable;
use eee::Token::TokenX;
use futures::executor::block_on;

#[derive(Default)]
struct EthChain();

#[derive(Default)]
struct EeeChain();

#[derive(Default)]
struct BtcChain();

pub(crate) struct Wallet {
    chains: Vec<Box<dyn ChainTrait>>,
    eee: Box<dyn EeeChainTrait>,
    eth: Box<dyn EthChainTrait>,
    btc: Box<dyn BtcChainTrait>,
}


#[async_trait]
impl ChainTrait for EthChain {
    fn generate_address(&self, mn: &[u8], wallet_type: &WalletType, net_type: &NetType) -> Result<MAddress, WalletError> {
        let mut m_address = MAddress::default();
        m_address.chain_type = wallets_types::EthChain::chain_type(wallet_type, net_type).to_string();
        let phrase = String::from_utf8(mn.to_vec())?;
        let secret_byte = eth::pri_from_mnemonic(&phrase, None)?;
        let (addr, puk) = eth::generate_eth_address(&secret_byte)?;
        m_address.address = addr;
        m_address.public_key = puk;
        Ok(m_address)
    }

    async fn generate_default_token(&self, context: &dyn ContextTrait, wallet: &MWallet, address: &MAddress, net_type: &NetType) -> Result<(), WalletError> {
        let wallet_type = WalletType::from(&wallet.wallet_type);
        let token_rb = context.db().data_db(&net_type);
        let mut tx = token_rb.begin_tx_defer(false).await?;
        let default_tokens = EthChainTokenDefault::list_by_net_type(context, &net_type).await?;
        let mut tokens = Vec::new();
        let mut token_address_balances = Vec::new();
        for default_token in default_tokens {
            {
                let mut token = MEthChainToken::default();
                token.chain_token_shared_id = default_token.chain_token_shared_id.clone();
                token.wallet_id = wallet.id.clone();
                token.chain_type = wallets_types::EthChain::chain_type(&wallet_type, &net_type).to_string();
                token.show = CTrue;
                token.contract_address = default_token.contract_address.clone();
                tokens.push(token);
            }
            {
                let mut token_address = MTokenAddress::default();
                token_address.wallet_id = wallet.id.clone();
                token_address.token_id = default_token.chain_token_shared_id.clone();
                token_address.chain_type = wallets_types::EthChain::chain_type(&wallet_type, &net_type).to_string();
                token_address.address_id = address.id.clone();
                token_address.balance = "0".to_string();
                token_address.status = 1;
                token_address_balances.push(token_address);
            }
        }
        MEthChainToken::save_batch(token_rb, &tx.tx_id, &mut tokens).await?;
        MTokenAddress::save_batch(token_rb, &tx.tx_id, &mut token_address_balances).await?;
        token_rb.commit(&tx.tx_id).await?;
        tx.manager = None;
        //}
        Ok(())
    }
}

const DEFAULT_SS58_VERSION: u8 = 42;

#[async_trait]
impl ChainTrait for EeeChain {
    fn generate_address(&self, mn: &[u8], wallet_type: &WalletType, net_type: &NetType) -> Result<MAddress, WalletError> {
        let mut addr = MAddress::default();
        addr.chain_type = wallets_types::EeeChain::chain_type(wallet_type, net_type).to_string();
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

    async fn generate_default_token(&self, context: &dyn ContextTrait, wallet: &MWallet, address: &MAddress, net_type: &NetType) -> Result<(), WalletError> {
        let wallet_type = WalletType::from(&wallet.wallet_type);

        let token_rb = context.db().data_db(&net_type);
        let mut tx = token_rb.begin_tx_defer(false).await?;
        let default_tokens = EeeChainTokenDefault::list_by_net_type(context, &net_type).await?;
        let mut tokens = Vec::new();
        let mut token_address_balances = Vec::new();
        for default_token in default_tokens {
            {
                let mut token = MEeeChainToken::default();
                token.chain_token_shared_id = default_token.chain_token_shared_id.clone();
                token.wallet_id = wallet.id.clone();
                token.chain_type = wallets_types::EeeChain::chain_type(&wallet_type, &net_type).to_string();
                token.show = CTrue;
                token.decimal = default_token.chain_token_shared.decimal;
                tokens.push(token);
            }

            {
                let mut token_address = MTokenAddress::default();
                token_address.wallet_id = wallet.id.clone();
                token_address.token_id = default_token.chain_token_shared_id.clone();
                token_address.chain_type = wallets_types::EeeChain::chain_type(&wallet_type, &net_type).to_string();
                token_address.address_id = address.id.clone();
                token_address.balance = "0".to_string();
                token_address.status = 1;
                token_address_balances.push(token_address);
            }
        }
        MEeeChainToken::save_batch(token_rb, &tx.tx_id, &mut tokens).await?;
        MTokenAddress::save_batch(token_rb, &tx.tx_id, &mut token_address_balances).await?;
        token_rb.commit(&tx.tx_id).await?;
        tx.manager = None;
        //}
        Ok(())
    }
}

#[async_trait]
impl ChainTrait for BtcChain {
    fn generate_address(&self, mn: &[u8], wallet_type: &WalletType, net_type: &NetType) -> Result<MAddress, WalletError> {
        const PASSPHRASE: &str = "";
        let mut addr = MAddress::default();
        {
            addr.chain_type = wallets_types::BtcChain::chain_type(wallet_type, net_type).to_string();
            let mn = String::from_utf8(mn.to_vec())?;
            let mnemonic = bitcoin_wallet::mnemonic::Mnemonic::from_str(&mn)
                .map_err(|e| WalletError::Custom(e.to_string()))?;
            let network = match wallet_type {
                WalletType::Normal => { bitcoin::network::constants::Network::Bitcoin }
                WalletType::Test => { bitcoin::network::constants::Network::Testnet }
            };
            let mut master = bitcoin_wallet::account::MasterAccount::from_mnemonic(&mnemonic, 0, network, PASSPHRASE, None)
                .map_err(|e| WalletError::Custom(e.to_string()))?;
            let mut unlocker = bitcoin_wallet::account::Unlocker::new_for_master(&master, PASSPHRASE)
                .map_err(|e| WalletError::Custom(e.to_string()))?;
            // path(0,0)
            let account = bitcoin_wallet::account::Account::new(&mut unlocker, AccountAddressType::P2PKH, 0, 0, 10)
                .map_err(|e| WalletError::Custom(e.to_string()))?;
            master.add_account(account);
            let account = master.get_mut((0, 0)).unwrap();
            let instance_key = account.next_key().unwrap();
            let address = instance_key.address.clone().to_string();
            let public_key = instance_key.public.clone();
            let ser = public_key.serialize();
            let public_key = format!("0x{}", hex::encode(ser));
            addr.address = address;
            addr.public_key = public_key;
        }
        Ok(addr)
    }

    async fn generate_default_token(&self, context: &dyn ContextTrait, wallet: &MWallet, address: &MAddress, net_type: &NetType) -> Result<(), WalletError> {
        let wallet_type = WalletType::from(&wallet.wallet_type);
        //这里如果实现并行就好了


        let token_rb = context.db().data_db(&net_type);
        let mut tx = token_rb.begin_tx_defer(false).await?;
        let default_tokens = BtcChainTokenDefault::list_by_net_type(context, &net_type).await?;
        let mut tokens = Vec::new();
        let mut token_address_balances = Vec::new();
        for default_token in default_tokens {
            {
                let mut token = MBtcChainToken::default();
                token.chain_token_shared_id = default_token.chain_token_shared_id.clone();
                token.wallet_id = wallet.id.clone();
                token.chain_type = wallets_types::BtcChain::chain_type(&wallet_type, &net_type).to_string();
                //token.chain_type = net_type.to_string();
                token.show = CTrue;
                token.decimal = default_token.chain_token_shared.decimal;
                tokens.push(token);
            }
            {
                let mut token_address = MTokenAddress::default();
                token_address.wallet_id = wallet.id.clone();
                token_address.token_id = default_token.chain_token_shared_id.clone();
                token_address.chain_type = wallets_types::BtcChain::chain_type(&wallet_type, &net_type).to_string();
                token_address.address_id = address.id.clone();
                token_address.balance = "0".to_string();
                token_address.status = 1;
                token_address_balances.push(token_address);
            }
        }
        MBtcChainToken::save_batch(token_rb, &tx.tx_id, &mut tokens).await?;
        MTokenAddress::save_batch(token_rb, &tx.tx_id, &mut token_address_balances).await?;

        token_rb.commit(&tx.tx_id).await?;
        tx.manager = None;
        //}
        Ok(())
    }
}

impl Wallet {
    pub fn new() -> Box<dyn WalletTrait> {
        let mut w = Wallet {
            chains: Default::default(),
            eee: Box::new(EeeChain::default()),
            eth: Box::new(EthChain::default()),
            btc: Box::new(BtcChain::default()),
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
    fn eee_chain(&self) -> &Box<dyn EeeChainTrait> { &self.eee }
    fn eth_chain(&self) -> &Box<dyn EthChainTrait> { &self.eth }
    fn btc_chain(&self) -> &Box<dyn BtcChainTrait> { &self.btc }
}



#[async_trait]
impl BtcChainTrait for BtcChain {
    async fn get_default_tokens(&self, context: &dyn ContextTrait, net_type: &NetType) -> Result<Vec<BtcChainTokenDefault>, WalletError> {
        let btc_tokens = BtcChainTokenDefault::list_by_net_type(context, net_type).await?;
        Ok(btc_tokens)
    }

    async fn update_default_tokens(&self, context: &dyn ContextTrait, default_tokens: Vec<BtcChainTokenDefault>) -> Result<(), WalletError> {
        let token_rb = context.db().wallets_db();
        let mut tx = token_rb.begin_tx_defer(false).await?;
        //disable all exist default tokens
        {
            let token_default_name = MBtcChainTokenDefault::table_name();
            let col_name = MBtcChainTokenDefault::status;
            let update_sql = format!("update {} set {} = 0", token_default_name, col_name);
            token_rb.exec(&tx.tx_id, &update_sql).await?;
        }
        //insert new tokens shared
        for token in default_tokens {
            let mut shared = token.btc_chain_token_shared.clone();
            {
                let token_shared_wrapper = token_rb.new_wrapper()
                    .eq(&MTokenShared::symbol, &token.btc_chain_token_shared.m.token_shared.symbol);
                if let Some(token_shared) = MBtcChainTokenShared::fetch_by_wrapper(token_rb, "", &token_shared_wrapper).await? {
                    shared.id = token_shared.id;
                }
                shared.save_update(token_rb, &tx.tx_id).await?;
            }
            {
                let token_default_wrapper = token_rb.new_wrapper()
                    .eq(&MBtcChainTokenDefault::chain_token_shared_id, &shared.id)
                    .eq(&MBtcChainTokenDefault::net_type, &token.net_type);
                //check if this default is exist!
                let mut default_token = if let Some(mut token_default) = MBtcChainTokenDefault::fetch_by_wrapper(token_rb, &tx.tx_id, &token_default_wrapper).await? {
                    token_default.position = token.position;
                    token_default
                } else {
                    let mut token_default = token.m.clone();
                    token_default.chain_token_shared_id = shared.id;
                    token_default
                };
                default_token.status = 1;
                default_token.save_update(token_rb, &tx.tx_id).await?;
            }
        }
        tx.manager = None;
        token_rb.commit(&tx.tx_id).await?;
        Ok(())
    }
    async fn update_auth_tokens(&self, context: &dyn ContextTrait, author_tokens: Vec<BtcChainTokenAuth>) -> Result<(), WalletError> {
        let token_rb = context.db().wallets_db();
        let mut tx = token_rb.begin_tx_defer(false).await?;
        //disable all exist default tokens
        {
            let token_default_name = MBtcChainTokenAuth::table_name();
            let col_name = MBtcChainTokenAuth::status;
            let update_sql = format!("update {} set {} = 0", token_default_name, col_name);
            token_rb.exec(&tx.tx_id, &update_sql).await?;
        }
        //insert new tokens shared
        for token in author_tokens {
            let mut shared = token.btc_chain_token_shared.clone();
            {
                let token_shared_wrapper = token_rb.new_wrapper()
                    .eq(&MTokenShared::symbol, &token.btc_chain_token_shared.m.token_shared.symbol);
                if let Some(token_shared) = MBtcChainTokenShared::fetch_by_wrapper(token_rb, "", &token_shared_wrapper).await? {
                    shared.id = token_shared.id;
                }
                shared.save_update(token_rb, &tx.tx_id).await?;
            }

            {
                let token_auth_wrapper = token_rb.new_wrapper()
                    .eq(&MBtcChainTokenAuth::chain_token_shared_id, &shared.id)
                    .eq(&MBtcChainTokenAuth::net_type, &token.net_type);
                //check if this default is exist!
                let mut auth_token = if let Some(mut token_auth) = MBtcChainTokenAuth::fetch_by_wrapper(token_rb, &tx.tx_id, &token_auth_wrapper).await? {
                    token_auth.position = token.position;
                    token_auth
                } else {
                    let mut token_auth = token.m.clone();
                    token_auth.chain_token_shared_id = shared.id;
                    token_auth
                };
                auth_token.status = 1;
                auth_token.save_update(token_rb, &tx.tx_id).await?;
            }
        }
        tx.manager = None;
        token_rb.commit(&tx.tx_id).await?;
        Ok(())
    }

    async fn get_auth_tokens(&self, context: &dyn ContextTrait, net_type: &NetType, start_item: u64, page_size: u64) -> Result<Vec<BtcChainTokenAuth>, WalletError> {
        let btc_tokens = BtcChainTokenAuth::list_by_net_type(context, net_type, start_item, page_size).await?;
        Ok(btc_tokens)
    }

    fn start_murmel(&self, context: &dyn ContextTrait, wallet_id: &str, net_type: &NetType) -> Result<(),WalletError> {
        // can't be async function, because in murmel we have a lot block_on
        let wallet_db = context.db().wallets_db();
        let m_address = {
            let w = wallet_db.new_wrapper().eq(&MAddress::wallet_id,wallet_id);
            block_on( MAddress::list_by_wrapper(wallet_db,wallet_id, &w)).map_err(|e| WalletError::Custom(e.to_string()))?
        };
        let btc_address = m_address.iter().filter(
            |&a| {
               a.chain_type.contains("Btc")
            }
        ).collect::<Vec<&MAddress>>();
        murmel::wallet::start(&net_type, btc_address);
        Ok(())
    }

    fn load_now_blocknumber(&self, _context: &dyn ContextTrait) -> Result<BtcNowLoadBlock, WalletError> {
        murmel::wallet::btc_load_now_blocknumber().map_err(|e| WalletError::RbatisError(e))
    }
}

#[async_trait]
impl EeeChainTrait for EeeChain {
    async fn update_basic_info(&self, context: &dyn ContextTrait, net_type: &NetType, basic_info: &mut SubChainBasicInfo) -> Result<(), WalletError> {
        let rb = context.db().data_db(net_type);
        let mut tx = rb.begin_tx_defer(false).await?;
        //whether update default chain basic info
        if basic_info.is_default == CTrue {
            //update existed default chain basic info
            if let Some(mut current_default_version) = SubChainBasicInfo::get_default_version(rb).await? {
                current_default_version.is_default = CFalse;
                current_default_version.save_update(rb, &tx.tx_id).await?;
            }
        }

        let mut save_basic_info = {
            if let Some(mut existed_info) = SubChainBasicInfo::find_by_version(rb, &basic_info.genesis_hash, basic_info.runtime_version, basic_info.tx_version).await?
            {
                existed_info.token_decimals = basic_info.token_decimals;
                existed_info.is_default = basic_info.is_default;
                existed_info.token_symbol = basic_info.token_symbol.clone();
                existed_info.ss58_format_prefix = basic_info.ss58_format_prefix;
                existed_info
            } else {
                let basic_info = &*basic_info;
                basic_info.clone()
            }
        };
        save_basic_info.save_update(rb, &tx.tx_id).await?;
        tx.manager = None;
        rb.commit(&tx.tx_id).await?;
        Ok(())
    }
    async fn get_basic_info(&self, context: &dyn ContextTrait, net_type: &NetType, genesis_hash: &str, runtime_version: i32, tx_version: i32) -> Result<SubChainBasicInfo, WalletError> {
        let rb = context.db().data_db(net_type);
        let chain_version = if genesis_hash.is_empty() && runtime_version == 0 && tx_version == 0 {
            SubChainBasicInfo::get_default_version(rb).await?
        } else {
            SubChainBasicInfo::find_by_version(rb, genesis_hash, runtime_version, tx_version).await?
        };
        if let Some(info) = chain_version
        {
            Ok(info)
        } else {
            Err(WalletError::NotExist)
        }
    }

    async fn update_sync_record(&self, context: &dyn ContextTrait, net_type: &NetType, sync_record: &AccountInfoSyncProg) -> Result<(), WalletError> {
        let rb = context.db().data_db(net_type);
        let mut record = {
            match AccountInfoSyncProg::find_by_account(rb, &sync_record.account).await? {
                Some(record) => record,
                None => {
                    let mut instance = MAccountInfoSyncProg::default();
                    instance.account = sync_record.account.clone();
                    instance
                }
            }
        };
        record.block_hash = sync_record.block_hash.clone();
        record.block_no = sync_record.block_no.clone();
        record.save_update(rb, "").await?;
        Ok(())
    }
    async fn get_sync_record(&self, context: &dyn ContextTrait, net_type: &NetType, account: &str) -> Result<AccountInfoSyncProg, WalletError> {
        let rb = context.db().data_db(net_type);
        if let Some(info) = AccountInfoSyncProg::find_by_account(rb, account).await? {
            Ok(info.into())
        } else {
            Err(WalletError::NotExist)
        }
    }
    async fn decode_account_info(&self, context: &dyn ContextTrait, net_type: &NetType, parameters: DecodeAccountInfoParameters) -> Result<AccountInfo, WalletError> {
        let rb = context.db().data_db(net_type);
        if let Some(chain_info) = SubChainBasicInfo::find_by_version(
            rb,
            &parameters.chain_version.genesis_hash,
            parameters.chain_version.runtime_version,
            parameters.chain_version.tx_version,
        ).await?
        {
            let genesis_hash = scry_crypto::hexstr_to_vec(&chain_info.genesis_hash)?;
            let chain_helper = eee::SubChainHelper::init(
                &chain_info.metadata,
                &genesis_hash[..],
                chain_info.runtime_version as u32,
                chain_info.tx_version as u32,
                None,
            )?;
            let account_info =
                match chain_helper.get_storage_value_key("System", "UpgradedToU32RefCount") {
                    Ok(_) => eee::SubChainHelper::decode_account_info::<EeeAccountInfo>(&parameters.encode_data).map_err(|error| error.into()),
                    Err(_) => eee::SubChainHelper::decode_account_info::<EeeAccountInfoRefU8>(&parameters.encode_data).map_err(|error| error.into()),
                };
            account_info.map(|info| AccountInfo {
                nonce: info.nonce,
                ref_count: info.refcount,
                free_balance: info.free.to_string(),
                reserved: info.reserved.to_string(),
                misc_frozen: info.misc_frozen.to_string(),
                fee_frozen: info.fee_frozen.to_string(),
            })
        } else {
            Err(WalletError::NotExist)
        }
    }
    async fn get_storage_key(&self, context: &dyn ContextTrait, net_type: &NetType, parameters: StorageKeyParameters) -> Result<String, WalletError> {
        let rb = context.db().data_db(net_type);
        if let Some(chain_info) = SubChainBasicInfo::find_by_version(rb, &parameters.chain_version.genesis_hash, parameters.chain_version.runtime_version, parameters.chain_version.tx_version).await?
        {
            let genesis_hash = scry_crypto::hexstr_to_vec(&chain_info.genesis_hash)?;
            let account_id = eee::AccountId::from_ss58check(&parameters.account)
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
    async fn eee_transfer(&self, context: &dyn ContextTrait, net_type: &NetType, transfer_payload: &EeeTransferPayload) -> Result<String, WalletError> {
        let data_rb = context.db().data_db(net_type);

        let m_wallet = wallets_types::Wallet::find_by_address(context, &transfer_payload.from_account).await?;
        if m_wallet.is_none() {
            return Err(WalletError::Custom(format!(" address {} wallet is not exist!", &transfer_payload.from_account)));
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
          /*  let decimal = if chain_info.token_decimals == 0 {
                15
            } else {
                chain_info.token_decimals as usize
            };
            let transfer_amount = crate::kits::token_unit_convert(&transfer_payload.value, decimal)
                .map(|amount| amount.to_string())
                .ok_or_else(|| WalletError::Custom("input amount is illegal".to_string()));*/
            log::info!("transfer eee amount is:{:?}", &transfer_payload.value);
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
                &transfer_payload.value,
                transfer_payload.index,
                None,
            )?;
            Ok(sign_data)
        } else {
            Err(WalletError::Custom(format!("chain info {} is not exist!", transfer_payload.chain_version.genesis_hash)))
        }
    }
    async fn tokenx_transfer(&self, context: &dyn ContextTrait, net_type: &NetType, transfer_payload: &EeeTransferPayload) -> Result<String, WalletError> {
        let data_rb = context.db().data_db(net_type);
        //todo 调整通过wallet　id查询wallet的功能
        let wallet_db = context.db().wallets_db();
        // get token decimal by account address
        let m_address = {
            let addr_wrapper = wallet_db.new_wrapper()
                .eq(&MAddress::address, &transfer_payload.from_account);
            MAddress::list_by_wrapper(wallet_db, "", &addr_wrapper).await?
        };

        if m_address.is_empty() {
            return Err(WalletError::Custom(format!("wallet address {} is not exist!", &transfer_payload.from_account)));
        }
        //todo 处理在测试网下存在相同地址的情况
        let address = m_address.get(0).unwrap();
        let m_wallet = MWallet::fetch_by_id(wallet_db, "", &address.wallet_id.to_owned()).await?;
        if m_wallet.is_none() {
            return Err(WalletError::Custom(format!("wallet {} is not exist!", address.wallet_id)));
        }
        let mnemonic = eee::Sr25519::get_mnemonic_context(
            &m_wallet.unwrap().mnemonic,
            transfer_payload.password.as_bytes(),
        )?;
        let mn = String::from_utf8(mnemonic)?;

        let ext_vec = scry_crypto::hexstr_to_vec(&transfer_payload.ext_data)?;

        if let Some(chain_info) = SubChainBasicInfo::find_by_version(
            data_rb,
            &transfer_payload.chain_version.genesis_hash,
            transfer_payload.chain_version.runtime_version as i32,
            transfer_payload.chain_version.tx_version as i32,
        ).await?
        {
            let chain_helper = eee::SubChainHelper::init(
                &chain_info.metadata,
                &scry_crypto::hexstr_to_vec(&chain_info.genesis_hash)?,
                chain_info.runtime_version as u32,
                chain_info.tx_version as u32,
                None,
            )?;
            let sign_data = chain_helper.token_transfer_sign(
                eee::Token::TokenX,
                &mn,
                &transfer_payload.to_account,
                &transfer_payload.value,
                transfer_payload.index,
                Some(ext_vec),
            )?;
            Ok(sign_data)
        } else {
            Err(WalletError::Custom(format!("chain info {} is not exist!", transfer_payload.chain_version.genesis_hash)))
        }
    }

    async fn tx_sign(&self, context: &dyn ContextTrait, net_type: &NetType, raw_tx_param: &RawTxParam, is_submittable: bool) -> Result<String, WalletError> {
        let data_rb = context.db().data_db(net_type);
        let tx_encode_data = scry_crypto::hexstr_to_vec(&raw_tx_param.raw_tx)?;
        let tx = eee::RawTx::decode(&mut &tx_encode_data[..])?;
        //todo 调整通过wallet　id查询wallet的功能
        let wallet_db = context.db().wallets_db();
        let m_wallet = MWallet::fetch_by_id(wallet_db, "", &raw_tx_param.wallet_id.to_owned()).await?;
        if m_wallet.is_none() {
            return Err(WalletError::Custom(format!("wallet {} is not exist!", &raw_tx_param.wallet_id)));
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
        ).await?
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
            Err(WalletError::Custom(format!("chain info {} is not exist!", genesis_hash_str)))
        }
    }
    async fn save_tx_record(&self, context: &dyn ContextTrait, net_type: &NetType, extrinsic_ctx: &ExtrinsicContext) -> Result<(), WalletError> {
        let data_rb = context.db().data_db(net_type);
        let runtime_version = extrinsic_ctx.chain_version.runtime_version;
        let tx_version = extrinsic_ctx.chain_version.tx_version;
        let basic_info = self.get_basic_info(context, net_type, &extrinsic_ctx.chain_version.genesis_hash, runtime_version, tx_version).await?;

        let genesis_byte = scry_crypto::hexstr_to_vec(&basic_info.genesis_hash)?;
        let helper = eee::chain_helper::ChainHelper::init(&basic_info.metadata, &genesis_byte, runtime_version as u32, tx_version as u32, None)?;

        let event_res = helper.decode_events(&extrinsic_ctx.event, None)?;
        let extrinsics_map = helper.decode_extrinsics(&extrinsic_ctx.extrinsics, &extrinsic_ctx.account)?;

        //Block transaction events There must be a time stamp setting
        let tx_time = extrinsics_map.get(&0).unwrap();//Get timestamp

        for (index, transfer_detail) in extrinsics_map.iter() {
            if transfer_detail.signer.is_none() {
                continue;
            }
            log::info!("tx index:{}", index);
            if let Some(is_successful) = event_res.get(index) {
                Self::save_transfer_detail(data_rb, extrinsic_ctx, transfer_detail, tx_time.timestamp.unwrap(), *is_successful).await?;
            }
        }
        Ok(())
    }

    async fn get_tx_record(&self, context: &dyn ContextTrait, net_type: &NetType, token_type: EeeTokenType, target_account: Option<String>, start_item: u64, page_size: u64) -> Result<Vec<EeeChainTx>, WalletError> {
        let page_req = PageRequest::new(start_item, page_size);
        let data_rb = context.db().data_db(&net_type);
        let wrapper = {
            if let Some(account) = target_account {
                data_rb.new_wrapper().eq(MEeeChainTx::wallet_account, &account)
            } else {
                data_rb.new_wrapper()
            }
        };
        let wrapper = wrapper.order_by(false, &[&mav::ma::TxShared::tx_timestamp]);

        match token_type {
            EeeTokenType::Eee => {
                let eee_tx_record = MEeeChainTx::fetch_page_by_wrapper(data_rb, "", &wrapper, &page_req).await?;
                let res = eee_tx_record.records.iter().map(|record| EeeChainTx::from(record.clone())).collect::<Vec<EeeChainTx>>();
                Ok(res)
            }
            EeeTokenType::TokenX => {
                let tokenx_record = MEeeTokenxTx::fetch_page_by_wrapper(data_rb, "", &wrapper, &page_req).await?;
                let res = tokenx_record.records.iter().map(|record| EeeChainTx::from(record.clone())).collect::<Vec<EeeChainTx>>();
                Ok(res)
            }
        }
    }

    async fn get_default_tokens(&self, context: &dyn ContextTrait, net_type: &NetType) -> Result<Vec<EeeChainTokenDefault>, WalletError> {
        let eee_tokens = EeeChainTokenDefault::list_by_net_type(context, net_type).await?;
        Ok(eee_tokens)
    }

    async fn update_default_tokens(&self, context: &dyn ContextTrait, default_tokens: Vec<EeeChainTokenDefault>) -> Result<(), WalletError> {
        let token_rb = context.db().wallets_db();
        let mut tx = token_rb.begin_tx_defer(false).await?;
        //disable all exist default tokens
        {
            let token_default_name = MEeeChainTokenDefault::table_name();
            let col_name = MEeeChainTokenDefault::status;
            let update_sql = format!("update {} set {} = 0", token_default_name, col_name);
            token_rb.exec(&tx.tx_id, &update_sql).await?;
        }
        //insert new tokens shared
        for token in default_tokens {
            let mut shared = token.eee_chain_token_shared.clone();
            {
                let token_shared_wrapper = token_rb.new_wrapper()
                    .eq(&MTokenShared::symbol, &token.eee_chain_token_shared.m.token_shared.symbol);
                if let Some(token_shared) = MEeeChainTokenShared::fetch_by_wrapper(token_rb, &tx.tx_id, &token_shared_wrapper).await? {
                    shared.id = token_shared.id;
                }
                shared.save_update(token_rb, &tx.tx_id).await?;
            }
            {
                let token_default_wrapper = token_rb.new_wrapper()
                    .eq(&MEeeChainTokenDefault::chain_token_shared_id, &shared.id)
                    .eq(&MEeeChainTokenDefault::net_type, &token.net_type);
                //check if this default is exist!
                let mut default_token = if let Some(mut token_default) = MEeeChainTokenDefault::fetch_by_wrapper(token_rb, &tx.tx_id, &token_default_wrapper).await? {
                    token_default.position = token.position;
                    token_default
                } else {
                    let mut token_default = token.m.clone();
                    token_default.chain_token_shared_id = shared.id;
                    token_default
                };
                default_token.status = 1;
                default_token.save_update(token_rb, &tx.tx_id).await?;
            }
        }
        tx.manager = None;
        token_rb.commit(&tx.tx_id).await?;
        Ok(())
    }
    async fn update_auth_tokens(&self, context: &dyn ContextTrait, author_tokens: Vec<EeeChainTokenAuth>) -> Result<(), WalletError> {
        let token_rb = context.db().wallets_db();
        let mut tx = token_rb.begin_tx_defer(false).await?;

        //disable all exist default tokens
        {
            let token_default_name = MEeeChainTokenAuth::table_name();
            let col_name = MEeeChainTokenAuth::status;
            let update_sql = format!("update {} set {} = 0", token_default_name, col_name);
            token_rb.exec(&tx.tx_id, &update_sql).await?;
        }
        //insert new tokens shared
        for token in author_tokens {
            let mut shared = token.eee_chain_token_shared.clone();
            {
                let token_shared_wrapper = token_rb.new_wrapper()
                    .eq(&MTokenShared::symbol, &token.eee_chain_token_shared.m.token_shared.symbol);
                if let Some(token_shared) = MEeeChainTokenShared::fetch_by_wrapper(token_rb, "", &token_shared_wrapper).await? {
                    shared.id = token_shared.id;
                }
                shared.save_update(token_rb, &tx.tx_id).await?;
            }
            {
                let token_auth_wrapper = token_rb.new_wrapper()
                    .eq(&MEeeChainTokenAuth::chain_token_shared_id, &shared.id)
                    .eq(&MEeeChainTokenAuth::net_type, &token.net_type);
                //check if this default is exist!
                let mut token_auth = if let Some(mut token_auth) = MEeeChainTokenAuth::fetch_by_wrapper(token_rb, &tx.tx_id, &token_auth_wrapper).await? {
                    token_auth.position = token.position;
                    token_auth
                } else {
                    let mut token_auth = token.m.clone();
                    token_auth.chain_token_shared_id = shared.id;
                    token_auth
                };
                token_auth.status = 1;
                token_auth.save_update(token_rb, &tx.tx_id).await?;
            }
        }
        tx.manager = None;
        token_rb.commit(&tx.tx_id).await?;
        Ok(())
    }

    async fn get_auth_tokens(&self, context: &dyn ContextTrait, net_type: &NetType, start_item: u64, page_size: u64) -> Result<Vec<EeeChainTokenAuth>, WalletError> {
        let eee_tokens = EeeChainTokenAuth::list_by_net_type(context, net_type, start_item, page_size).await?;
        Ok(eee_tokens)
    }
}

impl EeeChain {
    async fn save_transfer_detail(rb: &rbatis::rbatis::Rbatis, extrinsic_ctx: &ExtrinsicContext, tx_detail: &eee::TransferDetail, timestamp: u64, is_successful: bool) -> Result<(), WalletError> {
        log::info!("save_transfer_detail account:{},blockhash:{}", extrinsic_ctx.account, extrinsic_ctx.block_hash);

        match tx_detail.token_name.as_str() {
            "EEE" => {
                Self::save_eee_chain_tx(rb, extrinsic_ctx, tx_detail, timestamp, is_successful).await?
            }
            "TokenX" => {
                Self::save_eee_tokenx_tx(rb, extrinsic_ctx, tx_detail, timestamp, is_successful).await?
            }
            _ => {
                log::info!("We current don't  save {} tx ", tx_detail.token_name)
            }
        }
        Ok(())
    }
    async fn save_eee_chain_tx(rb: &rbatis::rbatis::Rbatis, extrinsic_ctx: &ExtrinsicContext, tx_detail: &eee::TransferDetail, timestamp: u64, is_successful: bool) -> Result<(), WalletError> {
        let query_tx_wrapper = rb.new_wrapper()
            .eq(&mav::ma::TxShared::tx_hash, tx_detail.hash.clone().unwrap_or_default())
            .eq(&mav::ma::TxShared::signer, tx_detail.signer.clone().unwrap_or_default());
        if let None = MEeeChainTx::fetch_by_wrapper(rb, "", &query_tx_wrapper).await? {
            let mut chain_tx = mav::ma::MEeeChainTx::default();
            chain_tx.from_address = tx_detail.from.clone().unwrap_or_default();
            chain_tx.to_address = tx_detail.to.clone().unwrap_or_default();
            chain_tx.wallet_account = extrinsic_ctx.account.clone();
            chain_tx.extension = tx_detail.ext_data.clone().unwrap_or_default();
            chain_tx.value = tx_detail.value.unwrap().to_string();
            chain_tx.status = is_successful as u32;
            chain_tx.tx_shared.signer = tx_detail.signer.clone().unwrap_or_default();
            chain_tx.tx_shared.block_hash = extrinsic_ctx.block_hash.clone();
            chain_tx.tx_shared.block_number = extrinsic_ctx.block_number.clone();
            chain_tx.tx_shared.tx_hash = tx_detail.hash.clone().unwrap_or_default();
            chain_tx.tx_shared.tx_timestamp = timestamp as i64;
            chain_tx.save(rb, "").await?;
        }
        return Ok(());
    }
    async fn save_eee_tokenx_tx(rb: &rbatis::rbatis::Rbatis, extrinsic_ctx: &ExtrinsicContext, tx_detail: &eee::TransferDetail, timestamp: u64, is_successful: bool) -> Result<(), WalletError> {
        let query_tx_wrapper = rb.new_wrapper()
            .eq(&mav::ma::TxShared::tx_hash, tx_detail.hash.clone().unwrap_or_default())
            .eq(&mav::ma::TxShared::signer, tx_detail.signer.clone().unwrap_or_default());
        if let None = MEeeTokenxTx::fetch_by_wrapper(rb, "", &query_tx_wrapper).await? {
            let mut chain_tx = mav::ma::MEeeTokenxTx::default();
            chain_tx.from_address = tx_detail.from.clone().unwrap_or_default();
            chain_tx.to_address = tx_detail.to.clone().unwrap_or_default();
            chain_tx.wallet_account = extrinsic_ctx.account.clone();
            chain_tx.extension = tx_detail.ext_data.clone().unwrap_or_default();
            chain_tx.value = tx_detail.value.unwrap().to_string();
            chain_tx.status = is_successful as u32;
            chain_tx.tx_shared.signer = tx_detail.signer.clone().unwrap_or_default();
            chain_tx.tx_shared.block_hash = extrinsic_ctx.block_hash.clone();
            chain_tx.tx_shared.block_number = extrinsic_ctx.block_number.clone();
            chain_tx.tx_shared.tx_hash = tx_detail.hash.clone().unwrap_or_default();
            chain_tx.tx_shared.tx_timestamp = timestamp as i64;
            chain_tx.save(rb, "").await?;
        }
        return Ok(());
    }
}

#[async_trait]
impl EthChainTrait for EthChain {
    async fn tx_sign(&self, context: &dyn ContextTrait, net_type: &NetType, tx_payload: &EthTransferPayload, password: &str) -> Result<String, WalletError> {
        let chain_id = match net_type {
            NetType::Main => 1,
            NetType::Test => 3,
            _ => 17
        };
        let tx_payload_trim = tx_payload.trim();
        let raw_tx = tx_payload_trim.decode()?;
        let pri_key = Self::get_private_key_from_address(context, &tx_payload.from_address, password).await?;
        let tx_signed = raw_tx.sign(&pri_key, Some(chain_id));
        Ok(format!("0x{}", hex::encode(tx_signed)))
    }

    async fn raw_tx_sign(&self, context: &dyn ContextTrait, net_type: &NetType, raw_tx_payload: &EthRawTxPayload, password: &str) -> Result<String, WalletError> {
        let chain_id = match net_type {
            NetType::Main => 1,
            NetType::Test => 3,
            _ => 17
        };
        let tx_encode_data = scry_crypto::hexstr_to_vec(&raw_tx_payload.raw_tx)?;
        let mut raw_tx = eth::RawTransaction::default();
        raw_tx.decode(&tx_encode_data)?;
        let pri_key = Self::get_private_key_from_address(context, &raw_tx_payload.from_address, password).await?;
        let tx_signed = raw_tx.sign(&pri_key, Some(chain_id));
        Ok(format!("0x{}", hex::encode(tx_signed)))
    }

    async fn decode_addition_data(&self, encode_data: &str) -> Result<String, WalletError> {
        if encode_data.is_empty() {
            return Ok("".to_string());
        }
        eth::decode_tranfer_data(encode_data).map_err(|error| error.into())
    }
    async fn update_default_tokens(&self, context: &dyn ContextTrait, default_tokens: Vec<EthChainTokenDefault>) -> Result<(), WalletError> {
        let token_rb = context.db().wallets_db();
        let mut tx = token_rb.begin_tx_defer(false).await?;
        //disable all exist default tokens
        {
            let token_default_name = MEthChainTokenDefault::table_name();
            let col_name = MEthChainTokenDefault::status;
            let update_sql = format!("update {} set {} = 0", token_default_name, col_name);
            token_rb.exec(&tx.tx_id, &update_sql).await?;
        }
        //insert new tokens shared
        for token in default_tokens {
            let mut shared = token.eth_chain_token_shared.clone();
            {
                let token_shared_wrapper = token_rb.new_wrapper()
                    .eq(&MTokenShared::symbol, &token.eth_chain_token_shared.m.token_shared.symbol);
                if let Some(token_shared) = MEthChainTokenShared::fetch_by_wrapper(token_rb, &tx.tx_id, &token_shared_wrapper).await? {
                    shared.id = token_shared.id;
                }
                shared.save_update(token_rb, &tx.tx_id).await?;
            }
            {
                let token_default_wrapper = token_rb.new_wrapper()
                    .eq(&MEthChainTokenDefault::chain_token_shared_id, &shared.id)
                    .eq(&MEthChainTokenDefault::net_type, &token.net_type);
                //check if this default is exist!
                let mut default_token = if let Some(mut token_default) = MEthChainTokenDefault::fetch_by_wrapper(token_rb, &tx.tx_id, &token_default_wrapper).await? {
                    token_default.contract_address = token.contract_address.clone();
                    token_default.position = token.position;
                    token_default
                } else {
                    let mut token_default = token.m.clone();
                    token_default.chain_token_shared_id = shared.id;
                    token_default
                };
                default_token.status = 1;
                default_token.save_update(token_rb, &tx.tx_id).await?;
            }
        }
        tx.manager = None;
        token_rb.commit(&tx.tx_id).await?;
        Ok(())
    }

    async fn get_default_tokens(&self, context: &dyn ContextTrait, net_type: &NetType) -> Result<Vec<EthChainTokenDefault>, WalletError> {
        let m_eth_tokens = EthChainTokenDefault::list_by_net_type(context, net_type).await?;
        Ok(m_eth_tokens)
    }

    async fn update_auth_tokens(&self, context: &dyn ContextTrait, author_tokens: Vec<EthChainTokenAuth>) -> Result<(), WalletError> {
        let token_rb = context.db().wallets_db();
        let mut tx = token_rb.begin_tx_defer(false).await?;
        //disable all exist auth tokens
        {
            let token_default_name = MEthChainTokenAuth::table_name();
            let col_name = MEthChainTokenAuth::status;
            let update_sql = format!("update {} set {} = 0", token_default_name, col_name);
            token_rb.exec(&tx.tx_id, &update_sql).await?;
        }
        //insert new tokens shared
        for token in author_tokens {
            let mut shared = token.eth_chain_token_shared.clone();
            {
                let token_shared_wrapper = token_rb.new_wrapper()
                    .eq(&MTokenShared::symbol, &token.eth_chain_token_shared.m.token_shared.symbol);
                if let Some(token_shared) = MEthChainTokenShared::fetch_by_wrapper(token_rb, "", &token_shared_wrapper).await? {
                    shared.id = token_shared.id;
                }
                shared.save_update(token_rb, &tx.tx_id).await?;
            }
            {
                let token_auth_wrapper = token_rb.new_wrapper()
                    .eq(&MEthChainTokenAuth::chain_token_shared_id, &shared.id)
                    .eq(&MEthChainTokenAuth::net_type, &token.net_type);
                //check if this default is exist!
                let mut token_auth = if let Some(mut token_auth) = MEthChainTokenAuth::fetch_by_wrapper(token_rb, &tx.tx_id, &token_auth_wrapper).await? {
                    token_auth.contract_address = token.contract_address.clone();
                    token_auth.position = token.position;
                    token_auth
                } else {
                    let mut token_auth = token.m.clone();
                    token_auth.chain_token_shared_id = shared.id;
                    token_auth
                };
                token_auth.status = 1;
                token_auth.save_update(token_rb, &tx.tx_id).await?;
            }
        }
        tx.manager = None;
        token_rb.commit(&tx.tx_id).await?;
        Ok(())
    }

    async fn update_non_auth_tokens(&self, context: &dyn ContextTrait, author_tokens: Vec<EthChainTokenNonAuth>) -> Result<(), WalletError> {
        let token_rb = context.db().wallets_db();
        let mut tx = token_rb.begin_tx_defer(false).await?;
        //disable all exist auth tokens
        {
            let token_default_name = MEthChainTokenNonAuth::table_name();
            let col_name = MEthChainTokenNonAuth::status;
            let update_sql = format!("update {} set {} = 0", token_default_name, col_name);
            token_rb.exec(&tx.tx_id, &update_sql).await?;
        }
        //insert new tokens shared
        for token in author_tokens {
            let mut shared = token.eth_chain_token_shared.clone();
            {
                let token_shared_wrapper = token_rb.new_wrapper()
                    .eq(&MTokenShared::symbol, &token.eth_chain_token_shared.m.token_shared.symbol);
                if let Some(token_shared) = MEthChainTokenShared::fetch_by_wrapper(token_rb, "", &token_shared_wrapper).await? {
                    shared.id = token_shared.id;
                }
                shared.save_update(token_rb, &tx.tx_id).await?;
            }
            {
                let query_wrapper = token_rb.new_wrapper()
                    .eq(&MEthChainTokenNonAuth::chain_token_shared_id, &shared.id)
                    .eq(&MEthChainTokenNonAuth::net_type, &token.net_type);
                //check if this default is exist!
                let mut new_token = if let Some(mut token_non_auth) = MEthChainTokenNonAuth::fetch_by_wrapper(token_rb, &tx.tx_id, &query_wrapper).await? {
                    token_non_auth.contract_address = token.contract_address.clone();
                    token_non_auth.position = token.position;
                    token_non_auth
                } else {
                    let mut token_auth = token.m.clone();
                    token_auth.chain_token_shared_id = shared.id;
                    token_auth
                };
                new_token.status = 1;
                new_token.save_update(token_rb, &tx.tx_id).await?;
            }
        }
        tx.manager = None;
        token_rb.commit(&tx.tx_id).await?;
        Ok(())
    }
    async fn get_non_auth_tokens(&self, context: &dyn ContextTrait, net_type: &NetType) -> Result<Vec<EthChainTokenNonAuth>, WalletError> {
        EthChainTokenNonAuth::list_by_net_type(context, net_type).await
    }
    async fn get_auth_tokens(&self, context: &dyn ContextTrait, net_type: &NetType, start_item: u64, page_size: u64) -> Result<Vec<EthChainTokenAuth>, WalletError> {
        EthChainTokenAuth::list_by_net_type(context, net_type, start_item, page_size).await
    }
}

impl EthChain {
    async fn get_private_key_from_address(context: &dyn ContextTrait, address: &str, password: &str) -> Result<Vec<u8>, WalletError> {
        if let Some(wallet) = wallets_types::Wallet::find_by_address(context, address).await? {
            let mnemonic = eee::Sr25519::get_mnemonic_context(&wallet.mnemonic, password.as_bytes())?;
            eth::pri_from_mnemonic(&String::from_utf8(mnemonic)?, None).map_err(|err| err.into())
        } else {
            Err(WalletError::Custom(format!("address {} wallet is not exist!", address)))
        }
    }
}

#[allow(dead_code)]
impl BtcChain {
    // TODO when sign btc-tx in wallet/chain use this function
    async fn get_mnemonic_from_address(context: &dyn ContextTrait, address: &str, password: &str) -> Result<Vec<u8>, WalletError> {
        if let Some(wallet) = wallets_types::Wallet::find_by_address(context, address).await? {
            let mnemonic = eee::Sr25519::get_mnemonic_context(&wallet.mnemonic, password.as_bytes())?;
            Ok(mnemonic)
        } else {
            Err(WalletError::Custom(format!("address {} wallet is not exist!", address)))
        }
    }

}