use super::*;

pub mod chain;
pub mod digit;
pub mod wallet;

#[test]
fn eth_tx_signed_test(){
    let json = r#" {
            "nonce": "0x0",
            "gasPrice": "0x4a817c800",
            "gas": "0x5208",
            "to": "0x7b02dca46711be2664310f4fe322c8bd35a9bd2a",
            "value": "0xde0b6b3a7640000",
            "data": []
        }"#;
    let chain_id = Some(17);
    let pri_key = "0x4646464646464646464646464646464646464646464646464646464646464646";
    let pri_bytes = hex::decode(pri_key.get(2..).unwrap()).unwrap();
    let tx : wallet::ethereum::RawTransaction = serde_json::from_str(json).expect("tx format");
    let sig =  tx.sign(pri_bytes.as_slice(),chain_id);
    let tx_hex = hex::encode(sig);
    println!("tx hex:{}",tx_hex);
}
