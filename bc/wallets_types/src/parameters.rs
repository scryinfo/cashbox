use parking_lot::ReentrantMutex;

#[derive(Debug, Default)]
pub struct InitParameters {
    pub db_name: DbName,
}

#[derive(Debug, Default)]
pub struct DbName {
    pub cashbox_wallets: String,
    pub cashbox_mnemonic: String,
    pub wallet_mainnet: String,
    pub wallet_private: String,
    pub wallet_testnet: String,
    pub wallet_testnet_private: String,
}

#[derive(Debug, Default)]
pub struct UnInitParameters {}

#[derive(Debug)]
pub struct Context {
    pub id: String,
    pub reentrant_mutex: ReentrantMutex<i32>,
}

impl Default for Context {
    fn default() -> Self {
        Self {
            reentrant_mutex: ReentrantMutex::new(0),
            id: uuid::Uuid::new_v4().to_string(),
        }
    }
}
