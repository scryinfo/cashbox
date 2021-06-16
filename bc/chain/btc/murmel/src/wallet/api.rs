//! api about wallet defined in here

use crate::constructor::Constructor;
use crate::db::{balance_helper, GlobalRB, GLOBAL_RB};
use crate::path::{BTC_HAMMER_PATH, PATH};
use crate::{db, Error, kit};
use bitcoin::{Address, Network, OutPoint, TxIn, TxOut};
use bitcoin_wallet::account::{Account, AccountAddressType, MasterAccount, Unlocker};
use bitcoin_wallet::mnemonic::Mnemonic;
use log::LevelFilter;
use mav::ma::MAddress;
use mav::{ChainType, NetType};
use std::net::{Ipv4Addr, SocketAddr, SocketAddrV4};
use std::path::Path;
use std::str::FromStr;
use std::time::SystemTime;
use wallets_types::{BtcBalance, BtcNowLoadBlock};
use bitcoin_hashes::sha256d;
use bitcoin::hashes::hex::FromHex;

const RBF: u32 = 0xffffffff - 2;

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

pub async fn btc_load_now_blocknumber(
    net_type: &NetType,
) -> Result<BtcNowLoadBlock, rbatis::Error> {
    set_global(net_type);
    db::fetch_scanned_height().await
}

pub async fn btc_load_balance(net_type: &NetType) -> Result<BtcBalance, rbatis::Error> {
    set_global(net_type);
    db::load_balance().await
}

fn set_global(net_type: &NetType) {
    if let None = GLOBAL_RB.get() {
        let network = match net_type {
            NetType::Main => Network::Bitcoin,
            NetType::Test => Network::Testnet,
            NetType::Private => Network::Regtest,
            NetType::PrivateTest => Network::Regtest,
        };
        let global_rb = GlobalRB::from(PATH, network).unwrap();
        GLOBAL_RB.set(global_rb).unwrap();
    }
}

pub async fn btc_tx_sign(
    net_type: &NetType,
    mnemonic: &String,
    from_address: &String,
    to_address: &String,
    password: &String,
    value: &String,
) -> Result<String, crate::Error> {
    set_global(net_type);
    let network = match net_type {
        NetType::Main => Network::Bitcoin,
        NetType::Test => Network::Testnet,
        NetType::Private => Network::Regtest,
        NetType::PrivateTest => Network::Regtest,
    };

    let balance = btc_load_balance(net_type).await?;
    let mut value = value
        .parse::<f64>()
        .map_err(|e| crate::Error::BtcTx(e.to_string()))?;
    value = value * 100000000f64;
    if (value as u64) > balance.balance {
        let e = Error::BtcTx("value not enough".to_string());
        return Err(e);
    }

    let mnemonic = Mnemonic::from_str(&mnemonic).map_err(|e| Error::BtcTx(e.to_string()))?;
    let mut master = MasterAccount::from_mnemonic(&mnemonic, 0, network, password, None).unwrap();
    let mut unlocker = Unlocker::new_for_master(&master, password).unwrap();
    // source
    let account = Account::new(&mut unlocker, AccountAddressType::P2PKH, 0, 0, 10)
        .map_err(|e| crate::Error::BtcTx(e.to_string()))?;
    master.add_account(account);
    let source = master
        .get_mut((0, 0))
        .unwrap()
        .next_key()
        .unwrap()
        .address
        .clone();
    if !source.to_string().eq(from_address) {
        return Err(Error::BtcTx("form address error".to_string()));
    }
    // target
    let target =
        bitcoin::Address::from_str(to_address).map_err(|e| crate::Error::BtcTx(e.to_string()))?;
    let target_script = target.script_pubkey();
    // utxos
    let outputs = balance_helper().await;
    let mut utxos = vec![];
    let mut total = 0;
    for output in outputs {
        if total <= value as u64 {
            total += output.1.value;
            utxos.push(output.1);
        }
    }
    //signature
    let mut txin = vec![];
    for utxo in utxos {
        txin.push(TxIn {
            previous_output: OutPoint {
                txid: sha256d::Hash::from_hex(
                    &utxo.btc_tx_hash
                )
                    .unwrap(),
                vout: utxo.idx,
            },
            script_sig: Default::default(),
            sequence: RBF,
            witness: vec![],
        });
    }

    let mut txout = vec![];
    txout.push(
        TxOut{
            value: value as u64,
            script_pubkey: target_script,
        }
    );
    let fee = kit::tx_fee(utxos.len() as u32,2);

    Ok("Sign Sucess".to_string())
}
