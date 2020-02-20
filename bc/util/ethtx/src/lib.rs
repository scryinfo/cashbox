#[macro_use]
extern crate serde_derive;

use ethabi::Contract;
use std::convert::TryFrom;
use ethereum_types::{U256, H160};
use rlp::RlpStream;
use secp256k1::{key::SecretKey, Message, Secp256k1};

pub mod contract;
mod types;
mod error;

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

    fn encode_contract_input<P>(&self, method: &str, params: P) -> Result<String, String> where P: contract::tokens::Tokenize {
        let data = self.abi.function(method).and_then(|function| {
            for input in function.inputs.iter() {
                println!("{:?}", input);
            }
            function.encode_input(&params.into_tokens())
        });
        //let data = self.abi.unwrap().function(method).and_then(|function| function.encode_input(&params.into_tokens()));
        match data {
            Ok(bytes) => {
                Ok(hex::encode(bytes))
            }
            Err(err) => Err(err.to_string())
        }
    }
}
pub fn get_erc20_transfer_data(address:&str,value:u128)->Result<String,String>{
    let bytecode = include_bytes!("build/Erc20.abi");
    let helper = EthTxHelper::load(&bytecode[..]);
    //convert address to bytes
    let mut address_bytes = [0u8; 20];
    let mut index =0;
    if address.starts_with("0x") {
        index = 2;
    }
    //TODO 检查地址可能带来的错误
   // address.get(index).map(|Some(address_hex)|hex::decode(address_hex).map(|bytes| address_bytes.clone_from_slice(&bytes)));
    address_bytes.clone_from_slice(hex::decode(address.get(index.. ).unwrap()).unwrap().as_slice());
    let address = types::Address::try_from(address_bytes);
    helper.encode_contract_input("transfer", (address.unwrap(), value))
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

pub fn keccak(s: &[u8]) -> [u8; 32] {
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
fn env_test() {
    assert_eq!(2 + 2, 4);
}

#[test]
fn erc20_transfer_test() {
    /*let bytecode = include_bytes!("build/Erc20.abi");
    let helper = EthTxHelper::load(&bytecode[..]);
    let mut bytes = [0u8; 20];
    bytes.clone_from_slice(hex::decode("5A0b54D5dc17e0AadC383d2db43B0a0D3E029c4c").unwrap().as_slice());

    let address = types::Address::try_from(bytes);
    let data = helper.encode_contract_input("transfer", (address.unwrap(), 255u32));
    println!("{:?}", data);*/
    let data = get_erc20_transfer_data("5A0b54D5dc17e0AadC383d2db43B0a0D3E029c4c",2000);
    println!("{:?}", data);
}