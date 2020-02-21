#[macro_use]
extern crate serde_derive;

use ethabi::Contract;
use std::convert::TryFrom;
use ethereum_types::{U256, H160};
use rlp::RlpStream;
use secp256k1::{key::SecretKey, Message, Secp256k1};
use bip39::{Mnemonic, MnemonicType, Language,Seed};

mod contract;
mod types;
mod error;

// 从助记词恢复私钥
pub fn pri_from_mnemonic(phrase:&str,psd:Option<Vec<u8>>)->Option<Vec<u8>>{
    let mnemonic = Mnemonic::from_phrase(phrase, Language::English).unwrap();
    let psd = {
        match psd {
            Some(data)=>String::from_utf8(data).unwrap(),
            None=>String::from(""),
        }
    };
    let seed = Seed::new(&mnemonic,&psd);
    seed.as_bytes().get(0..32).map(|data|data.to_vec())
}

#[derive(Clone, Debug, PartialEq)]
pub struct EthTxHelper {
    abi: Contract,
}

impl EthTxHelper {
    fn load(abi_data: &[u8]) -> Self {
        let abi = ethabi::Contract::load(&abi_data[..]).expect("input data format not correct!");
        EthTxHelper {
            abi,
        }
    }

    fn encode_contract_input<P>(&self, method: &str, params: P) -> Result<Vec<u8>, String> where P: contract::tokens::Tokenize {
        let data = self.abi.function(method).and_then(|function| {
            for input in function.inputs.iter() {
                println!("{:?}", input);
            }
            function.encode_input(&params.into_tokens())
        });
        //let data = self.abi.unwrap().function(method).and_then(|function| function.encode_input(&params.into_tokens()));
        match data {
            Ok(bytes) => {
                Ok(bytes)
            }
            Err(err) => Err(err.to_string())
        }
    }
}
pub fn get_erc20_transfer_data(address:&str,value:&str)->Result<Vec<u8>,String>{
    let bytecode = include_bytes!("build/Erc20.abi");
    let helper = EthTxHelper::load(&bytecode[..]);
    let mut index =0;
    if address.starts_with("0x") {
        index = 2;
    }
    let value = U256::from_dec_str(value).unwrap();
    //TODO 检查地址可能带来的错误
    let address =    H160::from_slice(hex::decode(address.get(index..).unwrap()).unwrap().as_slice());
    helper.encode_contract_input("transfer", (address, value))
}

/// Description of a Transaction, pending or in the chain.
#[derive(Debug, Default, Clone, PartialEq, Deserialize, Serialize)]
pub struct RawTransaction {
    /// Nonce
    pub nonce: U256,
    /// Recipient (None when contract creation)
    pub to: Option<H160>,
    /// Transfered value
    pub value: U256,
    /// Gas Price
    #[serde(rename = "gasPrice")]
    pub gas_price: U256,
    /// Gas amount
    pub gas: U256,
    /// Input data
    pub data: Vec<u8>,
}

impl RawTransaction {
    pub fn sign(&self, private_key: &[u8], chain_id: Option<u64>) -> Vec<u8> {
        let hash_data = self.hash(chain_id);
        let sig = ecdsa_sign(&hash_data, private_key, chain_id.unwrap());
        let mut r_n = sig.r;
        let mut s_n = sig.s;
        while r_n[0] == 0 {
            r_n.remove(0);
        }
        while s_n[0] == 0 {
            s_n.remove(0);
        }
        let mut tx = RlpStream::new();
        tx.begin_unbounded_list();
        self.encode(&mut tx);
        tx.append(&sig.v);
        tx.append(&r_n);
        tx.append(&s_n);
        tx.finalize_unbounded_list();
        tx.out()
    }

    /// Signs and returns the RLP-encoded transaction
    fn hash(&self, chain_id: Option<u64>) -> [u8; 32] {
        let mut stream = RlpStream::new();
        stream.begin_unbounded_list();
        self.encode(&mut stream);
        if let Some(n) = chain_id {
            stream.append(&n);
            stream.append(&U256::zero());
            stream.append(&U256::zero());
        }
        stream.finalize_unbounded_list();
        keccak(stream.out().as_slice())
    }

    //对RawTransaction 数据使用RLP编码
    fn encode(&self, rlp: &mut RlpStream) {
        rlp.append(&self.nonce);
        rlp.append(&self.gas_price);
        rlp.append(&self.gas);
        if let Some(ref t) = self.to {
            rlp.append(t);
        } else {
            rlp.append(&vec![]);
        }
        rlp.append(&self.value);
        rlp.append(&self.data);
    }
}

 fn keccak(s: &[u8]) -> [u8; 32] {
    let mut result = [0u8; 32];
    tiny_keccak::Keccak::keccak256(s, &mut result);
    result
}

pub struct EcdsaSig {
    v: u64,
    r: Vec<u8>,
    s: Vec<u8>,
}

fn ecdsa_sign(hash: &[u8], private_key: &[u8], chain_id: u64) -> EcdsaSig {
    let s = Secp256k1::signing_only();
    let msg = Message::from_slice(hash).unwrap();
    let key = SecretKey::from_slice(private_key).unwrap();
    let (v, sig_bytes) = s.sign_recoverable(&msg, &key).serialize_compact();

    EcdsaSig {
        v: v.to_i32() as u64 + chain_id * 2 + 35,
        r: sig_bytes[0..32].to_vec(),
        s: sig_bytes[32..64].to_vec(),
    }
}


#[test]
fn pri_from_mnemonic_test() {
    let words = "pulp second side simple clinic step salad enact only mixed address paddle";
    pri_from_mnemonic(words,None);
}

#[test]
fn erc20_transfer_data_test() {
    let data = get_erc20_transfer_data("5A0b54D5dc17e0AadC383d2db43B0a0D3E029c4c","2000");
    println!("{:?}", data);
}

#[test]
fn eth_rawtx_sign_test(){

    let json = r#" {
            "nonce": "0x0",
            "gasPrice": "0x4a817c800",
            "gas": "0x5208",
            "to": "0x7b02dca46711be2664310f4fe322c8bd35a9bd2a",
            "value": "0xde0b6b3a7640000",
            "data": []
        }"#;
    let chain_id = Some(3);
    let mut rawtx : RawTransaction = serde_json::from_str(json).expect("tx format");
    let addition ="tx test";
    rawtx.data = addition.as_bytes().to_vec();

    let words = "pulp second side simple clinic step salad enact only mixed address paddle";
    let pri = pri_from_mnemonic(words,None).unwrap();
    let signed_data = rawtx.sign(&pri,chain_id);
    println!("signed data:{:?}",hex::encode(signed_data));
}
