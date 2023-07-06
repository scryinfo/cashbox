use std::{cmp::min, ops::Deref};

use ethabi::Bytes;
use ethereum_types::{Address, BigEndianHash, H256, U256};
use parity_crypto::Keccak256;
use parity_crypto::publickey::{self, Public, recover, Signature};
use rlp::{self, DecoderError, Rlp, RlpStream};

use crate::{EcdsaSig, keccak};

use super::*;
use super::transaction_id::TypedTxId;

/// A `UnverifiedTransaction` with successfully recovered `sender`.
#[derive(Debug, Clone, Eq, PartialEq)]
pub struct SignedTransaction {
    transaction: UnverifiedTransaction,
    sender: Address,
    public: Option<Public>,
}

impl Deref for SignedTransaction {
    type Target = UnverifiedTransaction;
    fn deref(&self) -> &Self::Target {
        &self.transaction
    }
}

impl From<SignedTransaction> for UnverifiedTransaction {
    fn from(tx: SignedTransaction) -> Self {
        tx.transaction
    }
}

/// Convert public key into the address
pub fn public_to_address(public: &Public) -> Address {
    let hash = public.keccak256();
    let mut result = Address::zero();
    result.as_bytes_mut().copy_from_slice(&hash[12..]);
    result
}

impl SignedTransaction {
    // t_nb 5.3.1 Try to verify transaction and recover sender.
    pub fn new(transaction: UnverifiedTransaction) -> Result<Self, publickey::Error> {
        if transaction.is_unsigned() {
            return Err(publickey::Error::InvalidSignature);
        }
        let public = transaction.recover_public()?;
        let sender = public_to_address(&public);
        Ok(SignedTransaction {
            transaction,
            sender,
            public: Some(public),
        })
    }

    /// Returns transaction sender.
    pub fn sender(&self) -> Address {
        self.sender
    }

    /// Returns a public key of the sender.
    pub fn public_key(&self) -> Option<Public> {
        self.public
    }

    /// Checks is signature is empty.
    pub fn is_unsigned(&self) -> bool {
        self.transaction.is_unsigned()
    }

    /// Deconstructs this transaction back into `UnverifiedTransaction`
    pub fn deconstruct(self) -> (UnverifiedTransaction, Address, Option<Public>) {
        (self.transaction, self.sender, self.public)
    }

    pub fn rlp_append_list(s: &mut RlpStream, tx_list: &[SignedTransaction]) {
        s.begin_list(tx_list.len());
        for tx in tx_list.iter() {
            tx.unsigned.rlp_append(s, tx.chain_id, &tx.signature);
        }
    }
}


#[derive(Debug, Clone, Eq, PartialEq)]
pub enum TypedTransaction {
    Legacy(Transaction),
    // old legacy RLP encoded transaction
    AccessList(AccessListTx),
    // EIP-2930 Transaction with a list of addresses and storage keys that the transaction plans to access.
    // Accesses outside the list are possible, but become more expensive.
    EIP1559Transaction(EIP1559TransactionTx),
}

impl TypedTransaction {
    pub fn tx_type(&self) -> TypedTxId {
        match self {
            Self::Legacy(_) => TypedTxId::Legacy,
            Self::AccessList(_) => TypedTxId::AccessList,
            Self::EIP1559Transaction(_) => TypedTxId::EIP1559Transaction,
        }
    }

    /// The message hash of the transaction.
    pub fn signature_hash(&self, chain_id: Option<u64>) -> [u8; 32] {
        let data = match self {
            Self::Legacy(tx) => tx.encode(chain_id, None),
            Self::AccessList(tx) => tx.encode(chain_id, None),
            Self::EIP1559Transaction(tx) => tx.encode(chain_id, None)
        };
        crate::keccak(data.as_slice())
    }

    /// Signs the transaction as coming from `sender`.
    pub fn sign(self, private_key: &[u8], chain_id: Option<u64>) -> SignedTransaction {
        let sign_ret = crate::typed_tx_data_ecdsa_sign(&self.signature_hash(chain_id)[..], private_key);

        SignedTransaction::new(self.with_signature(sign_ret, chain_id))
            .expect("secret is valid so it's recoverable")
    }

