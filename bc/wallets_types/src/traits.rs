use async_trait::async_trait;

use mav::ma::{Db, MAddress, MWallet, EeeTokenType};
use mav::{WalletType, NetType};

use crate::{AccountInfo, AccountInfoSyncProg, BtcChainTokenAuth, BtcChainTokenDefault, DecodeAccountInfoParameters, EeeChainTokenAuth, EeeChainTokenDefault, EeeTransferPayload, EthChainTokenAuth, EthChainTokenDefault, EthRawTxPayload, EthTransferPayload, ExtrinsicContext, RawTxParam, StorageKeyParameters, SubChainBasicInfo, WalletError, EeeChainTx, EthChainTokenNonAuth, BtcNowLoadBlock, BtcBalance};

#[async_trait]
pub trait Load {
    type MType;
    async fn load(&mut self, context: &dyn ContextTrait, m: Self::MType) -> Result<(), WalletError>;
}

pub trait ContextTrait: Send + Sync {
    fn db(&self) -> &Db;
    ///是退出当前上下文，如已经运行了或将要运行uninit时，
    fn stopped(&self) -> bool;

    fn set_stopped(&mut self, s: bool);
}

#[async_trait]
pub trait ChainTrait: Send + Sync {
    fn generate_address(&self, mn: &[u8], wallet_type: &WalletType,net_type:&NetType) -> Result<MAddress, WalletError>;
    /// 因为trait object的限制，这里需要直接把数据存入数据库中，而不返回范型的参数[see](https://doc.rust-lang.org/error-index.html#E0038)
    async fn generate_default_token(&self, context: &dyn ContextTrait, wallet: &MWallet, address: &MAddress,net_type:&NetType) -> Result<(), WalletError>;
}

pub trait WalletTrait: Send + Sync {
    fn chains(&self) -> &Vec<Box<dyn ChainTrait>>;
    fn eee_chain(&self) -> &Box<dyn EeeChainTrait>;
    fn eth_chain(&self) -> &Box<dyn EthChainTrait>;
    fn btc_chain(&self) -> &Box<dyn BtcChainTrait>;
}

#[async_trait]
pub trait EeeChainTrait: Send + Sync {
    async fn update_basic_info(&self, context: &dyn ContextTrait, net_type: &NetType, basic_info: &mut SubChainBasicInfo) -> Result<(), WalletError>;
    async fn get_basic_info(&self, context: &dyn ContextTrait, net_type: &NetType, genesis_hash: &str, runtime_version: i32, tx_version: i32) -> Result<SubChainBasicInfo, WalletError>;

    async fn update_sync_record(&self, context: &dyn ContextTrait, net_type: &NetType, sync_record: &AccountInfoSyncProg) -> Result<(), WalletError>;
    async fn get_sync_record(&self, context: &dyn ContextTrait, net_type: &NetType, account: &str) -> Result<AccountInfoSyncProg, WalletError>;

    async fn decode_account_info(&self, context: &dyn ContextTrait, net_type: &NetType, parameters: DecodeAccountInfoParameters) -> Result<AccountInfo, WalletError>;
    async fn get_storage_key(&self, context: &dyn ContextTrait, net_type: &NetType, parameters: StorageKeyParameters) -> Result<String, WalletError>;
    async fn eee_transfer(&self, context: &dyn ContextTrait, net_type: &NetType, transfer_payload: &EeeTransferPayload) -> Result<String, WalletError>;
    async fn tokenx_transfer(&self, context: &dyn ContextTrait, net_type: &NetType, transfer_payload: &EeeTransferPayload) -> Result<String, WalletError>;
    async fn tx_sign(&self, context: &dyn ContextTrait, net_type: &NetType, raw_tx: &RawTxParam, is_submittable: bool) -> Result<String, WalletError>;
    async fn save_tx_record(&self, context: &dyn ContextTrait,net_type: &NetType, extrinsic_ctx:&ExtrinsicContext) -> Result<(), WalletError>;
    async fn get_tx_record(&self,context: &dyn ContextTrait,net_type: &NetType,token_type:EeeTokenType,target_account:Option<String>,start_item:u64,page_size:u64)->Result<Vec<EeeChainTx>,WalletError>;
    async fn get_default_tokens(&self,context: &dyn ContextTrait,net_type: &NetType)->Result<Vec<EeeChainTokenDefault>,WalletError>;
    async fn update_default_tokens(&self, context: &dyn ContextTrait, tokens: Vec<EeeChainTokenDefault>) -> Result<(), WalletError>;
    async fn update_auth_tokens(&self, context: &dyn ContextTrait, auth_tokens: Vec<EeeChainTokenAuth>) -> Result<(), WalletError>;
    async fn get_auth_tokens(&self,context: &dyn ContextTrait,net_type: &NetType,start_item:u64,page_size:u64)->Result<Vec<EeeChainTokenAuth>,WalletError>;

}

