use rbatis::rbatis::Rbatis;

use mav::{ChainType, WalletType};
use mav::ma::MWallet;

pub trait Chain2WalletType {
    fn chain_type(wallet_type: &WalletType) -> ChainType;
    /// 减少调用时把类型给错，而增加的方法，但不是每次都有实例，所以还保留了无 self的方法
    fn to_chain_type(&self, wallet_type: &WalletType) -> ChainType;

    fn wallet_type(chain_type: &ChainType) -> WalletType {
        match chain_type {
            ChainType::ETH | ChainType::BTC | ChainType::EEE => WalletType::Normal,
            ChainType::EthTest | ChainType::BtcTest | ChainType::EeeTest => WalletType::Test,
            ChainType::OTHER => WalletType::Test,
        }
    }
}

pub trait Chain {
    fn load(&mut self, rb: &Rbatis, mw: &MWallet);
}