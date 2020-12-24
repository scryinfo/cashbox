use std::fmt;
use std::io;
use std::ops::Add;

#[derive(Debug)]
pub enum WalletError {
    Success(String),
    Fail(String),
    Io(io::Error),
    Db(mav::Error),
    NoRecord(String),
    Parameters(String),
    Custom(String),
    Decode(String),
    EthTx(ethtx::Error),
    SubstrateTx(eee::error::Error),
    Serde(serde_json::Error),
    ScaleCodec(codec::Error),
    Secp256k1(secp256k1::Error),
    NoneError(String),
    RbatisError(rbatis_core::Error),
    NotExist,
}

impl fmt::Display for WalletError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            WalletError::Success(str) => write!(f, "Parameters error: {}", str),
            WalletError::Fail(str) => write!(f, "Parameters error: {}", str),
            WalletError::Io(ref err) => err.fmt(f),
            WalletError::Db(ref err) => err.fmt(f),
            WalletError::NoRecord(str) => write!(f, "No Record error: {}", str),
            WalletError::Parameters(ref err) => write!(f, "Parameters error: {}", err),
            // WalletError::Sqlite(ref err) => err.fmt(f),
            WalletError::EthTx(ref err) => err.fmt(f),
            WalletError::SubstrateTx(ref err) => err.fmt(f),
            WalletError::Serde(ref err) => err.fmt(f),
            WalletError::ScaleCodec(ref err) => err.fmt(f),
            WalletError::Secp256k1(ref err) => err.fmt(f),
            WalletError::NotExist => write!(f, "value not exist"),
            WalletError::Custom(err) => write!(f, "wallet custom error: {}", err),
            WalletError::Decode(err) => write!(f, "wallet decode error: {}", err),
            WalletError::NoneError(err) => err.fmt(f),
            WalletError::RbatisError(err) => err.fmt(f),
        }
    }
}

impl std::error::Error for WalletError {
    fn source(&self) -> Option<&(dyn std::error::Error + 'static)> {
        match self {
            WalletError::Io(err) =>  Some(err),
            // WalletError::Db(err) =>  Some(err),
            WalletError::EthTx(err) =>  Some(err),
            WalletError::SubstrateTx(err) =>  Some(err),
            WalletError::Serde(err) =>  Some(err),
            WalletError::ScaleCodec(err) =>  Some(err),
            WalletError::Secp256k1(err) =>  Some(err),
            WalletError::RbatisError(err) => Some(err),
            _ => None,
        }
    }
}

// impl From<sqlite::Error> for WalletError {
//     fn from(err: sqlite::Error) -> WalletError {
//         WalletError::Sqlite(err)
//     }
// }

impl From<serde_json::error::Error> for WalletError {
    fn from(err: serde_json::error::Error) -> WalletError {
        WalletError::Serde(err)
    }
}

impl From<ethtx::Error> for WalletError {
    fn from(err: ethtx::Error) -> WalletError {
        WalletError::EthTx(err)
    }
}

impl From<io::Error> for WalletError {
    fn from(err: io::Error) -> WalletError {
        WalletError::Io(err)
    }
}

impl From<hex::FromHexError> for WalletError {
    fn from(err: hex::FromHexError) -> Self {
        WalletError::Decode(format!("{:?}", err))
    }
}

impl From<std::string::FromUtf8Error> for WalletError {
    fn from(err: std::string::FromUtf8Error) -> Self {
        WalletError::Decode(format!("{:?}", err))
    }
}

impl From<failure::Error> for WalletError {
    fn from(err: failure::Error) -> Self {
        WalletError::Custom(format!("{:?}", err))
    }
}

impl From<codec::Error> for WalletError {
    fn from(err: codec::Error) -> Self {
        WalletError::ScaleCodec(err)
    }
}

impl From<secp256k1::Error> for WalletError {
    fn from(err: secp256k1::Error) -> Self {
        WalletError::Secp256k1(err)
    }
}

impl From<std::num::ParseIntError> for WalletError {
    fn from(err: std::num::ParseIntError) -> Self {
        WalletError::Decode(format!("{:?}", err))
    }
}

