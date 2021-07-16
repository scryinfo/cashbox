use ethereum_types::U64;
use serde_repr::*;

#[derive(Serialize_repr, Eq, Hash, Deserialize_repr, Debug, Copy, Clone, PartialEq)]
#[repr(u8)]
pub enum TypedTxId {
    EIP1559Transaction = 0x02,
    AccessList = 0x01,
    Legacy = 0x00,
}

impl TypedTxId {
    // used in json tets
    pub fn from_u8_id(n: u8) -> Option<Self> {
        match n {
            0 => Some(Self::Legacy),
            1 => Some(Self::AccessList),
            2 => Some(Self::EIP1559Transaction),
            _ => None,
        }
    }

    pub fn try_from_wire_byte(n: u8) -> Result<Self, ()> {
        match n {
            x if x == TypedTxId::EIP1559Transaction as u8 => Ok(TypedTxId::EIP1559Transaction),
            x if x == TypedTxId::AccessList as u8 => Ok(TypedTxId::AccessList),
            x if (x & 0x80) != 0x00 => Ok(TypedTxId::Legacy),
            _ => Err(()),
        }
    }

    #[allow(non_snake_case)]
    pub fn from_U64_option_id(n: Option<U64>) -> Option<Self> {
        match n.map(|t| t.as_u64()) {
            None => Some(Self::Legacy),
            Some(0x01) => Some(Self::AccessList),
            Some(0x02) => Some(Self::EIP1559Transaction),
            _ => None,
        }
    }

    #[allow(non_snake_case)]
    pub fn to_U64_option_id(self) -> Option<U64> {
        match self {
            Self::Legacy => None,
            _ => Some(U64::from(self as u8)),
        }
    }
}

impl Default for TypedTxId {
    fn default() -> TypedTxId {
        TypedTxId::Legacy
    }
}
