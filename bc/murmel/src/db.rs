//! mod for sqlite
//! use two database
//!     1. for btc chain database
//!     2. for user data (utxo address ...)
//!
use crate::api::{calc_default_address, calc_hash160, calc_pubkey};
use crate::path::{BTC_CHAIN_PATH, BTC_DETAIL_PATH};
use async_trait::async_trait;
use bitcoin::blockdata::constants::genesis_block;
use bitcoin::hashes::hex::ToHex;
use bitcoin::network::message_bloom_filter::FilterLoadMessage;
use bitcoin::{BitcoinHash, Network, Transaction};
use futures::executor::block_on;
use log::{debug, error, info};
use mav::ma::{Dao, MBlockHeader, MBtcChainTx, MBtcInputTx, MBtcOutputTx, MBtcTxState, MBtcUtxo};
use mav::ma::{MLocalTxLog, MProgress, MUserAddress};
use once_cell::sync::Lazy;
use rbatis::core::db::DBExecResult;
use rbatis::crud::CRUDTable;
use rbatis::crud::CRUD;
use rbatis::plugin::page::{IPage, Page, PageRequest};
use rbatis::rbatis::Rbatis;
use rbatis::wrapper::Wrapper;
use rbatis_core::Error;
use std::ops::Add;

pub struct ChainSqlite {
    rb: Rbatis,
    network: Network,
}

impl ChainSqlite {
    pub fn new(network: Network, db_file_name: &str) -> Self {
        let rb = block_on(async {
            let rb = Self::init_rbatis(db_file_name).await;
            let r = rb.exec("", MBlockHeader::create_table_script()).await;
            match r {
                Ok(a) => {
                    info!("{:?}", a);
                }
                Err(e) => {
                    error!("{:?}", e);
                }
            }
            rb
        });
        Self { rb, network }
    }

    pub async fn save_header(
        &self,
        header: String,
        timestamp: String,
    ) -> Result<DBExecResult, Error> {
        let mut block_header = MBlockHeader::default();
        block_header.scanned = "0".to_owned();
        block_header.header = header;
        block_header.timestamp = timestamp;
        block_header.save(&self.rb, "").await
    }

    /// fetch header which needed scan
    /// scan_flag = false scan_flag does not need +1
    /// scan_flag = true scan_flag need +1
    pub async fn fetch_scan_header(&self, timestamp: String, scan_flag: bool) -> Vec<String> {
        let w = self
            .rb
            .new_wrapper()
            .gt("timestamp", &timestamp)
            .and()
            .lt("scanned", 6);
        let req = PageRequest::new(1, 1000);
        let r: Result<Page<MBlockHeader>, _> = self.rb.fetch_page_by_wrapper("", &w, &req).await;
        let block_headers: Vec<MBlockHeader> = match r {
            Ok(page) => {
                let header_vec = page.get_records();
                header_vec.to_vec()
            }
            Err(_) => vec![],
        };
        let mut headers: Vec<String> = vec![];
        for header_block in block_headers {
            headers.push(header_block.header);
        }

        if scan_flag {
            let sql = format!(
                r#"
            UPDATE {} SET scanned = scanned+1
                WHERE rowid IN (
                    SELECT rowid FROM (
                        SELECT rowid FROM {}
                        WHERE timestamp >= {}
                        AND scanned <= 5
                        ORDER BY rowid ASC
                        LIMIT 0, 1000
                    ) tmp
                )
            "#,
                &MBlockHeader::table_name(),
                &MBlockHeader::table_name(),
                timestamp
            );
            let r = self.rb.exec("", &sql).await;
            match r {
                Ok(a) => {
                    debug!("=== {:?} ===", a);
                }
                Err(e) => {
                    error!("=== {:?} ===", e);
                }
            }
        }

        headers
    }

    // how may headers save in block_header table
    pub async fn fetch_height(&self) -> i64 {
        let w = self.rb.new_wrapper();
        let sql = format!("SELECT COUNT(*) FROM {} ", &MBlockHeader::table_name());
        let r: Result<i64, _> = self.rb.fetch_prepare("", &sql, &w.args).await;
        match r {
            Ok(r) => r,
            Err(_) => 0,
        }
    }

    pub async fn fetch_header_by_timestamp(&self, timestamp: String) -> i64 {
        let w = self.rb.new_wrapper();
        let sql = format!(
            "SELECT {} FROM {} WHERE timestamp = {}",
            "rowid",
            &MBlockHeader::table_name(),
            &timestamp
        );
        let r: Result<i64, _> = self.rb.fetch_prepare("", &sql, &w.args).await;
        match r {
            Ok(r) => r,
            Err(e) => {
                info!("=== fetch_header_by_timestamp error {:?} ===", e);
                0
            }
        }
    }
}