    /// Signs the transaction with signature.
    pub fn with_signature(self, sig: EcdsaSig, chain_id: Option<u64>) -> UnverifiedTransaction {
        UnverifiedTransaction {
            unsigned: self,
            chain_id,
            signature: SignatureComponents {
                r: sig.r().into(),
                s: sig.s().into(),
                standard_v: sig.v().into(),
            },
            hash: H256::zero(),
        }
            .compute_hash()
    }

    /// Specify the sender; this won't survive the serialize/deserialize process, but can be cloned.
    pub fn fake_sign(self, from: Address) -> SignedTransaction {
        SignedTransaction {
            transaction: UnverifiedTransaction {
                unsigned: self,
                chain_id: None,
                signature: SignatureComponents {
                    r: U256::one(),
                    s: U256::one(),
                    standard_v: 4,
                },
                hash: H256::zero(),
            }
                .compute_hash(),
            sender: from,
            public: None,
        }
    }

    /// Legacy EIP-86 compatible empty signature.
    /// This method is used in json tests as well as
    /// signature verification tests.
    pub fn null_sign(self, chain_id: u64) -> SignedTransaction {
        SignedTransaction {
            transaction: UnverifiedTransaction {
                unsigned: self,
                chain_id: Some(chain_id),
                signature: SignatureComponents {
                    r: U256::zero(),
                    s: U256::zero(),
                    standard_v: 0,
                },
                hash: H256::zero(),
            }
                .compute_hash(),
            sender: UNSIGNED_SENDER,
            public: None,
        }
    }

    /// Useful for test incorrectly signed transactions.
    #[cfg(test)]
    pub fn invalid_sign(self) -> UnverifiedTransaction {
        UnverifiedTransaction {
            unsigned: self,
            chain_id: None,
            signature: SignatureComponents {
                r: U256::one(),
                s: U256::one(),
                standard_v: 0,
            },
            hash: H256::zero(),
        }
            .compute_hash()
    }

    // Next functions are for encoded/decode

    pub fn tx(&self) -> &Transaction {
        match self {
            Self::Legacy(tx) => tx,
            Self::AccessList(ocl) => ocl.tx(),
            Self::EIP1559Transaction(tx) => tx.tx(),
        }
    }

    pub fn tx_mut(&mut self) -> &mut Transaction {
        match self {
            Self::Legacy(tx) => tx,
            Self::AccessList(ocl) => ocl.tx_mut(),
            Self::EIP1559Transaction(tx) => tx.tx_mut(),
        }
    }

    pub fn access_list(&self) -> Option<&AccessList> {
        match self {
            Self::EIP1559Transaction(tx) => Some(&tx.transaction.access_list),
            Self::AccessList(tx) => Some(&tx.access_list),
            Self::Legacy(_) => None,
        }
    }

    pub fn effective_gas_price(&self, block_base_fee: Option<U256>) -> U256 {
        match self {
            Self::EIP1559Transaction(tx) => min(
                self.tx().gas_price,
                tx.max_priority_fee_per_gas + block_base_fee.unwrap_or_default(),
            ),
            Self::AccessList(_) => self.tx().gas_price,
            Self::Legacy(_) => self.tx().gas_price,
        }
    }

    pub fn max_priority_fee_per_gas(&self) -> U256 {
        match self {
            Self::EIP1559Transaction(tx) => tx.max_priority_fee_per_gas,
            Self::AccessList(tx) => tx.tx().gas_price,
            Self::Legacy(tx) => tx.gas_price,
        }
    }

    fn decode_new(tx: &[u8]) -> Result<UnverifiedTransaction, DecoderError> {
        if tx.is_empty() {
            // at least one byte needs to be present
            return Err(DecoderError::RlpIncorrectListLen);
        }
        let id = TypedTxId::try_from_wire_byte(tx[0]);
        if id.is_err() {
            return Err(DecoderError::Custom("Unknown transaction"));
        }
        // other transaction types
        match id.unwrap() {
            TypedTxId::EIP1559Transaction => EIP1559TransactionTx::decode(&tx[1..]),
            TypedTxId::AccessList => AccessListTx::decode(&tx[1..]),
            TypedTxId::Legacy => return Err(DecoderError::Custom("Unknown transaction legacy")),
        }
    }

