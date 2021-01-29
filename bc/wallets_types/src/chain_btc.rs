use async_trait::async_trait;
use rbatis::crud::CRUDEnable;

use mav::{ChainType, NetType, WalletType};
use mav::kits::sql_left_join_get_b;
use mav::ma::{Dao, MBtcChainToken, MBtcChainTokenDefault, MBtcChainTokenShared, MWallet, MBtcChainTokenAuth};

use crate::{Address,Chain2WalletType, ChainShared, ContextTrait, deref_type, Load, WalletError};

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

#[async_trait]
impl Load for BtcChainTokenShared {
    type MType = MBtcChainTokenShared;
    async fn load(&mut self, _: &dyn ContextTrait, m: Self::MType) -> Result<(), WalletError> {
        self.m = m;
       // self.token_shared.m = self.m.token_shared.clone();
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
    pub async fn list_by_net_type(context: &dyn ContextTrait, net_type: &NetType) -> Result<Vec<MBtcChainTokenDefault>, WalletError> {
        let tx_id = "";
        let wallets_db = context.db().wallets_db();
        let tokens_shared: Vec<MBtcChainTokenShared> = {
            let default_name = MBtcChainTokenDefault::table_name();
            let shared_name = MBtcChainTokenShared::table_name();
            let mut wrapper = wallets_db.new_wrapper()
                .eq(format!("{}.{}", default_name, MBtcChainTokenDefault::net_type).as_str(), net_type.to_string());

            let sql = {
                wrapper = wrapper.check()?;
                let t = sql_left_join_get_b(&default_name, &MBtcChainTokenDefault::chain_token_shared_id,
                                            &shared_name, &MBtcChainTokenShared::id);
                format!("{} where {}", t, &wrapper.sql)
            };
            wallets_db.fetch_prepare(tx_id, &sql, &wrapper.args).await?
        };

        let mut tokens_default = {
            let wrapper = wallets_db.new_wrapper()
                .eq(MBtcChainTokenDefault::net_type, net_type.to_string())
                .check()?
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
        Ok(tokens_default)
    }
}
#[derive(Debug, Default)]
pub struct BtcChainTokenAuth {
    pub m: MBtcChainTokenAuth,
    pub btc_chain_token_shared: BtcChainTokenShared,
}
deref_type!(BtcChainTokenAuth,MBtcChainTokenAuth);

#[derive(Debug, Default)]
pub struct BtcChain {
    pub chain_shared: ChainShared,
    pub tokens: Vec<BtcChainToken>,
}

impl Chain2WalletType for BtcChain {
    fn chain_type(wallet_type: &WalletType) -> ChainType {
        match wallet_type {
            WalletType::Normal => ChainType::BTC,
            _ => ChainType::BtcTest,
        }
    }

    fn to_chain_type(&self, wallet_type: &WalletType) -> ChainType {
        BtcChain::chain_type(wallet_type)
    }
}

#[async_trait]
impl Load for BtcChain {
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
            let rb = context.db().data_db( &NetType::from(&mw.net_type));
            let wrapper = rb.new_wrapper()
                .eq(MBtcChainToken::wallet_id, mw.id.clone())
                .eq(MBtcChainToken::chain_type, self.chain_shared.chain_type.clone()).check()?;
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

