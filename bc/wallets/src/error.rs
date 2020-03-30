use std::io;
use std::fmt;

#[derive(Debug)]
pub enum WalletError{
    Io(io::Error),
    Sqlite(sqlite::Error),
    Custom(String),
    Decode(String),
    EthTx(ethtx::Error),
    Serde(serde_json::Error),
    NotExist,

}

impl fmt::Display for WalletError{

    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            WalletError::Io(ref err)=>err.fmt(f),
            WalletError::Sqlite(ref err)=>err.fmt(f),
            WalletError::EthTx(ref err)=>err.fmt(f),
            WalletError::Serde(ref err)=>err.fmt(f),
            WalletError::NotExist=>write!(f,"value not exist"),
            WalletError::Custom(err) => write!(f, "wallet custom error: {}", err),
            WalletError::Decode(err) => write!(f, "wallet decode error: {}", err),
        }

    }
}

//impl error::Error for WalletError {
/*impl Display for WalletError {
    fn description(&self) -> &str {
        // Both underlying errors already impl `Error`, so we defer to their
        // implementations.
        match self {
            WalletError::Io(ref err) => err.description(),
            WalletError::Sqlite(ref err) => err.description(),
            WalletError::EthTx(ref err) => err.description(),
            WalletError::Serde(ref err) => err.description(),
            WalletError::Custom(err) => err,
            WalletError::Decode(err) => err,
            WalletError::NotExist=>"not exist",
        }
    }
}*/

impl From<sqlite::Error> for WalletError{
    fn from(err: sqlite::Error) -> WalletError {
        WalletError::Sqlite(err)
    }
}

impl From<serde_json::error::Error> for WalletError{
    fn from(err: serde_json::error::Error) -> WalletError {
        WalletError::Serde(err)
    }
}

impl From<ethtx::Error> for WalletError{
    fn from(err: ethtx::Error) -> WalletError {
        WalletError::EthTx(err)
    }
}

impl From<io::Error> for WalletError{
    fn from(err: io::Error) -> WalletError {
        WalletError::Io(err)
    }
}

impl From<hex::FromHexError> for WalletError{
    fn from(err: hex::FromHexError) -> Self {
        WalletError::Decode(format!("{:?}", err))
    }
}

impl From<std::string::FromUtf8Error> for WalletError{
    fn from(err: std::string::FromUtf8Error) -> Self {
        WalletError::Decode(format!("{:?}", err))
    }
}