pub struct DetailSqlite {
    rb: Rbatis,
    network: Network,
}

impl DetailSqlite {
    pub fn new(network: Network, db_file_name: &str) -> Self {
        let rb = block_on(async {
            let rb = Self::init_rbatis(db_file_name).await;
            let r = DetailSqlite::init_table(&rb).await;
            match r {
                Ok(_) => {
                    info!("init detail sqlite table successfully {:?}", r)
                }
                Err(e) => {
                    error!("init detail sqlite table failed with error{:?}", e)
                }
            }
            rb
        });
        Self { rb, network }
    }

    async fn init_table(rb: &Rbatis) -> Result<(), Error> {
        DetailSqlite::create_progress(rb).await?;
        DetailSqlite::create_user_address(rb).await?;
        DetailSqlite::create_btc_input_tx(rb).await?;
        DetailSqlite::create_btc_output_tx(rb).await?;
        DetailSqlite::create_btc_chain_tx(rb).await?;
        DetailSqlite::create_local_tx(rb).await?;
        DetailSqlite::create_btc_tx_state(rb).await?;
        DetailSqlite::create_btc_utxo(rb).await?;
        DetailSqlite::init_state(rb).await?;
        Ok(())
    }

    async fn create_user_address(rb: &Rbatis) -> Result<DBExecResult, Error> {
        rb.exec("", MUserAddress::create_table_script()).await
    }

    async fn create_btc_input_tx(rb: &Rbatis) -> Result<DBExecResult, Error> {
        rb.exec("", MBtcInputTx::create_table_script()).await
    }

    async fn create_btc_output_tx(rb: &Rbatis) -> Result<DBExecResult, Error> {
        rb.exec("", MBtcOutputTx::create_table_script()).await
    }

    async fn create_btc_chain_tx(rb: &Rbatis) -> Result<DBExecResult, Error> {
        rb.exec("", MBtcChainTx::create_table_script()).await
    }

    async fn create_progress(rb: &Rbatis) -> Result<DBExecResult, Error> {
        rb.exec("", MProgress::create_table_script()).await
    }

    async fn create_local_tx(rb: &Rbatis) -> Result<DBExecResult, Error> {
        rb.exec("", MLocalTxLog::create_table_script()).await
    }

    async fn create_btc_tx_state(rb: &Rbatis) -> Result<DBExecResult, Error> {
        rb.exec("", MBtcTxState::create_table_script()).await
    }

    async fn create_btc_utxo(rb: &Rbatis) -> Result<DBExecResult, Error> {
        rb.exec("", MBtcUtxo::create_table_script()).await
    }

    pub async fn save_state(&self, seq: u16, state: String) {
        let mut tx_state = MBtcTxState::default();
        tx_state.seq = seq;
        tx_state.state = state;
        let r = tx_state.save(&self.rb, "").await;
        r.map_or_else(
            |e| error!("error save_state {:?}", e),
            |r| debug!("save_state {:?}", r),
        );
    }

    // insert statse in m_btc_tx_state
    async fn init_state(rb: &Rbatis) -> Result<DBExecResult, Error> {
        let mut state0 = MBtcTxState::default();
        let mut state1 = MBtcTxState::default();
        let mut state2 = MBtcTxState::default();
        let mut state3 = MBtcTxState::default();

        state0.seq = 0;
        state0.state = "unknown".to_owned();
        state1.seq = 1;
        state1.state = "spent".to_owned();
        state2.seq = 2;
        state2.state = "unspent".to_owned();
        state3.seq = 3;
        state3.state = "locked".to_owned();

        let mut tokens = vec![];
        tokens.push(state0);
        tokens.push(state1);
        tokens.push(state2);
        tokens.push(state3);

        MBtcTxState::save_batch(&rb, "init_state", &mut tokens).await
    }

    async fn save_progress(&self, header: String, timestamp: String) {
        let mut progress = MProgress::default();
        progress.header = header;
        progress.timestamp = timestamp;

        let r = progress.save(&self.rb, "").await;
        r.map_or_else(
            |e| error!("save_progress {:?}", e),
            |r| debug!("save_progress {:?}", r),
        );
    }

    async fn fetch_progress(&self) -> Option<MProgress> {
        let w = self.rb.new_wrapper().eq("rowid", 1);
        let r: Result<MProgress, _> = self.rb.fetch_by_wrapper("", &w).await;
        return match r {
            Ok(r) => Some(r),
            Err(_) => None,
        };
    }

