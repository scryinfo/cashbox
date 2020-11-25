
pub struct Error{}
pub struct InitParameters{}

pub struct UnInitParameters{}

pub struct WalletsContext{}
pub struct Wallet{}

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