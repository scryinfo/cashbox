use std::ops::Not;
use std::sync::atomic::AtomicBool;
use strum::IntoEnumIterator;

use failure::_core::sync::atomic::Ordering;
use parking_lot::lock_api::RawReentrantMutex;
use parking_lot::{RawMutex, RawThreadId};

use eee::Crypto;
use mav::ma::{BeforeSave, Dao, Db, DbCreateType, DbName, MAddress, MBtcChainToken, MEeeChainToken, MEthChainToken, MMnemonic, MTokenAddress, MWallet, SettingType, MEthChainTokenDefault, MEthChainTokenAuth, MEthChainTokenNonAuth};
use mav::{ChainType, NetType, WalletType, CTrue, CFalse, AppPlatformType};
use scry_crypto::Keccak256;
use wallets_types::{BtcChainTrait, Chain2WalletType, Context, ContextTrait, CreateWalletParameters, EeeChain, EeeChainTrait, EthChainTrait, InitParameters, Setting, TokenAddress, Wallet, WalletError, WalletTrait, WalletTokenStatus};

pub struct Wallets {
    raw_reentrant: RawReentrantMutex<RawMutex, RawThreadId>,
    pub(crate) ctx: Context,
    pub(crate) db: Db,
    //for test, make it pub
    stopped: AtomicBool,
    pub net_type: NetType,
    wallet_trait: Box<dyn WalletTrait>,
}

impl Default for Wallets {
    fn default() -> Self {
        Self {
            ctx: Default::default(),
            db: Default::default(),
            raw_reentrant: RawReentrantMutex::INIT,
            stopped: AtomicBool::new(false),
            net_type: NetType::Main,
            wallet_trait: crate::chain::Wallet::new(),
        }
    }
}
build_const::build_const!("constants");

impl Wallets {
    pub fn lock_read(&mut self) -> bool {
        self.raw_reentrant.lock();
        return true;
    }
    pub fn unlock_read(&mut self) -> bool {
        unsafe {
            self.raw_reentrant.unlock();
        }
        return true;
    }
    pub fn lock_write(&mut self) -> bool {
        self.raw_reentrant.lock();
        return true;
    }
    pub fn unlock_write(&mut self) -> bool {
        unsafe {
            self.raw_reentrant.unlock();
        }
        return true;
    }

    pub fn app_platform_type() -> String {
        let plat = CARGO_BUILD_TARGET.replace("-", "_");
        let plat_type = {
            match AppPlatformType::from(&plat) {
                Ok(t) => t,
                Err(_) => {
                    log::error!("AppPlatformType is not support");
                    AppPlatformType::any
                }
            }
        };
        plat_type.to_string()
    }
    pub fn package_version() -> String {
        CARGO_BUILD_VERSION.to_owned()
    }
    pub fn eee_chain_instance(&self) -> &Box<dyn EeeChainTrait> {
        self.wallet_trait.eee_chain()
    }
    pub fn eth_chain_instance(&self) -> &Box<dyn EthChainTrait> {
        self.wallet_trait.eth_chain()
    }
    pub fn btc_chain_instance(&self) -> &Box<dyn BtcChainTrait> {
        self.wallet_trait.btc_chain()
    }

    pub fn db_name(name: &wallets_types::DbName) -> wallets_types::DbName {
        wallets_types::DbName(DbName::generate_full_name(&name))
    }

    pub async fn init(&mut self, parameters: &InitParameters) -> Result<&Context, WalletError> {
        #[cfg(target_os = "android")]
            crate::init_logger_once();
        self.ctx.context_note = parameters.context_note.clone();
       // self.net_type =  NetType::Main;
        if parameters.is_memory_db == CTrue {
            self.db.init_memory_sql(&parameters.db_name).await?;
        } else {
            self.db.connect(&parameters.db_name).await?;
        }
        self.db.init_tables(&DbCreateType::NotExists).await?;
        let net_type = Setting::current_net_type(self).await?;
         self.net_type = if net_type.is_empty() {
           NetType::Main
       } else {
           NetType::from(&net_type)
       };
        Ok(&self.ctx)
    }

    pub async fn uninit(&mut self) -> Result<(), WalletError> {
        //todo
        Ok(())
    }

    pub async fn all(&self) -> Result<Vec<Wallet>, WalletError> {
        Wallet::all(self, &self.net_type).await
    }

    pub async fn has_any(&self) -> Result<bool, WalletError> {
        Wallet::has_any(self, &self.net_type).await
    }

