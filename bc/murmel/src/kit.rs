use bitcoin::Transaction;
use std::fmt::Write;
use bitcoin::consensus::encode::Error;

pub fn vec_to_string(vec: Vec<u8>) -> String {
    let mut r = String::new();
    for v in vec {
        write!(r, "{:02x}", v).expect("No write");
    }
    r
}

#[allow(dead_code)]
pub fn tx_to_hex(tx: &Transaction) -> String {
    let ser = bitcoin::consensus::serialize(tx);
    vec_to_string(ser)
}

pub fn hex_to_tx(str: &str) -> Result<Transaction, Error> {
    let hex_tx = bitcoin::util::misc::hex_bytes(str).unwrap();
    let tx: Result<Transaction, _> = bitcoin::consensus::deserialize(&hex_tx);
    tx
}