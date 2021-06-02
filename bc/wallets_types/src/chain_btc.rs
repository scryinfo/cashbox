use async_trait::async_trait;
use rbatis::crud::CRUDTable;

use mav::{ChainType, NetType, WalletType, CTrue};
use mav::kits::sql_left_join_get_b;
use mav::ma::{Dao, MBtcChainToken, MBtcChainTokenDefault, MBtcChainTokenShared, MWallet, MBtcChainTokenAuth};

use crate::{Chain2WalletType, ChainShared, ContextTrait, deref_type, Load, WalletError};

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
        let rb = context.db().wallets_db();
        let token_shared = MBtcChainTokenShared::fetch_by_id(rb, "", &self.chain_token_shared_id).await?;
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
        let tx_id = "";
        let wallets_db = context.db().wallets_db();
        let tokens_shared: Vec<MBtcChainTokenShared> = {
            let default_name = MBtcChainTokenDefault::table_name();
            let shared_name = MBtcChainTokenShared::table_name();
            let wrapper = wallets_db.new_wrapper()
                .eq(format!("{}.{}", default_name, MBtcChainTokenDefault::net_type).as_str(), net_type.to_string());

            let sql = {
                //wrapper = wrapper;
                let t = sql_left_join_get_b(&default_name, &MBtcChainTokenDefault::chain_token_shared_id,
                                            &shared_name, &MBtcChainTokenShared::id);
                format!("{} where {}", t, &wrapper.sql)
            };
            wallets_db.fetch_prepare(tx_id, &sql, &wrapper.args).await?
        };

        let mut tokens_default = {
            let wrapper = wallets_db.new_wrapper()
                .eq(MBtcChainTokenDefault::net_type, net_type.to_string())
                .eq(MBtcChainTokenDefault::status, CTrue)

                .order_by(true, &[MBtcChainTokenDefault::position]);
            MBtcChainTokenDefault::list_by_wrapper(wallets_db, tx_id, &wrapper).await?
        };
        for token_default in &mut tokens_default {
            for token_shared in &tokens_shared {
                if token_default.chain_token_shared_id == token_shared.id {
                    token_default.chain_token_shared = token_shared.clone();
                }
            }
        }
        let btc_tokens = tokens_default.iter().map(|token|BtcChainTokenDefault{
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


impl BtcChainTokenAuth{
    pub async fn list_by_net_type(context: &dyn ContextTrait, net_type: &NetType, start_item: u64, page_size: u64) -> Result<Vec<BtcChainTokenAuth>, WalletError> {
        let tx_id = "";
        let wallets_db = context.db().wallets_db();
        let page_query = format!(" limit {} offset {}", page_size, start_item);
        let mut tokens_auth = {
            let wrapper = wallets_db.new_wrapper()
                .eq(MBtcChainTokenAuth::net_type, net_type.to_string())
                .eq(MBtcChainTokenAuth::status, CTrue)
                .order_by(false, &[MBtcChainTokenAuth::create_time]).push_sql(&page_query);
            MBtcChainTokenAuth::list_by_wrapper(wallets_db, tx_id, &wrapper).await?
        };
        let token_shared_id = format!("id in (SELECT {} FROM {} WHERE {}='{}' ORDER by {} desc {})",
                                      MBtcChainTokenAuth::chain_token_shared_id, MBtcChainTokenAuth::table_name(), MBtcChainTokenAuth::net_type, net_type.to_string(), MBtcChainTokenAuth::create_time, page_query);
        let token_shared_wrapper = wallets_db.new_wrapper().push_sql(&token_shared_id);
        let tokens_shared = MBtcChainTokenShared::list_by_wrapper(wallets_db, tx_id, &token_shared_wrapper).await?;
        let mut target_tokens = vec![];
        for token_auth in &mut tokens_auth {
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
    fn chain_type(wallet_type: &WalletType,net_type:&NetType) -> ChainType {
        match (wallet_type,net_type) {
            (WalletType::Normal,NetType::Main) => ChainType::BTC,
            (WalletType::Test,NetType::Test) => ChainType::BtcTest,
            (WalletType::Test,NetType::Private) => ChainType::BtcPrivate,
            (WalletType::Test,NetType::PrivateTest) => ChainType::BtcPrivateTest,
            _ => ChainType::BtcTest,
        }
    }
   /* fn to_chain_type(&self, wallet_type: &WalletType) -> ChainType {
        BtcChain::chain_type(wallet_type)
    }*/
}

/*#[async_trait]*/
impl BtcChain {
    pub async fn load(&mut self, context: &dyn ContextTrait, mw: MWallet,net_type:&NetType) -> Result<(), WalletError> {
        self.chain_shared.set_m(&mw);
       // let wallet_type = WalletType::from(&mw.wallet_type);
       // self.chain_shared.m.chain_type = self.to_chain_type(&wallet_type).to_string();
        let wallet_type = WalletType::from(mw.wallet_type.as_str());
        let chain_type =  BtcChain::chain_type(&wallet_type, &net_type).to_string();
        {//load address
            let wallet_id = self.chain_shared.wallet_id.clone();
            self.chain_shared.set_addr(context, &wallet_id, &chain_type).await?;
            self.chain_shared.m.chain_type = chain_type.clone();
        }
        {//load token
            let rb = context.db().data_db( &net_type);
            let wrapper = rb.new_wrapper()
                .eq(MBtcChainToken::wallet_id, mw.id.clone())
                .eq(MBtcChainToken::chain_type, chain_type);
            let ms = MBtcChainToken::list_by_wrapper(&rb, "", &wrapper).await?;
            self.tokens.clear();
            for it in ms {
                let mut token = BtcChainToken::default();
                token.load(context, it).await?;
                self.tokens.push(token);
            }
        }
        Ok(())
    }
}

#[derive(Debug, Default, Clone)]
pub struct BtcNowLoadBlock{
    pub height: i64,
    pub header_hash: String,
    pub timestamp: String,
}

#[derive(Debug, Default, Clone)]
pub struct BtcBalance{
    pub address: String,
    pub balance: i64,
    pub height: i64,
}