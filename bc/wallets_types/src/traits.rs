use async_trait::async_trait;

use mav::ma::{Db, MAddress, MWallet};
use mav::WalletType;

use crate::WalletError;

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
}