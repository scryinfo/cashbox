use mav::{ChainType, WalletType, NetType};

pub trait Chain2WalletType {
    fn chain_type(wallet_type: &WalletType,net_type:&NetType) -> ChainType;
    /// 减少调用时把类型给错，而增加的方法，但不是每次都有实例，所以还保留了无 self的方法
    //fn to_chain_type(&self, wallet_type: &WalletType) -> ChainType;

    fn wallet_type(chain_type: &ChainType) -> WalletType {
        match chain_type {
            ChainType::ETH | ChainType::BTC | ChainType::EEE => WalletType::Normal,
            ChainType::EthTest | ChainType::BtcTest | ChainType::EeeTest=>WalletType::Test,
            ChainType::EthPrivate | ChainType::BtcPrivate | ChainType::EeePrivate => WalletType::Test,
            ChainType::EthPrivateTest | ChainType::BtcPrivateTest | ChainType::EeePrivateTest => WalletType::Test,
        }
    }
}