    pub fn decode(tx: &[u8]) -> Result<UnverifiedTransaction, DecoderError> {
        if tx.is_empty() {
            // at least one byte needs to be present
            return Err(DecoderError::RlpIncorrectListLen);
        }
        let header = tx[0];
        // type of transaction can be obtained from first byte. If first bit is 1 it means we are dealing with RLP list.
        // if it is 0 it means that we are dealing with custom transaction defined in EIP-2718.
        if (header & 0x80) != 0x00 {
            Transaction::decode(&Rlp::new(tx))
        } else {
            Self::decode_new(tx)
        }
    }

    pub fn decode_rlp_list(rlp: &Rlp) -> Result<Vec<UnverifiedTransaction>, DecoderError> {
        if !rlp.is_list() {
            // at least one byte needs to be present
            return Err(DecoderError::RlpIncorrectListLen);
        }
        let mut output = Vec::with_capacity(rlp.item_count()?);
        for tx in rlp.iter() {
            output.push(Self::decode_rlp(&tx)?);
        }
        Ok(output)
    }

    pub fn decode_rlp(tx: &Rlp) -> Result<UnverifiedTransaction, DecoderError> {
        if tx.is_list() {
            //legacy transaction wrapped around RLP encoding
            Transaction::decode(tx)
        } else {
            Self::decode_new(tx.data()?)
        }
    }

    fn rlp_append(
        &self,
        s: &mut RlpStream,
        chain_id: Option<u64>,
        signature: &SignatureComponents,
    ) {
        match self {
            Self::Legacy(tx) => tx.rlp_append(s, chain_id, signature),
            Self::AccessList(opt) => opt.rlp_append(s, chain_id, signature),
            Self::EIP1559Transaction(tx) => tx.rlp_append(s, chain_id, signature),
        }
    }

    pub fn rlp_append_list(s: &mut RlpStream, tx_list: &[UnverifiedTransaction]) {
        s.begin_list(tx_list.len());
        for tx in tx_list.iter() {
            tx.unsigned.rlp_append(s, tx.chain_id, &tx.signature);
        }
    }

    fn encode(&self, chain_id: Option<u64>, signature: &SignatureComponents) -> Vec<u8> {
        let signature = Some(signature);
        match self {
            Self::Legacy(tx) => tx.encode(chain_id, signature),
            Self::AccessList(opt) => opt.encode(chain_id, signature),
            Self::EIP1559Transaction(tx) => tx.encode(chain_id, signature),
        }
    }
}

#[derive(Debug, Clone, Eq, PartialEq)]
pub struct AccessListTx {
    pub transaction: Transaction,
    //optional access list
    pub access_list: AccessList,
}


/// Transaction action type.
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum Action {
    /// Create creates new contract.
    Create,
    /// Calls contract at given address.
    /// In the case of a transfer, this is the receiver's address.'
    Call(Address),
}

impl Default for Action {
    fn default() -> Action {
        Action::Create
    }
}

impl rlp::Decodable for Action {
    fn decode(rlp: &Rlp) -> Result<Self, DecoderError> {
        if rlp.is_empty() {
            if rlp.is_data() {
                Ok(Action::Create)
            } else {
                Err(DecoderError::RlpExpectedToBeData)
            }
        } else {
            Ok(Action::Call(rlp.as_val()?))
        }
    }
}

impl rlp::Encodable for Action {
    fn rlp_append(&self, s: &mut RlpStream) {
        match *self {
            Action::Create => s.append_internal(&""),
            Action::Call(ref addr) => s.append_internal(addr),
        };
    }
}

/// A set of information describing an externally-originating message call
/// or contract creation operation.
#[derive(Default, Debug, Clone, PartialEq, Eq)]
pub struct Transaction {
    /// Nonce.
    pub nonce: U256,
    /// Gas price for non 1559 transactions. MaxFeePerGas for 1559 transactions.
    pub gas_price: U256,
    /// Gas paid up front for transaction execution.
    pub gas: U256,
    /// Action, can be either call or contract create.
    pub action: Action,
    /// Transfered value.s
    pub value: U256,
    /// Transaction data.
    pub data: Bytes,
}

impl Transaction {
    /// encode raw transaction
    fn encode(&self, chain_id: Option<u64>, signature: Option<&SignatureComponents>) -> Vec<u8> {
        let mut stream = RlpStream::new();
        self.encode_rlp(&mut stream, chain_id, signature);
        stream.out().to_vec()
    }

