use super::*;
use serde_json::Value;

use sp_core::{H256, crypto::{Pair, Ss58Codec}};

use frame_support::{storage::StorageMap};

use codec::Encode;
use node_runtime::{AccountId, Balance, Index, Signature};
use node_runtime::{Call, Runtime};
//use node_runtime::Indices;
//use sp_core::{crypto::Ss58Codec, ecdsa, ed25519, H256, Pair, sr25519};
use sp_core::{ ecdsa, ed25519, sr25519};
pub use sp_runtime::generic::{Era, SignedPayload, UncheckedExtrinsic};
pub use sp_runtime::traits::{IdentifyAccount, Verify};
use crate::wallet_crypto::Crypto;

//pub type Address = <Indices as StaticLookup>::Source;
pub type Address = AccountId;
type AccountPublic = <Signature as Verify>::Signer;
type SignatureOf<C> = <<C as Crypto>::Pair as Pair>::Signature;
type PublicOf<C> = <<C as Crypto>::Pair as Pair>::Public;
pub type UncheckedExtrinsicV4 = sp_runtime::generic::UncheckedExtrinsic<Address, Call, Signature, SignedExtra>;

trait SignatureT: AsRef<[u8]> + AsMut<[u8]> + Default {
    /// Converts the signature into a runtime account signature, if possible. If not possible, bombs out.
    fn into_runtime(self) -> Signature {
        panic!("This cryptography isn't supported for this runtime.")
    }
}

trait PublicT: Sized + AsRef<[u8]> + Ss58Codec {
    /// Converts the public key into a runtime account public key, if possible. If not possible, bombs out.
    fn into_runtime(self) -> AccountPublic {
        panic!("This cryptography isn't supported for this runtime.")
    }
}

impl SignatureT for sr25519::Signature { fn into_runtime(self) -> Signature { self.into() } }

impl SignatureT for ed25519::Signature { fn into_runtime(self) -> Signature { self.into() } }

impl SignatureT for ecdsa::Signature { fn into_runtime(self) -> Signature { self.into() } }

impl PublicT for sr25519::Public { fn into_runtime(self) -> AccountPublic { self.into() } }

impl PublicT for ed25519::Public { fn into_runtime(self) -> AccountPublic { self.into() } }

impl PublicT for ecdsa::Public { fn into_runtime(self) -> AccountPublic { self.into() } }

/// 签名验证过程中需要满足的条件
type SignedExtra = (
    system::CheckVersion<Runtime>,
    system::CheckGenesis<Runtime>,
    system::CheckEra<Runtime>,
    system::CheckNonce<Runtime>,
    system::CheckWeight<Runtime>,
    transaction_payment::ChargeTransactionPayment<Runtime>,
    pallet_contracts::CheckBlockGasLimit<Runtime>,//检查合约执行消耗的gas是否超过区块gas限制
);


/// 将Call方法使用调用者的密钥进行签名
///
 fn generate_signed_extrinsic<C: Crypto>(function: Call, index: Index, signer: C::Pair, genesis_hash: H256,version:u32) -> UncheckedExtrinsicV4 where PublicOf<C>: PublicT, SignatureOf<C>: SignatureT,
{
    let extra = |i: Index, f: Balance| {
        (
            system::CheckVersion::<Runtime>::new(),
            system::CheckGenesis::<Runtime>::new(),
            system::CheckEra::<Runtime>::from(Era::Immortal),
            system::CheckNonce::<Runtime>::from(i),
            system::CheckWeight::<Runtime>::new(),
            transaction_payment::ChargeTransactionPayment::<Runtime>::from(f),
            Default::default(),
        )
    };
    let raw_payload = SignedPayload::from_raw(
        function,
        extra(index, 0),
        (
            version,
            genesis_hash,
            genesis_hash,
            (),
            (),
            (),
            (),
        ),
    );
    let signature = raw_payload.using_encoded(|payload| signer.sign(payload)).into_runtime();
    let signer = signer.public().into_runtime();
    let (function, extra, _) = raw_payload.deconstruct();

    UncheckedExtrinsic::new_signed(
        function,
        signer.into_account().into(),
        signature,
        extra,
    )
}


pub fn genesis_hash(client: &mut Rpc) -> Hash {
    client
        .request::<Hash>("chain_getBlockHash", vec![json!(0 as u64)])
        .wait()
        .unwrap()
        .unwrap()
}

pub fn runtime_version(client: &mut Rpc)->u32{
    let version = client
        .request::<Value>("state_getRuntimeVersion", vec![])
        .wait()
        .unwrap()
        .unwrap();
    let spec_version = version.get("specVersion");
    if spec_version.is_none(){
        return 0;
    }else {
        return spec_version.unwrap().as_u64().unwrap() as u32;
    }

}

pub fn account_nonce(client: &mut Rpc, account_id: AccountId) -> u64 {
     let final_key = <system::Account<Runtime>>::hashed_key_for(account_id);
      let key = format!("0x{:}", HexDisplay::from(&final_key));
      let nonce = client
          .request::<Value>("state_getStorage", vec![json!(key)])
          .wait();
      let nonce =nonce.expect("get value from Result<Value> result");
      let nonce =nonce.expect("get value from Value result");
      if nonce.is_string() {
          let nonce = nonce.as_str().unwrap();
          println!("nonce is {}",nonce);
          let blob = hex::decode(&nonce[2..]).unwrap();
          let mut index_target =[0u8;8];
          {
            let temp = &mut index_target[0..4];
              temp.copy_from_slice(blob.as_slice());
          }
          let index = u64::from_le_bytes(index_target);
          index
      } else {
          0
      }
}

pub fn transfer(client: &mut Rpc, mnemonic: &str, to: &str, amount: &str) -> Result<String, String> {
    let signer = wallet_crypto::Sr25519::pair_from_phrase(mnemonic, None);
    let genesis_hash = genesis_hash(client);
    let signer_account_id = AccountId::from(signer.public().0);
    let index = account_nonce(client, signer_account_id);
    let amount = str::parse::<Balance>(amount).unwrap();
    let runtime_version = runtime_version(client);
    let to_account_id=  AccountId::from_ss58check(to).expect("Invalid 'to' ss58check");
 /*   sp_core::crypto::AccountId32*/
    //let function = Call::Balances(BalancesCall::transfer(pallet_indices::address::Address::Id(to_account_id), amount));
    let function = Call::Balances(BalancesCall::transfer(to_account_id, amount));
    let result = tx_sign(mnemonic, genesis_hash, index as u32, function,runtime_version);
    Ok(result)
}

pub fn tx_sign(mnemonic: &str, genesis_hash: H256, index: u32, function: Call,version:u32) -> String {
    let signer = wallet_crypto::Sr25519::pair_from_phrase(mnemonic, None);
    let extrinsic = generate_signed_extrinsic::<wallet_crypto::Sr25519>(function, index, signer, genesis_hash,version);
    let result = format!("0x{}", hex::encode(&extrinsic.encode()));
    result
}
