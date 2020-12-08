use rbatis::rbatis::Rbatis;

use mav::ma::{Dao, MAddress, MChainShared, MTokenShared, MWallet};

use crate::{BtcChain, EeeChain, EthChain, WalletError};
use crate::deref_type;

#[derive(Debug, Default)]
pub struct Wallet {
    pub m: MWallet,
    pub eth_chain: EthChain,
    pub eee_chain: EeeChain,
    pub btc_chain: BtcChain,
}
deref_type!(Wallet,MWallet);

impl Wallet {
    pub async fn all(rb: &Rbatis) -> Result<Vec<Wallet>, WalletError> {
        let ws = Vec::new();
        let dws = MWallet::list(rb, "").await?;
        for dw in dws {
            let mut w = Wallet::default();
            w.m = dw;
            w.load(rb);
        }
        Ok(ws)
    }
    pub fn load(&mut self, rb: &Rbatis) {
        //todo 
    }
}


#[derive(Debug, Clone, Default)]
pub struct Address {
    pub m: MAddress,
}
deref_type!(Address,MAddress);

#[derive(Debug, Clone, Default)]
pub struct TokenShared {
    pub m: MTokenShared
}
deref_type!(TokenShared,MTokenShared);

#[derive(Debug, Clone, Default)]
pub struct ChainShared {
    pub m: MChainShared,
    /// 钱包地址
    pub wallet_address: Address,
}
deref_type!(ChainShared,MChainShared);
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