    pub fn rlp_append(
        &self,
        rlp: &mut RlpStream,
        chain_id: Option<u64>,
        signature: &SignatureComponents,
    ) {
        self.encode_rlp(rlp, chain_id, Some(signature));
    }

    fn encode_rlp(
        &self,
        rlp: &mut RlpStream,
        chain_id: Option<u64>,
        signature: Option<&SignatureComponents>,
    ) {
        let list_size = if chain_id.is_some() || signature.is_some() {
            9
        } else {
            6
        };
        rlp.begin_list(list_size);

        self.rlp_append_data_open(rlp);

        //append signature if given. If not, try to append chainId.
        if let Some(signature) = signature {
            signature.rlp_append_with_chain_id(rlp, chain_id);
        } else {
            if let Some(n) = chain_id {
                rlp.append(&n);
                rlp.append(&0u8);
                rlp.append(&0u8);
            }
        }
    }

    fn rlp_append_data_open(&self, s: &mut RlpStream) {
        s.append(&self.nonce);
        s.append(&self.gas_price);
        s.append(&self.gas);
        s.append(&self.action);
        s.append(&self.value);
        s.append(&self.data);
    }
    fn decode(d: &Rlp) -> Result<UnverifiedTransaction, DecoderError> {
        if d.item_count()? != 9 {
            return Err(DecoderError::RlpIncorrectListLen);
        }
        let hash = keccak(d.as_raw());

        let transaction = TypedTransaction::Legacy(Self::decode_data(d, 0)?);

        // take V from signatuere and decompose it into chain_id and standard V.
        let legacy_v: u64 = d.val_at(6)?;

        let signature = SignatureComponents {
            standard_v: signature::extract_standard_v(legacy_v),
            r: d.val_at(7)?,
            s: d.val_at(8)?,
        };
        Ok(UnverifiedTransaction::new(
            transaction,
            signature::extract_chain_id_from_legacy_v(legacy_v),
            signature,
            H256(hash),
        ))
    }

    fn decode_data(d: &Rlp, offset: usize) -> Result<Transaction, DecoderError> {
        Ok(Transaction {
            nonce: d.val_at(offset)?,
            gas_price: d.val_at(offset + 1)?,
            gas: d.val_at(offset + 2)?,
            action: d.val_at(offset + 3)?,
            value: d.val_at(offset + 4)?,
            data: d.val_at(offset + 5)?,
        })
    }
}

impl AccessListTx {
    pub fn new(transaction: Transaction, access_list: AccessList) -> AccessListTx {
        AccessListTx {
            transaction,
            access_list,
        }
    }

    pub fn tx_type(&self) -> TypedTxId {
        TypedTxId::AccessList
    }

    pub fn tx(&self) -> &Transaction {
        &self.transaction
    }

    pub fn tx_mut(&mut self) -> &mut Transaction {
        &mut self.transaction
    }

    // decode bytes by this payload spec: rlp([1, [chainId, nonce, gasPrice, gasLimit, to, value, data, access_list, senderV, senderR, senderS]])
    pub fn decode(tx: &[u8]) -> Result<UnverifiedTransaction, DecoderError> {
        let tx_rlp = &Rlp::new(tx);

        // we need to have 11 items in this list
        if tx_rlp.item_count()? != 11 {
            return Err(DecoderError::RlpIncorrectListLen);
        }

        let chain_id = Some(tx_rlp.val_at(0)?);
        //let chain_id = if chain_id == 0 { None } else { Some(chain_id) };

        // first part of list is same as legacy transaction and we are reusing that part.
        let transaction = Transaction::decode_data(&tx_rlp, 1)?;

        // access list we get from here
        let accl_rlp = tx_rlp.at(7)?;

        // access_list pattern: [[{20 bytes}, [{32 bytes}...]]...]
        let mut accl: AccessList = Vec::new();

        for i in 0..accl_rlp.item_count()? {
            let accounts = accl_rlp.at(i)?;

            // check if there is list of 2 items
            if accounts.item_count()? != 2 {
                return Err(DecoderError::Custom("Unknown access list length"));
            }
            accl.push((accounts.val_at(0)?, accounts.list_at(1)?));
        }

        // we get signature part from here
        let signature = SignatureComponents {
            standard_v: tx_rlp.val_at(8)?,
            r: tx_rlp.val_at(9)?,
            s: tx_rlp.val_at(10)?,
        };

        // and here we create UnverifiedTransaction and calculate its hash
        Ok(UnverifiedTransaction::new(
            TypedTransaction::AccessList(AccessListTx {
                transaction,
                access_list: accl,
            }),
            chain_id,
            signature,
            H256::zero(),
        )
            .compute_hash())
    }

