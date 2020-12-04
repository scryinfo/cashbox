use crate::{BtcChain, EeeChain, EthChain};

#[derive(Debug, Clone, Default)]
pub struct Error {
    //由于很多地方都有使用 error这个名字，加一个C减少重名
    pub code: u64,
    pub message: String,
}

#[repr(C)]
#[derive(Debug, Default)]
pub struct Wallet {
    pub id: String,
    pub next_id: String,
    pub eth_chain: EthChain,
    pub eee_chain: EeeChain,
    pub btc_chain: BtcChain,
}

#[repr(C)]
#[derive(Debug, Clone, Default)]
pub struct Address {
    pub id: String,
    pub wallet_id: String,
    pub chain_type: String,
    pub address: String,
    pub public_key: String,
}

#[repr(C)]
#[derive(Debug, Clone, Default)]
pub struct TokenShared {
    pub id: String,
    pub next_id: String,
    pub name: String,
    pub symbol: String,
}

#[repr(C)]
#[derive(Debug, Clone, Default)]
pub struct ChainShared {
    pub id: String,
    pub wallet_id: String,
    pub chain_type: String,
    /// 钱包地址
    pub wallet_address: Address,
}

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