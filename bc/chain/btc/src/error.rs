use derive_more::{Display, From};
use std::io::Error as IoError;

/// Errors which can occur when attempting to generate resource uri.
#[derive(Debug, Display, From)]
pub enum Error {
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
    /// transport error
    #[display(fmt = "Transport error: {}", _0)]
    #[from(ignore)]
    Transport(String),
    /// io error
    #[display(fmt = "IO error: {}", _0)]
    Io(IoError),
    /// web3 internal error
    #[display(fmt = "Internal Web3 error")]
    Internal,
    #[display(fmt = "other lib: {}", _0)]
    #[from(ignore)]
    Other(String),
    #[display(fmt = "secp256k1 error: {}", _0)]
    Secp256k1(secp256k1::Error),
}


impl From<tiny_hderive::Error> for Error {
    fn from(err: tiny_hderive::Error) -> Self {
        Error::Other(format!("{:?}", err))
    }
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

