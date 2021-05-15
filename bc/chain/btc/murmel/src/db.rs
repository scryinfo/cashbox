//! mod for sqlite
//! use two database
//!     1. for btc chain database
//!     2. for user data (utxo address ...)
//!
use crate::kit;
use crate::path::PATH;
use async_trait::async_trait;
use bitcoin::blockdata::constants::genesis_block;
use bitcoin::hashes::hex::ToHex;
use bitcoin::network::message_bloom_filter::FilterLoadMessage;
use bitcoin::{BitcoinHash, Network};
use futures::executor::block_on;
use log::{debug, error, info};
use mav::ma::{Dao, MAddress, MBlockHeader, MBtcChainTx, MBtcInputTx, MBtcOutputTx, MBtcUtxo};
use mav::ma::{MLocalTxLog, MProgress};
use once_cell::sync::OnceCell;
use rbatis::core::db::DBExecResult;
use rbatis::crud::CRUDTable;
use rbatis::crud::CRUD;
use rbatis::plugin::page::{IPage, Page, PageRequest};
use rbatis::rbatis::Rbatis;
use rbatis::wrapper::Wrapper;
use rbatis_core::Error;
use std::ops::Add;
use strum_macros::{EnumIter, EnumString, ToString};
use wallets_types::BtcNowLoadBlock;

// state value in btc database must be one of this enum
#[derive(Debug, Eq, PartialEq, EnumString, ToString, EnumIter)]
pub enum BtcTxState {
    #[strum(serialize = "Unknown", to_string = "Unknown")]
    Unknown,
    #[strum(serialize = "Spent", to_string = "Spent")]
    Spent,
    #[strum(serialize = "Unspent", to_string = "Unspent")]
    Unspent,
    #[strum(serialize = "Locked", to_string = "Locked")]
    Locked,
}

pub struct ChainSqlite<'a> {
    rb: Rbatis,
    network: &'a Network,
}

impl<'a> ChainSqlite<'a> {
    pub async fn new(network: &Network, db_file_name: &str) -> Result<Self, rbatis::Error> {
        let rb = {
            let rb = Self::init_rbatis(db_file_name).await;
            rb.exec("", MBlockHeader::create_table_script()).await?;
            rb
        };
        Ok(Self { rb, network })
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
                    print!("=== {:?} ===", a);
                }
                Err(e) => {
                    print!("=== {:?} ===", e);
                }
            }
        }

        headers
    }

    // how may headers save in block_header table
    pub async fn fetch_height(&self) -> u32 {
        let w = self.rb.new_wrapper();
        let sql = format!("SELECT COUNT(*) FROM {} ", &MBlockHeader::table_name());
        let r: Result<u32, _> = self.rb.fetch_prepare("", &sql, &w.args).await;
        match r {
            Ok(r) => r,
            Err(_) => 0,
        }
    }

    pub async fn fetch_header_by_timestamp(
        &self,
        timestamp: &String,
    ) -> Result<u32, rbatis::Error> {
        let w = self.rb.new_wrapper();
        let sql = format!(
            "SELECT {} FROM {} WHERE timestamp = {}",
            "rowid",
            &MBlockHeader::table_name(),
            &timestamp
        );
        let r: Result<u32, _> = self.rb.fetch_prepare("", &sql, &w.args).await;
        r
    }
}

pub struct DetailSqlite<'a> {
    rb: Rbatis,
    network: &'a Network,
}

impl<'a> DetailSqlite<'a> {
    pub async fn new(network: &Network, db_file_name: &str) -> Result<Self, rbatis::Error> {
        let rb = {
            let rb = Self::init_rbatis(db_file_name).await;
            DetailSqlite::init_table(&rb).await?;
            rb
        };
        Ok(Self { rb, network })
    }

