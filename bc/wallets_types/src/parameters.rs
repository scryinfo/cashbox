use failure::_core::ops::{Deref, DerefMut};

#[derive(Debug, Default, Clone)]
pub struct InitParameters {
    pub db_name: DbName,
    pub context_note: String,
}

#[derive(Debug, Default)]
pub struct UnInitParameters {}

#[derive(Debug, Default, Clone)]
pub struct DbName(pub mav::ma::DbName);

impl Deref for DbName {
    type Target = mav::ma::DbName;

    fn deref(&self) -> &Self::Target {
        &self.0
    }
}

impl DerefMut for DbName {
    fn deref_mut(&mut self) -> &mut Self::Target {
        &mut self.0
    }
}

#[derive(Debug, Default)]
pub struct CreateWalletParameters {
    pub name: String,
    pub password: String,
    pub mnemonic: String,
    pub wallet_type: String,
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

