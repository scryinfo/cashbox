//! mod for sqlite
//!
//! block_hash table record all block_hash from blockchain
//! scanned == 0 not scanned yet
//!
use std::sync::{Arc, Mutex};
use sqlite::{State, Value, Statement};
use bitcoin::Network;
use bitcoin::blockdata::constants::genesis_block;
use bitcoin::secp256k1::ecdh::SharedSecret;

pub type SharedSQLite = Arc<Mutex<SQLite>>;

pub struct SQLite {
    connection: sqlite::Connection,
    network: Network,
}

impl SQLite {
    pub fn open_db(network: Network) -> Self {
        let mut sqlite = sqlite::open("client_sqlite.sqlite").expect("create sqlite error");
        sqlite.set_busy_timeout(3000).unwrap();
        sqlite.execute(
            "
            CREATE TABLE IF NOT EXISTS block_hash(block_hash TEXT,scaned TEXT， timestamp TEXT);
            "
        ).expect("Create table block_hash error");
        sqlite.execute(
            "create table if not exists utxo(txhash TEXT,script TEXT, value REAL, vout INT);"
        ).expect("Create table tx error");
        Self {
            connection: sqlite,
            network,
        }
    }

    //存储区块头
    pub fn insert_block(&self, block_hash: String, timestamp: String) {
        let mut statement = self.connection.prepare(
            "INSERT INTO block_hash VALUES(?, 0, ?)"
        ).expect("PREPARE ERR");
        statement.bind(1, block_hash.as_str()).unwrap();
        statement.bind(2, timestamp.as_str()).unwrap();
        statement.next().unwrap();
    }

    //查询未扫描区块头 返回相应数据
    pub fn query_header(&self, scanned: String) {
        let mut statement = self.connection.prepare(
            "SELECT * FROM block_hash WHERE scanned = ? LIMIT 200"
        ).expect("query_header PREPARE ERR");
        statement.bind(
            1,
            scanned.as_str(),
        ).expect("bind ERR");
    }

    //修改已扫描的区块头的状态
}

