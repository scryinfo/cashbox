#![allow(non_upper_case_globals)]

use std::ffi::{CStr, CString};
use std::mem::ManuallyDrop;
use std::os::raw::c_char;
use std::ptr::null_mut;

pub type CBool = u16;

pub const CFalse: CBool = 0;
pub const CTrue: CBool = 1;

pub type CU64 = u64;

pub const Success: CU64 = 0;

/// call free_c_char to free memory
pub fn to_c_char(s: &str) -> *mut c_char {
    let cs = CString::new(s).expect("Failed to create CString");
    return cs.into_raw();
}

/// free the memory that make by to_c_char or CString::into_raw
pub fn free_c_char(cs: &mut *mut c_char) {
    unsafe {
        if !cs.is_null() {
            CString::from_raw(*cs);
        }
    };
    *cs = null_mut();//sure null
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
        free_c_char(self);
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
    ptr: *mut T,
    //数组指针，变量命名参考 rust Vec
    len: CU64,
    //数组长度，由于usize是不确定大小类型，在跨语言时不方便使用，所以使用u64类型
    cap: CU64, //数组的最大容量，由于usize是不确定大小类型，在跨语言时不方便使用，所以使用u64类型
}

impl<T: CStruct> CArray<T> {
    pub fn set(&mut self, ar: Vec<T>) {
        self.free();//释放之前的内存

        //Vec::into_raw_parts 这个方法不是稳定方法，所以参考它手动实现
        let mut t = ManuallyDrop::new(ar);
        self.len = t.len() as CU64;
        self.ptr = t.as_mut_ptr();
        self.cap = t.capacity() as CU64;
    }

    pub fn get(&mut self) -> &mut [T] {
        //from_raw_parts_mut 这个函数并不会获取所有权，所以它不会释放内存
        let p = unsafe { std::slice::from_raw_parts_mut(self.ptr, self.len as usize) };
        return p;
    }
}

impl<T: CStruct> Default for CArray<T> {
    fn default() -> Self {
        CArray {
            ptr: null_mut(),
            len: 0,
            cap: 0,
        }
    }
}

impl<T: CStruct> CStruct for CArray<T> {
    fn free(&mut self) {
        unsafe {
            if (self.len > 0 || self.cap > 0) && !self.ptr.is_null() {
                Vec::from_raw_parts(self.ptr, self.len as usize, self.cap as usize);
            }
        }
        self.len = 0;
        self.cap = 0;
        self.ptr = null_mut();
    }
}

drop_ctype!(CArray<T>);

pub fn into_raw<T: CStruct>(obj: T) -> *mut T {
    Box::into_raw(Box::new(obj))
}

pub unsafe fn from_raw<T: CStruct>(ptr: *mut T) -> Box<T> {
    Box::from_raw(ptr)
}

#[cfg(test)]
mod tests {
    use crate::kits::{CArray, CStruct, to_c_char, free_c_char};
    use crate::types::CError;
    use std::ptr::null_mut;

    #[test]
    fn test_Array() {
        struct Data {}
        impl CStruct for Data {
            fn free(&mut self) {}
        }
        drop_ctype!(Data);
        // Vec::new();

        {//正常释放 default对象
            let mut da = CArray::<Data>::default();
            assert_eq!(null_mut(), da.ptr);
            assert_eq!(0,da.len);
            assert_eq!(0,da.cap);
            da.free();
            assert_eq!(null_mut(), da.ptr);
            assert_eq!(0,da.len);
            assert_eq!(0,da.cap);
        }
        {
            let mut da = CArray::<Data>::default();
            da.set(vec![Data{},Data{}]);
            assert_ne!(null_mut(), da.ptr);
            assert_eq!(2,da.len);
            da.free();
            assert_eq!(null_mut(), da.ptr);
            assert_eq!(0,da.len);
            assert_eq!(0,da.cap);
        }
        {//验证在Array中的内存，会自动释放
            let mut ptr = null_mut();
            let mut pptr = &mut ptr as *mut _ as *mut *mut Data;
            {
                let mut da2 = CArray::<Data>::default();
                da2.set(vec![Data {}, Data {}]);
                unsafe {
                    pptr  = &mut da2.ptr as *mut _ as *mut *mut Data;
                }
            }
            unsafe {
                //pptr 使用已释放的内存，是非法操作，但是由于刚释放，正常情况下那个内存不会被再次分配，所以可以拿来检查
                ptr = *pptr;
                assert_eq!(null_mut(), ptr);
            }
        }
    }
    #[test]
    fn test_c_char(){
        let mut cs = to_c_char("test");
        free_c_char(&mut cs);
        assert_eq!(null_mut(),cs);
    }
}