//! mod for sqlite
//! use two database
//!     1. for btc chain database
//!     2. for user data (utxo address ...)
//!
use bitcoin::blockdata::constants::genesis_block;
use bitcoin::hashes::hex::ToHex;
use bitcoin::{BitcoinHash, Network};
use log::{info, debug};
use parking_lot::ReentrantMutex;
use once_cell::sync::OnceCell;
use crate::config::BTC_DETAIL_PATH;
use rbatis::rbatis::Rbatis;
use std::ops::Add;
use async_std::task::block_on;
use crate::moudle::chain::MBlockHeader;
use rbatis::crud::CRUD;
use crate::moudle::detail::{MProgress, MTxInput, MTxOutput};
use rbatis::plugin::page::{PageRequest, Page, IPage};
use async_trait::async_trait;

const NEWEST_KEY: &str = "NEWEST_KEY";

pub struct ClientSqlite {
    connection: sqlite::Connection,
    network: Network,
}

impl ClientSqlite {
    // create database
    pub fn create_cient_db(network: Network, path: &str) -> Self {
        let mut sqlite = sqlite::open(path).expect("create sqlite error");
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
        sqlite.execute(
            "create table if not exists compressed_pub(ID INTEGER PRIMARY KEY AUTOINCREMENT,address TEXT not null ,compressed_key TEXT);"
        ).expect("Create compressed_pub table error");
        sqlite.execute(
            "create table if not exists local_tx_log(ID INTEGER PRIMARY KEY AUTOINCREMENT,from_address TEXT not null ,to_address TEXT,value TEXT,status TEXT);"
        ).expect("Create local_tx_log table error");
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
        let mut statement = self
            .connection
            .prepare("INSERT INTO block_hash VALUES(?, ?, ?, ?)")
            .expect("PREPARE ERR");
        statement.bind(1, &Value::Null).expect("BIND ID ERR");
        statement.bind(2, block_hash.as_str()).unwrap();
        statement.bind(3, "0").unwrap();
        statement.bind(4, timestamp.as_str()).unwrap();
        statement.next().expect("insert block error");
    }

    // Query unscanned block header and return corresponding data based on timestamp
    pub fn query_header(&self, timestamp: String, add: bool) -> Vec<String> {
        let mut statement = self
            .connection
            .prepare("SELECT * FROM block_hash WHERE timestamp >= ? AND  scanned <= 5 LIMIT 1000")
            .expect("query_header PREPARE ERR");
        statement.bind(1, timestamp.as_str()).expect("bind ERR");
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
        let mut statement = self
            .connection
            .prepare("SELECT * FROM newest_hash WHERE key = ?")
            .expect("query_new error");
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
        let mut statement = self
            .connection
            .prepare("INSERT INTO newest_hash VALUES(?,?,?,?)")
            .expect("PREPARE ERR");
        statement.bind(1, &Value::Null).expect("ID BIND ERR");
        statement.bind(2, NEWEST_KEY).expect("KEY BIND ERR");
        statement
            .bind(3, block_hash.as_str())
            .expect("BLOCK_HASH BIND ERR");
        statement
            .bind(4, timestamp.as_str())
            .expect("TIMESTAMP BIND ERR");
        statement.next().expect("insert newest_header error");
    }

    //update the newest header
    pub fn update_newest_header(&self, block_hash: String, timestamp: String) {
        let mut statement = self
            .connection
            .prepare("UPDATE newest_hash SET block_hash = ?, timestamp = ? WHERE key = ?")
            .expect("PREPARE ERR");
        statement.bind(1, block_hash.as_str()).unwrap();
        statement.bind(2, timestamp.as_str()).unwrap();
        statement.bind(3, NEWEST_KEY).unwrap();
        statement.next().expect("insert newest_header error");
    }

