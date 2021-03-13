use std::os::raw::c_char;
use std::ffi::{CString, CStr};
use std::ptr::null_mut;
use std::any::Any;

/// free the memory that make by to_c_char or CString::into_raw
pub fn free_c_char(cs: &mut *mut c_char) {
    unsafe {
        if !cs.is_null() {
            CString::from_raw(*cs);
            *cs = null_mut(); //sure null
        }
    };
}

// call Str_free to free memory
pub fn to_c_char(rs: &str) -> *mut c_char {
    let cstr = CString::new(rs).expect("Failed to create CString");
    return cstr.into_raw();
}

// do not free the cs's memory
pub fn to_str<'a>(cs: *const c_char) -> &'a str {
    if cs.is_null(){
        ""
    }else{
        unsafe { CStr::from_ptr(cs).to_str().expect("Failed to create str") }
    }
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

impl CStruct for *mut i32{
    fn free(&mut self) {
        if !self.is_null(){
            unsafe { Box::from_raw(*self); }
            *self = null_mut();
        }
    }
    fn is_struct(&self) -> bool {
        false
    }
}

// impl CStruct for *mut c_char{
//     fn free(&mut self) {
//         if !self.is_null(){
//             free_c_char(self);
//         }
//     }
//     fn is_struct(&self) -> bool {
//         false
//     }
// }

pub fn d_ptr_alloc<T>() -> *mut *mut T {
    Box::into_raw(Box::new(null_mut()))
}

pub fn d_ptr_free<T: CStruct + Any>(d_ptr: &mut *mut *mut T) {
    (*d_ptr).free();
}