use async_trait::async_trait;
use rbatis::rbatis::Rbatis;

use mav::ma::{Dao, MAddress, MChainShared, MTokenShared, MWallet};
use mav::WalletType;

use crate::{BtcChain, EeeChain, EthChain, WalletError};
use crate::deref_type;

#[async_trait]
pub trait Load {
    type MType;
    async fn load(&mut self, rb: &Rbatis, m: Self::MType) -> Result<(), WalletError>;
}

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
        let mut ws = Vec::new();
        let dws = MWallet::list(rb, "").await?;
        for dw in &dws {
            let mut w = Wallet::default();
            w.load(rb, dw.clone()).await?;
            ws.push(w);
        }
        Ok(ws)
    }

    pub async fn mnemonic_digest(rb: &Rbatis, digest: &str) -> Result<Vec<MWallet>, WalletError> {
        let mut wrapper = rb.new_wrapper();
        wrapper.eq(MWallet::mnemonic_digest, digest);
        let ms = MWallet::list_by_wrapper(rb, "", &wrapper).await?;
        Ok(ms)
    }

    pub async fn wallet_type_mnemonic_digest(rb: &Rbatis, digest: &str, wallet_type: &WalletType) -> Result<Vec<MWallet>, WalletError> {
        let mut wrapper = rb.new_wrapper();
        wrapper.eq(MWallet::mnemonic_digest, digest.to_owned());
        wrapper.eq(MWallet::wallet_type, wallet_type.to_string());
        let ms = MWallet::list_by_wrapper(rb, "", &wrapper).await?;
        Ok(ms)
    }

    // pub async fn save(&mut self, rb: &Rbatis,tx_id: &str) ->Result<(), WalletError> {
    //     self.m.save(rb, tx_id).await?;
    // }
}

#[async_trait]
impl Load for Wallet {
    type MType = MWallet;
    async fn load(&mut self, rb: &Rbatis, mw: MWallet) -> Result<(), WalletError> {
        self.m = mw;
        {
            self.eth_chain.load(rb, self.m.clone()).await?;
            //todo wallet address
        }
        {
            self.eee_chain.load(rb, self.m.clone()).await?;
            //todo wallet address
        }
        {
            self.btc_chain.load(rb, self.m.clone()).await?;
            //todo wallet address
        }

        Ok(())
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

impl ChainShared {
    pub fn set_m(&mut self, mw: &MWallet) {
        self.m.wallet_id = mw.id.clone();
    }
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