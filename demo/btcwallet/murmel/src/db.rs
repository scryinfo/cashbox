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
use error;

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
            CREATE TABLE IF NOT EXISTS block_hash(block_hash TEXT,scaned TEXT,timestamp TEXT);
            "
        ).expect("Create table block_hash error");
        sqlite.execute(
            "create table if not exists utxo(txhash TEXT,script TEXT, value REAL, vout INT);"
        ).expect("Create table tx error");
        sqlite.execute(
            "create table if not exists newest_hash(key TEXT,block_hash TEXT,timestamp TEXT);"
        ).expect("Create newest_hash table error");
        Self {
            connection: sqlite,
            network,
        }
    }

    /// 查询上次初始化进度
    pub fn init(&mut self) {
        let newest = self.query_newset_header(NEWEST_KEY);
    }

    //存储区块头
    pub fn insert_block(&self, block_hash: String, timestamp: String) {
        let mut statement = self.connection.prepare(
            "INSERT INTO block_hash VALUES(?, ?, ?)"
        ).expect("PREPARE ERR");
        statement.bind(1, block_hash.as_str()).unwrap();
        statement.bind(2, "0").unwrap();
        statement.bind(3, timestamp.as_str()).unwrap();
        statement.next().expect("insert block error");
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

    //查询最新进度
    pub fn query_newset_header(&self, key: &str) -> Option<String> {
        let mut statement = self.connection.prepare(
            "SELECT * FROM newest_hash WHERE key = ?"
        ).expect("query_new error");
        statement.bind(1, key).expect("query newest error");
        let mut result: Option<String> = None;
        while let State::Row = statement.next().unwrap() {
            result = match statement.read::<String>(0) {
                Ok(hash) => Some(hash),
                Err(_) => None,
            }
        }
        result
    }

    //存储 utxo
    pub fn insert_utxo(&self, tx: String, script: String, value: f64, vout: i64) {
        let mut statement = self.connection.prepare(
            "INSERT INTO utxo VALUES(?,?,?,?)"
        ).expect("insert utxo error");
        statement.bind(1, tx.as_str()).expect("bind statement error");
        statement.bind(2, script.as_str()).expect("bind statement error");
        statement.bind(3, value).expect("bind statement error");
        statement.bind(4, vout).expect("bind statement error");
        statement.next().expect("insert utxo error");
    }
}

const NEWEST_KEY: &str = "NEWEST_KEY";

