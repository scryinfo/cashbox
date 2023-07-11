use async_trait::async_trait;
use rbatis::sql::{IPage, PageRequest};

use mav::{ChainType, CTrue, NetType, WalletType};
use mav::ma::{MBtcChainToken, MBtcChainTokenAuth, MBtcChainTokenDefault, MBtcChainTokenShared, MWallet, Shared};

use crate::{Chain2WalletType, ChainShared, ContextTrait, deref_type, Load, WalletError};

// use rbatis::crud::CRUDTable;

#[derive(Debug, Default)]
pub struct BtcChainToken {
    pub m: MBtcChainToken,
    pub btc_chain_token_shared: BtcChainTokenShared,
}
deref_type!(BtcChainToken,MBtcChainToken);

#[async_trait]
impl Load for BtcChainToken {
    type MType = MBtcChainToken;
    async fn load(&mut self, context: &dyn ContextTrait, m: Self::MType) -> Result<(), WalletError> {
        self.m = m;
        let mut rb = context.db().wallets_db();
        let token_shared = MBtcChainTokenShared::select_by_id(&mut rb, &self.chain_token_shared_id).await?;
        let token_shared = token_shared.ok_or_else(||
            WalletError::NoneError(format!("do not find id:{}, in {}", &self.chain_token_shared_id, MBtcChainTokenShared::table_name())))?;
        self.btc_chain_token_shared.load(context, token_shared).await?;
        Ok(())
    }
}

#[derive(Debug, Default)]
pub struct BtcChainTokenShared {
    pub m: MBtcChainTokenShared,
    //pub token_shared: TokenShared,
}
deref_type!(BtcChainTokenShared,MBtcChainTokenShared);

impl From<MBtcChainTokenShared> for BtcChainTokenShared {
    fn from(token_shared: MBtcChainTokenShared) -> Self {
        Self {
            m: token_shared,
        }
    }
}

#[async_trait]
impl Load for BtcChainTokenShared {
    type MType = MBtcChainTokenShared;
    async fn load(&mut self, _: &dyn ContextTrait, m: Self::MType) -> Result<(), WalletError> {
        self.m = m;
        Ok(())
    }
}

#[derive(Debug, Default)]
pub struct BtcChainTokenDefault {
    pub m: MBtcChainTokenDefault,
    pub btc_chain_token_shared: BtcChainTokenShared,
}
deref_type!(BtcChainTokenDefault,MBtcChainTokenDefault);



impl BtcChainTokenDefault {
    pub async fn list_by_net_type(context: &dyn ContextTrait, net_type: &NetType) -> Result<Vec<BtcChainTokenDefault>, WalletError> {
        let mut wallets_db = context.db().wallets_db();
        let tokens_shared: Vec<MBtcChainTokenShared> = {
            MBtcChainTokenShared::list_by_net_type(&mut wallets_db,&net_type.to_string()).await?
        };

        let mut tokens_default = {
            MBtcChainTokenDefault::select_net_type_statis_order_position(
                &mut wallets_db, &net_type.to_string(), CTrue as i64).await?
        };
        for token_default in &mut tokens_default {
            for token_shared in &tokens_shared {
                if token_default.chain_token_shared_id == token_shared.id {
                    token_default.chain_token_shared = token_shared.clone();
                }
            }
        }
        let btc_tokens = tokens_default.iter().map(|token| BtcChainTokenDefault {
            m: token.clone(),
            btc_chain_token_shared: BtcChainTokenShared::from(token.chain_token_shared.clone()),
        }).collect::<Vec<BtcChainTokenDefault>>();
        Ok(btc_tokens)
    }
}

#[derive(Debug, Default)]
pub struct BtcChainTokenAuth {
    pub m: MBtcChainTokenAuth,
    pub btc_chain_token_shared: BtcChainTokenShared,
}
deref_type!(BtcChainTokenAuth,MBtcChainTokenAuth);


impl BtcChainTokenAuth {
    pub async fn list_by_net_type(context: &dyn ContextTrait, net_type: &NetType, start_item: u64, page_size: u64) -> Result<Vec<BtcChainTokenAuth>, WalletError> {
        let mut wallets_db = context.db().wallets_db();
        let tokens_auth = {
            MBtcChainTokenAuth::select_net_type_status_order_create_time(
                &mut wallets_db, &PageRequest::new(start_item, page_size),
                &net_type.to_string(), CTrue as i64).await?
        };
        let tokens_shared = MBtcChainTokenShared::select_auth_page_net_type_and_id_in(&mut wallets_db, &net_type.to_string(), start_item,page_size).await?;
        let mut target_tokens = vec![];
        for token_auth in  tokens_auth.get_records() {
            for token_shared in &tokens_shared {
                let mut token = BtcChainTokenAuth::default();
                if token_auth.chain_token_shared_id == token_shared.id {
                    token.m = token_auth.clone();
                    token.btc_chain_token_shared = BtcChainTokenShared::from(token_shared.clone());
                    target_tokens.push(token)
                }
            }
        }
        Ok(target_tokens)
    }
}

#[derive(Debug, Default)]
pub struct BtcChain {
    pub chain_shared: ChainShared,
    pub tokens: Vec<BtcChainToken>,
}

impl Chain2WalletType for BtcChain {
    fn chain_type(wallet_type: &WalletType, net_type: &NetType) -> ChainType {
        match (wallet_type, net_type) {
            (WalletType::Normal, NetType::Main) => ChainType::BTC,
            (WalletType::Test, NetType::Test) => ChainType::BtcTest,
            (WalletType::Test, NetType::Private) => ChainType::BtcPrivate,
            (WalletType::Test, NetType::PrivateTest) => ChainType::BtcPrivateTest,
            _ => ChainType::BtcTest,
        }
    }
}

/*#[async_trait]*/
impl BtcChain {
    pub async fn load(&mut self, context: &dyn ContextTrait, mw: MWallet, net_type: &NetType) -> Result<(), WalletError> {
        self.chain_shared.set_m(&mw);
        // let wallet_type = WalletType::from(&mw.wallet_type);
        // self.chain_shared.m.chain_type = self.to_chain_type(&wallet_type).to_string();
        let wallet_type = WalletType::from(mw.wallet_type.as_str());
        let chain_type = BtcChain::chain_type(&wallet_type, &net_type).to_string();
        {//load address
            let wallet_id = self.chain_shared.wallet_id.clone();
            self.chain_shared.set_addr(context, &wallet_id, &chain_type).await?;
            self.chain_shared.m.chain_type = chain_type.clone();
        }
        {//load token
            let mut rb = context.db().data_db(&net_type);
            let w = MBtcChainToken::select_by_wallet_id_and_chain_type(&mut rb, &mw.id, &chain_type).await?;
            if let Some(w) = w {
                self.tokens.clear();
                let mut token = BtcChainToken::default();
                token.load(context, w).await?;
                self.tokens.push(token);
            }
        }
        Ok(())
    }
}

#[derive(Debug, Default, Clone)]
pub struct BtcNowLoadBlock {
    pub height: u64,
    pub header_hash: String,
    pub timestamp: String,
}

#[derive(Debug, Default, Clone)]
pub struct BtcBalance {
    pub balance: u64,
    pub height: u64,
}