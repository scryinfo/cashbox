//! start murmel form here
use crate::constructor::Constructor;
use crate::db::VERIFY;
use crate::path::BTC_HAMMER_PATH;
use bitcoin::Network;
use mav::NetType;
use std::net::{Ipv4Addr, SocketAddr, SocketAddrV4};
use std::path::Path;
use std::time::SystemTime;

pub fn start(net_type: &NetType) {
    let network = match net_type {
        NetType::Main => Network::Bitcoin,
        NetType::Test => Network::Testnet,
        _ => Network::Testnet,
    };

    // when test you must ignore this
    simple_logger::init_with_level(log::Level::Debug).unwrap();

    let port = match network {
        Network::Bitcoin => 8333,
        Network::Testnet => 18333,
        Network::Regtest => 18444,
    };
    let mut peers = vec![];
    peers.push(SocketAddr::from(SocketAddrV4::new(
        Ipv4Addr::new(127, 0, 0, 1),
        port,
    )));

    //default connections
    let connections = 1;
    let listen = vec![];
    let birth = SystemTime::now()
        .duration_since(SystemTime::UNIX_EPOCH)
        .unwrap()
        .as_secs();

    let chaindb = Constructor::open_db(Some(&Path::new(BTC_HAMMER_PATH)), network, birth).unwrap();
    let mut spv = Constructor::new(network, listen, chaindb, VERIFY.0.to_owned()).unwrap();
    spv.run(network, peers, connections)
        .expect("can not start node");
}

#[cfg(test)]
mod test {
    use crate::start::start;
    use mav::NetType;

    #[test]
    pub fn start_test() {
        simple_logger::init_with_level(log::Level::Debug).unwrap();
        start(&NetType::Test);
    }
}