    pub async fn find_by_id(&self, wallet_id: &str) -> Result<Option<Wallet>, WalletError> {
        Wallet::find_by_id(self, wallet_id, &self.net_type).await
    }
    ///注：只加载了wallet的id name等直接的基本数据，链数据没有加载
    pub async fn find_wallet_base_by_name(&self, name: &str) -> Result<Vec<Wallet>, WalletError> {
        let context = self;
        let ms = Wallet::m_wallet_by_name(context, name).await?;
        let mut target_wallets = Vec::new();
        for m_wallet in ms {
            let mut wallet = Wallet::default();
            wallet.m = m_wallet;
            target_wallets.push(wallet);
        }
        Ok(target_wallets)
    }
    pub async fn remove_wallet(&self, wallet_id: &str, password: &str) -> Result<(), WalletError> {
        let context = self;
        {
            // check whether is current_wallet
            if let Some(m_setting) =
            Setting::get_setting(context, &SettingType::CurrentWallet).await?
            {
                if m_setting.value_str.eq(wallet_id) {
                    return Err(WalletError::Custom(
                        "current wallet cannot be deleted".to_string(),
                    ));
                }
            }
        }
        match Wallet::m_wallet_by_id(context, wallet_id).await? {
            None => Err(WalletError::NoRecord("".to_owned())),
            Some(m_wallet) => {
                if let Err(err) = eee::Sr25519::get_mnemonic_context(
                    &m_wallet.mnemonic,
                    &password.as_bytes().to_vec(),
                ) {
                    Err(err.into())
                } else {
                    // todo transaction
                    //password is correct,start delete wallet_id related data
                    let rb = context.db().wallets_db();
                    let mut tx = rb.begin_tx_defer(false).await?;
                    {
                        //delete m_wallet table record
                        let _del_count =
                            MWallet::remove_by_id(rb, &tx.tx_id, &wallet_id.to_owned()).await?;
                    }
                    {
                        //delete wallet id related address,
                        let del_addr_wrapper = rb.new_wrapper().eq(MAddress::wallet_id, &wallet_id);
                        let _del_count =
                            MAddress::remove_by_wrapper(rb, &tx.tx_id, &del_addr_wrapper).await?;
                    }
                    rb.commit(&tx.tx_id).await?;
                    tx.manager = None;
                    {
                        // delete data
                        for net_type in NetType::iter() {
                            let data_rb = context.db().data_db(&net_type);
                            let wrapper = data_rb
                                .new_wrapper()
                                .eq(MTokenAddress::wallet_id, wallet_id.clone());
                            let _del_eee_chain =
                                MEeeChainToken::remove_by_wrapper(data_rb, "", &wrapper).await?;
                            let _del_eth_chain =
                                MEthChainToken::remove_by_wrapper(data_rb, "", &wrapper).await?;
                            let _del_btc_chain =
                                MBtcChainToken::remove_by_wrapper(data_rb, "", &wrapper).await?;
                            let _del_count =
                                MTokenAddress::remove_by_wrapper(data_rb, "", &wrapper).await?;
                        }
                    }
                    Ok(())
                }
            }
        }
    }
    pub async fn reset_wallet_password(&self, wallet_id: &str, old_password: &str, new_password: &str) -> Result<(), WalletError> {
        // let context = self;
        match Wallet::m_wallet_by_id(self, wallet_id).await? {
            None => Err(WalletError::NoRecord(wallet_id.to_owned())),
            Some(mut m_wallet) => {
                match eee::Sr25519::get_mnemonic_context(
                    &m_wallet.mnemonic,
                    old_password.as_bytes(),
                ) {
                    Ok(mn_data) => {
                        let encrypt_str = eee::Sr25519::encrypt_mnemonic(
                            mn_data.as_slice(),
                            new_password.as_bytes(),
                        );
                        m_wallet.mnemonic = encrypt_str;
                        let rb = self.db().wallets_db();
                        m_wallet.save_update(rb, "").await?;
                        Ok(())
                    }
                    Err(err) => Err(err.into()),
                }
            }
        }
    }

