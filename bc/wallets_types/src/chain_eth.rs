use async_trait::async_trait;
use rbatis::crud::CRUDEnable;

use mav::{ChainType, NetType, WalletType};
use mav::kits::sql_left_join_get_b;
use mav::ma::{Dao, MEthChainToken, MEthChainTokenAuth, MEthChainTokenDefault, MEthChainTokenShared, MWallet};

use crate::{Chain2WalletType, ChainShared, ContextTrait, deref_type, Load, WalletError};

#[derive(Debug, Default)]
pub struct EthChainToken {
    pub m: MEthChainToken,
    pub eth_chain_token_shared: EthChainTokenShared,
}
deref_type!(EthChainToken,MEthChainToken);

#[async_trait]
impl Load for EthChainToken {
    type MType = MEthChainToken;
    async fn load(&mut self, context: &dyn ContextTrait, m: Self::MType) -> Result<(), WalletError> {
        self.m = m;
        let rb = context.db().wallets_db();
        let token_shared = MEthChainTokenShared::fetch_by_id(rb, "", &self.m.chain_token_shared_id).await?;
        let token_shared = token_shared.ok_or_else(||
            WalletError::NoneError(format!("do not find id:{}, in {}", &self.chain_token_shared_id, MEthChainTokenShared::table_name())))?;
        self.eth_chain_token_shared.load(context, token_shared).await?;
        Ok(())
    }
}

#[derive(Debug, Default)]
pub struct EthChainTokenShared {
    pub m: MEthChainTokenShared,
    //pub token_shared: TokenShared,
}
deref_type!(EthChainTokenShared,MEthChainTokenShared);

#[async_trait]
impl Load for EthChainTokenShared {
    type MType = MEthChainTokenShared;
    async fn load(&mut self, _: &dyn ContextTrait, m: Self::MType) -> Result<(), WalletError> {
        self.m = m;
        //self.token_shared.m = self.m.token_shared.clone();
        Ok(())
    }
}

#[derive(Debug, Default)]
pub struct EthChainTokenDefault {
    pub m: MEthChainTokenDefault,
    pub eth_chain_token_shared: EthChainTokenShared,
}
deref_type!(EthChainTokenDefault,MEthChainTokenDefault);

impl EthChainTokenDefault {
    pub async fn list_by_net_type(context: &dyn ContextTrait, net_type: &NetType) -> Result<Vec<MEthChainTokenDefault>, WalletError> {
        let tx_id = "";
        let wallets_db = context.db().wallets_db();
        let tokens_shared: Vec<MEthChainTokenShared> = {
            let mut wrapper = wallets_db.new_wrapper();
            let default_name = MEthChainTokenDefault::table_name();
            let shared_name = MEthChainTokenShared::table_name();
            wrapper.eq(format!("{}.{}", default_name, MEthChainTokenDefault::net_type).as_str(), net_type.to_string());

            let sql = {
                wrapper = wrapper.check()?;
                let t = sql_left_join_get_b(&default_name, &MEthChainTokenDefault::chain_token_shared_id,
                                            &shared_name, &MEthChainTokenShared::id);
                format!("{} where {}", t, &wrapper.sql)
            };
            wallets_db.fetch_prepare(tx_id, &sql, &wrapper.args).await?
        };
        let mut tokens_default = {
            let mut wrapper = wallets_db.new_wrapper();
            wrapper.eq(MEthChainTokenDefault::net_type, net_type.to_string());
            wrapper.order_by(true, &[MEthChainTokenDefault::position]);
            MEthChainTokenDefault::list_by_wrapper(wallets_db, tx_id, &wrapper).await?
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
pub struct EthChainTokenAuth {
    pub m: MEthChainTokenAuth,
    pub eth_chain_token_shared: EthChainTokenShared,
}
deref_type!(EthChainTokenAuth,MEthChainTokenAuth);

#[derive(Debug, Default)]
pub struct EthChain {
    pub chain_shared: ChainShared,
    pub tokens: Vec<EthChainToken>,
}

impl Chain2WalletType for EthChain {
    fn chain_type(wallet_type: &WalletType) -> ChainType {
        match wallet_type {
            WalletType::Normal => ChainType::ETH,
            _ => ChainType::EthTest,
        }
    }

    fn to_chain_type(&self, wallet_type: &WalletType) -> ChainType {
        EthChain::chain_type(wallet_type)
    }
}

#[async_trait]
impl Load for EthChain {
    type MType = MWallet;

    async fn load(&mut self, context: &dyn ContextTrait, mw: Self::MType) -> Result<(), WalletError> {
        self.chain_shared.set_m(&mw);
        let wallet_type = WalletType::from(mw.wallet_type.as_str());
        self.chain_shared.m.chain_type = self.to_chain_type(&wallet_type).to_string();

        {//load token

            let rb = context.db().data_db( &NetType::from(&mw.net_type));
            let mut wrapper = rb.new_wrapper();
            wrapper.eq(MEthChainToken::wallet_id, mw.id.clone()).eq(MEthChainToken::chain_type, self.chain_shared.chain_type.clone());
            let ms = MEthChainToken::list_by_wrapper(&rb, "", &wrapper).await?;
            self.tokens.clear();
            for it in ms {
                let mut token = EthChainToken::default();
                token.load(context, it).await?;
                self.tokens.push(token);
            }
        }

        Ok(())
    }
}

#[cfg(test)]
mod tests {
    use mav::{ChainType, WalletType};

    use crate::{Chain2WalletType, EthChain};

    #[test]
    fn eth_chain_test() {
        let t = EthChain::chain_type(&WalletType::Normal);
        assert_eq!(ChainType::ETH, t);
        let t = EthChain::chain_type(&WalletType::Test);
        assert_eq!(ChainType::EthTest, t);

        let t = EthChain::wallet_type(&ChainType::ETH);
        assert_eq!(WalletType::Normal, t);
        let t = EthChain::wallet_type(&ChainType::EthTest);
        assert_eq!(WalletType::Test, t);
    }
}
