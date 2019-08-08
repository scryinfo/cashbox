use crate::account_crypto::Crypto;

pub mod account_crypto;

pub enum StatusCode{
    OK=200,//正常
    FailToGenerateMnemonic = 100,//生成助记词失败
    PwdIsWrong, //密码错误
    FailToRestPwd, //重置密码失败
    GasNotEnough, //GAS费不足
    BroadcastOk,//广播上链成功
    BroadcastFailure,  //广播上链失败
}

pub enum ChainType{
    BTC =1,
    BtcTest,
    ETH,
    EthTest,
    EEE,
    EeeTest,
}


#[repr(C)]
 pub struct Mnemonic{
    pub status:StatusCode,
    pub mn:Vec<u8>,
    pub mnid:String,
}

#[repr(C)]
 pub struct Address{
   pub chain_type:ChainType,
   pub pubkey:String,
   pub addr:String,
   pub pri_key:Vec<u8>,
}

pub fn crate_mnemonic<T>(num:u8)->Mnemonic where T:Crypto{
    let mnemonic = T::generate_phrase(num);
    let mut kecck = tiny_keccak::Keccak::new_keccak256();
    kecck.update(mnemonic.as_bytes());
    let mut mnemonic_id = [0u8; 32];
    kecck.finalize(&mut mnemonic_id);
    Mnemonic{
        status:StatusCode::OK,
        mn:mnemonic.as_bytes().to_vec(),
        mnid:hex::encode(mnemonic_id),
    }
}

#[cfg(test)]
mod tests {
    use crate::crate_mnemonic;
    use crate::account_crypto::Ed25519;
    use crate::account_crypto::Sr25519;


    #[test]
    fn verify_mnemonic_create() {

        println!("{}", crate_mnemonic::<Ed25519>(18));
        println!("{}", crate_mnemonic::<Sr25519>(18));
    }
}
