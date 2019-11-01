use crate::chaindb::{ChainDB, SharedChainDB};
use crate::error::SPVError;
use bitcoin::Network;
use std::sync::{Arc, RwLock, Mutex, mpsc};
use std::sync::atomic::AtomicUsize;
use std::net::SocketAddr;
use rand::{RngCore, thread_rng};
use crate::p2p::{PeerMessageSender, P2PControl, BitcoinP2PConfig, P2P};
use crate::downstream::{DownStreamDummy, SharedDownstream};
use crate::timeout::Timeout;
use crate::dispatcher::Dispatcher;
use bitcoin::network::message::{NetworkMessage, RawNetworkMessage};
use crate::headerdownload::HeaderDownload;
use crate::ping::Ping;

const MAX_PROTOCOL_VERSION: u32 = 70001;

/// The complete stack
pub struct Constructor {
    p2p: Arc<P2P<NetworkMessage, RawNetworkMessage, BitcoinP2PConfig>>,
    /// this should be accessed by Lightning
    pub downstream: SharedDownstream,
}

impl Constructor {
    pub fn open_db(network: Network) -> Result<SharedChainDB, SPVError> {
        let mut chaindb =
            ChainDB::persistent_db(network)?;

        chaindb.init()?;
        Ok(Arc::new(RwLock::new(chaindb)))
    }

    /// Construct the stack
    pub fn new(network: Network, listen: Vec<SocketAddr>, chaindb: SharedChainDB) -> Result<Constructor, SPVError> {
        const BACK_PRESSURE: usize = 10;

        let (to_dispatcher, from_p2p) = mpsc::sync_channel(BACK_PRESSURE);

        let p2pconfig = BitcoinP2PConfig {
            network,
            nonce: thread_rng().next_u64(),
            max_protocol_version: MAX_PROTOCOL_VERSION,
            user_agent: "Alvin: 0.1.0".to_owned(),
            height: AtomicUsize::new(0),
            server: !listen.is_empty(),
        };

        let (p2p, p2p_control) =
            P2P::new(p2pconfig, PeerMessageSender::new(to_dispatcher), BACK_PRESSURE);

        #[cfg(not(feature = "lightning"))] let lightning = Arc::new(Mutex::new(DownStreamDummy {}));

        let timeout = Arc::new(Mutex::new(Timeout::new(p2p_control.clone())));

        let mut dispatcher = Dispatcher::new(from_p2p);

        dispatcher.add_listener(HeaderDownload::new(chaindb.clone(), p2p_control.clone(), timeout.clone(), lightning.clone()));
        dispatcher.add_listener(Ping::new(p2p_control.clone(), timeout.clone()));

        for addr in &listen {
            p2p_control.send(P2PControl::Bind(addr.clone()));
        }

        Ok(Constructor { p2p, downstream: lightning })
    }
}