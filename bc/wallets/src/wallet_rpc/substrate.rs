use super::*;
use serde_json::Value;

use codec::{Compact, Decode, Encode};
use node_runtime::{Runtime,SignedPayload,System,VERSION};
use sp_core::{sr25519, H256, blake2_256, crypto::{Pair, AccountId32 as AccountId, Ss58Codec}, twox_128};
use sp_runtime::{generic::Era,traits::StaticLookup};
use frame_support::{storage::StorageMap};

//use indices::In
pub fn genesis_hash(client: &mut Rpc) -> Hash {
    client
        .request::<Hash>("chain_getBlockHash", vec![json!(0 as u64)])
        .wait()
        .unwrap()
        .unwrap()
}

pub fn account_nonce(client: &mut Rpc, account_id: AccountId) -> u64 {
     let final_key = <system::AccountNonce<Runtime>>::hashed_key_for(account_id);
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
          //let index: Result<u64,_> = Decode::decode(&mut blob.as_slice());
          //index.expect("get index")
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
    println!("index:{}",index);
   let index =index;
  let to_account_id=  AccountId::from_ss58check(to).expect("Invalid 'to' ss58check");
    let function = Call::Balances(BalancesCall::transfer(pallet_indices::address::Address::Id(to_account_id), amount));
    let result = tx_sign(mnemonic, genesis_hash, index as u32, function);
    // println!("{}", result);
    Ok(result)
}

pub fn tx_sign(mnemonic: &str, genesis_hash: H256, index: u32, function: Call) -> String {
    let signer = wallet_crypto::Sr25519::pair_from_phrase(mnemonic, None);
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

   /* let raw_payload = (
        function,
        extra(index, 0),
        (VERSION.spec_version as u32, &genesis_hash, &genesis_hash),
    );*/
    println!(" VERSION.spec_version:{}", VERSION.spec_version);
    let raw_payload = SignedPayload::from_raw(
        function,
        extra(index, 0),
        (
            VERSION.spec_version as u32,
            genesis_hash,
            genesis_hash,
            (),
            (),
            (),
            (),
        ),
    );
   /* let signature = raw_payload.using_encoded(|payload| if payload.len() > 256 {
        signer.sign(&blake2_256(payload)[..])
    } else {
        println!("Signing {}", HexDisplay::from(&payload));
        signer.sign(payload)
    });*/
    let signature = raw_payload.using_encoded(|payload| signer.sign(payload));

   let signer_account_id= AccountId::from(signer.public().0);
    let (function, extra, _) = raw_payload.deconstruct();

    let extrinsic = UncheckedExtrinsic::new_signed(
        function,
        pallet_indices::address::Address::Id(signer_account_id),
        sp_runtime::MultiSignature::Sr25519(signature),
        extra,
    );
   /* let extrinsic = UncheckedExtrinsic::new_signed(
        raw_payload.0,
        pallet_indices::address::Address::Id(signer_account_id),
        signature.into(),
        extra(index as u32, 0),
    );*/
    let result = format!("0x{}", hex::encode(&extrinsic.encode()));
    result
}
