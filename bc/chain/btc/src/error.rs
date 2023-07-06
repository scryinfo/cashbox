use std::io::Error as IoError;

use derive_more::{Display, From};

/// Errors which can occur when attempting to generate resource uri.
#[derive(Debug, Display, From)]
pub enum Error {
    #[display(fmt = "Wallets error:{}", _0)]
    Wallets(bitcoin_wallet::error::Error),
    /// server is unreachable
    #[display(fmt = "Server is unreachable")]
    Unreachable,
    /// decoder error
    #[display(fmt = "Decoder error: {}", _0)]
    Decoder(String),
    /// invalid response
    #[display(fmt = "Got invalid response: {}", _0)]
    #[from(ignore)]
    InvalidResponse(String),
    /// io error
    #[display(fmt = "IO error: {}", _0)]
    Io(IoError),
    /// web3 internal error
    #[display(fmt = "Internal Web3 error")]
    Internal,
    #[display(fmt = "other lib: {}", _0)]
    #[from(ignore)]
    Other(String),
}


impl From<failure::Error> for Error {
    fn from(err: failure::Error) -> Self {
        Error::Other(format!("{:?}", err))
    }
}

impl From<std::string::FromUtf8Error> for Error {
    fn from(err: std::string::FromUtf8Error) -> Self {
        Error::Decoder(format!("{:?}", err))
    }
}

