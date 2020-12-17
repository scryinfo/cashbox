use mav::ma::MAddress;
use mav::WalletType;
use substratetx::Crypto;
use wallets_types::{Chain2WalletType, ChainTrait, WalletError, WalletTrait};

#[derive(Default)]
struct EthChain();

#[derive(Default)]
struct EeeChain();

#[derive(Default)]
struct BtcChain();

pub(crate) struct Wallet {
    chains: Vec<Box<dyn ChainTrait>>,
}


impl ChainTrait for EthChain {
    fn generate_address(&self, mn: &[u8], wallet_type: &WalletType) -> Result<MAddress, WalletError> {
        let mut m_address = MAddress::default();
        m_address.chain_type = wallets_types::EthChain::chain_type(wallet_type).to_string();
        let phrase = String::from_utf8(mn.to_vec())?;
        let secret_byte = ethtx::pri_from_mnemonic(&phrase, None)?;
        let (addr, puk) = ethtx::generate_eth_address(&secret_byte)?;
        m_address.address = addr;
        m_address.public_key = puk;
        Ok(m_address)
    }
}

const DEFAULT_SS58_VERSION: u8 = 42;

impl ChainTrait for EeeChain {
    fn generate_address(&self, mn: &[u8], wallet_type: &WalletType) -> Result<MAddress, WalletError> {
        let mut addr = MAddress::default();
        addr.chain_type = wallets_types::EeeChain::chain_type(wallet_type).to_string();
        {
            let phrase = String::from_utf8(mn.to_vec())?;
            let seed = substratetx::Sr25519::seed_from_phrase(&phrase, None).unwrap();
            let pair = substratetx::Sr25519::pair_from_seed(&seed);
            let puk_key = substratetx::Sr25519::public_from_pair(&pair);

            addr.address = substratetx::Sr25519::ss58_from_pair(&pair, DEFAULT_SS58_VERSION);
            addr.public_key = format!("0x{}", hex::encode(puk_key));
        }
        Ok(addr)
    }
}

impl ChainTrait for BtcChain {
    fn generate_address(&self, _mn: &[u8], wallet_type: &WalletType) -> Result<MAddress, WalletError> {
        let mut addr = MAddress::default();
        addr.chain_type = wallets_types::BtcChain::chain_type(wallet_type).to_string();
        //todo
        Ok(addr)
    }
}

impl Wallet {
    pub fn new() -> Box<dyn WalletTrait> {
        let mut w = Wallet {
            chains: Default::default(),
        };
        w.chains.push(Box::new(EthChain::default()));
        w.chains.push(Box::new(EeeChain::default()));
        w.chains.push(Box::new(BtcChain::default()));
        Box::new(w)
    }
}

impl WalletTrait for Wallet {
    fn chains(&self) -> &Vec<Box<dyn ChainTrait>> {
        &self.chains
    }
}
