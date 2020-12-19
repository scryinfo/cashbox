//! mod for sqlite
//! use two database
//!     1. for btc chain database
//!     2. for user data (utxo address ...)
//!
use crate::config::{BTC_CHAIN_PATH, BTC_DETAIL_PATH};
use crate::moudle::chain::MBlockHeader;
use crate::moudle::detail::{MLocalTx, MProgress, MTxInput, MTxOutput, MUserAddress};
use async_std::task::block_on;
use async_trait::async_trait;
use bitcoin::blockdata::constants::genesis_block;
use bitcoin::hashes::hex::ToHex;
use bitcoin::{BitcoinHash, Network};
use log::{debug, info};
use once_cell::sync::Lazy;
use rbatis::crud::CRUD;
use rbatis::plugin::page::{IPage, Page, PageRequest};
use rbatis::rbatis::Rbatis;
use std::ops::Add;

pub struct ChainSqlite {
    rb: Rbatis,
    network: Network,
}

impl ChainSqlite {
    pub fn new(network: Network, db_file_name: &str) -> Self {
        let sql = MBlockHeader::SQL;
        let rb = block_on(Self::init_rbatis(db_file_name));
        let r = block_on(rb.exec("", sql));
        match r {
            Ok(a) => {
                info!("{:?}", a);
            }
            Err(e) => {
                info!("{:?}", e);
            }
        }
        Self { rb, network }
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
        let w = self
            .rb
            .new_wrapper()
            .gt("timestamp", &timestamp)
            .and()
            .lt("scanned", 6)
            .check()
            .unwrap();
        let req = PageRequest::new(1, 1000);
        let r: Result<Page<MBlockHeader>, _> =
            block_on(self.rb.fetch_page_by_wrapper("", &w, &req));
        let mut block_headers: Vec<MBlockHeader> = vec![];
        match r {
            Ok(page) => {
                let header_vec = page.get_records();
                block_headers = header_vec.to_vec();
            }
            Err(e) => debug!("{:?}", e),
        }
        let mut headers: Vec<String> = vec![];
        for header_block in block_headers {
            headers.push(header_block.header);
        }

        if scan_flag {
            let sql = format!(
                r#"
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
            "#,
                timestamp
            );
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
                _ => 0,
            }
        } else {
            return 0;
        }
    }
}

pub struct DetailSqlite {
    rb: Rbatis,
    network: Network,
}

impl DetailSqlite {
    pub fn new(network: Network, db_file_name: &str) -> Self {
        let rb = block_on(Self::init_rbatis(db_file_name));
        DetailSqlite::create_progress(&rb);
        DetailSqlite::create_user_address(&rb);
        DetailSqlite::create_tx_input(&rb);
        DetailSqlite::create_tx_output(&rb);
        DetailSqlite::create_local_tx(&rb);
        Self { rb, network }
    }

    fn create_user_address(rb: &Rbatis) {
        let sql = MUserAddress::SQL;
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
        let sql = MTxInput::SQL;
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
        let sql = MTxOutput::SQL;
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
        let sql = MProgress::SQL;
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
        let sql = MLocalTx::SQL;
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
            Err(_) => None,
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
            Some(progress) => progress,
        }
    }

    pub fn save_txin(
        &self,
        tx: String,
        sig_script: String,
        prev_tx: String,
        prev_vout: String,
        sequence: u32,
    ) {
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

    pub fn save_txout(&self, tx: String, script: String, value: String, vin: String) {
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

    pub fn save_user_address(&self, address: String, compressed_pub_key: String) {
        let user_address = MUserAddress {
            id: None,
            address,
            compressed_pub_key,
        };
        let r = block_on(self.rb.save("", &user_address));
        match r {
            Ok(a) => {
                debug!("save_tx_input {:?}", a);
            }
            Err(e) => {
                debug!("save_tx_input {:?}", e);
            }
        }
    }

    pub fn fetch_user_address(&self) -> Option<MUserAddress> {
        let r: Result<Option<MUserAddress>, _> = block_on(self.rb.fetch_by_id("", &1u64));
        match r {
            Ok(p) => p,
            Err(_) => None,
        }
    }
}

#[async_trait]
trait RInit {
    async fn init_rbatis(db_file_name: &str) -> Rbatis {
        if std::fs::metadata(db_file_name).is_err() {
            let file = std::fs::File::create(db_file_name);
            if file.is_err() {
                info!("error when init file {:?}", file.err().unwrap());
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

pub static RB_CHAIN: Lazy<ChainSqlite> =
    Lazy::new(|| ChainSqlite::new(Network::Testnet, BTC_CHAIN_PATH));

pub static RB_DETAIL: Lazy<DetailSqlite> =
    Lazy::new(|| DetailSqlite::new(Network::Testnet, BTC_DETAIL_PATH));
