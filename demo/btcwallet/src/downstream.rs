//!
//! # Connector to downstream modules
//!

use bitcoin::{
    blockdata::{
        block::{Block, BlockHeader}
    },
};

use std::sync::{Arc, Mutex};

pub type SharedDownstream = Arc<Mutex<dyn Downstream>>;

pub trait Downstream : Send + Sync {
    /// called by the node if new block added to trunk (longest chain)
    fn block_connected(&mut self, block: &Block, height: u32);

    /// called by the node if new header added to trunk (longest chain)
    fn header_connected(&mut self, header: &BlockHeader, height: u32);

    /// called by the node if a block is removed from trunk (orphaned from longest chain)
    fn block_disconnected(&mut self, header: &BlockHeader);
}

pub struct DownStreamDummy {}

impl Downstream for DownStreamDummy {
    fn block_connected(&mut self, _block: &Block, _height: u32) {}

    fn header_connected(&mut self, _header: &BlockHeader, _height: u32) {}

    fn block_disconnected(&mut self, _header: &BlockHeader) {}
}