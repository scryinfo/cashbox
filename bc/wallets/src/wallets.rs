use wallets_types::{InitParameters, Error, UnInitParameters, WalletsContext, Wallet};

pub struct Wallets{

}

impl Wallets{
    pub fn lock_read(&mut self) -> bool{
        return true;
    }
    pub fn unlock_read(&mut self) -> bool{
        return true;
    }
    pub fn lock_write(&mut self) -> bool{
        return true;
    }
    pub fn unlock_write(&mut self) -> bool{
        return true;
    }

    pub fn init(&mut self, params: &mut InitParameters) -> Error {
        Error{}
    }

    pub fn uninit(&mut self, params: &mut UnInitParameters) -> Error {
        Error{}
    }

    pub fn all(&mut self, ctx: &mut WalletsContext, ws: &mut Vec::<Wallet>) -> Error {
        Error{}
    }
}

impl Default for Wallets{
    fn default() -> Self {
        Self{}
    }
}