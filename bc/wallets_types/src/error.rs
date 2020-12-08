use std::error::Error;
use std::fmt;
use std::io;

#[derive(Debug)]
pub enum WalletError {
    Success(String),
    Fail(String),
    Io(io::Error),
    Parameters(String),
    Custom(String),
    Decode(String),
    // EthTx(ethtx::Error),
    // SubstrateTx(substratetx::error::Error),
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
            WalletError::Parameters(ref err) => write!(f, "Parameters error: {}", err),
            // WalletError::Sqlite(ref err) => err.fmt(f),
            // WalletError::EthTx(ref err) => err.fmt(f),
            // WalletError::SubstrateTx(ref err) => err.fmt(f),
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

impl Error for WalletError {
    fn source(&self) -> Option<&(dyn Error + 'static)> {
        match self {
            WalletError::Io(ref err) => Some(err),
            WalletError::Serde(error) => Some(error),
            // WalletError::EthTx(error) => Some(error),
            // WalletError::SubstrateTx(error) => Some(error),
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

// impl From<ethtx::Error> for WalletError {
//     fn from(err: ethtx::Error) -> WalletError {
//         WalletError::EthTx(err)
//     }
// }

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

// impl From<substratetx::error::Error> for WalletError {
//     fn from(err: substratetx::error::Error) -> Self {
//         WalletError::SubstrateTx(err)
//     }
// }

impl From<semver::SemVerError> for WalletError {
    fn from(err: semver::SemVerError) -> Self {
        WalletError::Custom(format!("{:?}", err))
    }
}

// impl From<failure::NoneError> for WalletError{
//     fn from(err: failure::NoneError) -> Self {
//         WalletError::NoneError(err)
//     }
// }

impl From<rbatis_core::Error> for WalletError {
    fn from(err: rbatis_core::Error) -> Self {
        WalletError::RbatisError(err)
    }
}