//
// Copyright 2018-2019 Tamas Blummer
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//!
//! # Murmel Error
//!
//! All modules of this library use this error class to indicate problems.
//!

use bitcoin::consensus::encode;
use bitcoin::util;
use bitcoin::util::bip158;
use hammersbald;
use std::fmt;
use std::io;

/// An error class to offer a unified error interface upstream
pub enum Error {
    /// the block's work target is not correct
    SpvBadTarget,
    /// bad proof of work
    SpvBadProofOfWork,
    /// unconnected header chain detected
    UnconnectedHeader,
    /// no chain tip found
    NoTip,
    /// no peers to connect to
    NoPeers,
    /// unknown UTXO referred
    UnknownUTXO,
    /// Merkle root of block does not match the header
    BadMerkleRoot,
    /// downstream error
    Downstream(String),
    /// Network IO error
    IO(io::Error),
    /// Bitcoin util error
    Util(util::Error),
    /// Bitcoin serialize error
    Serialize(encode::Error),
    /// Hammersbald error
    Hammersbald(hammersbald::Error),
    /// Handshake failure
    Handshake,
    /// lost connection
    Lost(String),
    /// bitcoin_hashes error
    BitcoinHash(bitcoin_hashes::hex::Error),
    /// rbatis error
    Rbatis(rbatis::Error),
}

impl std::error::Error for Error {
    fn source(&self) -> Option<&(dyn std::error::Error + 'static)> {
        match *self {
            Error::SpvBadTarget => None,
            Error::SpvBadProofOfWork => None,
            Error::UnconnectedHeader => None,
            Error::NoTip => None,
            Error::NoPeers => None,
            Error::UnknownUTXO => None,
            Error::Downstream(_) => None,
            Error::BadMerkleRoot => None,
            Error::IO(ref err) => Some(err),
            Error::Util(ref err) => Some(err),
            Error::Hammersbald(ref err) => Some(err),
            Error::Serialize(ref err) => Some(err),
            Error::Handshake => None,
            Error::Lost(_) => None,
            Error::BitcoinHash(ref err) => Some(err),
            Error::Rbatis(ref err) => Some(err),
        }
    }
}

impl fmt::Display for Error {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match *self {
            Error::SpvBadTarget => write!(f, "bad proof of work target"),
            Error::SpvBadProofOfWork => write!(f, "bad proof of work"),
            Error::UnconnectedHeader => write!(f, "unconnected header"),
            Error::NoTip => write!(f, "no chain tip found"),
            Error::UnknownUTXO => write!(f, "unknown utxo"),
            Error::NoPeers => write!(f, "no peers"),
            Error::BadMerkleRoot => {
                write!(f, "merkle root of header does not match transaction list")
            }
            Error::Handshake => write!(f, "handshake"),
            Error::Lost(ref s) => write!(f, "lost connection: {}", s),
            Error::Downstream(ref s) => write!(f, "downstream error: {}", s),
            // The underlying errors already impl `Display`, so we defer to their implementations.
            Error::IO(ref err) => write!(f, "IO error: {}", err),
            Error::Util(ref err) => write!(f, "Util error: {}", err),
            Error::Hammersbald(ref err) => write!(f, "Hammersbald error: {}", err),
            Error::Serialize(ref err) => write!(f, "Serialize error: {}", err),
            Error::BitcoinHash(ref err) => write!(f, "bitcoin_hashes::hex::Error {}", err),
            Error::Rbatis(ref err) => {
                write!(f, "rbatis::Error {}", err)
            }
        }
    }
}

impl fmt::Debug for Error {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        (self as &dyn fmt::Display).fmt(f)
    }
}

impl From<Error> for io::Error {
    fn from(err: Error) -> io::Error {
        match err {
            Error::IO(e) => e,
            _ => io::Error::new(io::ErrorKind::Other, err.to_string()),
        }
    }
}

impl From<io::Error> for Error {
    fn from(err: io::Error) -> Error {
        Error::IO(err)
    }
}

impl From<util::Error> for Error {
    fn from(err: util::Error) -> Error {
        Error::Util(err)
    }
}

impl From<hammersbald::Error> for Error {
    fn from(err: hammersbald::Error) -> Error {
        Error::Hammersbald(err)
    }
}

impl From<encode::Error> for Error {
    fn from(err: encode::Error) -> Error {
        Error::Serialize(err)
    }
}

impl From<Box<dyn std::error::Error>> for Error {
    fn from(err: Box<dyn std::error::Error>) -> Self {
        Error::Downstream(err.to_string())
    }
}

impl From<bip158::Error> for Error {
    fn from(err: bip158::Error) -> Self {
        match err {
            bip158::Error::Io(io) => Error::IO(io),
            bip158::Error::UtxoMissing(_) => Error::UnknownUTXO,
        }
    }
}

impl From<bitcoin_hashes::hex::Error> for Error {
    fn from(err: bitcoin_hashes::hex::Error) -> Self {
        Error::BitcoinHash(err)
    }
}

impl From<rbatis::Error> for Error {
    fn from(err: rbatis::Error) -> Self {
        Error::Rbatis(err)
    }
}