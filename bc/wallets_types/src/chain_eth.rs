use rbatis::rbatis::Rbatis;

use mav::{ChainType, WalletType};
use mav::ma::{MEthChainToken, MEthChainTokenAuth, MEthChainTokenDefault, MEthChainTokenShared, MWallet};

use crate::{Chain, Chain2WalletType, ChainShared, deref_type, TokenShared};

#[derive(Debug, Default)]
pub struct EthChainToken {
    pub m: MEthChainToken,
    pub token_shared: EthChainTokenShared,
}
deref_type!(EthChainToken,MEthChainToken);

#[derive(Debug, Default)]
pub struct EthChainTokenShared {
    pub m: MEthChainTokenShared,
    pub token_shared: TokenShared,
}
deref_type!(EthChainTokenShared,MEthChainTokenShared);

#[derive(Debug, Default)]
pub struct EthChainTokenDefault {
    pub m: MEthChainTokenDefault,
    pub token_shared: EthChainTokenShared,
}
deref_type!(EthChainTokenDefault,MEthChainTokenDefault);

#[derive(Debug, Default)]
pub struct EthChainTokenAuth {
    pub m: MEthChainTokenAuth,
    pub token_shared: EthChainTokenShared,
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

impl Chain for EthChain {
    fn load(&mut self, rb: &Rbatis, mw: &MWallet) {
        self.chain_shared.set_m(mw);
        let wallet_type = WalletType::from(mw.wallet_type.as_str());
        self.chain_shared.m.chain_type = self.to_chain_type(&wallet_type).to_string();
        //todo
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

        let t = EthChain::wallet_type(&ChainType::OTHER);
        assert_eq!(WalletType::Test, t);
    }
}