#[async_trait]
pub trait EthChainTrait: Send + Sync {
    async fn tx_sign(&self, context: &dyn ContextTrait, net_type: &NetType, transfer_tx: &EthTransferPayload, password: &str) -> Result<String, WalletError>;
    async fn raw_tx_sign(&self, context: &dyn ContextTrait, net_type: &NetType, raw_tx: &EthRawTxPayload, password: &str) -> Result<String, WalletError>;
    async fn decode_addition_data(&self, encode_data: &str) -> Result<String, WalletError>;
    async fn update_default_tokens(&self, context: &dyn ContextTrait, default_tokens: Vec<EthChainTokenDefault>) -> Result<(), WalletError>;
    async fn get_default_tokens(&self,context: &dyn ContextTrait,net_type: &NetType)->Result<Vec<EthChainTokenDefault>,WalletError>;
    async fn update_auth_tokens(&self, context: &dyn ContextTrait, auth_tokens: Vec<EthChainTokenAuth>) -> Result<(), WalletError>;
    async fn update_non_auth_tokens(&self, context: &dyn ContextTrait, non_auth_tokens: Vec<EthChainTokenNonAuth>) -> Result<(), WalletError>;
    async fn get_non_auth_tokens(&self,context: &dyn ContextTrait,net_type: &NetType)->Result<Vec<EthChainTokenNonAuth>,WalletError>;
    async fn get_auth_tokens(&self,context: &dyn ContextTrait,net_type: &NetType,start_item:u64,page_size:u64)->Result<Vec<EthChainTokenAuth>,WalletError>;
    async fn query_auth_tokens(&self, context: &dyn ContextTrait, net_type: &NetType, name: Option<String>, contract_addr: Option<String>, start_item: u64, page_size: u64)->Result<Vec<EthChainTokenAuth>,WalletError>;
}

#[async_trait]
pub trait BtcChainTrait: Send + Sync {
    async fn get_default_tokens(&self,context: &dyn ContextTrait,net_type: &NetType)->Result<Vec<BtcChainTokenDefault>,WalletError>;
    async fn update_default_tokens(&self, context: &dyn ContextTrait, default_tokens: Vec<BtcChainTokenDefault>) -> Result<(), WalletError>;
    async fn update_auth_tokens(&self, context: &dyn ContextTrait, auth_tokens: Vec<BtcChainTokenAuth>) -> Result<(), WalletError>;
    async fn get_auth_tokens(&self,context: &dyn ContextTrait,net_type: &NetType,start_item:u64,page_size:u64)->Result<Vec<BtcChainTokenAuth>,WalletError>;
    fn start_murmel(&self, context: &dyn ContextTrait, wallet_id: &str, net_type:&NetType) ->Result<(),WalletError>;
    fn load_now_blocknumber(&self, context: &dyn ContextTrait, net_type:&NetType) ->Result<BtcNowLoadBlock,WalletError>;
    fn load_balance(&self, context: &dyn ContextTrait,net_type: &NetType) -> Result<BtcBalance,WalletError>;
    fn tx_sign(&self, context: &dyn ContextTrait, net_type: &NetType) -> Result<String, WalletError>;
}