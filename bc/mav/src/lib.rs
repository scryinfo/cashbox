use strum_macros::EnumIter;

pub use kits::Error;

pub mod ma;
pub mod kits;

#[allow(non_upper_case_globals)]
pub const CFalse: u32 = 0u32;
#[allow(non_upper_case_globals)]
pub const CTrue: u32 = 1u32;

#[derive(PartialEq, Clone, Debug, EnumIter)]
pub enum ChainType {
    //Used to distinguish the chain types supported by the wallet
    BTC = 1,
    BtcTest = 2,
    ETH = 3,
    EthTest = 4,
    EEE = 5,
    EeeTest = 6,
    BtcPrivate = 7,
    BtcPrivateTest = 8,
    EthPrivate = 9,
    EthPrivateTest = 10,
    EeePrivate = 11,
    EeePrivateTest = 12,
}

impl ChainType {
    pub fn from(chain_type: &str) -> Result<Self, Error> {
        match chain_type {
            "BTC" => Ok(ChainType::BTC),
            "BtcTest" => Ok(ChainType::BtcTest),
            "BtcPrivate" => Ok(ChainType::BtcTest),
            "BtcPrivateTest" => Ok(ChainType::BtcTest),
            "ETH" => Ok(ChainType::ETH),
            "EthTest" => Ok(ChainType::EthTest),
            "EthPrivate" => Ok(ChainType::EthPrivate),
            "EthPrivateTest" => Ok(ChainType::EthPrivateTest),
            "EEE" => Ok(ChainType::EEE),
            "EeeTest" => Ok(ChainType::EeeTest),
            "EeePrivate" => Ok(ChainType::EeePrivate),
            "EeePrivateTest" => Ok(ChainType::EeePrivateTest),
            _ => {
                let err = format!("the chain type:{} currently not supported ", chain_type);
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
            ChainType::BtcPrivate => "BtcPrivate".to_owned(),
            ChainType::BtcPrivateTest => "BtcPrivateTest".to_owned(),
            ChainType::ETH => "ETH".to_owned(),
            ChainType::EthTest => "EthTest".to_owned(),
            ChainType::EthPrivate => "EthPrivate".to_owned(),
            ChainType::EthPrivateTest => "EthPrivateTest".to_owned(),
            ChainType::EEE => "EEE".to_owned(),
            ChainType::EeeTest => "EeeTest".to_owned(),
            ChainType::EeePrivate => "EeePrivate".to_owned(),
            ChainType::EeePrivateTest => "EeePrivateTest".to_owned(),
        }
    }
}

#[derive(PartialEq, Clone, Debug, EnumIter)]
pub enum WalletType {
    Normal,
    //正式钱包
    Test,  //测试钱包，对应的链为测试链
}

impl WalletType {
    pub fn check_chain_type_match(wallet_type: &WalletType, chain_type: &NetType) -> bool {
        if wallet_type.eq(&WalletType::Normal) && chain_type.eq(&NetType::Main) {
            true
        } else {
            wallet_type.eq(&WalletType::Test) && chain_type.ne(&NetType::Main)
        }
    }
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

impl From<&NetType> for WalletType {
    fn from(net_type: &NetType) -> Self {
        if NetType::Main.eq(net_type) {
            WalletType::Normal
        } else {
            WalletType::Test
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

impl NetType {
    pub fn from_chain_type(chain_type: &str) -> Self {
        if chain_type.contains("PrivateTest") {
            NetType::PrivateTest
        } else if chain_type.contains("Private") {
            NetType::Private
        } else if chain_type.contains("Test") {
            NetType::Test
        } else {
            NetType::Main
        }
    }
}

#[allow(non_camel_case_types)]
#[derive(PartialEq, Clone, Debug, EnumIter)]
pub enum AppPlatformType {
    any,
    aarch64_linux_android,
    armv7_linux_androideabi,
    i686_linux_android,
    x86_64_linux_android,
    x86_64_pc_windows_gnu,
    x86_64_pc_windows_msvc,
    x86_64_unknown_linux_gnu,
    aarch64_apple_ios,
    x86_64_apple_ios,
}

impl AppPlatformType {
    pub fn from(plat_type: &str) -> Result<Self, Error> {
        match plat_type {
            "any" => Ok(AppPlatformType::any),
            "aarch64_linux_android" => Ok(AppPlatformType::aarch64_linux_android),
            "armv7_linux_androideabi" => Ok(AppPlatformType::armv7_linux_androideabi),
            "i686_linux_android" => Ok(AppPlatformType::i686_linux_android),
            "x86_64_linux_android" => Ok(AppPlatformType::x86_64_linux_android),
            "x86_64_pc_windows_gnu" => Ok(AppPlatformType::x86_64_pc_windows_gnu),
            "x86_64_pc_windows_msvc" => Ok(AppPlatformType::x86_64_pc_windows_msvc),
            "x86_64_unknown_linux_gnu" => Ok(AppPlatformType::x86_64_unknown_linux_gnu),
            "aarch64_apple_ios" => Ok(AppPlatformType::aarch64_apple_ios),
            "x86_64_apple_ios" => Ok(AppPlatformType::x86_64_apple_ios),
            _ => {
                let err = format!("the str:{} can not be AppPlatformType", plat_type);
                log::error!("{}", err);
                Err(Error::from(err.as_str()))
            }
        }
    }
}

impl ToString for AppPlatformType {
    fn to_string(&self) -> String {
        match self {
            AppPlatformType::any => "any".to_owned(),
            AppPlatformType::aarch64_linux_android => "aarch64_linux_android".to_owned(),
            AppPlatformType::armv7_linux_androideabi => "armv7_linux_androideabi".to_owned(),
            AppPlatformType::i686_linux_android => "i686_linux_android".to_owned(),
            AppPlatformType::x86_64_linux_android => "x86_64_linux_android".to_owned(),
            AppPlatformType::x86_64_pc_windows_gnu => "x86_64_pc_windows_gnu".to_owned(),
            AppPlatformType::x86_64_pc_windows_msvc => "x86_64_pc_windows_msvc".to_owned(),
            AppPlatformType::x86_64_unknown_linux_gnu => "x86_64_unknown_linux_gnu".to_owned(),
            AppPlatformType::aarch64_apple_ios => "aarch64_apple_ios".to_owned(),
            AppPlatformType::x86_64_apple_ios => "x86_64_apple_ios".to_owned(),
        }
    }
}

#[cfg(test)]
mod tests {
    use strum::IntoEnumIterator;

    use crate::{AppPlatformType, ChainType, NetType, WalletType};

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

    #[test]
    fn app_platform_type_test() {
        for it in AppPlatformType::iter() {
            assert_eq!(it, AppPlatformType::from(&it.to_string()).unwrap());
        }
    }
}
