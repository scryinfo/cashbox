#![allow(non_snake_case)]

use anyhow::Result;
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize)]
pub struct ModuleVersion(String, u32);


#[derive(Debug, Deserialize, Serialize)]
pub struct NodeVersion {
    pub apis: Vec<ModuleVersion>,
    pub authoringVersion: u32,
    pub implName: String,
    pub implVersion: u32,
    pub specName: String,
    pub specVersion: u32,
    pub transactionVersion: u32,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct DigestItem {
    logs: Vec<String>,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct Block {
    pub block: BlockDetail,
    pub justification: Option<Vec<u8>>,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct BlockDetail {
    pub header: Header,
    pub extrinsics: Vec<String>,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct Header {
    pub digest: DigestItem,
    pub extrinsicsRoot: String,
    pub number: String,
    pub parentHash: String,
    pub stateRoot: String,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct StorageChange {
    pub block: String,
    pub changes: Vec<Vec<String>>,
}

#[jsonrpc_client::api]
pub trait Node {
    async fn chain_getBlockHash(&self, block_num: u64) -> String;
    async fn chain_getHeader(&self, block_hash: Option<&str>) -> Header;
    async fn chain_getBlock(&self, block_hash: &str) -> Block;
    async fn state_getRuntimeVersion(&self, block_hash: &str) -> NodeVersion;
    async fn state_queryStorage(&self, query_keys: Vec<String>, start_block_hash: &str, end_block_hash: &str) -> Vec<StorageChange>;
    async fn state_getStorage(&self, event_key: &str, block_hash: &str) -> String;
    async fn state_getMetadata(&self, block_hash: Option<String>) -> String;
}

#[jsonrpc_client::implement(Node)]
pub struct Client {
    inner: reqwest::Client,
    base_url: jsonrpc_client::Url,
}

impl Client {
    pub fn new(base_url: String) -> Result<Self> {
        Ok(Self {
            inner: reqwest::Client::new(),
            base_url: base_url.parse()?,
        })
    }
}