use super::*;
use ethereum_types::{Address};

mod transaction;
mod transaction_id;

pub use transaction_id::TypedTxId;
pub use transaction::{Action,TypedTransaction,EIP1559TransactionTx,AccessListTx,Transaction};

pub type AccessListItem = (H160, Vec<H256>);
pub type AccessList = Vec<AccessListItem>;

/// Fake address for unsigned transactions as defined by EIP-86.
pub const UNSIGNED_SENDER: Address = H160([0xff; 20]);

/// System sender address for internal state updates.
pub const SYSTEM_ADDRESS: Address = H160([
    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
    0xff, 0xff, 0xff, 0xfe,
]);