    fn encode_payload(
        &self,
        chain_id: Option<u64>,
        signature: Option<&SignatureComponents>,
    ) -> RlpStream {
        let mut stream = RlpStream::new();

        let list_size = if signature.is_some() { 11 } else { 8 };
        stream.begin_list(list_size);

        // append chain_id. from EIP-2930: chainId is defined to be an integer of arbitrary size.
        stream.append(&(if let Some(n) = chain_id { n } else { 0 }));

        // append legacy transaction
        self.transaction.rlp_append_data_open(&mut stream);

        // access list
        stream.begin_list(self.access_list.len());
        for access in self.access_list.iter() {
            stream.begin_list(2);
            stream.append(&access.0);
            stream.begin_list(access.1.len());
            for storage_key in access.1.iter() {
                stream.append(storage_key);
            }
        }

        // append signature if any
        if let Some(signature) = signature {
            signature.rlp_append(&mut stream);
        }
        stream
    }

    // encode by this payload spec: 0x01 | rlp([1, [chain_id, nonce, gasPrice, gasLimit, to, value, data, access_list, senderV, senderR, senderS]])
    pub fn encode(
        &self,
        chain_id: Option<u64>,
        signature: Option<&SignatureComponents>,
    ) -> Vec<u8> {
        let stream = self.encode_payload(chain_id, signature);
        // make as vector of bytes
        [&[TypedTxId::AccessList as u8], stream.as_raw()].concat()
    }

    pub fn rlp_append(
        &self,
        rlp: &mut RlpStream,
        chain_id: Option<u64>,
        signature: &SignatureComponents,
    ) {
        rlp.append(&self.encode(chain_id, Some(signature)));
    }
}

#[derive(Debug, Clone, Eq, PartialEq)]
pub struct EIP1559TransactionTx {
    pub transaction: AccessListTx,
    pub max_priority_fee_per_gas: U256,
}


impl EIP1559TransactionTx {
    pub fn tx_type(&self) -> TypedTxId {
        TypedTxId::EIP1559Transaction
    }

    pub fn tx(&self) -> &Transaction {
        &self.transaction.tx()
    }

    pub fn tx_mut(&mut self) -> &mut Transaction {
        self.transaction.tx_mut()
    }

    // decode bytes by this payload spec: rlp([2, [chainId, nonce, maxPriorityFeePerGas, maxFeePerGas(gasPrice), gasLimit, to, value, data, access_list, senderV, senderR, senderS]])
    pub fn decode(tx: &[u8]) -> Result<UnverifiedTransaction, DecoderError> {
        let tx_rlp = &Rlp::new(tx);

        // we need to have 12 items in this list
        if tx_rlp.item_count()? != 12 {
            return Err(DecoderError::RlpIncorrectListLen);
        }

        let chain_id = Some(tx_rlp.val_at(0)?);

        let max_priority_fee_per_gas = tx_rlp.val_at(2)?;

        let tx = Transaction {
            nonce: tx_rlp.val_at(1)?,
            gas_price: tx_rlp.val_at(3)?, //taken from max_fee_per_gas
            gas: tx_rlp.val_at(4)?,
            action: tx_rlp.val_at(5)?,
            value: tx_rlp.val_at(6)?,
            data: tx_rlp.val_at(7)?,
        };

        // access list we get from here
        let accl_rlp = tx_rlp.at(8)?;

        // access_list pattern: [[{20 bytes}, [{32 bytes}...]]...]
        let mut accl: AccessList = Vec::new();

        for i in 0..accl_rlp.item_count()? {
            let accounts = accl_rlp.at(i)?;

            // check if there is list of 2 items
            if accounts.item_count()? != 2 {
                return Err(DecoderError::Custom("Unknown access list length"));
            }
            accl.push((accounts.val_at(0)?, accounts.list_at(1)?));
        }

        // we get signature part from here
        let signature = SignatureComponents {
            standard_v: tx_rlp.val_at(9)?,
            r: tx_rlp.val_at(10)?,
            s: tx_rlp.val_at(11)?,
        };

        // and here we create UnverifiedTransaction and calculate its hash
        Ok(UnverifiedTransaction::new(
            TypedTransaction::EIP1559Transaction(EIP1559TransactionTx {
                transaction: AccessListTx::new(tx, accl),
                max_priority_fee_per_gas,
            }),
            chain_id,
            signature,
            H256::zero(),
        )
            .compute_hash())
    }

