use std::ops::Add;

use crate::{BtcChain, EeeChain, EthChain, WalletError};

#[derive(Debug, Clone, Default)]
pub struct Error {
    //由于很多地方都有使用 error这个名字，加一个C减少重名
    pub code: u64,
    pub message: String,
}

#[allow(non_snake_case)]
impl Error {
    pub fn SUCCESS() -> Self {
        Error {
            code: 0,
            message: String::from("Success "),
        }
    }

    pub fn FAIL() -> Error {
        Error {
            code: 1,
            message: "FAIL error ".to_owned(),
        }
    }

    pub fn IO() -> Error {
        Error {
            code: 100,
            message: "IO error".to_owned(),
        }
    }
    pub fn PARAMETER() -> Error {
        Error {
            code: 110,
            message: "Parameter error ".to_owned(),
        }
    }
    pub fn CUSTOM() -> Error {
        Error {
            code: 120,
            message: "CUSTOM error".to_owned(),
        }
    }

    pub fn DECODE() -> Error {
        Error {
            code: 130,
            message: "DECODE error".to_owned(),
        }
    }

    pub fn SERDE() -> Error {
        Error {
            code: 140,
            message: "SERDE error".to_owned(),
        }
    }
    pub fn SCALE_CODEC() -> Error {
        Error {
            code: 150,
            message: "SCALE_CODEC error".to_owned(),
        }
    }

    pub fn SECP256K1() -> Error {
        Error {
            code: 160,
            message: "SECP256K1 error".to_owned(),
        }
    }
    pub fn NONE() -> Error {
        Error {
            code: 170,
            message: "NONE error".to_owned(),
        }
    }
    pub fn RBATIS() -> Error {
        Error {
            code: 180,
            message: "RBATIS error".to_owned(),
        }
    }
    pub fn NOT_EXIST() -> Error {
        Error {
            code: 190,
            message: "NOT_EXIST error".to_owned(),
        }
    }

    pub fn set_code(&self, code: u64) -> Error {
        Error {
            code,
            message: self.message.clone(),
        }
    }

    pub fn set_message(&self, message: &str) -> Error {
        Error {
            code: self.code,
            message: message.to_owned(),
        }
    }

    pub fn append_message(&self, message: &str) -> Error {
        Error {
            code: self.code,
            message: self.message.clone().add(message),
        }
    }
}

impl From<&WalletError> for Error {
    fn from(err: &WalletError) -> Self {
        match err {
            WalletError::Success(str) => Self::SUCCESS().set_message(str),
            WalletError::Fail(str) => Self::FAIL().set_message(str),
            WalletError::Io(err) => Self::IO().set_message(&err.to_string()),
            WalletError::Parameters(err) => Self::PARAMETER().set_message(&err),
            WalletError::Custom(str) => Self::CUSTOM().set_message(str),
            WalletError::Decode(str) => Self::DECODE().set_message(str),
            WalletError::Serde(err) => Self::SERDE().set_message(&err.to_string()),
            WalletError::ScaleCodec(err) => Self::SCALE_CODEC().set_message(&err.to_string()),
            WalletError::Secp256k1(err) => Self::SECP256K1().set_message(&err.to_string()),
            WalletError::NoneError(str) => Self::NONE().set_message(str),
            WalletError::RbatisError(err) => Self::RBATIS().set_message(&err.to_string()),
            WalletError::NotExist => Self::NOT_EXIST(),
        }
    }
}

#[repr(C)]
#[derive(Debug, Default)]
pub struct Wallet {
    pub id: String,
    pub next_id: String,
    pub eth_chain: EthChain,
    pub eee_chain: EeeChain,
    pub btc_chain: BtcChain,
}

#[repr(C)]
#[derive(Debug, Clone, Default)]
pub struct Address {
    pub id: String,
    pub wallet_id: String,
    pub chain_type: String,
    pub address: String,
    pub public_key: String,
}

#[repr(C)]
#[derive(Debug, Clone, Default)]
pub struct TokenShared {
    pub id: String,
    pub next_id: String,
    pub name: String,
    pub symbol: String,
}

#[repr(C)]
#[derive(Debug, Clone, Default)]
pub struct ChainShared {
    pub id: String,
    pub wallet_id: String,
    pub chain_type: String,
    /// 钱包地址
    pub wallet_address: Address,
}

// pub struct Address([u8]);
//
// impl Address{
//     fn toHex(self) -> String{
//         // hex::encode(self.0)
//         "".to_owned()
//     }
//     fn setBytes(&mut self, bs: &[u8]){
//         self.0.set_bytes(bs);
//     }
//     fn setHex(&mut self,addr: String){
//         let d = hex::encode_to_slice(self,addr);
//
//     }
//
// }
//
// /// 由助词或公钥生成地址
// pub trait MakeAddress{
//     fn publicKey_to(pkey:&[u8]) ->Address;
//     fn mnemonic_to(pkey:&[u8]) ->Address;
// }