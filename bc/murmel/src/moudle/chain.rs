#[crud_enable(table_name: block_header)]
#[derive(Serialize, Deserialize, Clone, Debug)]
pub struct MBlockHeader{
    pub id: String,
    pub header: String,
    pub scanned: String,
    pub timestamp: String,
}

