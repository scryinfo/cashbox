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
//! # Murmel Bitcoin node
//!
//! This library implements a Simplified Payment Verification (SPV) of Bitcoin
//!

#![deny(non_upper_case_globals)]
#![deny(non_camel_case_types)]
#![deny(non_snake_case)]
#![deny(unused_mut)]
#![deny(unused_must_use)]
#![allow(bare_trait_objects)]
#![allow(ellipsis_inclusive_range_patterns)]
#![allow(incomplete_include)]

mod headercache;
#[cfg(feature = "lightning")]
mod lightning;

pub mod bloomfilter;
pub mod broadcast;
pub mod chaindb;
pub mod constructor;
pub mod db;
pub mod dispatcher;
pub mod dns;
pub mod downstream;
pub mod error;
pub mod getdata;
pub mod headerdownload;
pub mod hooks;
pub mod api;
pub mod p2p;
pub mod ping;
pub mod timeout;
pub mod walletlib;
pub mod path;
mod kit;
pub mod satrt;

pub use error::Error;