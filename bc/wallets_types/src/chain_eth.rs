use async_trait::async_trait;
use rbatis::sql::{IPage, PageRequest};

use mav::{ChainType, CTrue, NetType, WalletType};
use mav::ma::{MEthChainToken, MEthChainTokenAuth, MEthChainTokenDefault, MEthChainTokenNonAuth, MEthChainTokenShared, MWallet, Shared};

use crate::{Chain2WalletType, ChainShared, ContextTrait, deref_type, Load, WalletError};

// use rbatis::crud::CRUDTable;

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
        let mut rb = context.db().wallets_db();
        let token_shared = MEthChainTokenShared::select_by_id(&mut rb, &self.m.chain_token_shared_id).await?;
        let token_shared = token_shared.ok_or_else(||
            WalletError::NoneError(format!("do not find id:{}, in {}", &self.chain_token_shared_id, MEthChainTokenShared::table_name())))?;
        self.eth_chain_token_shared.load(context, token_shared).await?;
        Ok(())
    }
}

#[derive(Debug, Default)]
pub struct EthChainTokenShared {
    pub m: MEthChainTokenShared,
    //  pub token_shared: TokenShared,
}
deref_type!(EthChainTokenShared,MEthChainTokenShared);

impl From<MEthChainTokenShared> for EthChainTokenShared {
    fn from(token_shared: MEthChainTokenShared) -> Self {
        Self {
            m: token_shared,
        }
    }
}

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
    pub async fn list_by_net_type(context: &dyn ContextTrait, net_type: &NetType) -> Result<Vec<EthChainTokenDefault>, WalletError> {
        let mut wallets_db = context.db().wallets_db();
        let tokens_shared: Vec<MEthChainTokenShared> = {
            MEthChainTokenShared::list_by_net_type(&mut wallets_db, &net_type.to_string()).await?
        };
        let mut tokens_default = {
            MEthChainTokenDefault::select_by_net_type_order_position(&mut wallets_db, &net_type.to_string()).await?
        };
        for token_default in &mut tokens_default {
            for token_shared in &tokens_shared {
                if token_default.chain_token_shared_id == token_shared.id {
                    token_default.chain_token_shared = token_shared.clone();
                }
            }
        }
        let eth_tokens = tokens_default.iter().map(|token| EthChainTokenDefault {
            m: token.clone(),
            eth_chain_token_shared: EthChainTokenShared::from(token.chain_token_shared.clone()),
        }).collect::<Vec<EthChainTokenDefault>>();
        Ok(eth_tokens)
    }
}


#[derive(Debug, Default)]
pub struct EthChainTokenAuth {
    pub m: MEthChainTokenAuth,
    pub eth_chain_token_shared: EthChainTokenShared,
}
deref_type!(EthChainTokenAuth,MEthChainTokenAuth);


impl EthChainTokenAuth {
    pub async fn list_by_net_type(context: &dyn ContextTrait, net_type: &NetType, start_item: u64, page_size: u64) -> Result<Vec<EthChainTokenAuth>, WalletError> {
        let mut rb = context.db().wallets_db();
        let tokens_auth = {
            MEthChainTokenAuth::select_page_net_type_status_order_create_time(&mut rb, &PageRequest::new(start_item, page_size), &net_type.to_string(), CTrue as i64).await?
        };
        let tokens_shared = MEthChainTokenShared::select_auth_page_net_type_and_id_in(&mut rb, &net_type.to_string(), start_item, page_size).await?;
        let mut target_tokens = vec![];
        for token_auth in tokens_auth.get_records() {
            for token_shared in &tokens_shared {
                let mut token = EthChainTokenAuth::default();
                if token_auth.chain_token_shared_id == token_shared.id {
                    token.m = token_auth.clone();
                    token.eth_chain_token_shared = EthChainTokenShared::from(token_shared.clone());
                    target_tokens.push(token)
                }
            }
        }
        Ok(target_tokens)
    }

