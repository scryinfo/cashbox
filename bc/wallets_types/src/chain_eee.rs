use async_trait::async_trait;
use rbatis::crud::CRUDEnable;

use mav::{ChainType, NetType, WalletType};
use mav::kits::sql_left_join_get_b;
use mav::ma::{Dao, MEeeChainToken, MEeeChainTokenDefault, MEeeChainTokenShared, MWallet,MSubChainBasicInfo, MAccountInfoSyncProg};

use crate::{Address, Chain2WalletType, ChainShared, ContextTrait, deref_type, Load, TokenShared, WalletError};
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
    pub token_shared: TokenShared,
}
deref_type!(EeeChainTokenShared,MEeeChainTokenShared);

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
    pub async fn list_by_net_type(context: &dyn ContextTrait, net_type: &NetType) -> Result<Vec<MEeeChainTokenDefault>, WalletError> {
        let tx_id = "";
        let wallets_db = context.db().wallets_db();
        let tokens_shared: Vec<MEeeChainTokenShared> = {
            let mut wrapper = wallets_db.new_wrapper();
            let default_name = MEeeChainTokenDefault::table_name();
            let shared_name = MEeeChainTokenShared::table_name();
            wrapper.eq(format!("{}.{}", default_name, MEeeChainTokenDefault::net_type).as_str(), net_type.to_string());

            let sql = {
                wrapper = wrapper.check()?;
                let t = sql_left_join_get_b(&default_name, &MEeeChainTokenDefault::chain_token_shared_id,
                                            &shared_name, &MEeeChainTokenShared::id);
                format!("{} where {}", t, &wrapper.sql)
            };
            wallets_db.fetch_prepare(tx_id, &sql, &wrapper.args).await?
        };

        let mut tokens_default = {
            let mut wrapper = wallets_db.new_wrapper();
            wrapper.eq(MEeeChainTokenDefault::net_type, net_type.to_string());
            wrapper.order_by(true, &[MEeeChainTokenDefault::position]);
            MEeeChainTokenDefault::list_by_wrapper(wallets_db, tx_id, &wrapper).await?
        };
        for token_default in &mut tokens_default {
            for token_shared in &tokens_shared {
                if token_default.chain_token_shared_id == token_shared.id {
                    token_default.chain_token_shared = token_shared.clone();
                }
            }
        }
        Ok(tokens_default)
    }
}


#[derive(Debug, Default)]
pub struct EeeChain {
    pub chain_shared: ChainShared,
    pub address: Address,
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

        {//load token
            let rb = context.db().data_db( &NetType::from(&mw.net_type));
            let mut wrapper = rb.new_wrapper();
            wrapper.eq(MEeeChainToken::wallet_id, mw.id.clone()).eq(MEeeChainToken::chain_type, self.chain_shared.chain_type.clone());
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


#[derive(Debug,Default, Clone)]
pub struct AccountInfoSyncProg {
    m:MAccountInfoSyncProg
}
deref_type!(AccountInfoSyncProg,MAccountInfoSyncProg);

impl From<MAccountInfoSyncProg> for AccountInfoSyncProg{
    fn from(m_sync_prog: MAccountInfoSyncProg) -> Self {
        let mut info =  AccountInfoSyncProg{
            m: Default::default()
        };
        info.m = m_sync_prog;
        info
    }
}

impl AccountInfoSyncProg{
    pub async fn find_by_account(rb: &Rbatis, account: &str) -> Result<Option<MAccountInfoSyncProg>, WalletError> {
        let mut wrapper = rb.new_wrapper();
        wrapper.eq(MAccountInfoSyncProg::account, account.to_string());
        let r = MAccountInfoSyncProg::fetch_by_wrapper(rb, "", &wrapper).await?.map(|info|info.into());
        Ok(r)
    }
}

#[derive(Debug, Default, Clone)]
pub struct SubChainBasicInfo {
    m:MSubChainBasicInfo
}
deref_type!(SubChainBasicInfo,MSubChainBasicInfo);

impl From<MSubChainBasicInfo> for SubChainBasicInfo{
    fn from(m_sub_info: MSubChainBasicInfo) -> Self {
        let mut info =  SubChainBasicInfo{
            m: Default::default()
        };
        info.m = m_sub_info;
        info
    }
}

impl SubChainBasicInfo{
    pub async fn find_by_version(rb: &Rbatis, genesis_hash: &str,runtime_version:i32,tx_version:i32) -> Result<Option<SubChainBasicInfo>, WalletError> {
        let mut wrapper = rb.new_wrapper();
        wrapper.eq(MSubChainBasicInfo::genesis_hash, genesis_hash.to_string());
        wrapper.eq(MSubChainBasicInfo::runtime_version, runtime_version);
        wrapper.eq(MSubChainBasicInfo::tx_version, tx_version);
        let r = MSubChainBasicInfo::fetch_by_wrapper(rb, "", &wrapper).await?.map(|info|info.into());
        Ok(r)
    }
}


