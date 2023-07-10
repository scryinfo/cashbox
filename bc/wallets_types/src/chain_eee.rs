use async_trait::async_trait;
use rbatis::rbatis::RBatis;
use rbatis::sql::{IPage, PageRequest};

use mav::{ChainType, CTrue, NetType, WalletType};
use mav::kits::sql_left_join_get_b;
use mav::ma::{MAccountInfoSyncProg, MEeeChainToken, MEeeChainTokenAuth, MEeeChainTokenDefault, MEeeChainTokenShared, MSubChainBasicInfo, MWallet, Shared};

use crate::{Chain2WalletType, ChainShared, ContextTrait, deref_type, Load, WalletError};

#[derive(Debug, Default)]
pub struct EeeChainToken {
    pub m: MEeeChainToken,
    pub eee_chain_token_shared: EeeChainTokenShared,
}
deref_type!(EeeChainToken,MEeeChainToken);

#[async_trait]
impl Load for EeeChainToken {
    type MType = MEeeChainToken;
    async fn load(&mut self, context: &dyn ContextTrait, m: Self::MType) -> Result<(), WalletError> {
        self.m = m;
        let rb = context.db().wallets_db();
        let token_shared = MEeeChainTokenShared::fetch_by_id(rb, "", &self.chain_token_shared_id).await?;
        let token_shared = token_shared.ok_or_else(||
            WalletError::NoneError(format!("do not find id:{}, in {}", &self.chain_token_shared_id, MEeeChainTokenShared::table_name())))?;
        self.eee_chain_token_shared.load(context, token_shared).await?;
        Ok(())
    }
}

#[derive(Debug, Default)]
pub struct EeeChainTokenShared {
    pub m: MEeeChainTokenShared,
    //pub token_shared: TokenShared,
}
deref_type!(EeeChainTokenShared,MEeeChainTokenShared);

impl From<MEeeChainTokenShared> for EeeChainTokenShared {
    fn from(token_shared: MEeeChainTokenShared) -> Self {
        Self {
            m: token_shared,
        }
    }
}

#[async_trait]
impl Load for EeeChainTokenShared {
    type MType = MEeeChainTokenShared;
    async fn load(&mut self, _: &dyn ContextTrait, m: Self::MType) -> Result<(), WalletError> {
        self.m = m;
        //self.token_shared.m = self.m.token_shared.clone();
        Ok(())
    }
}

#[derive(Debug, Default)]
pub struct EeeChainTokenDefault {
    pub m: MEeeChainTokenDefault,
    pub eee_chain_token_shared: EeeChainTokenShared,
}
deref_type!(EeeChainTokenDefault,MEeeChainTokenDefault);


impl EeeChainTokenDefault {
    pub async fn list_by_net_type(context: &dyn ContextTrait, net_type: &NetType) -> Result<Vec<EeeChainTokenDefault>, WalletError> {
        let tx_id = "";
        let mut wallets_db = context.db().wallets_db();
        let tokens_shared: Vec<MEeeChainTokenShared> = {
            MEeeChainTokenShared::list_by_net_type(&mut wallets_db, &net_type.to_string()).await?
        };

        let mut tokens_default = {
            MEeeChainTokenDefault::select_by_net_type_status_order_position(&mut wallets_db, &net_type.to_string(), CTrue as i64).await?
        };
        for token_default in &mut tokens_default {
            for token_shared in &tokens_shared {
                if token_default.chain_token_shared_id == token_shared.id {
                    token_default.chain_token_shared = token_shared.clone();
                }
            }
        }
        let eee_tokens = tokens_default.iter().map(|token| EeeChainTokenDefault {
            m: token.clone(),
            eee_chain_token_shared: EeeChainTokenShared::from(token.chain_token_shared.clone()),
        }).collect::<Vec<EeeChainTokenDefault>>();
        Ok(eee_tokens)
    }
}

#[derive(Debug, Default)]
pub struct EeeChainTokenAuth {
    pub m: MEeeChainTokenAuth,
    pub eee_chain_token_shared: EeeChainTokenShared,
}
deref_type!(EeeChainTokenAuth,MEeeChainTokenAuth);

