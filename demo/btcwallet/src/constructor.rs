use std::path::Path;
use crate::chaindb::{ChainDB, SharedChainDB};
use crate::error::SPVError;
use bitcoin::Network;
use std::sync::{Arc, RwLock};


pub struct Constructor;

impl Constructor {
    pub fn open_db(path: Option<&Path>, network: Network) -> Result<SharedChainDB, SPVError> {
        let mut chaindb =
            if let Some(path) = path {
                ChainDB::persistent_db(path, network)?
            } else {
                ChainDB::mem_db(network)?
            };

        chaindb.init()?;
        Ok(Arc::new(RwLock::new(chaindb)))
    }
}