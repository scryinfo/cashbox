//！ hooks message for notices when should get data

use crate::p2p::PeerId;

pub enum HooksMessage {
    ReceivedHeaders(PeerId),
    Others,
}

pub enum ApiMessage {
    Api,
    Db,
    Other,
}

// Conditions for use CondVar
// handhsake -> header -> filter -> getdata
// handhsake -> header -> tx
pub struct Condition {
    pub header_ready: bool,
    pub fillter_ready: bool,
}