    pub async fn query_by_condition(context: &dyn ContextTrait, net_type: &NetType, name: Option<String>, contract_addr: Option<String>, start_item: u64, page_size: u64) -> Result<Vec<EthChainTokenAuth>, WalletError> {
        let mut rb = context.db().wallets_db();

        let name = name.unwrap_or_default();
        let contract_addr = contract_addr.unwrap_or_default();

        let tokens_shared = {
            MEthChainTokenShared::select_page_by_name_and_in(
                &mut rb, &PageRequest::new(start_item, page_size),
                &name, &contract_addr, &net_type.to_string()).await?
        };
        let mut target_tokens = vec![];

        for token_shared in tokens_shared.get_records() {
            let tokens_auth = {
                MEthChainTokenAuth::select_by_shared_id_net_type_status(&mut rb, &token_shared.id, &net_type.to_string(), CTrue as i64).await?
            };
            for token_auth in tokens_auth {
                let mut token = EthChainTokenAuth::default();
                token.m = token_auth.clone();
                token.eth_chain_token_shared = EthChainTokenShared::from(token_shared.clone());
                target_tokens.push(token)
            }
        }
        Ok(target_tokens)
    }
}

#[derive(Debug, Default)]
pub struct EthChainTokenNonAuth {
    pub m: MEthChainTokenNonAuth,
    pub eth_chain_token_shared: EthChainTokenShared,
}
deref_type!(EthChainTokenNonAuth,MEthChainTokenNonAuth);

impl EthChainTokenNonAuth {
    pub async fn list_by_net_type(context: &dyn ContextTrait, net_type: &NetType) -> Result<Vec<EthChainTokenNonAuth>, WalletError> {
        let mut rb = context.db().wallets_db();
        let tokens_shared: Vec<MEthChainTokenShared> = {
            MEthChainTokenShared::select_nonauth_net_type_and_id_in(&mut rb, &net_type.to_string()).await?
        };
        let mut tokens_non_auth = {
            MEthChainTokenNonAuth::select_net_type_status_order_position(&mut rb, &net_type.to_string(), CTrue as i64).await?
        };
        let mut target_tokens = vec![];
        for token_non_auth in &mut tokens_non_auth {
            for token_shared in &tokens_shared {
                let mut token = EthChainTokenNonAuth::default();
                if token_non_auth.chain_token_shared_id == token_shared.id {
                    token.m = token_non_auth.clone();
                    token.eth_chain_token_shared = EthChainTokenShared::from(token_shared.clone());
                    target_tokens.push(token)
                }
            }
        }
        Ok(target_tokens)
    }
}


#[derive(Debug, Default)]
pub struct EthChain {
    pub chain_shared: ChainShared,
    pub tokens: Vec<EthChainToken>,
}

impl Chain2WalletType for EthChain {
    fn chain_type(wallet_type: &WalletType, net_type: &NetType) -> ChainType {
        match (wallet_type, net_type) {
            (WalletType::Normal, NetType::Main) => ChainType::ETH,
            (WalletType::Test, NetType::Test) => ChainType::EthTest,
            (WalletType::Test, NetType::Private) => ChainType::EthPrivate,
            (WalletType::Test, NetType::PrivateTest) => ChainType::EthPrivateTest,
            _ => ChainType::EthTest,
        }
    }
}

/*#[async_trait]*/
impl EthChain {
    pub async fn load(&mut self, context: &dyn ContextTrait, mw: MWallet, net_type: &NetType) -> Result<(), WalletError> {
        self.chain_shared.set_m(&mw);

        let wallet_type = WalletType::from(mw.wallet_type.as_str());
        let chain_type = EthChain::chain_type(&wallet_type, &net_type).to_string();
        {//load address
            let wallet_id = self.chain_shared.wallet_id.clone();
            self.chain_shared.set_addr(context, &wallet_id, &chain_type).await?;
            self.chain_shared.m.chain_type = chain_type.clone();
        }
        {//load token

            let mut rb = context.db().data_db(&net_type);
            let w = MEthChainToken::select_by_wallet_id_and_chain_type(&mut rb, &mw.id, &chain_type).await?;
            if let Some(w) = w {
                self.tokens.clear();
                let mut token = EthChainToken::default();
                token.load(context, w).await?;
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