    fn encode_payload(
        &self,
        chain_id: Option<u64>,
        signature: Option<&SignatureComponents>,
    ) -> RlpStream {
        let mut stream = RlpStream::new();

        let list_size = if signature.is_some() { 12 } else { 9 };
        stream.begin_list(list_size);

        // append chain_id. from EIP-2930: chainId is defined to be an integer of arbitrary size.
        stream.append(&(if let Some(n) = chain_id { n } else { 0 }));

        stream.append(&self.tx().nonce);
        stream.append(&self.max_priority_fee_per_gas);
        stream.append(&self.tx().gas_price);
        stream.append(&self.tx().gas);
        stream.append(&self.tx().action);
        stream.append(&self.tx().value);
        stream.append(&self.tx().data);

        // access list
        stream.begin_list(self.transaction.access_list.len());
        for access in self.transaction.access_list.iter() {
            stream.begin_list(2);
            stream.append(&access.0);
            stream.begin_list(access.1.len());
            for storage_key in access.1.iter() {
                stream.append(storage_key);
            }
        }

        // append signature if any
        if let Some(signature) = signature {
            signature.rlp_append(&mut stream);
        }
        stream
    }

    // encode by this payload spec: 0x02 | rlp([2, [chainId, nonce, maxPriorityFeePerGas, maxFeePerGas(gasPrice), gasLimit, to, value, data, access_list, senderV, senderR, senderS]])
    pub fn encode(
        &self,
        chain_id: Option<u64>,
        signature: Option<&SignatureComponents>,
    ) -> Vec<u8> {
        let stream = self.encode_payload(chain_id, signature);
        // make as vector of bytes
        [&[TypedTxId::EIP1559Transaction as u8], stream.as_raw()].concat()
    }

    pub fn rlp_append(
        &self,
        rlp: &mut RlpStream,
        chain_id: Option<u64>,
        signature: &SignatureComponents,
    ) {
        rlp.append(&self.encode(chain_id, Some(signature)));
    }
}


/// Replay protection logic for v part of transaction's signature
pub mod signature {
    /// Adds chain id into v
    pub fn add_chain_replay_protection(v: u8, chain_id: Option<u64>) -> u64 {
        v as u64
            + if let Some(n) = chain_id {
            35 + n * 2
        } else {
            27
        }
    }

    /// Returns refined v
    /// 0 if `v` would have been 27 under "Electrum" notation, 1 if 28 or 4 if invalid.
    pub fn extract_standard_v(v: u64) -> u8 {
        match v {
            v if v == 27 => 0,
            v if v == 28 => 1,
            v if v >= 35 => ((v - 1) % 2) as u8,
            _ => 4,
        }
    }

    pub fn extract_chain_id_from_legacy_v(v: u64) -> Option<u64> {
        if v >= 35 {
            Some((v - 35) / 2 as u64)
        } else {
            None
        }
    }
}


/// Components that constitute transaction signature
#[derive(Debug, Clone, Eq, PartialEq)]
pub struct SignatureComponents {
    /// The V field of the signature; the LS bit described which half of the curve our point falls
    /// in. It can be 0 or 1.
    pub standard_v: u8,
    /// The R field of the signature; helps describe the point on the curve.
    pub r: U256,
    /// The S field of the signature; helps describe the point on the curve.
    pub s: U256,
}

impl SignatureComponents {
    pub fn rlp_append(&self, s: &mut RlpStream) {
        s.append(&self.standard_v);
        s.append(&self.r);
        s.append(&self.s);
    }

