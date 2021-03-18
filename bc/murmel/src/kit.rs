use bitcoin::consensus::encode::Error;
use bitcoin::Transaction;
use std::fmt::Write;

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

///
/// static tx fee mybe not a good idea <br>
/// Data from https://bitcoinfees.earn.com/ <br>
/// {"fastestFee":102,"halfHourFee":102,"hourFee":88} <br>
/// tx fee changes over time <br>
/// size = inputsNum * 148 + outputsNum * 34 + 10 (+/-) 40
/// tx fee related to inputs and outputs
///
pub fn tx_fee(input_sum: f32, outputs_num: f32) -> f32 {
    let size = input_sum * 148f32 + outputs_num * 34f32 + 10f32;
    size * 88
}