    pub async fn export_wallet(&self, wallet_id: &str, password: &str) -> Result<String, WalletError> {
        // let context = self;
        match Wallet::m_wallet_by_id(self, wallet_id).await? {
            None => Err(WalletError::NoRecord(wallet_id.to_owned())),
            Some(m_wallet) => {
                match eee::Sr25519::get_mnemonic_context(&m_wallet.mnemonic, password.as_bytes()) {
                    Ok(mn_data) => Ok(String::from_utf8(mn_data)?),
                    Err(err) => Err(err.into()),
                }
            }
        }
    }
    pub async fn rename_wallet(&mut self, name: &str, wallet_id: &str, tx_id: &str) -> Result<u64, WalletError> {
        let context = self;
        match Wallet::m_wallet_by_id(context, wallet_id).await? {
            None => Err(WalletError::NoRecord("".to_owned())),
            Some(mut m_wallet) => {
                m_wallet.name = name.to_owned();
                Wallet::update_by_id(context, &mut m_wallet, tx_id).await
            }
        }
    }
    pub async fn save_current_wallet_chain(&mut self, wallet_id: &str, chain_type: &ChainType) -> Result<(), WalletError> {
        Setting::save_current_wallet_chain(self, wallet_id, chain_type).await

    }
    pub async fn current_wallet_chain(&self) -> Result<Option<(String, ChainType)>, WalletError> {
       Setting::current_wallet_chain(self).await

    }
    pub async fn change_net_type(&mut self, net_type: NetType)->Result<(),WalletError> {
        let _effect_row_num = Setting::change_net_type(self,&net_type).await?;
        self.net_type = net_type;
        Ok(())
    }
    pub async fn current_net_type(&self) -> Result<String, WalletError> {
        Setting::current_net_type(self).await

    }
    pub fn generate_mnemonic(mnemonic_num: u32) -> String {
        eee::Sr25519::generate_phrase(mnemonic_num)
    }

    /// 如果是正式钱包，一个助记词只能创建一个钱包（test类型的钱包允许有重复的）
    pub async fn create_wallet(&self, parameters: CreateWalletParameters) -> Result<Wallet, WalletError> {
        let context = self;
        let rb = context.db.wallets_db();
        let hex_mn_digest = {
            let hash_first = parameters.mnemonic.as_bytes().keccak256();
            format!("0x{}", hex::encode((&hash_first[..]).keccak256()))
        };

        let wallet_type = WalletType::from(&parameters.wallet_type);
        if !WalletType::check_chain_type_match(&wallet_type, &context.net_type)
        {
            let msg = format!(" {} wallet must match {} network,{} wallet can't use {} network",
                              WalletType::Normal.to_string(), NetType::Main.to_string(), WalletType::Test.to_string(), NetType::Main.to_string());
            return Err(WalletError::Custom(msg));
        }
        // normal wallet mnemonic can't be used more than once,test wallet mnemonic can't be used in normal wallet
        let ms = Wallet::check_duplicate_mnemonic(context, &hex_mn_digest, &wallet_type).await?;
        if ms.is_empty().not() {
            let msg = {
                if wallet_type.eq(&WalletType::Normal) {
                    format!("{} wallet mnemonic can't been reuse", &parameters.wallet_type)
                } else {
                    format!("this mnemonic has been used create a {} wallet", WalletType::Normal.to_string())
                }
            };
            return Err(WalletError::Custom(msg));
        }

        let mut m_wallet = MWallet::default();
        {
            m_wallet.mnemonic_digest = hex_mn_digest;
            m_wallet.mnemonic = eee::Sr25519::encrypt_mnemonic(
                &parameters.mnemonic.as_bytes().to_vec(),
                &parameters.password.as_bytes().to_vec(),
            );
            m_wallet.wallet_type = wallet_type.to_string();
            m_wallet.name = parameters.name.clone();
            m_wallet.show = CTrue;
        }
        {
            let mut tx = rb.begin_tx_defer(false).await?;
            for net_type in NetType::iter() {
                if !WalletType::check_chain_type_match(&wallet_type, &net_type) {
                    continue;
                }
                let mut m_addresses = self.generate_address_token(&mut m_wallet, &parameters.mnemonic.as_bytes().to_vec(), &net_type).await?;
                MAddress::save_batch(rb, &tx.tx_id, &mut m_addresses).await?;
            }
            //save to database
            //tx 只处理异常情况下，事务的rollback，所以会在事务提交成功后，调用 tx.manager = None; 阻止 [rbatis::tx::TxGuard]再管理事务
            {
                m_wallet.save(rb, &tx.tx_id).await?;
                let mut m_mnemonic = MMnemonic::default();
                m_mnemonic.from(&m_wallet);
                // todo 增加事务的管理
                m_mnemonic.save(self.db.mnemonic_db(), "").await?;
            }
            rb.commit(&tx.tx_id).await?;
            tx.manager = None;
        }
        if Wallet::count(context, &context.net_type).await? == 1 {
            //是第一个创建的wallet，把它设置为当前钱包
            let wallet_type = WalletType::from(&m_wallet.wallet_type);
            //创建的第一个钱包，的默认链是 eee
            Setting::save_current_wallet_chain(
                context,
                &m_wallet.id,
                &EeeChain::chain_type(&wallet_type, &self.net_type),
            ).await?;
        }
        let mut wallet = Wallet::default();
        wallet.load(self, m_wallet, &self.net_type).await?;
        return Ok(wallet);
    }

