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
use std::collections::HashMap;
use std::ops::Add;
use strum_macros::{EnumIter, EnumString, ToString};
use wallets_types::{BtcBalance, BtcNowLoadBlock};

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

#[derive(Debug)]
pub struct ChainSqlite {
    rb: Rbatis,
    network: Network,
}

impl ChainSqlite {
    pub async fn new(network: Network, db_file_name: &str) -> Result<ChainSqlite, rbatis::Error> {
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
    ) -> Result<u64, rbatis::Error> {
        let w = self.rb.new_wrapper();
        let sql = format!(
            "SELECT {} FROM {} WHERE timestamp = {} LIMIT 1",
            "rowid",
            &MBlockHeader::table_name(),
            &timestamp
        );
        let r: Result<u64, _> = self.rb.fetch_prepare("", &sql, &w.args).await;
        r
    }
}

#[derive(Debug)]
pub struct DetailSqlite {
    rb: Rbatis,
    network: Network,
}

impl<'a> DetailSqlite {
    pub async fn new(network: Network, db_file_name: &str) -> Result<DetailSqlite, rbatis::Error> {
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
                error!("error save btc_output_tx {:?}", e);
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

    pub async fn list_btc_input_tx(&self) -> Vec<MBtcInputTx> {
        let r = MBtcInputTx::list(&self.rb, "").await;
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
impl RInit for ChainSqlite {}

#[async_trait]
impl RInit for DetailSqlite {}

#[derive(Debug)]
pub struct GlobalRB {
    pub chain: ChainSqlite,
    pub detail: DetailSqlite,
}

pub static GLOBAL_RB: OnceCell<GlobalRB> = OnceCell::new();

impl GlobalRB {
    pub fn global() -> &'static GlobalRB {
        GLOBAL_RB.get().expect("GlobalRB is not initialized")
    }

    pub fn from(path: &str, network: Network) -> Result<GlobalRB, rbatis::Error> {
        block_on(async move {
            let prefix = match network {
                Network::Bitcoin => "main_",
                Network::Testnet => "test_",
                Network::Regtest => "private_",
            };

            let chain =
                ChainSqlite::new(network, &format!("{}{}btc_chain.db", path, prefix)).await?;
            let detail =
                DetailSqlite::new(network, &format!("{}{}btc_detail.db", path, prefix)).await?;
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

pub fn fetch_scanned_height() -> Result<BtcNowLoadBlock, rbatis::Error> {
    let r = block_on(async {
        let mprogress = GlobalRB::global().detail.progress().await;
        let height = GlobalRB::global()
            .chain
            .fetch_header_by_timestamp(&mprogress.timestamp)
            .await?;
        let r = BtcNowLoadBlock {
            height,
            header_hash: mprogress.header,
            timestamp: mprogress.timestamp,
        };
        Ok(r)
    });
    r
}

pub fn load_balance() -> Result<BtcBalance, rbatis::Error> {
    block_on(async {
        let vec = GlobalRB::global().detail.list_btc_output_tx().await;
        let mut value_map = HashMap::new();
        for out in vec {
            value_map.insert(out.btc_tx_hash, out.value);
        }

        let vec = GlobalRB::global().detail.list_btc_input_tx().await;
        let inputs = vec.into_iter().map(|y| y.tx_id).collect::<Vec<String>>();
        let r = value_map
            .into_iter()
            .filter(|x| !inputs.contains(&x.0))
            .collect::<HashMap<_, _>>();
        let value = r.iter().map(|x| x.1).sum::<u64>();
        let mprogress = GlobalRB::global().detail.progress().await;
        let height = GlobalRB::global()
            .chain
            .fetch_header_by_timestamp(&mprogress.timestamp)
            .await?;
        let r = BtcBalance {
            balance: value,
            height,
        };
        Ok(r)
    })
}

mod test {
    use crate::db::{fetch_scanned_height, GlobalRB, Verify, GLOBAL_RB};
    use crate::path::PATH;
    use bitcoin::{Network, Transaction};
    use futures::executor::block_on;
    use log::kv::Source;
    use std::collections::HashMap;

    #[test]
    pub fn test_test_tx() {
        use crate::db;
        use bitcoin::consensus::deserialize;
        use bitcoin::util::misc::hex_bytes;

        let hex_tx = hex_bytes("02000000440735ab4dc68f78139dbb2917d74da8adb80b30e26351402593ad59dd25822dfb0000000023220020c5cb2845cf040b8ddf7e08a49a4ae82a90ca51b010db0a36fe6a66c7117dbd8afdffffffd9ec2c53821d62c3f96447b89e6dbd85735cce69869a7c39bb5201d6b16a54aa00000000232200200f367512cfb2ba1a16411f5bd2c065fd89151accdea281562fdf01e23129909efdffffff67fd6cda37f2530e7a939cf6ae6576ab5070b06a5a55a320f8139eb0907c259d0000000023220020b82920607065ed70bdd0fe915eca9542c2fed6b95ec4d7866768d569acda368bfdffffff24814c88695d1898312dd6bb8068944333f034c0dd25530c2738487ecec43a7f01000000232200206a0b495283b08505a048baac900ddadd756548e8297aa9c996e2d3757b563550fdffffff3215e15956dbaac7c776c16041b0eba88aec1dda01db807916924d49045a2eba0000000023220020bf3a63a31a8a7e07f3fe817af400e84400d376ac797b75add3f56cfdd2b04365fdffffffe8ad94f360c2dc0e6bc9385aadac8aae0f96340ba90d1a447fda7931a19f2cce010000002322002053c7c33571fdcbfd1883b3eb49242a4b456d4eb94f2b9f6105fa1770b898a60efdffffff6dbae0da8b6bd1bce8045fa501b1da3d73ad41ac4e046ca11fef8adb1f17f64f01000000232200200b9c860d33e2e0c86c99878b460000c1a6dc9d76f477ed7fd16389b78e072b34fdffffffe2f68ab41cbf221ed735652d7b9145106008fb69353737fcaef64d6b0a2be1350000000023220020165999fe6ad97ee2afd85ff712e931aafc8e547f6c96d6376f05377263a26f31fdffffffe4793d2e7dcce19619bc1db203a7595f362dbe7a79de56da05650bb374a14846010000002322002095a353f13e77e588ffad52e54df3deb0e77bc2ab93375674e6972184277fb3a7fdfffffffdcd001ca77e7291921f4c85e2c810118e42f26dea1e641a6cf78caa61da5e9200000000232200208c990d0745b540bb50bd49cbdab6840f3bf75e4f53e55206035278d3dbc3388bfdffffff4f82cb4c90f9dd2b01b61fbee2b8b6c2347dac999c4bfa501d50e59cbc8fdf660000000023220020605286bd035430bfcd781ace7d6bea22a0ffc41e21efc539c230006a2b617a0cfdffffff011348278945c15b293103b73ccbc192bc77d5fa9b495548194cd9fce3b765420000000023220020a2453c99eba18177cb0cf07763d89d5ba5a2ed4b050a74537314057d58a97a77fdffffffe8675100c8e6788925cbbe17ac1ea5b5173141b72fe9656f3f2d6817862fd4a00000000023220020a5f98edf1c321d4a212639645a21a91d4c4fbe78f8676ecc126d2ab55eaa81defdffffffafb99320f74eef4235907a2b4aefba4647eb281fb0d600196d76e6e22e1190100100000023220020a9a56ade9aeb42c43b318e327786279e5870ed676e8df52945fee19d22b0cf5bfdffffff2e69bd50f9eb9031cd0f7016caa073858e0ae3f4ff18d1b4daeb785b5cb554020100000023220020f40ee45ed3140f216f4fe0a59f033b0bde0641445f90d16b71a108a081a13f81fdffffff2300aa47555a4991d2992a3d720124e04c753c92c02d5d8228a921738e40cd8f0000000023220020a6813294a8547c977f9c2644449a79720c54fc1e6ac773290b093060c153b057fdffffff06de9ea1dbfc7793fdddc7158615da62e6dc41dd588926b105ad996ffadaee440100000023220020d3a8ca61bcc406f101780f5de8a0a7ccc394ca1bf15aa2aa0811b5b7ede4bffefdffffff48c01a389d58736a24f398eaea885bf1571982da4ce4d1f3c258e2bf4944803a0000000023220020d4fe624e52c93ce970cf9d60bd8dbc1e69db9c0cc11cc00e4065b5a4e381ff59fdffffff4a9996758f92e667a8625c053d56ff5df3dbf982774939db4cd5eedb6d2e9fcb0100000023220020d8360682053d9847f72297e5e8ac12221bba3c48b9c5157ba581d0002f444f70fdffffff88ec3b707cd79dd18589900a02c041b43f963e15ab1483a2651a0bb3c97934b1010000002322002026dc8a3f05eba4c9319e0a1c7919c3b0eb8e491bd38f38a97a53b59cc67e3097fdffffff62d984fd19677501a655fde3153f30e63ff257c82f048c0331304afca6794d7b010000002322002026dc8a3f05eba4c9319e0a1c7919c3b0eb8e491bd38f38a97a53b59cc67e3097fdffffff82ff059be8be36bc7adc6f297821a933d03a36e722e9c02959b063b45b03368f010000002322002026dc8a3f05eba4c9319e0a1c7919c3b0eb8e491bd38f38a97a53b59cc67e3097fdffffff48f882adab8aa7580da83c4ffcf1b690bc71bdca7a521907dc63ad27b4865d9b01000000232200204a97825c3beea1a6bfe047c8311946e85ac1ca16ee29f85e8011a446756cc656fdffffffeb47360bdc8082276096815c882cc8582979e6f98f25a0e142512ba1c78acd3f0100000023220020d4fe624e52c93ce970cf9d60bd8dbc1e69db9c0cc11cc00e4065b5a4e381ff59fdfffffff979758abe0d3b6ff9ae655285e2ec87783829936bf417e3c7500e391555cb840100000023220020d4fe624e52c93ce970cf9d60bd8dbc1e69db9c0cc11cc00e4065b5a4e381ff59fdffffff63e39053e0510c72e882bf3a1d25bfb8b758a5229064da20a48f9ebc42c4124401000000232200205943b4b5e63194315f0c1f5e17382c1523bc024ca5ff490df5667606687b6c8cfdfffffffc8d22a2001a8753fe6fdde14d31df9a90ab77412d1645274744ab8ce4ed0f7a00000000232200205943b4b5e63194315f0c1f5e17382c1523bc024ca5ff490df5667606687b6c8cfdffffff0528799d865e3c66205c1a8ff8f36749bbee777a33cfd8dd5d1b6b6ec9e6a99f01000000232200205943b4b5e63194315f0c1f5e17382c1523bc024ca5ff490df5667606687b6c8cfdffffff325af76d6d15c62670e224c28b3b8be526cf83b7afa9001865ba714e50ec7df0010000002322002094f3951cf1c77454723dd9ea6c0fbbed2bf567c3ec06b2cb3ba7cb0799c6fb85fdffffffa48ca0a576818cde4476068a27522377532e03ede58eab43b72ac80e427d07a4000000002322002094f3951cf1c77454723dd9ea6c0fbbed2bf567c3ec06b2cb3ba7cb0799c6fb85fdffffff05d90b8ded307c1f13ab06fc83faf87597f1e1087dfd9bc92be20d4f82674bf6000000002322002094f3951cf1c77454723dd9ea6c0fbbed2bf567c3ec06b2cb3ba7cb0799c6fb85fdffffff07415d9622b3a66ffb0fa16b856387ffc9330a05337b04081d8b187e1d645ea201000000232200204a97825c3beea1a6bfe047c8311946e85ac1ca16ee29f85e8011a446756cc656fdffffff474a42bb42bd1e764ee314a4d06a7d6d62119f22c54da8926d939a85f6f2f0cc0100000023220020d4fe624e52c93ce970cf9d60bd8dbc1e69db9c0cc11cc00e4065b5a4e381ff59fdffffff2e9dfaa815cb437e5f4c2dd2d535f0a1845967b060f68c73770b5476563825870000000023220020705007ae3023ac4a2dedc775e5b3ac3e1a4a44c009f54a07e65a4db7e43669c7fdffffff7ed940881ffe923b47287af143da3ac021298995da1fdb64a9a7b7abee90f0bc0000000023220020705007ae3023ac4a2dedc775e5b3ac3e1a4a44c009f54a07e65a4db7e43669c7fdffffff5154315b173587a996fff1ee6011cec9cc0321ca5f926c6c9d09a33a0e1fe85e270000002322002094f3951cf1c77454723dd9ea6c0fbbed2bf567c3ec06b2cb3ba7cb0799c6fb85fdffffff118b1cf95718d33a74ed3f3932c3f64fb2f0c6e4518b15747b733555b75991bd0000000023220020e8ced8e40c4e22e6ab74ef55a110b0e9c613b2b7a9f02acc67afabdbad7f3356fdffffffc63e39f7689496014a5857cbb78061924f0470a93b279764de92981bd36835ca00000000232200207b68a4b0f8fddf8e0361a86c69676cab16b1028153e9e39f63574276dc4b661ffdffffff39090fab3b5f16b38253595b815c5bd5bdb26566e9019477035e7c41aee372c800000000232200207b68a4b0f8fddf8e0361a86c69676cab16b1028153e9e39f63574276dc4b661ffdffffff3f10ba06de3593b235590c768cd04234cb1872798f377849caf0ab768ab79d0200000000232200207b68a4b0f8fddf8e0361a86c69676cab16b1028153e9e39f63574276dc4b661ffdffffffd96535bd40580821ee7cb764193e3b6541b7690322a70bd6a221a0af54342f5200000000232200200d04d7e00bb0142760d85390271aee054b4e433ef51ff94cc36d6e0e67b031a8fdffffffc391cd1eb472cee0e15b6b5a5041199e46f199d0e6cdc3c9e69324981ffab2de0000000023220020587f32734410b52ff4c2e8e5270ef93f549da72ccf300f28c4ad1110db07f467fdffffff451c69339b4f86b74491410c6ec0d4db380f58b06e00de3811dc6fc88729a8fe000000002322002003f278d79595e5b902b07386525a0ccaaf7d99307e299aeac1147825f20c4338fdffffff86ca04d5136844983aec64c389ed432981bd235989df872fbb006b5b9af1e9a3000000002322002003f278d79595e5b902b07386525a0ccaaf7d99307e299aeac1147825f20c4338fdffffff0d330e37c4584ab00561f748c0e4b400afa92e14f42a6b48a17c153a299ef9640100000023220020701b227dca90b841b28bf0328541f5625b6c117c58a23e77cac4ece8cb8a7778fdffffffec1bdb7c63c544dde3f579ada1226df77506978691b2579c7fbc781e34b047520000000023220020430838065d3cdda3c482cb742a96449c1d0bf4a4058bf94564daa35f01655eb3fdffffff8e03c7408f509d7b56c0ba781376071b4e32011b73d509e16dbb54dd269584c90000000023220020430838065d3cdda3c482cb742a96449c1d0bf4a4058bf94564daa35f01655eb3fdffffffb2560ad6510da1f8d496ca4c2292d7c37728ba7c3853df34438e70a779a2bd8c0000000023220020bf0d4a77e40a5889bfd84db1acef18fa6772543f55e8adec85d5ae81c08e780cfdffffff500ffe2ba7f58f55c98822e9180945d479e5718ddd6bffe01ef7a3733dd4879c0000000023220020680b4eae9cc4de5977d876acd5dcbd03fea3f7559760d5a413e9ad89ede671d7fdffffff6343917d55915286dfc87ceee1c7e4a509c56fe60f5747867b7611ca1f2dd07f0000000023220020dac2ed63bde6187bad2070e14c54d3c9901e0db7b70f091ec1d0d32091d8642efdfffffffe8d06499cdb510452e440ce099fe6374129847378e49d6df8543ee085c320ec010000002322002083e06f376b92cb8957439f0fb1b4f2d2490c878e71752d4699af784e205f5060fdffffffb829912f9bad8888fb0656c895cefee659ab48d31aac26a97700356555dc0f2b000000002322002083e06f376b92cb8957439f0fb1b4f2d2490c878e71752d4699af784e205f5060fdffffffadfe829a172268aec9a7bdeec251d0dbb160f7088e85da73cd47ffd09ffff2ef000000002322002083e06f376b92cb8957439f0fb1b4f2d2490c878e71752d4699af784e205f5060fdffffffaa9818abc51db791491c04e91e25c4e74d16db86b1020174c6ecad75605cb6950000000023220020ffc58ae0e6e93e110850b650626419883c322fe25f7c87b5c3a060eecca59a79fdffffff258b09df7edaa286383d5ba4557f5f455871ee8a50b47bb6946a9d35d424bd1a0000000023220020ffc58ae0e6e93e110850b650626419883c322fe25f7c87b5c3a060eecca59a79fdffffff632bc03f330d41e39f7d000e745cca4ab59f4af2d50cddbd64d19009bfc5ec450000000023220020bb23e5397679504762bb9fe453eb9973b10b306be086e4af25b2d11a38c5bf60fdffffff376449daff9b7e3a363a9fd866755509b098cff086af89655455eeba913789a401000000232200208694599b7ad76f6bbdaa981151745a06d951dec724893691801f3337e8af360bfdffffff5ed9088749c0f15f782ff1761e34eceed380afabc9cfa2f05cd00d3776d7ee3c00000000232200206ec0db726d1c788476244a53513ad009c263ebc5ece32dcf9979b0e703784ba6fdffffffe45fb67db4b342b030a2e5292859395cd7e07c5f5211f4f651408bd2543fa46b00000000232200207102b46de60d584f9e9acc76cb40a8dbb0192872dd02ab0c7d52953f2247355afdffffff7d57159712a19f665e41468b27a9c5006751a6f7bc2dfe43881c84b7590ea01c0000000023220020d5abe96f8429f455372bb070423d67a20ce63db37b6c00d71800d4cb1e5969cafdffffff40f725efcb2bbcc3b1b4ebc18a8b94ad157af07dace8a3b2efb9a8d411e4b240000000002322002041293326a22cffc40cd35233c573291a577bafd9a2faf5e428a87dcc7328b99efdffffffe641be0cd372c0af5e7ee6648d8a470ae7db1f1b9aa0d8267188756a8a712ab5010000002322002041293326a22cffc40cd35233c573291a577bafd9a2faf5e428a87dcc7328b99efdffffffd03ec57d1bfe41f3f953d0fd1dbe73c83bbf6bc1cee69f1d7bae80f1028c3d21010000002322002041293326a22cffc40cd35233c573291a577bafd9a2faf5e428a87dcc7328b99efdffffff7810afd7f1c13c2af25f5a1600fb8bacb2b6f577ac64bba9f8682c65ca3f3c38000000002322002051f696125fff93f88f97c2a6236abfbf0c19681cf4cb4939f6ea127f75eb7d8afdffffff2118f7b0dfc8ce89cfda2a050e4b5e01f31d9ac2c2dbef78740e6410b47d624e000000002322002051f696125fff93f88f97c2a6236abfbf0c19681cf4cb4939f6ea127f75eb7d8afdfffffff1e2244e1de0d0f0df12c43e1cfb7b160c1e2409b781f54a34898f59c5f9051e000000002322002051f696125fff93f88f97c2a6236abfbf0c19681cf4cb4939f6ea127f75eb7d8afdffffff7ec3f6fb6403c26f2daacc9697e9317cfd365b9817af0b825eba36509c94158b00000000232200207b0b63784765a9c37cfda6e7183d9b8daa8bc2836d975f9d03794834517e615ffdffffff9821f789df94e1c2ecbb2cb3b5281fdd09e9316d27383deb1d982f327fba696700000000232200207b0b63784765a9c37cfda6e7183d9b8daa8bc2836d975f9d03794834517e615ffdffffff026ca554000000000017a9146713a00ebface724d051bfc9e82871b6787be0758700ca9a3b0000000017a9144f1096a70fcf40943cc0ad98fab0819b373471268714801900").unwrap();
        let tx: Result<Transaction, _> = deserialize(&hex_tx);
        let tx = tx.unwrap();
        println!("{:#?}", tx);

        let vouts = tx.output;
        for (index, vout) in vouts.iter().enumerate() {
            let script = vout.to_owned().script_pubkey;
            let asm = script.asm();
            let mut iter = asm.split_ascii_whitespace();
            let a = iter.next();
            println!("1  {}", a.unwrap());
            let a = iter.next();
            println!("2  {}", a.unwrap());
            let a = iter.next();
            println!("3  {}", a.unwrap());
            let current_hash_160 = iter.next().unwrap_or(" ");
        }
    }

    #[test]
    pub fn test_load_balane() {
        let global_rb = GlobalRB::from(PATH, Network::Testnet).unwrap();
        GLOBAL_RB.set(global_rb).unwrap();
        block_on(async {
            let vec = GlobalRB::global().detail.list_btc_output_tx().await;
            let mut value_map = HashMap::new();
            for out in vec {
                value_map.insert(out.btc_tx_hash, out.value);
            }

            let vec = GlobalRB::global().detail.list_btc_input_tx().await;
            let inputs = vec.into_iter().map(|y| y.tx_id).collect::<Vec<String>>();
            let r = value_map
                .into_iter()
                .filter(|x| !inputs.contains(&x.0))
                .collect::<HashMap<_, _>>();
            let values = r.iter().map(|x| x.1).sum::<u64>();
            let mprogress = GlobalRB::global().detail.progress().await;
            let height = GlobalRB::global()
                .chain
                .fetch_header_by_timestamp(&mprogress.timestamp)
                .await
                .unwrap();
            println!("{}", height);
        });
    }
}