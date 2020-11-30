use parking_lot::ReentrantMutex;

#[derive(Default)]
pub struct Error {}

#[derive(Default)]
pub struct DbName {
    pub cashbox_wallets: String,
    pub cashbox_mnemonic: String,
    pub wallet_mainnet: String,
    pub wallet_private: String,
    pub wallet_testnet: String,
    pub wallet_testnet_private: String,
}

#[derive(Default)]
pub struct InitParameters {}


#[derive(Default)]
pub struct UnInitParameters {}

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

#[derive(Default)]
pub struct Wallet {}

// pub struct Address([u8]);
//
// impl Address{
//     fn toHex(self) -> String{
//         // hex::encode(self.0)
//         "".to_owned()
//     }
//     fn setBytes(&mut self, bs: &[u8]){
//         self.0.set_bytes(bs);
//     }
//     fn setHex(&mut self,addr: String){
//         let d = hex::encode_to_slice(self,addr);
//
//     }
//
// }
//
// /// 由助词或公钥生成地址
// pub trait MakeAddress{
//     fn publicKey_to(pkey:&[u8]) ->Address;
//     fn mnemonic_to(pkey:&[u8]) ->Address;
// }