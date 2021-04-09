use sp_std::prelude::*;

#[cfg(feature = "std")]
use std::fmt;
use codec::{Compact, Decode, Encode, Error, Input};

use sp_core::{blake2_256,H256,};
use sp_runtime::{generic::Era, MultiSignature,AccountId32 as AccountId};

pub type AccountIndex = u64;
pub type GenericAddress =AccountId; // crate::multiaddress::MultiAddress<AccountId, ()>

/// Simple generic extra mirroring the SignedExtra currently used in extrinsics. Does not implement
/// the SignedExtension trait. It simply encodes to the same bytes as the real SignedExtra. The
/// Order is (CheckVersion, CheckGenesis, Check::Era, CheckNonce, CheckWeight, transactionPayment::ChargeTransactionPayment).
/// This can be locked up in the System module. Fields that are merely PhantomData are not encoded and are
/// therefore omitted here.
#[cfg_attr(feature = "std", derive(Debug))]
#[derive(Decode, Encode, Clone, Eq, PartialEq)]
pub struct GenericExtra(Era, Compact<u32>, Compact<u128>);

impl GenericExtra {
    pub fn new(era: Era, nonce: u32) -> GenericExtra {
        GenericExtra(era, Compact(nonce), Compact(0_u128))
    }
   pub fn get_nonce(&self)->u32{
        self.1.0
    }
}

impl Default for GenericExtra {
    fn default() -> Self {
        Self::new(Era::Immortal, 0)
    }

}

/// additionalSigned fields of the respective SignedExtra fields.
/// Order is the same as declared in the extra.
pub type AdditionalSigned = (u32, u32, H256, H256, (), (), ());

#[derive(Encode, Clone)]
pub struct SignedPayload<Call>((Call, GenericExtra, AdditionalSigned));

impl<Call> SignedPayload<Call>
where
    Call: Encode,
{
    pub fn from_raw(call: Call, extra: GenericExtra, additional_signed: AdditionalSigned) -> Self {
        Self((call, extra, additional_signed))
    }

    /// Get an encoded version of this payload.
    ///
    /// Payloads longer than 256 bytes are going to be `blake2_256`-hashed.
    pub fn using_encoded<R, F: FnOnce(&[u8]) -> R>(&self, f: F) -> R {
        self.0.using_encoded(|payload| {
            if payload.len() > 256 {
                let hash = blake2_256(payload);
                f(&hash[..])
            } else {
                f(payload)
            }
        })
    }
}

/// Mirrors the currently used Extrinsic format (V3) from substrate. Has less traits and methods though.
/// The SingedExtra used does not need to implement SingedExtension here.
#[derive(Clone, PartialEq)]
pub struct UncheckedExtrinsicV4<Call> {
    pub signature: Option<(GenericAddress, MultiSignature, GenericExtra)>,
    pub function: Call,
}

impl<Call> UncheckedExtrinsicV4<Call>
where
    Call: Encode,
{
    pub fn new_signed(
        function: Call,
        signed: GenericAddress,
        signature: MultiSignature,
        extra: GenericExtra,
    ) -> Self {
        UncheckedExtrinsicV4 {
            signature: Some((signed, signature, extra)),
            function,
        }
    }

    #[cfg(feature = "std")]
    pub fn hex_encode(&self) -> String {
        let mut hex_str = hex::encode(self.encode());
        hex_str.insert_str(0, "0x");
        hex_str
    }
}

#[cfg(feature = "std")]
impl<Call> fmt::Debug for UncheckedExtrinsicV4<Call>
where
    Call: fmt::Debug,
{
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(
            f,
            "UncheckedExtrinsic({:?}, {:?})",
            self.signature.as_ref().map(|x| (&x.0, &x.2)),
            self.function
        )
    }
}

const V4: u8 = 4;

impl<Call> Encode for UncheckedExtrinsicV4<Call>
where
    Call: Encode,
{
    fn encode(&self) -> Vec<u8> {
        encode_with_vec_prefix::<Self, _>(|v| {
            match self.signature.as_ref() {
                Some(s) => {
                    v.push(V4 | 0b1000_0000);
                    s.encode_to(v);
                }
                None => {
                    v.push(V4 & 0b0111_1111);
                }
            }
            self.function.encode_to(v);
        })
    }
}

impl<Call> Decode for UncheckedExtrinsicV4<Call>
where
    Call: Decode + Encode,
{
    fn decode<I: Input>(input: &mut I) -> Result<Self, Error> {
        // This is a little more complicated than usual since the binary format must be compatible
        // with substrate's generic `Vec<u8>` type. Basically this just means accepting that there
        // will be a prefix of vector length (we don't need
        // to use this).
        let _length_do_not_remove_me_see_above: Vec<()> = Decode::decode(input)?;

        let version = input.read_byte()?;

        let is_signed = version & 0b1000_0000 != 0;
        let version = version & 0b0111_1111;
        if version != V4 {
            return Err("Invalid transaction version".into());
        }

        Ok(UncheckedExtrinsicV4 {
            signature: if is_signed {
                Some(Decode::decode(input)?)
            } else {
                None
            },
            function: Decode::decode(input)?,
        })
    }
}
#[derive(Debug)]
pub struct RawExtrinsic {
   pub module_index:u8,
   pub call_index:u8,
   pub args:Vec<u8>,
}

