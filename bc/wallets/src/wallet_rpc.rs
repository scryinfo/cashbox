use super::*;
use std::sync::mpsc;
use futures::Future;
use ws::{Rpc, RpcError};
use substrate_primitives::{blake2_256,hexdisplay::HexDisplay};
use serde_json::json;
use node_primitives::{Balance, Index, Hash};
use node_runtime::{Call, UncheckedExtrinsic, BalancesCall};
use wallet_crypto::Crypto;

mod ws;
pub mod substrate;
pub use substrate::transfer;

pub fn substrate_thread(
    send_tx: mpsc::Sender<jsonrpc_ws_server::ws::Message>,
) -> Result<Rpc, RpcError> {
    let port = 9944;
    Rpc::new(&format!("ws://127.0.0.1:{}", port), send_tx)
}

pub fn submit_data(client: &mut Rpc, tx: String) -> u64 {
    client
        .request::<u64>("author_submitAndWatchExtrinsic", vec![json!(tx)])
        .wait()
        .unwrap()
        .unwrap()
}


