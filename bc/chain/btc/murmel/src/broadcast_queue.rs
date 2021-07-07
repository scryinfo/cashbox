use bitcoin::Transaction;
use once_cell::sync::OnceCell;
use parking_lot::{Condvar, Mutex};
use std::sync::Arc;

// CondVar use for sync thread
pub type CondPair<T> = Arc<(parking_lot::Mutex<T>, Condvar)>;

#[derive(Debug)]
pub struct NamedQueue<'a, T> {
    name: &'a str,
    q: Vec<T>,
}

impl<'a, T> NamedQueue<'a, T> {
    pub fn init(name: &'static str) -> NamedQueue<T> {
        NamedQueue { name, q: vec![] }
    }

    pub fn push(&mut self, t: T) {
        self.q.push(t)
    }

    pub fn pop(&mut self) -> Option<T> {
        self.q.pop()
    }
}

pub fn global_q(name: &str) -> &'static Mutex<NamedQueue<Transaction>> {
    static GLOBAL_QUEUE: OnceCell<Mutex<NamedQueue<Transaction>>> = OnceCell::new();
    GLOBAL_QUEUE.get_or_init(|| {
        let q: NamedQueue<_> = NamedQueue::init(name);
        Mutex::new(q)
    })
}
