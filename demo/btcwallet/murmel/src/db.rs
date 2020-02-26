//! mod for sqlite
//!
//! block_hash table record all block_hash from blockchain
//! scanned == 0 not scanned yet
//!
use std::sync::{Arc, Mutex};
use sqlite::{State, Value};
use bitcoin::Network;
use bitcoin::blockdata::constants::genesis_block;
use bitcoin::secp256k1::ecdh::SharedSecret;

pub type SharedSQLite = Arc<Mutex<sqlite::Connection>>;

pub struct SQLite {}

impl SQLite {
    pub fn open_db() -> SharedSQLite {
        let mut sqlite = sqlite::open("client_sqlite.sqlite").expect("create sqlite error");
        sqlite.set_busy_timeout(3000).unwrap();
        sqlite.execute(
            "
            CREATE TABLE IF NOT EXISTS block_hash(block_hash TEXT,scaned INT);
            "
        ).expect("Create table block_hash error");
        sqlite.execute(
            "create table if not exists utxo(txhash TEXT,value TEXT,spendable INT)"
        ).expect("Create table tx error");
        Arc::new(Mutex::new(sqlite))
    }

    pub fn insert_block(connection: &SharedSQLite, block_hash: String) {
        let connection = connection.lock().unwrap();
        let mut statement = connection.prepare(
            "INSERT INTO block_hash VALUES(?, 0)"
        ).expect("PREPARE ERR");
        statement.bind(1,block_hash.as_str()).unwrap();
        statement.next().unwrap();
    }
}

