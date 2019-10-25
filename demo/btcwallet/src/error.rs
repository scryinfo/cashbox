/// The mod for error handing, use failure [https://github.com/rust-lang-nursery/failure]
use failure::Fail;

#[derive(Debug, Fail)]
pub enum SPVError {
    /// rusqlite error
    #[fail(display = "the rusqlite Error")]
    RusqliteError(rusqlite::Error),
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
}

impl std::convert::From<rusqlite::Error> for SPVError {
    fn from(err: rusqlite::Error) -> Self {
        SPVError::RusqliteError(err)
    }
}