#![allow(non_upper_case_globals)]

use std::any::Any;
use std::ffi::{CStr, CString};
use std::mem::ManuallyDrop;
use std::os::raw::c_char;
use std::ptr::null_mut;

pub type CU64 = u64;
pub type CBool = u32;

pub const CFalse: CBool = 0u32;
pub const CTrue: CBool = 1u32;

/// call free_c_char to free memory
pub fn to_c_char(s: &str) -> *mut c_char {
    match CString::new(s) {
        Err(_e) => {
            null_mut()
        }
        Ok(cs) => cs.into_raw()
    }
}

/// free the memory that make by to_c_char or CString::into_raw
pub fn free_c_char(cs: &mut *mut c_char) {
    unsafe {
        if !cs.is_null() {
            CString::from_raw(*cs);
            *cs = null_mut(); //sure null
        }
    };
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
    ///返回当前是否为struct，用于解决多层raw指针时的内存释放问题
    fn is_struct(&self) -> bool {
        true
    }
}

/// 为类型 “*mut T”实现 trait CStruct, T要实现 trait CStruct， T 与 *mut T是两种不同的类型，所以要再实现一次
/// 注1：如果T为“*mut”类型，实际类型为“*mut *mut”，这时调用free方法时，要递归调用
/// 注2：如果rust支持泛型特化后，就可以不使用TypeId了，而使用下面注释的实现方式，高效且结构明确
impl<T: CStruct + Any> CStruct for *mut T {
    fn free(&mut self) {
        if !self.is_null() {
            unsafe {
                if !((**self).is_struct()) {
                    (**self).free();
                }
                if std::any::TypeId::of::<c_char>() == std::any::TypeId::of::<T>() {
                    free_c_char(&mut (*self as *mut c_char));
                } else {
                    Box::from_raw(*self);
                }
            }
            *self = null_mut();
        }
    }
    fn is_struct(&self) -> bool {
        false
    }
}

// impl fmt::Debug for *mut c_char{
//     fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
//         unimplemented!()
//     }
// }

// /// 为类型 “*mut c_char”实现 trait CStruct，因为现在rust还不支持泛型特化，所不支持
// impl CStruct for *mut c_char {
//     fn free(&mut self) {
//         free_c_char(self);
//     }
//     fn is_struct(&self) -> bool {
//         false
//     }
// }

//为所有需要 c <==> rust的原始类型实现 CStruct
macro_rules! promise_c_struct {
    ($t:ident) => {
        impl CStruct for $t {
            fn free(&mut self) {}
        }
    };
    ($t:ident,$($t2:ident),+) => {
        impl CStruct for $t {
            fn free(&mut self) {}
        }
        promise_c_struct!($($t2), +);
    };
}
promise_c_struct!(c_char, i32, i64, u32, u64, f32, f64);
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
        impl<$tt: crate::kits::CStruct> Drop for $t<$tt> {
            fn drop(&mut self) {
                self.free();
            }
        }
    };
}

pub trait CR<C: CStruct, R> {
    fn to_c(r: &R) -> C;

    fn to_c_ptr(r: &R) -> *mut C;

    fn to_rust(c: &C) -> R;

    fn ptr_rust(c: *mut C) -> R;
}

/// c的数组需要定义两个字段，所定义一个结构体进行统一管理
/// 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替
#[repr(C)]
#[derive(Debug)] //,DlStruct,DlDefault
pub struct CArray<T: CStruct> {
    ptr: *mut T,
    //数组指针，变量命名参考 rust Vec
    len: CU64,
    //数组长度，由于usize是不确定大小类型，在跨语言时不方便使用，所以使用u64类型
    cap: CU64, //数组的最大容量，由于usize是不确定大小类型，在跨语言时不方便使用，所以使用u64类型
}

impl<T: CStruct> CArray<T> {
    pub fn new(ar: Vec<T>) -> Self {
        //Vec::into_raw_parts 这个方法不是稳定方法，所以参考它手动实现
        let mut t = ManuallyDrop::new(ar);
        Self {
            len: t.len() as CU64,
            ptr: t.as_mut_ptr(),
            cap: t.capacity() as CU64,
        }
    }
    pub fn set(&mut self, ar: Vec<T>) {
        self.free(); //释放之前的内存

        //Vec::into_raw_parts 这个方法不是稳定方法，所以参考它手动实现
        let mut t = ManuallyDrop::new(ar);
        self.len = t.len() as CU64;
        self.ptr = t.as_mut_ptr();
        self.cap = t.capacity() as CU64;
    }

    pub fn get_mut(&mut self) -> &mut [T] {
        //from_raw_parts_mut 这个函数并不会获取所有权，所以它不会释放内存
        let p = unsafe { std::slice::from_raw_parts_mut(self.ptr, self.len as usize) };
        return p;
    }

    pub fn get(&self) -> &[T] {
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
                let mut v = Vec::from_raw_parts(self.ptr, self.len as usize, self.cap as usize);
                for it in v.iter_mut() {
                    if !((*it).is_struct()) {
                        (*it).free();
                    } else {
                        break;
                    }
                }
            }
        }
        self.len = 0;
        self.cap = 0;
        self.ptr = null_mut();
    }
}

impl<T: CStruct + CR<T, R>, R: Default> CR<CArray<T>, Vec<R>> for CArray<T> {
    fn to_c(r: &Vec<R>) -> CArray<T> {
        let mut c = Self::default();
        let temp = r.iter().map(|it| T::to_c(it)).collect();
        c.set(temp);
        c
    }

    fn to_c_ptr(r: &Vec<R>) -> *mut CArray<T> {
        Box::into_raw(Box::new(Self::to_c(r)))
    }

    fn to_rust(c: &CArray<T>) -> Vec<R> {
        let temp = c.get().iter().map(|it| T::to_rust(it)).collect();
        temp
    }

    fn ptr_rust(c: *mut CArray<T>) -> Vec<R> {
        Self::to_rust(unsafe { &*c })
    }
}

drop_ctype!(CArray<T>);


impl CR<*mut c_char, String> for *mut c_char {
    fn to_c(r: &String) -> *mut c_char {
        to_c_char(r)
    }

    fn to_c_ptr(r: &String) -> *mut *mut c_char {
        let t = d_ptr_alloc();
        unsafe { *t = to_c_char(r); }
        t
    }

    fn to_rust(c: &*mut c_char) -> String {
        to_str(*c).to_owned()
    }

    fn ptr_rust(c: *mut *mut c_char) -> String {
        to_str(unsafe { *c }).to_owned()
    }
}


pub fn d_ptr_alloc<T>() -> *mut *mut T {
    Box::into_raw(Box::new(null_mut()))
}

pub fn ptr_alloc<T: Default>() -> *mut T {
    Box::into_raw(Box::new(T::default()))
}
