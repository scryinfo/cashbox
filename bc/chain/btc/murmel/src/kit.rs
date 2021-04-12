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
/// https://coinb.in/#fees <br>
/// tx fee changes over time <br>
/// size = inputsNum * 148 + outputsNum * 34 + 10 (+/-) 40 <br>
/// tx fee related to inputs and outputs <br>
/// use low fee compaire with tx fee in Mainet <br>
/// '19' comes from coinb.in (Satoshi per Byte: 19) </br>
///
/// another website  https://bitcoinfees.earn.com/api/v1/fees/recommended
///
pub fn tx_fee(input_sum: u32, outputs_num: u32) -> u32 {
    let size = input_sum * 148u32 + outputs_num * 34u32  + 10;
    size * 19
}

mod test {
    use crate::kit::tx_fee;

    #[test]
    pub fn tx_fee_test() {
        let fee = tx_fee(1, 1);
        println!("{:?}", fee);
    }
}