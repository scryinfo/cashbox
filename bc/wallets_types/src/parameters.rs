#[derive(Debug, Default, Clone)]
pub struct InitParameters {
    pub db_name: DbName,
    pub context_note: String,
}

#[derive(Debug, Default, Clone)]
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

#[derive(Debug, Default)]
pub struct CreateWalletParameters {
    pub name: String,
    pub password: String,
    pub mnemonic: String,
}

#[derive(Debug, Clone)]
pub struct Context {
    pub id: String,
    pub context_note: String,
}

impl Default for Context {
    fn default() -> Self {
        Self {
            id: uuid::Uuid::new_v4().to_string(),
            context_note: "".to_owned(),
        }
    }
}

