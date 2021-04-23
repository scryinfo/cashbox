//! start murmel form here
use crate::constructor::Constructor;
use crate::db::VERIFY;
use crate::path::BTC_HAMMER_PATH;
use bitcoin::Network;
use log::LevelFilter;
use mav::ma::MAddress;
use mav::{ChainType, NetType};
use std::net::{Ipv4Addr, SocketAddr, SocketAddrV4};
use std::path::Path;
use std::time::SystemTime;

///
/// btc now just have three type    </br>
///     1. Bitcoin Mainnet
///     2. Testnet
///     3. Regtest （Private)
///
pub fn start(net_type: &NetType, address: Vec<&MAddress>) {
    let (chain_type, network) = match net_type {
        NetType::Main => (ChainType::BTC, Network::Bitcoin),
        NetType::Test => (ChainType::BtcTest, Network::Testnet),
        NetType::Private => (ChainType::BtcPrivate, Network::Regtest),
        _ => (ChainType::BtcTest, Network::Testnet),
    };

    #[cfg(test)]
    simple_logger::SimpleLogger::new()
        .with_level(LevelFilter::Debug)
        .init()
        .unwrap();

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