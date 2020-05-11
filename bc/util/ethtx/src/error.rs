//! Web3 Error
use derive_more::{Display, From};
use serde_json::Error as SerdeError;
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

}

impl std::error::Error for Error {
    fn source(&self) -> Option<&(dyn std::error::Error + 'static)> {
        use self::Error::*;
        match *self {
            Unreachable | Decoder(_) | InvalidResponse(_) | Transport(_) | Internal|Other(_) => None,
            Io(ref e) => Some(e),
        }
    }
}

impl From<SerdeError> for Error {
    fn from(err: SerdeError) -> Self {
        Error::Decoder(format!("{:?}", err))
    }
}

impl  From<ethabi::Error> for Error{
    fn from(err: ethabi::Error) -> Self {
        Error::Decoder(format!("{:?}", err))
    }
}

impl From<hex::FromHexError> for Error{
    fn from(err: hex::FromHexError) -> Self {
        Error::Decoder(format!("{:?}", err))
    }
}
impl From<std::string::FromUtf8Error> for Error{
    fn from(err: std::string::FromUtf8Error) -> Self {
        Error::Decoder(format!("{:?}", err))
    }
}

impl From<tiny_hderive::Error> for Error {
    fn from(err: tiny_hderive::Error) -> Self {
        Error::Other(format!("{:?}", err))
    }
}
impl From<failure::Error> for Error{
    fn from(err: failure::Error)->Self{
        Error::Other(format!("{:?}", err))
    }
}


impl Clone for Error {
    fn clone(&self) -> Self {
        use self::Error::*;
        match self {
            Unreachable => Unreachable,
            Decoder(s) => Decoder(s.clone()),
            InvalidResponse(s) => InvalidResponse(s.clone()),
            Transport(s) => Transport(s.clone()),
            Io(e) => Io(IoError::from(e.kind())),
            Internal => Internal,
            Other(s)=>Other(s.clone()),
        }
    }
}

impl PartialEq for Error {
    fn eq(&self, other: &Self) -> bool {
        use self::Error::*;
        match (self, other) {
            (Unreachable, Unreachable) | (Internal, Internal) => true,
            (Decoder(a), Decoder(b)) | (InvalidResponse(a), InvalidResponse(b)) | (Transport(a), Transport(b)) => {
                a == b
            }
            (Io(a), Io(b)) => a.kind() == b.kind(),
            _ => false,
        }
    }
}