    pub async fn update_progress(&self, header: String, timestamp: String) {
        let mut progress = MProgress::default();
        progress.header = header;
        progress.timestamp = timestamp;

        let w = self.rb.new_wrapper().eq("rowid", 1);
        let r = progress.update_by_wrapper(&self.rb, "", &w, true).await;
        match r {
            Ok(a) => {
                debug!("update_progress {:?}", a);
            }
            Err(e) => {
                error!("update_progress {:?}", e);
            }
        }
    }

    pub async fn progress(&self) -> MProgress {
        let progress = self.fetch_progress().await;
        match progress {
            None => {
                let genesis = genesis_block(self.network).header;
                let header = genesis.bitcoin_hash().to_hex();
                let timestamp = genesis.time.to_string();
                info!("=== scanned newest block from genesis {:?} ===", &genesis);
                self.save_progress(header.clone(), timestamp.clone()).await;
                let mut progress = MProgress::default();
                progress.header = header;
                progress.timestamp = timestamp;
                return progress;
            }
            Some(progress) => progress,
        }
    }

    pub async fn save_btc_input_tx(
        &self,
        tx_id: String,
        vout: u32,
        sig_script: String,
        sequence: u32,
        idx: u32,
        btc_tx_hash: String,
        btc_tx_hexbytes: String,
    ) {
        let mut btc_input_tx = MBtcInputTx::default();
        btc_input_tx.tx_id = tx_id;
        btc_input_tx.vout = vout;
        btc_input_tx.sig_script = sig_script;
        btc_input_tx.sequence = sequence;
        btc_input_tx.idx = idx;
        btc_input_tx.btc_tx_hash = btc_tx_hash;
        btc_input_tx.btc_tx_hexbytes = btc_tx_hexbytes;

        let r = btc_input_tx.save_update(&self.rb, "").await;
        match r {
            Ok(a) => {
                debug!("save btc_input_tx {:?}", a);
            }
            Err(e) => {
                debug!("error save btc_input_tx {:?}", e);
            }
        }
    }

    pub fn save_btc_output_tx(
        &self,
        value: u64,
        pk_script: String,
        idx: u32,
        btc_tx_hash: String,
        btc_tx_hexbytes: String,
    ) {
        let mut btc_output_tx = MBtcOutputTx::default();
        btc_output_tx.value = value;
        btc_output_tx.pk_script = pk_script;
        btc_output_tx.idx = idx;
        btc_output_tx.btc_tx_hash = btc_tx_hash;
        btc_output_tx.btc_tx_hexbytes = btc_tx_hexbytes;

        let r = block_on(btc_output_tx.save_update(&self.rb, ""));
        match r {
            Ok(a) => {
                debug!("save btc_output_tx {:?}", a);
            }
            Err(e) => {
                debug!("error save btc_output_tx {:?}", e);
            }
        }
    }

    pub async fn list_btc_output_tx(&self) -> Vec<MBtcOutputTx> {
        let r = MBtcOutputTx::list(&self.rb, "").await;
        match r {
            Err(e) => {
                error!("{:?}", e);
                vec![]
            }
            Ok(r) => r,
        }
    }

    pub fn save_user_address(&self, address: String, compressed_pub_key: String, verify: String) {
        let mut user_address = MUserAddress::default();
        user_address.address = address;
        user_address.compressed_pub_key = compressed_pub_key;
        user_address.verify = verify;
        let r = block_on(user_address.save(&self.rb, ""));
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
        let w = self.rb.new_wrapper().eq("rowid", 1);
        let r: Result<MUserAddress, _> = block_on(self.rb.fetch_by_wrapper("", &w));
        match r {
            Ok(u) => Some(u),
            Err(_) => None,
        }
    }

    pub fn save_local_tx(
        &self,
        address_from: String,
        address_to: String,
        value: String,
        status: String,
    ) {
        let mut local_tx = MLocalTxLog::default();
        local_tx.address_from = address_from;
        local_tx.address_to = address_to;
        local_tx.value = value;
        local_tx.status = status;
        let r = block_on(local_tx.save(&self.rb, ""));
        match r {
            Ok(a) => {
                debug!("save_tx_input {:?}", a);
            }
            Err(e) => {
                error!("save_tx_input {:?}", e);
            }
        }
    }

