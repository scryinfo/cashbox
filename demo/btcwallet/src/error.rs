//! The mod for error handing, use failure [https://github.com/rust-lang-nursery/failure]
use failure::Fail;
use std::io;

#[derive(Debug, Fail)]
pub enum SPVError {
    /// rusqlite error
    #[fail(display = "the rustorm Error")]
    RustormError(rustorm::error::DbError),
    /// unconnected header chain detected
    #[fail(display = "Header unconnected")]
    UnconnectedHeader,
    /// bad proof of work
    #[fail(display = "SPV bad proof of work")]
    SpvBadProofOfWork,
    /// no chain tip found
    /// about chaintips see details at [https://bitcoincore.org/en/doc/0.18.0/rpc/blockchain/getchaintips/]
   /// Return information about all known tips in the block tree, including the main chain as well as orphaned branches.
    #[fail(display = "no chain tip found")]
    NoTip,
    /// the block's work target is not correct
    #[fail(display = "SPVError the block's work target is not correct")]
    SpvBadTarget,
    /// Handshake failure
    #[fail(display = "Handshake error")]
    Handshake,
    #[fail(display = "IO error")]
    IO(io::Error),
    /// downstream error
    #[fail(display = "Downstream")]
    Downstream(String),
}

impl std::convert::From<rustorm::error::DbError> for SPVError {
    fn from(err: rustorm::error::DbError) -> Self {
        SPVError::RustormError(err)
    }
}

impl std::convert::From<io::Error> for SPVError {
    fn from(err: io::Error) -> Self {
        SPVError::IO(err)
    }
}