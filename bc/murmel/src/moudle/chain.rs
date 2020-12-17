use super::*;

#[crud_enable(table_name: block_header)]
#[derive(Serialize, Deserialize, Clone, Debug)]
pub struct MBlockHeader {
    pub id: Option<u64>,
    pub header: String,
    pub scanned: String,
    pub timestamp: String,
}

impl MBlockHeader {
    pub(crate) const SQL: &'static str = std::include_str!("../../sql/create_block_header.sql");
}
