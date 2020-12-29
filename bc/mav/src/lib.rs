use strum_macros::EnumIter;

pub use kits::Error;

pub mod ma;
pub mod kits;

#[derive(PartialEq, Clone, Debug, EnumIter)]
pub enum ChainType {
    //Used to distinguish the chain types supported by the wallet
    BTC = 1,
    BtcTest = 2,
    ETH = 3,
    EthTest = 4,
    EEE = 5,
    EeeTest = 6,
}

impl ChainType {
    pub fn from(chain_type: &str) -> Result<Self, Error> {
        match chain_type {
            "BTC" => Ok(ChainType::BTC),
            "BtcTest" => Ok(ChainType::BtcTest),
            "ETH" => Ok(ChainType::ETH),
            "EthTest" => Ok(ChainType::EthTest),
            "EEE" => Ok(ChainType::EEE),
            "EeeTest" => Ok(ChainType::EeeTest),
            _ => {
                let err = format!("the str:{} can not be ChainType", chain_type);
                log::error!("{}", err);
                Err(Error::from(err.as_str()))
            }
        }
    }
}

impl ToString for ChainType {
    fn to_string(&self) -> String {
        match &self {
            ChainType::BTC => "BTC".to_owned(),
            ChainType::BtcTest => "BtcTest".to_owned(),
            ChainType::ETH => "ETH".to_owned(),
            ChainType::EthTest => "EthTest".to_owned(),
            ChainType::EEE => "EEE".to_owned(),
            ChainType::EeeTest => "EeeTest".to_owned(),
        }
    }
}

#[derive(PartialEq, Clone, Debug, EnumIter)]
pub enum WalletType {
    Normal,
    //钱包
    Test,  //测试钱包，对应的链为测试链
}

impl From<&str> for WalletType {
    fn from(wallet_type: &str) -> Self {
        match wallet_type {
            "Normal" => WalletType::Normal,
            "Test" => WalletType::Test,
            _ => {
                log::error!("the str:{} can not be WalletType", wallet_type);
                WalletType::Test
            }
        }
    }
}

impl From<&String> for WalletType {
    fn from(wallet_type: &String) -> Self {
        WalletType::from(wallet_type.as_str())
    }
}

impl ToString for WalletType {
    fn to_string(&self) -> String {
        match &self {
            WalletType::Normal => "Normal".to_owned(),
            WalletType::Test => "Test".to_owned(),
        }
    }
}

/// 用来切换钱包的网络时使用的
///
/// [WalletType.Test] 可以切换为 [NetType.Test]， [NetType.Private] ，[NetType.PrivateTest]
///
/// [WalletType.Normal] 只能为 [NetType.Main]
///
/// 测试钱包不能切换到主网，这样做是为了避免用户弄错了
///
/// [WalletType.Test]:WalletType::TEST
/// [WalletType.Normal]:WalletType::Normal
/// [NetType.Main]:NetType::Main
/// [NetType.Test]:NetType::Test
/// [NetType.Test]:NetType::Test
/// [NetType.PrivateTest]:NetType::PrivateTest
#[derive(PartialEq, Clone, Debug, EnumIter)]
pub enum NetType {
    Main,
    Test,
    Private,
    PrivateTest,
}

impl NetType {
    pub fn default_net_type(wallet_type: &WalletType) -> NetType {
        match wallet_type {
            WalletType::Normal => NetType::Main,
            WalletType::Test => NetType::Test,
        }
    }
}

impl From<&str> for NetType {
    fn from(net_type: &str) -> Self {
        match net_type {
            "Main" => NetType::Main,
            "Test" => NetType::Test,
            "Private" => NetType::Private,
            "PrivateTest" => NetType::PrivateTest,
            _ => {
                log::error!("the str:{} can not be NetType", net_type);
                NetType::Test
            }
        }
    }
}

impl From<&String> for NetType {
    fn from(net_type: &String) -> Self {
        NetType::from(net_type.as_str())
    }
}

impl ToString for NetType {
    fn to_string(&self) -> String {
        match &self {
            NetType::Main => "Main".to_owned(),
            NetType::Test => "Test".to_owned(),
            NetType::Private => "Private".to_owned(),
            NetType::PrivateTest => "PrivateTest".to_owned(),
        }
    }
}

#[cfg(test)]
mod tests {
    use strum::IntoEnumIterator;

    use crate::{ChainType, NetType, WalletType};

    #[test]
    fn net_type_test() {
        for it in NetType::iter() {
            assert_eq!(it, NetType::from(&it.to_string()));
        }
    }

    #[test]
    fn chain_type_test() {
        for it in ChainType::iter() {
            assert_eq!(it, ChainType::from(&it.to_string()).unwrap());
        }
    }

    #[test]
    fn wallet_type_test() {
        for it in WalletType::iter() {
            assert_eq!(it, WalletType::from(&it.to_string()));
        }
    }
}
