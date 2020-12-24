use async_trait::async_trait;
use strum::IntoEnumIterator;

use eee::Crypto;
use mav::{NetType, WalletType};
use mav::ma::{Dao, MAddress, MBtcChainToken, MEeeChainToken, MEthChainToken, MWallet};
use wallets_types::{BtcChainTokenDefault, Chain2WalletType, ChainTrait, ContextTrait, EeeChainTokenDefault, EthChainTokenDefault, WalletError, WalletTrait};

#[derive(Default)]
struct EthChain();

#[derive(Default)]
struct EeeChain();

#[derive(Default)]
struct BtcChain();

pub(crate) struct Wallet {
    chains: Vec<Box<dyn ChainTrait>>,
}

#[async_trait]
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

    async fn generate_default_token(&self, context: &dyn ContextTrait, wallet: &MWallet, address: &MAddress) -> Result<(), WalletError> {
        let wallet_type = WalletType::from(&wallet.wallet_type);
        //�������ʵ�ֲ��оͺ���
        for net_type in NetType::iter() {
            let token_rb = context.db().data_db(&net_type);
            let mut tx = token_rb.begin_tx_defer(false).await?;
            let default_tokens = EthChainTokenDefault::list_by_net_type(context, &net_type, &tx.tx_id).await?;
            let mut tokens = Vec::new();
            for it in default_tokens {
                let mut token = MEthChainToken::default();
                token.chain_token_shared_id = it.chain_token_shared_id.clone();
                token.wallet_id = wallet.id.clone();
                token.chain_type = wallets_types::EthChain::chain_type(&wallet_type).to_string();
                token.show = true;
                //todo how to
                // gas_limit: 0,
                // gas_price: "".to_string(),
                // decimal: 0
                tokens.push(token);
            }
            MEthChainToken::save_batch(token_rb, &tx.tx_id, &mut tokens).await?;

            token_rb.commit(&tx.tx_id).await?;
            tx.manager = None;
        }
        Ok(())
    }
}

const DEFAULT_SS58_VERSION: u8 = 42;

#[async_trait]
impl ChainTrait for EeeChain {
    fn generate_address(&self, mn: &[u8], wallet_type: &WalletType) -> Result<MAddress, WalletError> {
        let mut addr = MAddress::default();
        addr.chain_type = wallets_types::EeeChain::chain_type(wallet_type).to_string();
        {
            let phrase = String::from_utf8(mn.to_vec())?;
            let seed = eee::Sr25519::seed_from_phrase(&phrase, None).unwrap();
            let pair = eee::Sr25519::pair_from_seed(&seed);
            let puk_key = eee::Sr25519::public_from_pair(&pair);

            addr.address = eee::Sr25519::ss58_from_pair(&pair, DEFAULT_SS58_VERSION);
            addr.public_key = format!("0x{}", hex::encode(puk_key));
        }
        Ok(addr)
    }

    async fn generate_default_token(&self, context: &dyn ContextTrait, wallet: &MWallet, address: &MAddress) -> Result<(), WalletError> {
        let wallet_type = WalletType::from(&wallet.wallet_type);
        //�������ʵ�ֲ��оͺ���
        for net_type in NetType::iter() {
            let token_rb = context.db().data_db(&net_type);
            let mut tx = token_rb.begin_tx_defer(false).await?;
            let default_tokens = EeeChainTokenDefault::list_by_net_type(context, &net_type, &tx.tx_id).await?;
            let mut tokens = Vec::new();
            for it in default_tokens {
                let mut token = MEeeChainToken::default();
                token.chain_token_shared_id = it.chain_token_shared_id.clone();
                token.wallet_id = wallet.id.clone();
                token.chain_type = wallets_types::EeeChain::chain_type(&wallet_type).to_string();
                token.show = true;
                //todo how to
                // decimal: 0
                tokens.push(token);
            }
            MEeeChainToken::save_batch(token_rb, &tx.tx_id, &mut tokens).await?;

            token_rb.commit(&tx.tx_id).await?;
            tx.manager = None;
        }
        Ok(())
    }
}

#[async_trait]
impl ChainTrait for BtcChain {
    fn generate_address(&self, _mn: &[u8], wallet_type: &WalletType) -> Result<MAddress, WalletError> {
        let mut addr = MAddress::default();
        addr.chain_type = wallets_types::BtcChain::chain_type(wallet_type).to_string();
        //todo
        Ok(addr)
    }

    async fn generate_default_token(&self, context: &dyn ContextTrait, wallet: &MWallet, address: &MAddress) -> Result<(), WalletError> {
        let wallet_type = WalletType::from(&wallet.wallet_type);
        //�������ʵ�ֲ��оͺ���
        for net_type in NetType::iter() {
            let token_rb = context.db().data_db(&net_type);
            let mut tx = token_rb.begin_tx_defer(false).await?;
            let default_tokens = BtcChainTokenDefault::list_by_net_type(context, &net_type, &tx.tx_id).await?;
            let mut tokens = Vec::new();
            for it in default_tokens {
                let mut token = MBtcChainToken::default();
                token.chain_token_shared_id = it.chain_token_shared_id.clone();
                token.wallet_id = wallet.id.clone();
                token.chain_type = wallets_types::EeeChain::chain_type(&wallet_type).to_string();
                token.show = true;
                //todo how to
                // decimal: 0
                tokens.push(token);
            }
            MBtcChainToken::save_batch(token_rb, &tx.tx_id, &mut tokens).await?;

            token_rb.commit(&tx.tx_id).await?;
            tx.manager = None;
        }
        Ok(())
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
