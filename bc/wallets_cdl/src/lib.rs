pub use kits::{CArray, CR, CStruct, CU64, to_c_char, to_str};

pub mod types;
mod types_btc;
mod types_eee;
mod types_eth;

pub mod mem_c;
pub mod parameters;
pub mod wallets_c;

pub mod chain_btc_c;
pub mod chain_eee_c;
pub mod chain_eth_c;

mod chain;
mod chain_btc;
mod chain_eee;
mod chain_eth;

pub mod kits;

// pub mod samples {
//     use std::os::raw::c_char;
//     use crate::{CArray,CStruct,CR,to_c_char,to_str};
//     use crate::kits::Assignment;
//     use wallets_macro::{DlCR, DlDefault, DlStruct};
//     use std::ptr::null_mut;
//
//     #[allow(non_snake_case)]
//     #[repr(C)]
//     #[derive(Debug, DlStruct, DlDefault, DlCR)]
//     pub struct CData2 {
//         len: u32,
//         name: *mut c_char,
//         list: CArray<*mut c_char>,
//     }
//     #[derive(Default)]
//     pub struct Data2 {
//         len: u32,
//         name: String,
//         list: Vec<String>,
//         more_field: String, //
//     }
//
//     #[no_mangle]
//     pub unsafe extern "C" fn Data2_new(
//         c_data: *mut CData2,
//     ) -> *mut  CData2{
//         let data_new: *mut CData2 = null_mut();
//         if c_data.is_null() {
//             return data_new;
//         }
//         let mut data2:Data2 = CData2::ptr_rust(c_data);
//         data2.name = "new".to_owned();
//
//         let c_ptr = CData2::to_c_ptr(data2);
//         return c_ptr;
//     }
//
//     #[test]
//     fn sample() {
//         //rust to c
//         let mut data = Data2::default();
//         data.name = "name".to_owned();
//         data.list.push("test".to_owned());
//
//         let c_data: CData2 = CData2::to_c(&data);
//         assert_eq!(data.len, c_data.len);
//         assert_eq!(data.name.as_str(), to_str(c_data.name));
//         {
//             let list: Vec<String> = CArray::to_rust(&c_data.list);
//             assert_eq!(data.list.len(), list.len());
//             assert_eq!(data.list, list);
//         }
//         let mut c: *mut CData2 = CData2::to_c_ptr(&data);
//         //c ro rust
//         let data2:Data2 = CData2::ptr_rust(c);
//         assert_eq!(data.len, data2.len);
//         assert_eq!(data.name, data2.name);
//         assert_eq!(data.list, data2.list);
//
//         c.free();
//         assert_eq!(c, null_mut());
//
//     }
// }
