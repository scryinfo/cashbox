use super::*;

#[crud_enable(table_name: user_address)]
#[derive(Serialize, Deserialize, Clone, Debug)]
pub struct MUserAddress {
    pub id: Option<u64>,
    pub address: String,
    pub compressed_pub_key: String,
}

#[crud_enable(table_name: tx_input)]
#[derive(Serialize, Deserialize, Clone, Debug)]
pub struct MTxInput {
    pub id: Option<u64>,
    pub tx: String,
    pub sig_script: String,
    pub prev_tx: String,
    pub prev_vout: String,
    pub sequence: i64,
}

#[crud_enable(table_name: tx_output)]
#[derive(Serialize, Deserialize, Clone, Debug)]
pub struct MTxOutput {
    pub id: Option<u64>,
    pub tx: String,
    pub script: String,
    pub value: String,
    pub vin: String,
}

#[crud_enable(table_name: progress)]
#[derive(Serialize, Deserialize, Clone, Debug)]
pub struct MProgress {
    pub id: Option<u64>,
    pub header: String,
    pub timestamp: String,
}

#[crud_enable(table_name: local_tx)]
#[derive(Serialize, Deserialize, Clone, Debug)]
pub struct MLocalTx {
    pub id: Option<u64>,
    pub address_from: String,
    pub address_to: String,
    pub value: String,
    pub status: String,
}

