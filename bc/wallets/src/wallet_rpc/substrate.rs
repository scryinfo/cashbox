use super::*;
use serde_json::Value;
use std::convert::Into;
use codec::{Compact, Decode, Encode};
use node_runtime::{Runtime,VERSION};
use substrate_primitives::{sr25519, crypto::{Pair, Ss58Codec}};
use sr_primitives::generic::Era;
use node_primitives::AccountId;
use srml_support::storage::StorageMap;

pub fn genesis_hash(client: &mut Rpc) -> Hash {
    client
        .request::<Hash>("chain_getBlockHash", vec![json!(0 as u64)])
        .wait()
        .unwrap()
        .unwrap()
}

pub fn account_nonce(client: &mut Rpc, account_id: &AccountId) -> u64 {
      let key = <system::AccountNonce<Runtime>>::key_for(account_id);
      let key = blake2_256(&key);
      let key = format!("0x{:}", HexDisplay::from(&key));

      let nonce = client
          .request::<Value>("state_getStorage", vec![json!(key)])
          .wait();
    let nonce =nonce.expect("get nonce 1");
    let nonce =nonce.expect("get nonce 2");
      if nonce.is_string() {
          let nonce = nonce.as_str().unwrap();
          println!("nonce is {}",nonce);
          let blob = hex::decode(&nonce[2..]).unwrap();
          let mut index_target =[0u8;8];
          {
            let temp = &mut index_target[0..4];
              temp.copy_from_slice(blob.as_slice());
          }
        //  index_target[0..4].copy_from_slice(blob.as_slice());
          let index = u64::from_le_bytes(index_target);
          //let index: Result<u64,_> = Decode::decode(&mut blob.as_slice());
          //index.expect("get index")
          index
      } else {
          0
      }
}

pub fn transfer(client: &mut Rpc, mnemonic: &str, to: &str, amount: &str) -> Result<String, String> {
    let extra = |i: Index, f: Balance| {
        (
            system::CheckVersion::<Runtime>::new(),
            system::CheckGenesis::<Runtime>::new(),
            system::CheckEra::<Runtime>::from(Era::Immortal),
            system::CheckNonce::<Runtime>::from(i),
            system::CheckWeight::<Runtime>::new(),
            balances::TakeFees::<Runtime>::from(f),
        )
    };

    //let signer = wallet_crypto::Sr25519::pair_from_suri("//Alice", None);
    let signer = wallet_crypto::Sr25519::pair_from_phrase(mnemonic, None);

    println!("pair detail:{}", signer.public());
    let from_pub = wallet_crypto::Sr25519::ss58_from_pair(&signer);
    println!("from_pub:{}", from_pub);
    let genesis_hash = genesis_hash(client);

    let index = account_nonce(client, &signer.public());
    let amount = str::parse::<Balance>(amount).unwrap();
  //  let index =index+1;
    let to = sr25519::Public::from_string(to).ok().or_else(||
        sr25519::Pair::from_string(to, None).ok().map(|p| p.public())
    ).expect("Invalid 'to' URI; expecting either a secret URI or a public URI.");

    let function = Call::Balances(BalancesCall::transfer(to.into(), amount));

    let raw_payload = (
        function,
        extra(index as u32, 0),
        (VERSION.spec_version as u32,&genesis_hash, &genesis_hash),
    );
    let signature = raw_payload.using_encoded(|payload| if payload.len() > 256 {
        signer.sign(&blake2_256(payload)[..])
    } else {
        println!("Signing {}", HexDisplay::from(&payload));
        signer.sign(payload)
    });
    let extrinsic = UncheckedExtrinsic::new_signed(
        raw_payload.0,
        signer.public().into(),
        signature.into(),
        extra(index as u32, 0),
    );
    let result = format!("0x{}", hex::encode(&extrinsic.encode()));
   // println!("{}", result);
    Ok(result)
}
