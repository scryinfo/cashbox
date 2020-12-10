use super::*;

#[crud_enable(table_name: block_header)]
#[derive(Serialize, Deserialize, Clone, Debug)]
pub struct MBlockHeader{
    pub id: Option<u64>,
    pub header: String,
    pub scanned: String,
    pub timestamp: String,
}

