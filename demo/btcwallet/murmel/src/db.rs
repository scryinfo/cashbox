//! mod for sqlite
//!
//!
use std::sync::{Arc, Mutex};
use sqlite::{State, Value, Statement};
use bitcoin::{Network, BitcoinHash};
use bitcoin::blockdata::constants::genesis_block;
use error;
use bitcoin::hashes::hex::ToHex;

pub type SharedSQLite = Arc<Mutex<SQLite>>;

const NEWEST_KEY: &str = "NEWEST_KEY";

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
            CREATE TABLE IF NOT EXISTS block_hash(ID INTEGER PRIMARY KEY AUTOINCREMENT,block_hash TEXT,scanned TEXT,timestamp TEXT);
            "
        ).expect("Create table block_hash error");
        sqlite.execute(
            "create table if not exists newest_hash(ID INTEGER PRIMARY KEY AUTOINCREMENT,key TEXT,block_hash TEXT,timestamp TEXT);"
        ).expect("Create newest_hash table error");
        sqlite.execute(
            "create table if not exists tx_input(ID INTEGER PRIMARY KEY AUTOINCREMENT,tx TEXT not null ,sig_script TEXT, prev_tx TEXT, prev_vout INT, sequence INT);"
        ).expect("Create tx_input table error");
        sqlite.execute(
            "create table if not exists tx_output(ID INTEGER PRIMARY KEY AUTOINCREMENT,tx TEXT not null ,script TEXT, value REAL, vin INT);"
        ).expect("Create tx_output table error");
        Self {
            connection: sqlite,
            network,
        }
    }

    // Query the last initialization progress
    pub fn init(&self) -> (String, String) {
        let (block_hash, timestamp) = self.query_newest_header(NEWEST_KEY);
        if block_hash.is_none() {
            let genesis = genesis_block(self.network).header;
            let block_hash = genesis.bitcoin_hash().to_hex();
            let timestamp = genesis.time.to_string();
            info!("scanned newest block from genesis {:?}", &block_hash);
            self.insert_newest_header(block_hash.clone(), timestamp.clone());
            return (block_hash.clone(), timestamp.clone());
        }

        let block_hash = block_hash.expect("No block");
        let timestamp = timestamp.expect("No timestamp");
        info!("scanned newest block from restored block {:?}", &block_hash);
        (block_hash, timestamp)
    }

    // Storage block header
    pub fn insert_block(&self, block_hash: String, timestamp: String) {
        let mut statement = self.connection.prepare(
            "INSERT INTO block_hash VALUES(?, ?, ?, ?)"
        ).expect("PREPARE ERR");
        statement.bind(1, &Value::Null).expect("BIND ID ERR");
        statement.bind(2, block_hash.as_str()).unwrap();
        statement.bind(3, "0").unwrap();
        statement.bind(4, timestamp.as_str()).unwrap();
        statement.next().expect("insert block error");
    }

    // Query unscanned block header and return corresponding data based on timestamp
    pub fn query_header(&self, timestamp: String, add: bool) -> Vec<String> {
        let mut statement = self.connection.prepare(
            "SELECT * FROM block_hash WHERE timestamp >= ? AND  scanned <= 5 LIMIT 1000"
        ).expect("query_header PREPARE ERR");
        statement.bind(
            1,
            timestamp.as_str(),
        ).expect("bind ERR");
        let mut block_hashes = vec![];
        while let State::Row = statement.next().unwrap() {
            let block_hash = statement.read::<String>(1).unwrap();
            block_hashes.push(block_hash);
        }

        if add {
            let mut statement2 = self.connection.prepare(
                "UPDATE block_hash SET scanned = scanned + 1 WHERE timestamp >= ? AND scanned <= 5 LIMIT 1000"
            ).expect("update scan ERR");
            statement2.bind(1, timestamp.as_str()).expect("bind ERR");
            statement2.next().expect("update scanned ERR");
        }

        block_hashes
    }

    //query new
    pub fn query_newest_header(&self, key: &str) -> (Option<String>, Option<String>) {
        let mut statement = self.connection.prepare(
            "SELECT * FROM newest_hash WHERE key = ?"
        ).expect("query_new error");
        statement.bind(1, key).expect("query newest error");
        while let State::Row = statement.next().unwrap() {
            let block_hash = statement.read::<String>(2).expect("query block hash error");
            let timestamp = statement.read::<String>(3).expect("query block hash error");
            return (Some(block_hash), Some(timestamp));
        }
        (None, None)
    }

    //insert new header
    pub fn insert_newest_header(&self, block_hash: String, timestamp: String) {
        let mut statement = self.connection.prepare(
            "INSERT INTO newest_hash VALUES(?,?,?,?)"
        ).expect("PREPARE ERR");
        statement.bind(1, &Value::Null).expect("ID BIND ERR");
        statement.bind(2, NEWEST_KEY).expect("KEY BIND ERR");
        statement.bind(3, block_hash.as_str()).expect("BLOCK_HASH BIND ERR");
        statement.bind(4, timestamp.as_str()).expect("TIMESTAMP BIND ERR");
        statement.next().expect("insert newest_header error");
    }

    //update the newest header
    pub fn update_newest_header(&self, block_hash: String, timestamp: String) {
        let mut statement = self.connection.prepare(
            "UPDATE newest_hash SET block_hash = ?, timestamp = ? WHERE key = ?"
        ).expect("PREPARE ERR");
        statement.bind(1, block_hash.as_str()).unwrap();
        statement.bind(2, timestamp.as_str()).unwrap();
        statement.bind(3, NEWEST_KEY).unwrap();
        statement.next().expect("insert newest_header error");
    }

    //insert txin
    pub fn insert_txin(&self, tx: String, sig_script: String, prev_tx: String, prev_vout: String, sequence: String) {
        let mut statement = self.connection.prepare(
            "INSERT OR IGNORE INTO tx_input VALUES(NULL,?,?,?,?,?)"
        ).expect("insert txin error");
        statement.bind(1, tx.as_str()).expect("bind statement error");
        statement.bind(2, sig_script.as_str()).expect("bind statement error");
        statement.bind(3, prev_tx.as_str()).expect("bind statement error");
        statement.bind(4, prev_vout.as_str()).expect("bind statement error");
        statement.bind(5, sequence.as_str()).expect("bind statement error");
        statement.next().expect("insert utxos error");
    }

    //insert txout
    pub fn insert_txout(&self, tx: String, script: String, value: String, vout: i64) {
        let mut statement = self.connection.prepare(
            "INSERT OR IGNORE INTO tx_output VALUES(NULL,?,?,?,?)"
        ).expect("insert utxo error");
        statement.bind(1, tx.as_str()).expect("bind statement error");
        statement.bind(2, script.as_str()).expect("bind statement error");
        statement.bind(3, value.as_str()).expect("bind statement error");
        statement.bind(4, vout).expect("bind statement error");
        statement.next().expect("insert utxos error");
    }

    // query count
    pub fn count(&self) -> u64 {
        let mut statement = self.connection.prepare(
            "select count(*) from block_hash"
        ).expect("count error");

        let mut count: u64 = 0;
        while let State::Row = statement.next().unwrap() {
            let c = statement.read::<String>(0).unwrap();
            count = c.parse::<u64>().unwrap();
        }
        count
    }

    // query height that we scanned
    pub fn query_scanned_height(&self) -> String {
        let (block_hash, _timestamp) = self.query_newest_header(NEWEST_KEY);
        let mut statement = self.connection.prepare(
            "SELECT ID FROM block_hash WHERE block_hash = ?"
        ).expect("select hash error");

        if let Some(block_hash) = block_hash {
            statement.bind(1, block_hash.as_str()).expect("bind error");
            while let State::Row = statement.next().expect("select error") {
                return statement.read::<String>(0).expect("read error");
            }
        }
        String::from("0")
    }
}

mod test {
    use jniapi::btcapi::SHARED_SQLITE;
    use db::NEWEST_KEY;

    #[test]
    pub fn test_init() {
        let sqlite = SHARED_SQLITE.lock().expect("sqlite open error");
        let (hash, timestamp) = sqlite.init();
        println!("{},{}", hash, timestamp);
    }

    #[test]
    pub fn test_query_newest_header() {
        let sqlite = SHARED_SQLITE.lock().expect("sqlite open error");
        let (hash, timestamp) = sqlite.query_newest_header(NEWEST_KEY);
        println!("{},{}", hash.unwrap(), timestamp.unwrap());
    }

    #[test]
    pub fn test_query_header() {
        let sqlite = SHARED_SQLITE.lock().expect("sqlite open error");
        let headers = sqlite.query_header("1296688602".to_string(), false);
        for header in headers {
            println!("{}", header);
        }
    }

    #[test]
    pub fn test_query_scanned_height(){
        let sqlite = SHARED_SQLITE.lock().expect("sqlite open error");
        let height = sqlite.query_scanned_height();
        println!("{}", height);
    }
}