    async fn init_table(rb: &Rbatis) -> Result<(), Error> {
        DetailSqlite::create_progress(rb).await?;
        DetailSqlite::create_address(rb).await?;
        DetailSqlite::create_btc_input_tx(rb).await?;
        DetailSqlite::create_btc_output_tx(rb).await?;
        DetailSqlite::create_btc_chain_tx(rb).await?;
        DetailSqlite::create_local_tx(rb).await?;
        DetailSqlite::create_btc_utxo(rb).await?;
        Ok(())
    }

    async fn create_address(rb: &Rbatis) -> Result<DBExecResult, Error> {
        rb.exec("", MAddress::create_table_script()).await
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

    async fn create_btc_utxo(rb: &Rbatis) -> Result<DBExecResult, Error> {
        rb.exec("", MBtcUtxo::create_table_script()).await
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
        let w = self.rb.new_wrapper().eq("_ROWID_", 1);
        let r: Result<MProgress, _> = self.rb.fetch_by_wrapper("", &w).await;
        return match r {
            Ok(r) => Some(r),
            Err(e) => {
                print!("{:?}", e);
                None
            }
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
                let genesis = genesis_block(self.network.to_owned()).header;
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

    pub async fn save_address(&self, ref mut address: MAddress) {
        let r = address.save(&self.rb, "").await;
        match r {
            Ok(a) => {
                debug!("save address {:?}", a);
            }
            Err(e) => {
                debug!("error save address {:?}", e);
            }
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

    pub async fn save_btc_output_tx(
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

        let r = btc_output_tx.save_update(&self.rb, "").await;
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

    pub async fn save_local_tx(
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
        let r = local_tx.save(&self.rb, "").await;
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
     * | the output marked as spend then  |                               | the output marked as unspent   |
     * | clac the total spend and tx fee  |                               | when you can sign a Tx you can |
     * +----------------------------------+                               | use it                         |
     *                                                                    +--------------------------------+
     */
    pub async fn utxo(&self) {
        let outputs = MBtcOutputTx::list(&self.rb, "").await;
        if let Ok(outputs) = outputs {
            for this_output in outputs {
                let tx_hash = this_output.btc_tx_hash.clone();
                let idx = this_output.idx;
                let w = self
                    .rb
                    .new_wrapper()
                    .eq(MBtcInputTx::tx_id, tx_hash)
                    .eq(MBtcInputTx::vout, idx);
                let r = self.fetch_btc_input_tx(&w).await;
                match r {
                    None => {
                        let mut utxo = MBtcUtxo::default();
                        utxo.state = BtcTxState::Unspent.to_string();
                        utxo.btc_tx_hash = this_output.btc_tx_hash.clone();
                        utxo.idx = this_output.idx;
                        utxo.btc_tx_hexbytes = this_output.btc_tx_hexbytes;
                        utxo.value = this_output.value;
                        let r = utxo.save_update(&self.rb, "").await;
                        r.map_or_else(|e| error!("{:?}", e), |d| debug!("{:?}", d))
                    }
                    Some(input) => {
                        let mut utxo = MBtcUtxo::default();
                        utxo.state = BtcTxState::Spent.to_string();
                        utxo.btc_tx_hash = this_output.btc_tx_hash.clone();
                        utxo.idx = this_output.idx;
                        utxo.btc_tx_hexbytes = this_output.btc_tx_hexbytes;
                        utxo.value = this_output.value;

                        let input_tx = kit::hex_to_tx(&input.btc_tx_hexbytes);
                        let mut spent_value = 0;
                        if let Ok(tx) = input_tx {
                            let outs = tx.output;
                            for o in outs {
                                spent_value += o.value
                            }
                        }

                        utxo.spent_value = Some(spent_value);
                        let r = utxo.save_update(&self.rb, "").await;
                        r.map_or_else(|e| error!("{:?}", e), |d| debug!("{:?}", d))
                    }
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
impl<'a> RInit for ChainSqlite<'a> {}

#[async_trait]
impl<'a> RInit for DetailSqlite<'a> {}

pub struct GlobalRB<'a> {
    chain: ChainSqlite<'a>,
    detail: DetailSqlite<'a>,
}

static GLOBAL_RB: OnceCell<GlobalRB> = OnceCell::new();

impl<'a> GlobalRB<'a> {
    pub fn global() -> &'static GlobalRB<'a> {
        GLOBAL_RB.get().expect("GlobalRB is not initialized")
    }

    pub fn from(path: &str, network: &Network) -> Result<Self, rbatis::Error> {
        block_on(async {
            let prefix = match network {
                Network::Bitcoin => "main_",
                Network::Testnet => "test_",
                Network::Regtest => "private_",
            };

            let chain = ChainSqlite::new(network, &format!("{}{}btc_chain.db", path, prefix))?;
            let detail = DetailSqlite::new(network, &format!("{}{}btc_detail.db", path, prefix))?;
            Ok(Self { chain, detail })
        })
    }
}

#[derive(Debug)]
pub struct Verify {
    address: String,
    public_key: String,
    pub(crate) verify: String,
    pub(crate) filter: FilterLoadMessage,
}

pub static INSTANCE: OnceCell<Verify> = OnceCell::new();

impl Verify {
    pub fn global() -> &'static Verify {
        INSTANCE.get().expect("Verify is not initialized")
    }

    pub fn from_address(address: MAddress) -> Self {
        let public_key = &address.public_key.as_str()[2..]; // trim 0x
        Verify {
            address: address.address,
            public_key: public_key.to_string(),
            verify: kit::hash160(public_key),
            filter: FilterLoadMessage::calculate_filter(public_key),
        }
    }
}

pub fn fetch_scanned_height(network: &Network) -> Result<BtcNowLoadBlock, rbatis::Error> {
    let global_rb = GlobalRB::from(PATH, network)?;
    GLOBAL_RB.set(global_rb);
    let mprogress = block_on(GlobalRB::global().detail.progress());
    let height = block_on(
        GlobalRB::global()
            .chain
            .fetch_header_by_timestamp(&mprogress.timestamp),
    )?;
    Ok(BtcNowLoadBlock {
        height: height - 1,
        header_hash: mprogress.header,
        timestamp: mprogress.timestamp,
    })
}

#[cfg(test)]
mod test {
    use crate::db::{fetch_scanned_height, GlobalRB, GLOBAL_RB};
    use crate::path::PATH;
    use bitcoin::Network;
    use futures::executor::block_on;

    fn set_global() {
        let global_rb = GlobalRB::from(PATH, &Network::Testnet)?;
        GLOBAL_RB.set(global_rb);
    }

    #[test]
    fn test_fetch_scann_header() {
        set_global();
        let r = block_on(
            GlobalRB::global()
                .chain
                .fetch_scan_header("1296688928".to_owned(), false),
        );
        println!("{:?}", r);
        let r = block_on(
            GlobalRB::global()
                .chain
                .fetch_scan_header("1296688928".to_owned(), true),
        );
        println!("{:?}", r);
    }

    #[test]
    fn test_fetch_height() {
        set_global();
        let h = block_on(GlobalRB::global().chain.fetch_height());
        println!("{}", h)
    }

    #[test]
    fn test_fetch_process() {
        let progress = block_on(GlobalRB::global().detail.fetch_progress());
        println!("{:?}", &progress);
    }

    #[test]
    fn test_update_progress() {
        set_global();
        block_on(GlobalRB::global().detail.update_progress(
            "00000000ea6690ba48686a4fa690eb186000d55b6c67f30bd8d4f0a7d7f1f98b".to_owned(),
            "1337966145".to_owned(),
        ));
    }

    #[test]
    fn test_utxo() {
        set_global();
        block_on(GlobalRB::global().detail.utxo());
    }

    #[test]
    fn test_btc_load_now_block() {
        set_global();
        let r = fetch_scanned_height(&Network::Testnet);
        match r {
            Ok(r) => {
                println!("{:?}", r)
            }
            Err(e) => {
                println!("{:?}", e)
            }
        }
    }
}