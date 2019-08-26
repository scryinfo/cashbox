#[macro_use]
extern crate serde_derive;

pub mod account_generate;
pub mod walletstore;
pub mod module;


#[derive(PartialEq)]
pub enum StatusCode {
    DylibError = -1,
    OK = 200,
    //正常
    FailToGenerateMnemonic = 100,
    //生成助记词失败
    PwdIsWrong,
    //密码错误
    FailToRestPwd,
    //重置密码失败
    GasNotEnough,
    //GAS费不足
    BroadcastOk,
    //广播上链成功
    BroadcastFailure,  //广播上链失败
}

pub enum ChainType {
    BTC = 1,
    BtcTest,
    ETH,
    EthTest,
    EEE,
    EeeTest,
    OTHER,
}

impl From<i64> for ChainType {
    fn from(chain_type: i64) -> Self {
        match chain_type {
            1 => ChainType::BTC,
            2 => ChainType::BtcTest,
            3 => ChainType::ETH,
            4 => ChainType::EthTest,
            5 => ChainType::EEE,
            6 => ChainType::EeeTest,
            _ => ChainType::OTHER,
        }
    }
}


#[cfg(test)]
mod tests {
    use crate::crate_mnemonic;
    use crate::account_crypto::Ed25519;
    use crate::account_crypto::Sr25519;


    #[test]
    fn verify_mnemonic_create() {
        println!("{}", crate_mnemonic::<Ed25519>(18));
        println!("{}", crate_mnemonic::<Sr25519>(18));
    }
}