#[derive(Debug)]
pub struct CheckedExtrinsic{
    pub signature: Option<(GenericAddress, MultiSignature, GenericExtra)>,
    pub function: RawExtrinsic,
}
/// Mirrors the currently used Extrinsic format from substrate UncheckedExtrinsicV4. Has less traits and methods though.
/// The SingedExtra used does not need to implement SingedExtension here.
/// Construct a data format that meets the requirements of the chain through transactions constructed by external methods.
#[derive(Clone, PartialEq)]
pub struct UncheckedExtrinsicFromOuter{
    pub signature: Option<(GenericAddress, MultiSignature, GenericExtra)>,
    pub function: Vec<u8>,
}
impl UncheckedExtrinsicFromOuter
{
    pub fn new_signed(
        function: Vec<u8>,
        signed: GenericAddress,
        signature: MultiSignature,
        extra: GenericExtra,
    ) -> Self {
        UncheckedExtrinsicFromOuter {
            signature: Some((signed, signature, extra)),
            function,
        }
    }
    #[cfg(feature = "std")]
    pub fn hex_encode(&self) -> String {
        let mut hex_str = hex::encode(self.encode());
        hex_str.insert_str(0, "0x");
        hex_str
    }
}

#[cfg(feature = "std")]
impl fmt::Debug for UncheckedExtrinsicFromOuter
{
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(
            f,
            "UncheckedExtrinsic({:?}, {:?})",
            self.signature.as_ref().map(|x| (&x.0, &x.2)),
            self.function
        )
    }
}

impl Encode for UncheckedExtrinsicFromOuter
{
    fn encode(&self) -> Vec<u8> {
        encode_with_vec_prefix::<Self, _>(|v| {
            match self.signature.as_ref() {
                Some(s) => {
                    v.push(V4 | 0b1000_0000);
                    s.encode_to(v);
                }
                None => {
                    v.push(V4 & 0b0111_1111);
                }
            }
            let func_len = self.function.len();
            let func_encode_vec = self.function.encode();
            let offset_start = func_encode_vec.len()-func_len;
            v.extend_from_slice(&func_encode_vec[offset_start..]);
        })
    }
}

impl Decode for CheckedExtrinsic
{
    fn decode<I: Input>(input: &mut I) -> Result<Self, Error> {
        // This is a little more complicated than usual since the binary format must be compatible
        // with substrate's generic `Vec<u8>` type. Basically this just means accepting that there
        // will be a prefix of vector length (we don't need
        // to use this).
        let _length_do_not_remove_me_see_above: Vec<()> = Decode::decode(input)?;
        let version = input.read_byte()?;

        let is_signed = version & 0b1000_0000 != 0;
        let version = version & 0b0111_1111;
        if version != V4 {
            return Err("Invalid transaction version".into());
        }

        let  sig =  if is_signed {
            let sig : (GenericAddress, MultiSignature, GenericExtra) = Decode::decode(input)?;
            Some(sig)
        }else {
            None
        };

        let module_index = input.read_byte()?;
        let call_index = input.read_byte()?;
        let len = input.remaining_len().unwrap().unwrap();
        let mut func_args = vec![0u8;len];
        input.read( &mut func_args)?;
      //  func_args.clone_from_slice(input.);
        let raw_tx = RawExtrinsic{
            module_index,
            call_index,
            args: func_args
        };
        let checked_tx = CheckedExtrinsic{
            signature:sig,
            function:raw_tx,
        };
        Ok(checked_tx)
    }
}

pub fn get_func_prefix_len(func_data:&[u8])->usize{
    let len = match func_data.len(){
        1..=0b0100_0000 => 1,//1-64 real func data range is 0-63
        0b0100_0010..=0b0100_0000_0000_0001 => 2,// 66-(2**14+1)  real func data range is 64-(2**14-1)
        _ => 4,
    };
    // prefix = array length + version code
    len+1
}

/// Same function as in primitives::generic. Needed to be copied as it is private there.
fn encode_with_vec_prefix<T: Encode, F: Fn(&mut Vec<u8>)>(encoder: F) -> Vec<u8> {
    let size = sp_std::mem::size_of::<T>();
    let reserve = match size {
        0..=0b0011_1111 => 1,
        0b0100_0000..=0b0011_1111_1111_1111 => 2,
        _ => 4,
    };
    let mut v = Vec::with_capacity(reserve + size);
    v.resize(reserve, 0);
    encoder(&mut v);

    // need to prefix with the total length to ensure it's binary compatible with
    // Vec<u8>.
    let mut length: Vec<()> = Vec::new();
    length.resize(v.len() - reserve, ());
    length.using_encoded(|s| {
        v.splice(0..reserve, s.iter().cloned());
    });

    v
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::extrinsic::xt_primitives::{GenericAddress, GenericExtra};
    use sp_runtime::MultiSignature;

    #[test]
    fn encode_decode_roundtrip_works() {
        let xt = UncheckedExtrinsicV4::new_signed(
            vec![1, 1, 1],
            GenericAddress::default(),
            MultiSignature::default(),
            GenericExtra::default(),
        );

        let xt_enc = xt.encode();
        assert_eq!(xt, Decode::decode(&mut xt_enc.as_slice()).unwrap())
    }
}