impl EeeChainTokenAuth {
    pub async fn list_by_net_type(context: &dyn ContextTrait, net_type: &NetType, start_item: u64, page_size: u64) -> Result<Vec<EeeChainTokenAuth>, WalletError> {
        let tx_id = "";
        let mut wallets_db = context.db().wallets_db();
        let page_query = format!(" limit {} offset {}", page_size, start_item);
        let mut tokens_auth = {
            MEeeChainTokenAuth::select_net_type_status_order_create_time(&mut wallets_db, &PageRequest::new(start_item, page_size), &net_type.to_string(), CTrue as i64).await?
        };
        let tokens_shared = MEeeChainTokenShared::select_left_net_type_order_create_time(&mut wallets_db, &net_type.to_string(), page_size, start_item).await?;
        let mut target_tokens = vec![];
        for token_auth in tokens_auth.get_records() {
            for token_shared in &tokens_shared {
                let mut token = EeeChainTokenAuth::default();
                if token_auth.chain_token_shared_id == token_shared.id {
                    token.m = token_auth.clone();
                    token.eee_chain_token_shared = EeeChainTokenShared::from(token_shared.clone());
                    target_tokens.push(token)
                }
            }
        }
        Ok(target_tokens)
    }
}


#[derive(Debug, Default)]
pub struct EeeChain {
    pub chain_shared: ChainShared,
    //  pub address: Address,
    pub tokens: Vec<EeeChainToken>,
}

impl Chain2WalletType for EeeChain {
    fn chain_type(wallet_type: &WalletType, net_type: &NetType) -> ChainType {
        match (wallet_type, net_type) {
            (WalletType::Normal, NetType::Main) => ChainType::EEE,
            (WalletType::Test, NetType::Test) => ChainType::EeeTest,
            (WalletType::Test, NetType::Private) => ChainType::EeePrivate,
            (WalletType::Test, NetType::PrivateTest) => ChainType::EeePrivateTest,
            _ => ChainType::EeeTest,
        }
    }
}

/*#[async_trait]*/
impl EeeChain {
    pub async fn load(&mut self, context: &dyn ContextTrait, mw: MWallet, net_type: &NetType) -> Result<(), WalletError> {
        self.chain_shared.set_m(&mw);

        let wallet_type = WalletType::from(mw.wallet_type.as_str());
        let chain_type = EeeChain::chain_type(&wallet_type, &net_type).to_string();
        {//load address
            let wallet_id = self.chain_shared.wallet_id.clone();
            self.chain_shared.set_addr(context, &wallet_id, &chain_type).await?;
            self.chain_shared.m.chain_type = chain_type.clone();
        }

        {//load token
            let mut rb = context.db().data_db(&net_type);
            let w = MEeeChainToken::select_by_wallet_id_and_chain_type(&mut rb, &mw.id, &chain_type).await?;
            if let Some(w) = w {
                self.tokens.clear();
                let mut token = EeeChainToken::default();
                token.load(context, w).await?;
                self.tokens.push(token);
            }
        }
        Ok(())
    }
}


#[derive(Debug, Default, Clone)]
pub struct AccountInfoSyncProg {
    m: MAccountInfoSyncProg,
}
deref_type!(AccountInfoSyncProg,MAccountInfoSyncProg);

impl From<MAccountInfoSyncProg> for AccountInfoSyncProg {
    fn from(m_sync_prog: MAccountInfoSyncProg) -> Self {
        let mut info = AccountInfoSyncProg {
            m: Default::default()
        };
        info.m = m_sync_prog;
        info
    }
}

impl AccountInfoSyncProg {
    pub async fn find_by_account(rb: &mut RBatis, account: &str) -> Result<Option<MAccountInfoSyncProg>, WalletError> {
        let r = MAccountInfoSyncProg::select_by_column(rb, MAccountInfoSyncProg::account, account.to_string()).await?;
        let r = r.first().cloned();
        Ok(r)
    }
}

#[derive(Debug, Default, Clone)]
pub struct SubChainBasicInfo {
    m: MSubChainBasicInfo,
}
deref_type!(SubChainBasicInfo,MSubChainBasicInfo);

impl From<MSubChainBasicInfo> for SubChainBasicInfo {
    fn from(m_sub_info: MSubChainBasicInfo) -> Self {
        let mut info = SubChainBasicInfo {
            m: Default::default()
        };
        info.m = m_sub_info;
        info
    }
}

impl SubChainBasicInfo {
    pub async fn find_by_version(rb: &mut RBatis, genesis_hash: &str, runtime_version: i32, tx_version: i32) -> Result<Option<SubChainBasicInfo>, WalletError> {
        let r = MSubChainBasicInfo::select_genesis_hash_runtime_version_tx_version(rb, &genesis_hash.to_string(), &runtime_version.to_string(), tx_version).await?.map(|info| info.into());
        Ok(r)
    }
    pub async fn get_default_version(rb: &RBatis) -> Result<Option<SubChainBasicInfo>, WalletError> {
        let wrapper = rb.new_wrapper().eq(MSubChainBasicInfo::is_default, CTrue);
        let r = MSubChainBasicInfo(rb, "", &wrapper).await?.map(|info| info.into());
        Ok(r)
    }
}


