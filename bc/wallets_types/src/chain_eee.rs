use async_trait::async_trait;
use rbatis::crud::CRUDTable;

use mav::{ChainType, NetType, WalletType, CTrue};
use mav::kits::sql_left_join_get_b;
use mav::ma::{Dao, MEeeChainToken, MEeeChainTokenDefault, MEeeChainTokenShared, MWallet, MSubChainBasicInfo, MAccountInfoSyncProg, MEeeChainTokenAuth};

use crate::{Address, Chain2WalletType, ChainShared, ContextTrait, deref_type, Load, WalletError};
use rbatis::rbatis::Rbatis;

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
        let wallets_db = context.db().wallets_db();
        let tokens_shared: Vec<MEeeChainTokenShared> = {
            let default_name = MEeeChainTokenDefault::table_name();
            let shared_name = MEeeChainTokenShared::table_name();
            let wrapper =  wallets_db.new_wrapper().eq(format!("{}.{}", default_name, MEeeChainTokenDefault::net_type).as_str(), net_type.to_string());

            let sql = {
                let t = sql_left_join_get_b(&default_name, &MEeeChainTokenDefault::chain_token_shared_id,
                                            &shared_name, &MEeeChainTokenShared::id);
                format!("{} where {}", t, &wrapper.sql)
            };
            wallets_db.fetch_prepare(tx_id, &sql, &wrapper.args).await?
        };

        let mut tokens_default = {
            let wrapper = wallets_db.new_wrapper()
                .eq(MEeeChainTokenDefault::net_type, net_type.to_string())
                .order_by(true, &[MEeeChainTokenDefault::position]);
            MEeeChainTokenDefault::list_by_wrapper(wallets_db, tx_id, &wrapper).await?
        };
        for token_default in &mut tokens_default {
            for token_shared in &tokens_shared {
                if token_default.chain_token_shared_id == token_shared.id {
                    token_default.chain_token_shared = token_shared.clone();
                }
            }
        }
        let eee_tokens = tokens_default.iter().map(|token|EeeChainTokenDefault{
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

impl EeeChainTokenAuth{
    pub async fn list_by_net_type(context: &dyn ContextTrait, net_type: &NetType, start_item: u64, page_size: u64) -> Result<Vec<EeeChainTokenAuth>, WalletError> {
        let tx_id = "";
        let wallets_db = context.db().wallets_db();
        let page_query = format!(" limit {} offset {}", page_size, start_item);
        let mut tokens_auth = {
            let wrapper = wallets_db.new_wrapper()
                .eq(MEeeChainTokenAuth::net_type, net_type.to_string())
                .order_by(false, &[MEeeChainTokenAuth::create_time]).push_sql(&page_query);
            MEeeChainTokenAuth::list_by_wrapper(wallets_db, tx_id, &wrapper).await?
        };
        let token_shared_id = format!("id in (SELECT {} FROM {} WHERE {}='{}' ORDER by {} desc {})",
                                      MEeeChainTokenAuth::chain_token_shared_id, MEeeChainTokenAuth::table_name(), MEeeChainTokenAuth::net_type, net_type.to_string(), MEeeChainTokenAuth::create_time, page_query);
        let token_shared_wrapper = wallets_db.new_wrapper().push_sql(&token_shared_id);
        let tokens_shared = MEeeChainTokenShared::list_by_wrapper(wallets_db, tx_id, &token_shared_wrapper).await?;
        let mut target_tokens = vec![];
        for token_auth in &mut tokens_auth {
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
    fn chain_type(wallet_type: &WalletType) -> ChainType {
        match wallet_type {
            WalletType::Normal => ChainType::EEE,
            _ => ChainType::EeeTest,
        }
    }

    fn to_chain_type(&self, wallet_type: &WalletType) -> ChainType {
        EeeChain::chain_type(wallet_type)
    }
}

#[async_trait]
impl Load for EeeChain {
    type MType = MWallet;
    async fn load(&mut self, context: &dyn ContextTrait, mw: MWallet) -> Result<(), WalletError> {
        self.chain_shared.set_m(&mw);
        let wallet_type = WalletType::from(&mw.wallet_type);
        self.chain_shared.m.chain_type = self.to_chain_type(&wallet_type).to_string();

        {//load address
            let wallet_id = self.chain_shared.wallet_id.clone();
            let chain_type = self.chain_shared.chain_type.clone();
            self.chain_shared.set_addr(context,&wallet_id,&chain_type).await?;
        }

        {//load address
            let mut addr = Address::default();
            addr.load(context,&self.chain_shared.wallet_id,&self.chain_shared.chain_type).await?;
            self.chain_shared.wallet_address= addr;
        }
        {//load token
            let rb = context.db().data_db(&NetType::from(&mw.net_type));
            let wrapper = rb.new_wrapper()
                .eq(MEeeChainToken::wallet_id, mw.id.clone())
                .eq(MEeeChainToken::chain_type, self.chain_shared.chain_type.clone());
            let ms = MEeeChainToken::list_by_wrapper(&rb, "", &wrapper).await?;
            self.tokens.clear();
            for it in ms {
                let mut token = EeeChainToken::default();
                token.load(context, it).await?;
                self.tokens.push(token);
            }
        }
        Ok(())
    }
}


#[derive(Debug, Default, Clone)]
pub struct AccountInfoSyncProg {
    m: MAccountInfoSyncProg
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
    pub async fn find_by_account(rb: &Rbatis, account: &str) -> Result<Option<MAccountInfoSyncProg>, WalletError> {
        let wrapper = rb.new_wrapper()
            .eq(MAccountInfoSyncProg::account, account.to_string());
        let r = MAccountInfoSyncProg::fetch_by_wrapper(rb, "", &wrapper).await?.map(|info| info.into());
        Ok(r)
    }
}

#[derive(Debug, Default, Clone)]
pub struct SubChainBasicInfo {
    m: MSubChainBasicInfo
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
    pub async fn find_by_version(rb: &Rbatis, genesis_hash: &str, runtime_version: i32, tx_version: i32) -> Result<Option<SubChainBasicInfo>, WalletError> {
        let wrapper = rb.new_wrapper()
            .eq(MSubChainBasicInfo::genesis_hash, genesis_hash.to_string())
            .eq(MSubChainBasicInfo::runtime_version, runtime_version)
            .eq(MSubChainBasicInfo::tx_version, tx_version);
        let r = MSubChainBasicInfo::fetch_by_wrapper(rb, "", &wrapper).await?.map(|info| info.into());
        Ok(r)
    }
    pub async fn get_default_version(rb: &Rbatis) -> Result<Option<SubChainBasicInfo>, WalletError> {
        let wrapper = rb.new_wrapper().eq(MSubChainBasicInfo::is_default, CTrue);
        let r = MSubChainBasicInfo::fetch_by_wrapper(rb, "", &wrapper).await?.map(|info| info.into());
        Ok(r)
    }
}


