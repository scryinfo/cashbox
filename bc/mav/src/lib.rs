pub use db::Error;

pub mod ma;
pub mod kits;
pub mod db;

#[derive(PartialEq, Clone, Debug)]
pub enum ChainType {
    //Used to distinguish the chain types supported by the wallet
    BTC = 1,
    BtcTest = 2,
    ETH = 3,
    EthTest = 4,
    EEE = 5,
    EeeTest = 6,
    OTHER = 7,
}

// impl From<i64> for ChainType {
//     fn from(chain_type: i64) -> Self {
//         match chain_type {
//             1 => ChainType::BTC,
//             2 => ChainType::BtcTest,
//             3 => ChainType::ETH,
//             4 => ChainType::EthTest,
//             5 => ChainType::EEE,
//             6 => ChainType::EeeTest,
//             _ => ChainType::OTHER,
//         }
//     }
// }

impl From<&str> for ChainType {
    fn from(chain_type: &str) -> Self {
        match chain_type {
            "BTC" => ChainType::BTC,
            "BtcTest" => ChainType::BtcTest,
            "ETH" => ChainType::ETH,
            "EthTest" => ChainType::EthTest,
            "EEE" => ChainType::EEE,
            "EeeTest" => ChainType::EeeTest,
            _ => ChainType::OTHER,
        }
    }
}

impl From<&String> for ChainType {
    fn from(chain_type: &String) -> Self {
        ChainType::from(chain_type.as_str())
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
            ChainType::OTHER => "OTHER".to_owned(),
        }
    }
}

#[derive(PartialEq, Clone, Debug)]
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
                log::error!("the str:{} can not to WalletType",wallet_type);
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
/// [WalletType.Test] 可以切换为 [NetType.Test]， [NetType.Test] ，[NetType.PrivateTest]
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
#[derive(PartialEq, Clone, Debug)]
pub enum NetType {
    Main,
    Test,
    Private,
    PrivateTest,
}

impl From<&str> for NetType {
    fn from(net_type: &str) -> Self {
        match net_type {
            "Main" => NetType::Main,
            "Test" => NetType::Test,
            "Private" => NetType::Private,
            "PrivateTest" => NetType::PrivateTest,
            _ => {
                log::error!("the str:{} can not to NetType",net_type);
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
    #[test]
    fn it_works() {
        assert_eq!(2 + 2, 4);
    }
}
