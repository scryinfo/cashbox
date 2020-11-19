#![allow(non_upper_case_globals)]

pub type CBool = u16;

pub const CFalse: CBool = 0;
pub const CTrue: CBool = 1;

pub type CU64 = u64;

pub const Success: CU64 = 0;

use std::os::raw::c_char;
use std::ptr::null_mut;
use std::ffi::{CString, CStr};

/// call free_c_char to free memory
pub fn to_c_char(s: &str) -> *mut c_char {
    let cs = CString::new(s).expect("Failed to create CString");
    return cs.into_raw();
}

/// free the memory that make by to_c_char or CString::into_raw
pub fn free_c_char(mut cs: *mut c_char) {
    unsafe {
        if !cs.is_null() {
            CString::from_raw(cs);
        }
    };
    cs = null_mut();//sure null
}

// do not free the cs's memory
pub fn to_str(cs: *const c_char) -> &'static str {
    let s = unsafe {
        if cs.is_null() {
            ""
        } else {
            CStr::from_ptr(cs).to_str().expect("Failed to create str")
        }
    };
    return s;
}


/// 释放c struct的内存， 这些内存需要手工管理
pub trait CStruct {
    fn free(&mut self);
}

/// 为类型 “*mut T”实现 trait CType, T要实现 trait CType， T 与 *mut T是两种不同的类型，所以要再实现一次
impl<T: CStruct> CStruct for *mut T {
    fn free(&mut self) {
        if !self.is_null() {
            unsafe {
                Box::from_raw(*self);
            }
        }
        *self = null_mut();
    }
}

/// 为类型 “*mut c_char”实现 trait CType
impl CStruct for *mut c_char {
    fn free(&mut self) {
        free_c_char(*self);
        *self = null_mut();
    }
}

/// 实现drop, 要求实现 trait CStruct
#[macro_export]
macro_rules! drop_ctype {
    ($t:ident) => {
        impl Drop for $t {
            fn drop(&mut self) {
                self.free();
            }
        }
    };
    ($t:ident<$tt:tt>) => {
        impl<$tt:crate::kits::CStruct> Drop for $t<$tt> {
            fn drop(&mut self) {
                self.free();
            }
        }
    }
}

/// c的数组需要定义两个字段，所定义一个结构体进行统一管理
/// 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替
#[repr(C)]
#[derive(Debug, Clone)]
pub struct CArray<T: CStruct> {
    pub ptr: *mut T,
    pub len: CU64,
}

impl<T: CStruct> Default for CArray<T> {
    fn default() -> Self {
        CArray {
            ptr: null_mut(),
            len: 0,
        }
    }
}

impl<T: CStruct> CStruct for CArray<T> {
    fn free(&mut self) {
        self.ptr.free();
    }
}

drop_ctype!(CArray<T>);