    async fn generate_address_token(&self, wallet: &mut MWallet, mn: &[u8], net_type: &NetType) -> Result<Vec<MAddress>, WalletError> {
        if wallet.id.is_empty() {
            //make sure the id is not empty
            wallet.before_save();
        }
        let mut addrs = Vec::new();
        let chains = self.wallet_trait.chains();
        let wallet_type = WalletType::from(&wallet.wallet_type);
        for chain in chains {
            let mut addr = chain.generate_address(mn, &wallet_type, net_type)?;
            addr.before_save();
            addr.wallet_id = wallet.id.clone();
            addr.is_wallet_address = CTrue;
            addr.show = CTrue;
            chain.generate_default_token(self, &wallet, &addr, net_type).await?;
            addrs.push(addr);
        }
        Ok(addrs)
    }

    async fn query_contract_by_shared_id(&self, token_shared_id: &str, net_type: &str) -> Result<String, WalletError> {
        //通过
        let wallet_rb = self.db().wallets_db();
        let token_query_wrapper = wallet_rb.new_wrapper()
            .eq(&MEthChainTokenDefault::chain_token_shared_id, token_shared_id)
            .eq(&MEthChainTokenDefault::net_type, net_type);
            if let Some(token_auth) = MEthChainTokenAuth::fetch_by_wrapper(wallet_rb, "", &token_query_wrapper).await?{
                Ok(token_auth.contract_address)
            } else if let Some(token_non_auth) = MEthChainTokenNonAuth::fetch_by_wrapper(wallet_rb, "", &token_query_wrapper).await?{
                Ok(token_non_auth.contract_address)
            } else if let Some(token_default) = MEthChainTokenDefault::fetch_by_wrapper(wallet_rb, "", &token_query_wrapper).await? {
                Ok(token_default.contract_address)
            }else {
                let msg = format!("token shared id {},{} not exist in token liberay",token_shared_id,net_type);
                Err(WalletError::Custom(msg))
            }
    }

    pub async fn update_address_balance(&self, token_address: &TokenAddress) -> Result<(), WalletError> {
        let data_rb = self.db().data_db(&self.net_type);
        // use the same field in m_eee_chain_token,m_eth_chain_token,m_btc_chain_token
        let token_query_wrapper = data_rb.new_wrapper()
            .eq(&MEthChainToken::wallet_id, &token_address.wallet_id)
            .eq(&MEthChainToken::chain_type, &token_address.chain_type)
            .eq(&MEthChainToken::chain_token_shared_id, &token_address.token_id);
        let mut tx = data_rb.begin_tx_defer(false).await?;
        let chain_type = ChainType::from(&token_address.chain_type)?;
        match chain_type {
            ChainType::EthPrivateTest | ChainType::EthPrivate | ChainType::EthTest | ChainType::ETH => {
                if MEthChainToken::fetch_by_wrapper(data_rb, &tx.tx_id, &token_query_wrapper).await?.is_none() {
                    let contract_addr = self.query_contract_by_shared_id(&token_address.token_id,&self.net_type.to_string()).await?;
                    let mut token = MEthChainToken::default();
                    token.chain_token_shared_id = token_address.token_id.clone();
                    token.wallet_id = token_address.wallet_id.clone();
                    token.chain_type = token_address.chain_type.to_string();
                    token.show = CTrue;
                    token.contract_address = contract_addr;
                    token.save_update(data_rb, &tx.tx_id).await?;
                }
            }
            ChainType::EeePrivateTest | ChainType::EeePrivate | ChainType::EeeTest | ChainType::EEE => {
                if MEeeChainToken::fetch_by_wrapper(data_rb, &tx.tx_id, &token_query_wrapper).await?.is_none() {
                    let mut token = MEeeChainToken::default();
                    token.chain_token_shared_id = token_address.token_id.clone();
                    token.wallet_id = token_address.wallet_id.clone();
                    token.chain_type = token_address.chain_type.to_string();
                    token.show = CTrue;
                    token.save_update(data_rb, &tx.tx_id).await?;
                }
            }
            ChainType::BtcPrivateTest | ChainType::BtcPrivate | ChainType::BtcTest | ChainType::BTC => {
                if MBtcChainToken::fetch_by_wrapper(data_rb, &tx.tx_id, &token_query_wrapper).await?.is_none() {
                    let mut token = MBtcChainToken::default();
                    token.chain_token_shared_id = token_address.token_id.clone();
                    token.wallet_id = token_address.wallet_id.clone();
                    token.chain_type = token_address.chain_type.to_string();
                    token.show = CTrue;
                    token.save_update(data_rb, &tx.tx_id).await?;
                }
            }
        }

        let token_address_wrapper = data_rb
            .new_wrapper()
            .eq(&MTokenAddress::wallet_id, &token_address.wallet_id)
            .eq(&MTokenAddress::chain_type, &token_address.chain_type)
            .eq(&MTokenAddress::token_id, &token_address.token_id)
            .eq(&MTokenAddress::address_id, &token_address.address_id);
        if let Some(mut target_address) =
        MTokenAddress::fetch_by_wrapper(data_rb, &tx.tx_id, &token_address_wrapper).await?
        {
            target_address.balance = token_address.balance.clone();
            target_address.status = 1;
            target_address.save_update(data_rb, &tx.tx_id).await?;
        } else {
            let mut token_address_instance = token_address.clone();
            token_address_instance.m.status = 1;
            token_address_instance.save(data_rb, &tx.tx_id).await?;
        }

        data_rb.commit(&tx.tx_id).await?;
        tx.manager = None;
        Ok(())
    }
    pub async fn query_address_balance(&self, wallet_id: &str) -> Result<Vec<TokenAddress>, WalletError> {
        let data_rb = self.db().data_db(&self.net_type);
        let token_address_wrapper = data_rb
            .new_wrapper()
            .eq(&MTokenAddress::wallet_id, wallet_id)
            .eq(&MTokenAddress::status, 1);
        let m_address_balance =
            MTokenAddress::list_by_wrapper(data_rb, "", &token_address_wrapper).await?;
        let address_ret = m_address_balance
            .iter()
            .map(|address| TokenAddress { m: address.clone() })
            .collect::<Vec<TokenAddress>>();
        Ok(address_ret)
    }

