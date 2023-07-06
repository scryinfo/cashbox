//! Contract call/query error.

use derive_more::{Display, From};
use ethabi::Error as EthError;

use crate::error::Error as ApiError;

/// Contract error.
#[derive(Debug, Display, From)]
pub enum Error {
    /// invalid output type requested by the caller
    #[display(fmt = "Invalid output type: {}", _0)]
    InvalidOutputType(String),
    /// eth abi error
    #[display(fmt = "Abi error: {}", _0)]
    Abi(EthError),
    /// Rpc error
    #[display(fmt = "Api error: {}", _0)]
    Api(ApiError),
}

impl std::error::Error for Error {
    fn source(&self) -> Option<&(dyn std::error::Error + 'static)> {
        match *self {
            Error::InvalidOutputType(_) => None,
            Error::Abi(ref e) => Some(e),
            Error::Api(ref e) => Some(e),
        }
    }
}

pub mod deploy {
    use derive_more::{Display, From};

    use crate::error::Error as ApiError;
    use crate::types::H256;

    /// Contract deployment error.
    #[derive(Debug, Display, From)]
    pub enum Error {
        /// Rpc error
        #[display(fmt = "Api error: {}", _0)]
        Api(ApiError),
        /// Contract deployment failed
        #[display(fmt = "Failure during deployment.Tx hash: {:?}", _0)]
        ContractDeploymentFailure(H256),
    }

    impl std::error::Error for Error {
        fn source(&self) -> Option<&(dyn std::error::Error + 'static)> {
            match *self {
                Error::Api(ref e) => Some(e),
                Error::ContractDeploymentFailure(_) => None,
            }
        }
    }
}