    //insert txin
    pub fn insert_txin(
        &self,
        tx: String,
        sig_script: String,
        prev_tx: String,
        prev_vout: String,
        sequence: String,
    ) {
        let mut statement = self
            .connection
            .prepare("INSERT OR IGNORE INTO tx_input VALUES(NULL,?,?,?,?,?)")
            .expect("insert txin error");
        statement
            .bind(1, tx.as_str())
            .expect("bind statement error");
        statement
            .bind(2, sig_script.as_str())
            .expect("bind statement error");
        statement
            .bind(3, prev_tx.as_str())
            .expect("bind statement error");
        statement
            .bind(4, prev_vout.as_str())
            .expect("bind statement error");
        statement
            .bind(5, sequence.as_str())
            .expect("bind statement error");
        statement.next().expect("insert utxos error");
    }

    //insert txout
    pub fn insert_txout(&self, tx: String, script: String, value: String, vout: i64) {
        let mut statement = self
            .connection
            .prepare("INSERT OR IGNORE INTO tx_output VALUES(NULL,?,?,?,?)")
            .expect("insert utxo error");
        statement
            .bind(1, tx.as_str())
            .expect("bind statement error");
        statement
            .bind(2, script.as_str())
            .expect("bind statement error");
        statement
            .bind(3, value.as_str())
            .expect("bind statement error");
        statement.bind(4, vout).expect("bind statement error");
        statement.next().expect("insert utxos error");
    }

    // query count
    pub fn count(&self) -> u64 {
        let mut statement = self
            .connection
            .prepare("select count(*) from block_hash")
            .expect("count error");

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
        let mut statement = self
            .connection
            .prepare("SELECT ID FROM block_hash WHERE block_hash = ?")
            .expect("select hash error");

        if let Some(block_hash) = block_hash {
            statement.bind(1, block_hash.as_str()).expect("bind error");
            while let State::Row = statement.next().expect("select error") {
                return statement.read::<String>(0).expect("read error");
            }
        }
        String::from("0")
    }

    // insert address compressed_pub key and bloom filter
    pub fn insert_compressed_pub_key(&self, address: String, pubkey: String) {
        let mut statement = self
            .connection
            .prepare("INSERT INTO compressed_pub VALUES(NULL,?,?)")
            .expect("prepare compressed pub key error");
        statement
            .bind(1, address.as_str())
            .expect("bind statement error");
        statement
            .bind(2, pubkey.as_str())
            .expect("bind statement error");
        statement.next().expect("insert compressed error");
    }

    // query public compressed key
    pub fn query_compressed_pub_key(&self) -> Option<String> {
        let mut statement = self
            .connection
            .prepare("SELECT * FROM compressed_pub")
            .expect("query compressed key error");
        while let State::Row = statement.next().unwrap() {
            let compressed_pub_key = statement.read::<String>(2).expect("query block hash error");
            return Some(compressed_pub_key);
        }
        None
    }
}

pub struct ChainSqlite {
    rb: Rbatis,
    network: Network,
}

impl ChainSqlite {
    pub fn init_chain_db(network: Network, db_file_name: &str) -> Self {
        let sql = include_str!("sql/create_chain.sql");
        let rb = block_on(ChainSqlite::init_rbatis(db_file_name));
        let r = block_on(rb.exec("create chain db", sql));
        match r {
            Ok(a) => {
                info!("{:?}", a);
            }
            Err(e) => {
                info!("{:?}", e);
            }
        }
        Self {
            rb,
            network,
        }
    }

    pub fn save_header(&self, header: String, timestamp: String) {
        let block_header = MBlockHeader {
            id: None,
            header,
            scanned: "0".to_string(),
            timestamp,
        };

        let r = block_on(self.rb.save("", &block_header));
        match r {
            Ok(a) => {
                debug!("{:?}", a);
            }
            Err(e) => {
                debug!("{:?}", e);
            }
        }
    }