impl From<rlp::DecoderError> for WalletError {
    fn from(err: rlp::DecoderError) -> Self {
        WalletError::Decode(format!("{:?}", err))
    }
}

impl From<eee::error::Error> for WalletError {
    fn from(err: eee::error::Error) -> Self {
        WalletError::SubstrateTx(err)
    }
}

impl From<semver::SemVerError> for WalletError {
    fn from(err: semver::SemVerError) -> Self {
        WalletError::Custom(format!("{:?}", err))
    }
}

// impl From<failure::NoneError> for WalletError{
//     fn from(err: failure::NoneError) -> Self {
//         WalletError::NoneError(err.to_string())
//     }
// }

impl From<rbatis_core::Error> for WalletError {
    fn from(err: rbatis_core::Error) -> Self {
        WalletError::RbatisError(err)
    }
}

impl From<mav::Error> for WalletError {
    fn from(err: mav::Error) -> Self {
        WalletError::Db(err)
    }
}


#[derive(Debug, Clone, Default)]
pub struct Error {
    //由于很多地方都有使用 error这个名字，加一个C减少重名
    pub code: u64,
    pub message: String,
}

#[allow(non_snake_case)]
impl Error {
    pub fn SUCCESS() -> Self { Error { code: 0, message: String::from("Success ") } }
    pub fn FAIL() -> Error { Error { code: 1, message: "FAIL error ".to_owned() } }
    pub fn IO() -> Error { Error { code: 100, message: "IO error".to_owned() } }
    pub fn DB() -> Error { Error { code: 500, message: "DB error".to_owned() } }
    pub fn NoRecord() -> Error { Error { code: 501, message: "No Record error".to_owned() } }
    pub fn PARAMETER() -> Error { Error { code: 110, message: "Parameter error ".to_owned() } }
    pub fn ETHTX() -> Error { Error { code: 300, message: "EthTx error ".to_owned() } }
    pub fn SUBSTRATETX() -> Error { Error { code: 310, message: "SubstrateTx error ".to_owned() } }
    pub fn CUSTOM() -> Error { Error { code: 120, message: "CUSTOM error".to_owned() } }
    pub fn DECODE() -> Error { Error { code: 130, message: "DECODE error".to_owned() } }
    pub fn SERDE() -> Error { Error { code: 140, message: "SERDE error".to_owned() } }
    pub fn SCALE_CODEC() -> Error { Error { code: 150, message: "SCALE_CODEC error".to_owned() } }
    pub fn SECP256K1() -> Error { Error { code: 160, message: "SECP256K1 error".to_owned() } }
    pub fn NONE() -> Error { Error { code: 170, message: "NONE error".to_owned() } }
    pub fn RBATIS() -> Error { Error { code: 180, message: "RBATIS error".to_owned() } }
    pub fn NOT_EXIST() -> Error { Error { code: 190, message: "NOT_EXIST error".to_owned() } }

    pub fn set_code(&self, code: u64) -> Error {
        Error { code, message: self.message.clone() }
    }
    pub fn set_message(&self, message: &str) -> Error {
        Error { code: self.code, message: message.to_owned() }
    }
    pub fn append_message(&self, message: &str) -> Error {
        Error { code: self.code, message: self.message.clone().add(message) }
    }
}

impl From<WalletError> for Error {
    fn from(err: WalletError) -> Self {
        match &err {
            WalletError::Success(str) => Self::SUCCESS().set_message(str),
            WalletError::Fail(str) => Self::FAIL().set_message(str),
            WalletError::Io(err) => Self::IO().set_message(&err.to_string()),
            WalletError::Db(err) => Self::DB().set_message(&err.to_string()),
            WalletError::NoRecord(str) => Self::NoRecord().set_message(str),
            WalletError::Parameters(err) => Self::PARAMETER().set_message(&err),
            WalletError::EthTx(err) => Self::ETHTX().set_message(&err.to_string()),
            WalletError::SubstrateTx(err) => Self::SUBSTRATETX().set_message(&err.to_string()),
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

impl From<mav::Error> for Error {
    fn from(err: mav::Error) -> Self {
        Self::DB().set_message(&err.to_string())
    }
}

impl fmt::Display for Error {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "error code: {}, message: {}", self.code, self.message)
    }
}
