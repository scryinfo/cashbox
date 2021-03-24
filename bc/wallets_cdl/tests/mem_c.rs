use std::os::raw::c_char;
use std::ptr::null_mut;

use wallets_cdl::{CR, to_c_char};
use wallets_cdl::kits::CArray;
use wallets_cdl::mem_c::{CArrayCChar_dAlloc, CArrayCChar_dFree};

// run with valgrind to check the memory
#[test]
fn array_char_test() {
    unsafe {
        let mut ptr = CArrayCChar_dAlloc();
        CArrayCChar_dFree(ptr);
        // assert_eq!(null_mut(), *ptr);
        ptr = null_mut();
        CArrayCChar_dFree(ptr);

        {
            let _a = CArray::<*mut c_char>::default();
        }

        {
            let mut a = CArray::<*mut c_char>::default();
            let ss = vec![to_c_char("test"), null_mut()];
            a.set(ss);
            let ss = vec![to_c_char("test"), null_mut()];
            a.set(ss);
        }

        let ss = vec!["test2".to_owned(), "".to_owned()];

        let ptr = CArrayCChar_dAlloc();
        *ptr = CArray::<*mut c_char>::to_c_ptr(&ss);
        CArrayCChar_dFree(ptr);
    }
}