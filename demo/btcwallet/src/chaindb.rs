/// This mod is for block chain database
use std::sync::{Arc, RwLock};
use log::{info, error};
use crate::error::SPVError;
use std::path::Path;
use rusqlite::{Connection, NO_PARAMS};
use bitcoin_hashes::sha256d;
use bitcoin::{Network, BitcoinHash, BlockHeader};
use bitcoin::blockdata::constants::genesis_block;
use crate::headercache::{HeaderCache, StoredHeader, CachedHeader};

/// Shared handle to a database storing the block chain
/// protected by an RwLock
pub type SharedChainDB = Arc<RwLock<ChainDB>>;

pub struct ChainDB {
    db: Connection,
    headercache: HeaderCache,
    network: Network,
}

impl ChainDB {
    /// Create an in-memory database instance
    pub fn mem_db(network: Network) -> Result<ChainDB, SPVError> {
        info!("working with in memory chain db");
        let db = Connection::open_in_memory()?;
        let headercache = HeaderCache::new(network);
        Ok(ChainDB { db, headercache, network })
    }

    /// Create or open a persistent database instance identified by the path
    /// genesis_block --> 创世块
    ///
    pub fn persistent_db(path: &Path, network: Network) -> Result<ChainDB, SPVError> {
        info!("working with persistent chain db ");
        let db = Connection::open(path)?;
        let headercache = HeaderCache::new(network);
        Ok(ChainDB { db, headercache, network })
    }

    /// Initialize caches
    pub fn init(&mut self) -> Result<(), SPVError> {
        self.init_headers()?;
        Ok(())
    }

    /// The detail about getchaintips [https://chainquery.com/bitcoin-cli/getchaintips]
    fn init_headers(&mut self) -> Result<(), SPVError> {
        if let Some(tip) = self.fetch_header_tip()? {
            info!("reading stored header chain from tip {}", tip);
            let mut h = tip;
            while let Some(stored) = self.fetch_header(&h)? {
                self.headercache.add_header_unchecked(&h, &stored);
                if stored.header.prev_blockhash != sha256d::Hash::default() {
                    h = stored.header.prev_blockhash;
                } else {
                    break;
                }
            }
            self.headercache.reverse_trunk();
            info!("read {} headers", self.headercache.len());
        } else {
            let genesis = genesis_block(self.network).header;
            if let Some((cached, _, _)) = self.headercache.add_header(&genesis)? {
                info!("Initialized with genesis header {}", genesis.bitcoin_hash());
//                TODO
//                Store some bitcoin object that has a bitcoin hash
//                self.db.put_hash_keyed(&cached.stored)?;
//                批量操作
//                self.db.batch()?;
//                都是些hammers 的功能 后续使用sqlite3补全
                self.store_header_tip(&cached.bitcoin_hash())?;
//                self.db.batch()?;
            } else {
                error!("Failed to initialize with genesis header");
                return Err(SPVError::NoTip);
            }
        }
        Ok(())
    }

    /// return position of hash on trunk if hash is on trunk
    pub fn pos_on_trunk(&self, hash: &sha256d::Hash) -> Option<u32> {
        self.headercache.pos_on_trunk(hash)
    }

    /// iterate trunk [from .. tip]
    pub fn iter_trunk<'a>(&'a self, from: u32) -> impl Iterator<Item=&'a CachedHeader> + 'a {
        self.headercache.iter_trunk(from)
    }

    /// iterate trunk [genesis .. from] in reverse order from is the tip if not specified
    pub fn iter_trunk_rev<'a>(&'a self, from: Option<u32>) -> impl Iterator<Item=&'a CachedHeader> + 'a {
        self.headercache.iter_trunk_rev(from)
    }

    /// retrieve the id of the block/header with most work
    pub fn header_tip(&self) -> Option<CachedHeader> {
        self.headercache.tip()
    }

    /// Fetch a header by its id from cache
    pub fn get_header(&self, id: &sha256d::Hash) -> Option<CachedHeader> {
        self.headercache.get_header(id)
    }

    /// Fetch a header by its id from cache
    pub fn get_header_for_height(&self, height: u32) -> Option<CachedHeader> {
        self.headercache.get_header_for_height(height)
    }

    /// locator for getheaders message
    pub fn header_locators(&self) -> Vec<sha256d::Hash> {
        self.headercache.locator_hashes()
    }

    /// Store a header
    /// todo
    /// 后续使用sqlite3
    pub fn add_header(&mut self, header: &BlockHeader) -> Result<Option<(StoredHeader, Option<Vec<sha256d::Hash>>, Option<Vec<sha256d::Hash>>)>, SPVError> {
        if let Some((cached, unwinds, forward)) = self.headercache.add_header(header)? {
//            self.db.put_hash_keyed(&cached.stored)?;
            if let Some(forward) = forward.clone() {
                if forward.len() > 0 {
                    self.store_header_tip(forward.last().unwrap())?;
                }
            }
            return Ok(Some((cached.stored, unwinds, forward)));
        }
        Ok(None)
    }

    /// Store the header id with most work
    /// TODO
    /// 后续使用sqlite3
    pub fn store_header_tip(&mut self, tip: &sha256d::Hash) -> Result<(), SPVError> {
//        self.db.put_keyed_encodable(HEADER_TIP_KEY, tip)?;
        unimplemented!();
//        Ok(())
    }

    /// Find header id with most work
    /// TODO
    /// 后续使用sqlite3
    pub fn fetch_header_tip(&self) -> Result<Option<sha256d::Hash>, SPVError> {
        unimplemented!();
//        Ok(self.db.get_keyed_decodable::<sha256d::Hash>(HEADER_TIP_KEY)?.map(|(_, h)| h.clone()))
    }

    /// Read header from the DB
    /// TODO
    pub fn fetch_header(&self, id: &sha256d::Hash) -> Result<Option<StoredHeader>, SPVError> {
        unimplemented!();
//        Ok(self.db.get_hash_keyed::<StoredHeader>(id)?.map(|(_, header)| header))
    }
}

// need to implement if put_hash_keyed and get_hash_keyed should be used
impl BitcoinHash for StoredHeader {
    fn bitcoin_hash(&self) -> sha256d::Hash {
        self.header.bitcoin_hash()
    }
}

const HEADER_TIP_KEY: &[u8] = &[0u8; 1];