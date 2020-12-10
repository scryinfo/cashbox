#[crud_enable(table_name: user_address)]
#[derive(Serialize, Deserialize, Clone, Debug)]
pub struct MUserAddress {
    id: String,
    address: String,
    compressed_pub_key: String,
}

#[crud_enable(table_name: tx_input)]
#[derive(Serialize, Deserialize, Clone, Debug)]
pub struct MTxInput {
    id: String,
    tx: String,
    sig_script: String,
    prev_tx: String,
    prev_vout: String,
    sequence: i64,
}

#[crud_enable(table_name: tx_output)]
#[derive(Serialize, Deserialize, Clone, Debug)]
pub struct MTxOutput {
    id: String,
    tx: String,
    script: String,
    value: String,
    vin: String,
}

#[crud_enable(table_name: progress)]
#[derive(Serialize, Deserialize, Clone, Debug)]
pub struct MProgress {
    id: String,
    header: String,
    timestamp: String,
}

#[crud_enable(table_name: local_tx)]
#[derive(Serialize, Deserialize, Clone, Debug)]
pub struct MLocalTx {
    id: String,
    address_from: String,
    address_to: String,
    value: String,
    status: String,
}

