pub enum WalletType {
    Normal,//钱包
    Test,  //测试钱包，对应的链为测试链
}

pub enum ChainType {
    Eth,
    EthTest,
    Eee,
    EeeTest,
    Btc,
    BtcTest,
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
pub enum NetType {
    Main,
    Test,
    Private,
    PrivateTest,
}

#[derive(Default, Clone)]
pub struct Wallet {
    //primary key
    pub id: String,
    //下一个显示顺序的 wallet_id
    pub next_id: String,
    pub full_name: String,
    pub mnemonic_digest: String,
    pub mnemonic: String,
    /// [WalletType]
    pub wallet_type: String,
    /// [NetType]
    pub net_type: String,
    pub create_time: i64,
    pub update_time: i64,
}

//每一种链类型一条记录，与钱包没有关系
#[derive(Default, Clone)]
pub struct Chain {
    //primary key
    pub id: String,
    //下一个显示顺序的 chain_id
    pub next_id: i32,
    /// [ChainType]
    pub chain_type: String,
    pub short_name: String,
    pub full_name: String,
    pub create_time: i64,
    pub update_time: i64,
}

#[derive(Default, Clone)]
pub struct Address {
    //primary key
    pub id: String,
    /// [Wallet]
    pub wallet_id: String,
    /// [Chain]
    pub chain_id: String,
    pub address: String,
    pub public_key: String,
    pub wallet_address: bool, //是否为钱包地址

    pub create_time: i64,
    pub update_time: i64,
}

//如名字图片等不变的信息
#[derive(Default, Clone)]
pub struct AuthToken {
    //primary key
    pub id: String,
    pub next_id: String,
    pub name: String,
    /// [ChainType]
    pub chain_type: String,
}

/// DefaultDigit must be a [AuthDigit]
#[derive(Default, Clone)]
pub struct DefaultToken {
    //primary key
    pub id: String,
    pub name: String,
    /// [AuthDigit]
    pub auth_token_id: String,
}




