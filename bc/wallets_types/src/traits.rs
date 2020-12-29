use async_trait::async_trait;

use mav::ma::{Db, MAddress, MWallet};
use mav::{WalletType, NetType};

use crate::{WalletError, SubChainBasicInfo, RawTxParam, AccountInfoSyncProg, DecodeAccountInfoParameters, AccountInfo, StorageKeyParameters, TransferPayload};

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
    fn generate_address(&self, mn: &[u8], wallet_type: &WalletType) -> Result<MAddress, WalletError>;
    /// 因为trait object的限制，这里需要直接把数据存入数据库中，而不返回范型的参数[see](https://doc.rust-lang.org/error-index.html#E0038)
    async fn generate_default_token(&self, context: &dyn ContextTrait, wallet: &MWallet, address: &MAddress) -> Result<(), WalletError>;
}

pub trait WalletTrait: Send + Sync {
    fn chains(&self) -> &Vec<Box<dyn ChainTrait>>;
    fn eee_chain(&self) -> &Box<dyn EeeChainTrait>;
}

#[async_trait]
pub trait EeeChainTrait: Send + Sync {
    async fn update_basic_info(&self, context: &dyn ContextTrait, net_type: &NetType, basic_info: &mut SubChainBasicInfo) -> Result<(), WalletError>;
    async fn get_basic_info(&self, context: &dyn ContextTrait, net_type: &NetType, genesis_hash: &str, runtime_version: i32, tx_version: i32) -> Result<SubChainBasicInfo, WalletError>;

    async fn update_sync_record(&self, context: &dyn ContextTrait, net_type: &NetType, sync_record: &AccountInfoSyncProg) -> Result<(), WalletError>;
    async fn get_sync_record(&self, context: &dyn ContextTrait, net_type: &NetType, account: &str) -> Result<AccountInfoSyncProg, WalletError>;

    async fn decode_account_info(&self, context: &dyn ContextTrait, net_type: &NetType, parameters: DecodeAccountInfoParameters) -> Result<AccountInfo, WalletError>;
    async fn get_storage_key(&self, context: &dyn ContextTrait, net_type: &NetType, parameters: StorageKeyParameters) -> Result<String, WalletError>;
    async fn eee_transfer(&self, context: &dyn ContextTrait, net_type: &NetType, transfer_payload: &TransferPayload) -> Result<String, WalletError>;
    async fn tokenx_transfer(&self, context: &dyn ContextTrait, net_type: &NetType, transfer_payload: &TransferPayload) -> Result<String, WalletError>;
    async fn tx_sign(&self, context: &dyn ContextTrait, net_type: &NetType, raw_tx: &RawTxParam, is_submittable: bool) -> Result<String, WalletError>;
}