    // get utxo from m_btc_output_tx and m_btc_input_tx
    // 从txin的表格和txout的表中计算出utxo,utxo含有状态，如果需要计算地址对应的balance，也从utxo表格算出
    /*
     *                           +---------------------------------------+
     *                           |       serach btc_output_tx find       |
     *                           |           tx_hash and idx             |
     *                           +------------------+--------------------+
     *                                              |
     *                                              |
     *                                              |
     *                                              |                                                            v
     *                                              v
     *                               +----------------------------------+
     *                               |                                  |
     *                               |serach in btc_input_tx by         |     No
     *                     Yes       |    tx_hash and idx in tx_output  +-------------+
     *                +--------------+ where tx_hash == tx_id in input  |             |
     *                |              | and idx == vout in input table   |             |
     *                |              |                                  |             |
     *                |              +----------------------------------+             |
     *                |                                                               |
     *                v                                                               v
     * +----------------------------------+                               +--------------------------------+
     * | the output marked as spend then  |                               | the output marked as unspend   |
     * | clac the total spend and tx fee  |                               | when you can sign a Tx you can |
     * +----------------------------------+                               | use it                         |
     *                                                                    +--------------------------------+
     */
    pub async fn utxo(&self) {
        let outputs = MBtcOutputTx::list(&self.rb, "").await;
        if let Ok(outputs) = outputs {
            for output in outputs {
                let tx_hash = output.btc_tx_hash.clone();
                let idx = output.idx;
                let w = self
                    .rb
                    .new_wrapper()
                    .eq(MBtcInputTx::tx_id, tx_hash)
                    .eq(MBtcInputTx::vout, idx);
                let r = self.fetch_btc_input_tx(&w).await;
                match r {
                    None => {
                        let mut utxo = MBtcUtxo::default();
                        utxo.state = "unspend".to_owned();
                        utxo.btc_tx_hash = output.btc_tx_hash.clone();
                        utxo.idx = output.idx;
                        utxo.btc_tx_hexbytes = output.btc_tx_hexbytes;
                        utxo.value = output.value;
                    }
                    Some(input) => {}
                }
            }
        }
    }

    pub async fn fetch_btc_input_tx(&self, w: &Wrapper) -> Option<MBtcInputTx> {
        let r = self.rb.fetch_by_wrapper("", &w).await;
        match r {
            Ok(r) => r,
            Err(_) => None,
        }
    }
}

pub fn fetch_scanned_height() -> i64 {
    let mprogress = block_on(RB_DETAIL.progress());
    let h = block_on(RB_CHAIN.fetch_header_by_timestamp(mprogress.timestamp));
    h
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

pub static VERIFY: Lazy<(Option<FilterLoadMessage>, String)> = Lazy::new(|| {
    let user_address = RB_DETAIL.fetch_user_address();
    match user_address {
        None => {
            info!("Did not have pubkey in database yet, calc default address and pubkey");
            let default_address = calc_default_address();
            let address = default_address.to_string();
            let default_pubkey = calc_pubkey();
            let verify = calc_hash160(default_pubkey.as_str());
            {
                RB_DETAIL.save_user_address(address, default_pubkey.clone(), verify.clone());
            }
            let filter_load_message = FilterLoadMessage::calculate_filter(default_pubkey.as_str());
            (Some(filter_load_message), verify)
        }
        Some(u) => {
            info!("User Address {:?}", &u);
            let filter_load_message =
                FilterLoadMessage::calculate_filter(u.compressed_pub_key.as_str());
            (Some(filter_load_message), u.verify)
        }
    }
});

#[cfg(test)]
mod test {
    use crate::db::{RB_CHAIN, RB_DETAIL};
    use futures::executor::block_on;

    #[test]
    fn test_fetch_scann_header() {
        let r = block_on(RB_CHAIN.fetch_scan_header("1296688928".to_owned(), false));
        println!("{:?}", r);
        let r = block_on(RB_CHAIN.fetch_scan_header("1296688928".to_owned(), true));
        println!("{:?}", r);
    }

    #[test]
    fn test_fetch_height() {
        let h = block_on(RB_CHAIN.fetch_height());
        println!("{}", h)
    }

    #[test]
    fn test_fetch_scanned_header_by_timestamp() {
        let h = block_on(RB_CHAIN.fetch_header_by_timestamp("1368475833".to_owned()));
        println!("{}", h)
    }

    #[test]
    fn test_fetch_process() {
        let progress = block_on(RB_DETAIL.fetch_progress());
        println!("{:?}", &progress);
    }

    #[test]
    fn test_update_progress() {
        RB_DETAIL.update_progress(
            "00000000ea6690ba48686a4fa690eb186000d55b6c67f30bd8d4f0a7d7f1f98b".to_owned(),
            "1337966145".to_owned(),
        );
    }

    #[test]
    fn test_progress() {
        let progress = block_on(RB_DETAIL.progress());
        println!("{:#?}", &progress);
    }

    #[test]
    fn test_fetch_user_address() {
        let u = RB_DETAIL.fetch_user_address();
        println!("{:?}", &u);
    }

    #[test]
    fn test_utxo() {
        block_on(RB_DETAIL.utxo());
    }
}