    pub fn rlp_append_with_chain_id(&self, s: &mut RlpStream, chain_id: Option<u64>) {
        s.append(&signature::add_chain_replay_protection(
            self.standard_v,
            chain_id,
        ));
        s.append(&self.r);
        s.append(&self.s);
    }
}

/// Signed transaction information without verified signature.
#[derive(Debug, Clone, Eq, PartialEq)]
pub struct UnverifiedTransaction {
    /// Plain Transaction.
    pub unsigned: TypedTransaction,
    /// Transaction signature
    pub signature: SignatureComponents,
    /// chain_id recover from signature in legacy transaction. For TypedTransaction it is probably separate field.
    pub chain_id: Option<u64>,
    /// Hash of the transaction
    pub hash: H256,
}


impl Deref for UnverifiedTransaction {
    type Target = TypedTransaction;

    fn deref(&self) -> &Self::Target {
        &self.unsigned
    }
}

impl UnverifiedTransaction {
    pub fn rlp_append(&self, s: &mut RlpStream) {
        self.unsigned.rlp_append(s, self.chain_id, &self.signature);
    }

    pub fn rlp_append_list(s: &mut RlpStream, tx_list: &[UnverifiedTransaction]) {
        s.begin_list(tx_list.len());
        for tx in tx_list.iter() {
            tx.unsigned.rlp_append(s, tx.chain_id, &tx.signature);
        }
    }

    pub fn encode(&self) -> Vec<u8> {
        self.unsigned.encode(self.chain_id, &self.signature)
    }

    /// Used to compute hash of created transactions.
    pub fn compute_hash(mut self) -> UnverifiedTransaction {
        let hash = keccak(&*self.encode());
        self.hash = H256::from(hash);
        self
    }

    /// Used by TypedTransaction to create UnverifiedTransaction.
    fn new(
        transaction: TypedTransaction,
        chain_id: Option<u64>,
        signature: SignatureComponents,
        hash: H256,
    ) -> UnverifiedTransaction {
        UnverifiedTransaction {
            unsigned: transaction,
            chain_id,
            signature,
            hash,
        }
    }
    /// Checks if the signature is empty.
    pub fn is_unsigned(&self) -> bool {
        self.signature.r.is_zero() && self.signature.s.is_zero()
    }

    ///    Reference to unsigned part of this transaction.
    pub fn as_unsigned(&self) -> &TypedTransaction {
        &self.unsigned
    }

    /// Returns standardized `v` value (0, 1 or 4 (invalid))
    pub fn standard_v(&self) -> u8 {
        self.signature.standard_v
    }

    /// The legacy `v` value that contains signatures v and chain_id for replay protection.
    pub fn legacy_v(&self) -> u64 {
        signature::add_chain_replay_protection(self.signature.standard_v, self.chain_id)
    }

    /// The `v` value that appears in the RLP.
    pub fn v(&self) -> u64 {
        match self.unsigned {
            TypedTransaction::Legacy(_) => self.legacy_v(),
            _ => self.signature.standard_v as u64,
        }
    }

    /// The chain ID, or `None` if this is a global transaction.
    pub fn chain_id(&self) -> Option<u64> {
        self.chain_id
    }

    /// Construct a signature object from the sig.
    pub fn signature(&self) -> Signature {
        let r: H256 = BigEndianHash::from_uint(&self.signature.r);
        let s: H256 = BigEndianHash::from_uint(&self.signature.s);
        let mut sig = [0u8; 65];
        sig[0..32].copy_from_slice(r.as_ref());
        sig[32..64].copy_from_slice(s.as_ref());
        sig[64] = self.standard_v();
        Signature::from(sig)
        // Signature::from_rsv(&r, &s, self.standard_v())
    }

    /// Checks whether the signature has a low 's' value.
    pub fn check_low_s(&self) -> Result<(), publickey::Error> {
        if !self.signature().is_low_s() {
            Err(publickey::Error::InvalidSignature.into())
        } else {
            Ok(())
        }
    }

    /// Get the hash of this transaction (keccak of the RLP).
    pub fn hash(&self) -> H256 {
        self.hash
    }

    /// Recovers the public key of the sender.
    pub fn recover_public(&self) -> Result<Public, publickey::Error> {
        Ok(recover(
            &self.signature(),
            &publickey::Message::from_slice(&self.unsigned.signature_hash(self.chain_id())[..]),
        )?)
    }
}