    /// fetch header which needed scan
    /// scan_flag = false scan_flag does not need +1
    /// scan_flag = true scan_flag need +1
    pub fn fetch_scan_header(&self, timestamp: String, scan_flag: bool) -> Vec<String> {
        let w = self.rb.new_wrapper()
                    .gt("timestamp", &timestamp)
                    .and()
                    .lt("scanned", 6)
                    .check().unwrap();
        let req = PageRequest::new(1, 1000);
        let r: Result<Page<MBlockHeader>, _> = block_on(self.rb.fetch_page_by_wrapper("", &w, &req));
        let mut block_headers: Vec<MBlockHeader> = vec![];
        match r {
            Ok(page) => {
                let header_vec = page.get_records();
                block_headers = header_vec.to_vec();
            }
            Err(e) => debug!("{:?}", e)
        }
        let mut headers: Vec<String> = vec![];
        for header_block in block_headers {
            headers.push(header_block.header);
        }

        if scan_flag {
            let sql = format!(r#"
            UPDATE block_header SET scanned = scanned+1
                WHERE id IN (
                    SELECT id FROM (
                        SELECT id FROM block_header
                        WHERE timestamp >= {}
                        AND scanned <= 5
                        ORDER BY id ASC
                        LIMIT 0, 1000
                    ) tmp
                )
            "#, timestamp);
            let r = block_on(self.rb.exec("", &sql));
            match r {
                Ok(a) => {
                    debug!("{:?}", a);
                }
                Err(e) => {
                    debug!("{:?}", e);
                }
            }
        }

        headers
    }

    // how may headers save in block_header table
    pub fn fetch_height(&self) -> u64 {
        let py = r#"
        SELECT * FROM block_header
        Order By id DESC
        LIMIT 1;
        "#;
        let r: Result<MBlockHeader, _> = block_on(self.rb.py_fetch("", py, &""));
        if let Ok(r) = r {
            match r.id {
                Some(id) => id,
                _ => 0
            }
        } else { return 0; }
    }
}

pub struct DetailSqlite {
    rb: Rbatis,
    network: Network,
}

impl DetailSqlite {
    pub fn init_detail_db(network: Network, db_file_name: &str) -> Self {
        let rb = block_on(DetailSqlite::init_rbatis(db_file_name));
        DetailSqlite::create_progress(&rb);
        DetailSqlite::create_user_address(&rb);
        DetailSqlite::create_tx_input(&rb);
        DetailSqlite::create_tx_output(&rb);
        DetailSqlite::create_local_tx(&rb);
        Self {
            rb,
            network,
        }
    }

    fn create_user_address(rb: &Rbatis) {
        let sql = include_str!("sql/create_user_address.sql");
        let r = block_on(rb.exec("", sql));
        match r {
            Ok(a) => {
                debug!("create_user_address {:?}", a);
            }
            Err(e) => {
                debug!("create_user_address {:?}", e);
            }
        }
    }

    fn create_tx_input(rb: &Rbatis) {
        let sql = include!("sql/create_tx_input.sql");
        let r = block_on(rb.exec("", sql));
        match r {
            Ok(a) => {
                debug!("create_tx_input {:?}", a);
            }
            Err(e) => {
                debug!("create_tx_input {:?}", e);
            }
        }
    }

    fn create_tx_output(rb: &Rbatis) {
        let sql = include!("sql/create_tx_output.sql");
        let r = block_on(rb.exec("", sql));
        match r {
            Ok(a) => {
                debug!("create_tx_output {:?}", a);
            }
            Err(e) => {
                debug!("create_tx_output {:?}", e);
            }
        }
    }

    fn create_progress(rb: &Rbatis) {
        let sql = include_str!("sql/create_progress.sql");
        let r = block_on(rb.exec("", sql));
        match r {
            Ok(a) => {
                debug!("create_progress {:?}", a);
            }
            Err(e) => {
                debug!("create_progress {:?}", e);
            }
        }
    }

    fn create_local_tx(rb: &Rbatis) {
        let sql = include!("sql/create_local_tx.sql");
        let r = block_on(rb.exec("", sql));
        match r {
            Ok(a) => {
                debug!("create_local_tx {:?}", a);
            }
            Err(e) => {
                debug!("create_local_tx {:?}", e);
            }
        }
    }

