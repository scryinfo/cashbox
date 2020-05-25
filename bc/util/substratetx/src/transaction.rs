use super::*;
use codec::{Encode,Decode};
use node_runtime::{AccountId, Balance, Index, Signature,Call, Runtime,BalancesCall};
use sp_core::{
    H256,ecdsa, ed25519, sr25519,
    crypto::{Pair, Ss58Codec},
    hexdisplay::HexDisplay
};
pub use sp_runtime::{
    generic::{Era, SignedPayload, UncheckedExtrinsic},
    traits::{IdentifyAccount, Verify},
};
use frame_support::storage::{StorageMap,StorageValue};
use std::ops::Mul;
use crypto::Crypto;

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

pub fn transfer( mnemonic: &str, to: &str, amount: &str,genesis_hash: H256, index: u32,runtime_version:u32)-> Result<String, error::Error>{
    //todo 考虑将交易的生成与交易的签名分成两个步骤，在交易生成环节可以计算出当前交易所需要的手续费，提示用户针对这次转账共需要消耗多少balance?
    let to_account_id=  AccountId::from_ss58check(to)?;
   // let amount = str::parse::<Balance>(amount)?;
    let amount =  balance_unit_convert(amount,12).unwrap();
    //构造转账 call function
    let function = Call::Balances(BalancesCall::transfer(to_account_id, amount)).encode();
    //为了能够在签名时将数据解码出来，需要为function 计算对应的前缀
    let mut prefix = calculate_prefix(function.len());
    prefix.extend_from_slice(&function);

    let result = tx_sign(mnemonic, genesis_hash, index as u32, &prefix,runtime_version)?;
    Ok(result)
}

pub fn tx_sign(mnemonic: &str, genesis_hash: H256, index: u32, func_data:&[u8],version:u32) -> Result<String,error::Error> {
    let signer = crypto::Sr25519::pair_from_phrase(mnemonic, None)?;
    let extrinsic = node_runtime::UncheckedExtrinsic::decode(&mut &func_data[..])?;
    let extrinsic = generate_signed_extrinsic::<crypto::Sr25519>(extrinsic.function, index, signer, genesis_hash,version);
    let result = format!("0x{}", hex::encode(&extrinsic.encode()));
    Ok(result)
}

//TODO do该计算方法是通过数字找出来的规律，这样构造出来的数据 能够在链上验证，背后的理论知识还需要再去源码中查找！
fn calculate_prefix(func_len: usize) -> Vec<u8> {
    //交易版本号需要占一个字节
    let mut num = (func_len + 1).mul(4);
    let func_base_num = num;
    let mut add_num: usize = 0;
    while num > 255 {
        num = num >> 8;
        add_num = add_num + 1;
    }
    let mut prefix_vec = vec![];
    let num = func_base_num + add_num;
    let prefix_le_bytes: [u8; 8] = num.to_le_bytes();
    let zeros_num = (num.leading_zeros() / 8) as usize;
    prefix_vec.extend_from_slice(&prefix_le_bytes[0..8 - zeros_num]);
    prefix_vec.push(4u8);
    prefix_vec
}
//todo 处理转换失败的情况，将option 转换为result来表示
fn balance_unit_convert(amount:&str,decimal:usize) ->Option<u128>{
    match amount.find(".") {
        Some(index) => {
            let integer_part = amount.get(0..index).unwrap();
            //默认输入的数字在u128 表示的范围内
            let integer_part_data = str::parse::<Balance>(integer_part).unwrap();
            let integer_part_u128 = integer_part_data.checked_mul(10_u128.pow(decimal as u32)).unwrap();
            //获取小数部分，只保留指定精度部分数据
            //max_distace 用于截取小数部分的长度
            let max_distace = if amount.len() - index <= decimal {
                amount.len()
            } else {
                index + 1 + decimal
            };
            let decimal_part = amount.get((index + 1)..max_distace).unwrap();
            let decimal_part_data = str::parse::<Balance>(decimal_part).unwrap();
            //将小数点去掉后，还需要在末尾添加0的个数
            let add_zero = decimal - decimal_part.len();
            let base = 10_u128.pow(add_zero as u32);
            let decimal_part_u128 = decimal_part_data.checked_mul(base).unwrap();
            integer_part_u128.checked_add(decimal_part_u128)
        },
        None => {
            let amount = str::parse::<Balance>(amount).unwrap();
            amount.checked_mul(10_u128.pow(decimal as u32))
        }
    }
}

pub fn account_info_key(account_id:&str)->Result<String,error::Error>{
    let account_id=  AccountId::from_ss58check(account_id)?;
    let final_key =  <system::Account<Runtime>>::hashed_key_for(account_id);
    let key = format!("0x{:}", HexDisplay::from(&final_key));
    Ok(key)
}

pub fn event_key()->String{
    let final_key = <system::Events<Runtime>>::hashed_key();
     format!("0x{:}", HexDisplay::from(&final_key))
}

pub fn decode_account_info(info:&str)->Result<EeeAccountInfo,error::Error>{
    if !info.starts_with("0x") {
        return Err(error::Error::Custom("input data format error,please start with '0x'".to_string()))
    }
    let state_vec = hex::decode(info.get(2..).unwrap())?;
    let  state = system::AccountInfo::<Index,balances::AccountData<Balance>>::decode(&mut &state_vec.as_slice()[..])?;
    Ok(EeeAccountInfo{
        nonce:state.nonce,
        refcount:state.refcount as u32,
        free: state.data.free.to_string(),
        reserved: state.data.reserved.to_string(),
        misc_frozen: state.data.misc_frozen.to_string(),
        fee_frozen: state.data.fee_frozen.to_string()
    })
}

#[test]
fn balance_unit_convert_test() {
    println!("{:?}",balance_unit_convert("200.02",12));
}

#[test]
fn account_info_key_test(){
println!("{:?}",account_info_key("5FfBQ3kwXrbdyoqLPvcXRp7ikWydXawpNs2Ceu3WwFdhZ8W4"));
}

#[test]
fn decode_test(){
    let nonce = "0x0b00000000002ed2523097f2d21d02000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";

    let blob = hex::decode(&nonce[2..10]).unwrap();
    let mut index_target =[0u8;8];
    {
        let temp = &mut index_target[0..4];
        temp.copy_from_slice(blob.as_slice());
    }
    let index = u64::from_le_bytes(index_target);
    println!("{:?}",index);
}

#[test]
fn decode_account_info_test(){
    let state_str = "0x0b00000000002ed2523097f2d21d02000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
    let info = decode_account_info(state_str);
    println!("account info:{:?}",info);
}
