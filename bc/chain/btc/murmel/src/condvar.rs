use once_cell::sync::OnceCell;
use parking_lot::Condvar;
use std::sync::Arc;

// CondVar use for sync thread
pub type CondPair<T> = Arc<(parking_lot::Mutex<T>, Condvar)>;

pub static BROADCAST_INSTANCE: OnceCell<CondPair<usize>> = OnceCell::new();

