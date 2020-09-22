//！ hooks message for notices when should get data

use p2p::PeerId;

pub enum HooksMessage {
    ReceivedHeaders(PeerId),
    Others,
}

pub enum ApiMessage {
    Api,
    Db,
    Other,
}