    fn save_progress(&self, header: String, timestamp: String) {
        let progress = MProgress {
            id: None,
            header,
            timestamp,
        };
        let r = block_on(self.rb.save("", &progress));
        match r {
            Ok(a) => {
                debug!("save_progress {:?}", a);
            }
            Err(e) => {
                debug!("save_progress {:?}", e);
            }
        }
    }

    fn fetch_progress(&self) -> Option<MProgress> {
        let r: Result<Option<MProgress>, _> = block_on(self.rb.fetch_by_id("", &1u64));
        match r {
            Ok(p) => p,
            Err(_) => None
        }
    }

    pub fn update_progress(&self, header: String, timestamp: String) {
        let progress = MProgress {
            id: None,
            header,
            timestamp,
        };
        let w = self.rb.new_wrapper().eq("id", 1).check().unwrap();
        let r = block_on(self.rb.update_by_wrapper("", &progress, &w, false));
        match r {
            Ok(a) => {
                debug!("update_progress {:?}", a);
            }
            Err(e) => {
                debug!("update_progress {:?}", e);
            }
        }
    }

    pub fn progress(&self) -> MProgress {
        let progress = self.fetch_progress();
        match progress {
            None => {
                let genesis = genesis_block(self.network).header;
                let header = genesis.bitcoin_hash().to_hex();
                let timestamp = genesis.time.to_string();
                info!("scanned newest block from genesis {:?}", &genesis);
                self.save_progress(header.clone(), timestamp.clone());
                return MProgress {
                    id: None,
                    header,
                    timestamp,
                };
            }
            Some(progress) => {
                progress
            }
        }
    }

    pub fn save_tx_input(&self,
                         tx: String,
                         sig_script: String,
                         prev_tx: String,
                         prev_vout: String,
                         sequence: i64) {
        let tx_input = MTxInput {
            id: None,
            tx,
            sig_script,
            prev_tx,
            prev_vout,
            sequence,
        };
        let r = block_on(self.rb.save("", &tx_input));
        match r {
            Ok(a) => {
                debug!("save_tx_input {:?}", a);
            }
            Err(e) => {
                debug!("save_tx_input {:?}", e);
            }
        }
    }

    pub fn save_txout(&self,
                      tx: String,
                      script: String,
                      value: String,
                      vin: String) {
        let tx_output = MTxOutput {
            id: None,
            tx,
            script,
            value,
            vin,
        };
        let r = block_on(self.rb.save("", &tx_output));
        match r {
            Ok(a) => {
                debug!("save_tx_input {:?}", a);
            }
            Err(e) => {
                debug!("save_tx_input {:?}", e);
            }
        }
    }
}

#[async_trait]
trait RInit {
    async fn init_rbatis(db_file_name: &str) -> Rbatis {
        info!("init_rbatis");
        if std::fs::metadata(db_file_name).is_err() {
            let file = std::fs::File::create(db_file_name);
            if file.is_err() {
                info!("init file {:?}", file.err().unwrap());
            }
        }
        let rb = Rbatis::new();
        let url = "sqlite://".to_owned().add(db_file_name);
        info!("file url: {:?}", url);
        let r = rb.link(url.as_str()).await;
        if r.is_err() {
            info!("{:?}", r.err().unwrap());
        }
        rb
    }
}

#[async_trait]
impl RInit for ChainSqlite {}

#[async_trait]
impl RInit for DetailSqlite {}


pub fn lazy_db(network: Network, path: &str) -> &'static ReentrantMutex<SQLite> {
    static INSTANCE: OnceCell<ReentrantMutex<SQLite>> = OnceCell::new();
    INSTANCE.get_or_init(|| {
        let sqlite = SQLite::create_db(network, path);
        ReentrantMutex::new(sqlite)
    })
}

pub fn lazy_db_main() -> &'static ReentrantMutex<SQLite> {
    lazy_db(Network::Bitcoin, BTC_DETAIL_PATH)
}

pub fn lazy_db_test() -> &'static ReentrantMutex<SQLite> {
    lazy_db(Network::Testnet, BTC_DETAIL_PATH)
}

pub fn lazy_db_default() -> &'static ReentrantMutex<SQLite> {
    lazy_db_test()
}


