//! api about wallet defined in here

use crate::constructor::Constructor;
use crate::db;
use crate::db::{GlobalRB, GLOBAL_RB};
use crate::path::{BTC_HAMMER_PATH, PATH};
use bitcoin::Network;
use log::LevelFilter;
use mav::ma::MAddress;
use mav::{ChainType, NetType};
use std::net::{Ipv4Addr, SocketAddr, SocketAddrV4};
use std::path::Path;
use std::time::SystemTime;
use wallets_types::{BtcBalance, BtcNowLoadBlock};

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

    let address = address
        .iter()
        .filter(|&&a| a.chain_type.eq(chain_type.to_string().as_str()))
        .collect::<Vec<&&MAddress>>();

    //#[cfg(test)]
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
    let mut spv = Constructor::new(network, listen, chaindb, *address[0]).unwrap();
    spv.run(network, peers, connections)
        .expect("can not start node");
}

pub fn btc_load_now_blocknumber(net_type: &NetType) -> Result<BtcNowLoadBlock, rbatis::Error> {
    let network = match net_type {
        NetType::Main => Network::Bitcoin,
        NetType::Test => Network::Testnet,
        NetType::Private => Network::Regtest,
        NetType::PrivateTest => Network::Regtest,
    };
    if let None = GLOBAL_RB.get() {
        set_global(network);
    }
    db::fetch_scanned_height()
}

pub fn btc_load_balance(net_type: &NetType) -> Result<BtcBalance, rbatis::Error> {
    let network = match net_type {
        NetType::Main => Network::Bitcoin,
        NetType::Test => Network::Testnet,
        NetType::Private => Network::Regtest,
        NetType::PrivateTest => Network::Regtest,
    };
    if let None = GLOBAL_RB.get() {
        set_global(network);
    }
    db::load_balance()
}

fn set_global(network: Network) {
    let global_rb = GlobalRB::from(PATH, network).unwrap();
    GLOBAL_RB.set(global_rb).unwrap();
}

pub fn btc_tx_sign(
    net_type: &NetType,
    mnemonic: &String,
    to_address: &String,
    value: &String,
) -> Result<String, rbatis::Error> {
    todo!()
}