    pub async fn change_wallet_token_show_status(&self, wallet_token: &WalletTokenStatus) -> Result<(), WalletError> {
        let data_rb = self.db().data_db(&self.net_type);
        let chain_token_wrapper = data_rb.new_wrapper()
            .eq(&MEthChainToken::wallet_id, &wallet_token.wallet_id)
            .eq(&MEthChainToken::chain_type, &wallet_token.chain_type)
            .eq(&MEthChainToken::chain_token_shared_id, &wallet_token.token_id);

        match ChainType::from(&wallet_token.chain_type)? {
            ChainType::ETH | ChainType::EthTest | ChainType::EthPrivate | ChainType::EthPrivateTest => {
                if let Some(mut target_address) = MEthChainToken::fetch_by_wrapper(data_rb, "", &chain_token_wrapper).await? {
                    target_address.show = wallet_token.is_show;
                    target_address.save_update(data_rb, "").await?;
                    Ok(())
                } else {
                    let msg = format!("wallet {} will hide token {} on chain {} not exist!", wallet_token.wallet_id, wallet_token.token_id, wallet_token.chain_type);
                    Err(WalletError::Fail(msg))
                }
            }
            ChainType::BTC | ChainType::BtcTest | ChainType::BtcPrivate | ChainType::BtcPrivateTest => {
                if let Some(mut target_address) = MBtcChainToken::fetch_by_wrapper(data_rb, "", &chain_token_wrapper).await? {
                    target_address.show = wallet_token.is_show;
                    target_address.save_update(data_rb, "").await?;
                    Ok(())
                } else {
                    let msg = format!("wallet {} will hide token {} not exist!", wallet_token.wallet_id, wallet_token.token_id);
                    Err(WalletError::Fail(msg))
                }
            }
            ChainType::EEE | ChainType::EeeTest | ChainType::EeePrivate | ChainType::EeePrivateTest => {
                if let Some(mut target_address) = MEeeChainToken::fetch_by_wrapper(data_rb, "", &chain_token_wrapper).await? {
                    target_address.show = wallet_token.is_show;
                    target_address.save_update(data_rb, "").await?;
                    Ok(())
                } else {
                    let msg = format!("wallet {} will hide token {} not exist!", wallet_token.wallet_id, wallet_token.token_id);
                    Err(WalletError::Fail(msg))
                }
            }
        }
    }
}

impl ContextTrait for Wallets {
    fn db(&self) -> &Db {
        &self.db
    }

    fn stopped(&self) -> bool {
        self.stopped.load(Ordering::SeqCst) //todo
    }

    fn set_stopped(&mut self, s: bool) {
        self.stopped.store(s, Ordering::SeqCst); //todo
    }
}
