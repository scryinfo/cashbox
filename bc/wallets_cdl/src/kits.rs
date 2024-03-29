#![allow(non_upper_case_globals)]

use std::any::Any;
use std::ffi::{CStr, CString};
use std::mem::ManuallyDrop;
use std::os::raw::c_char;
use std::ptr::null_mut;

pub type CU64 = u64;
pub type CBool = u32;

pub const CFalse: CBool = mav::CFalse;
pub const CTrue: CBool = mav::CTrue;

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

/// do not free the cs's memory
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

/// c struct 与 rust struct之间的转换
pub trait CR<C: CStruct, R> {
    /// 从rust 到 c的转换
    fn to_c(r: &R) -> C;
    /// 从rust 到 c 指针（*mut C）的转换
    fn to_c_ptr(r: &R) -> *mut C;
    /// 从c到rust的转换
    fn to_rust(c: &C) -> R;
    /// 从c指针(*mut C)到rust的转换
    fn ptr_rust(c: *mut C) -> R;
}

/// c struct与rust struct赋值（由于rust不支持重载“=”，所以定义一个trait来实现）
pub trait Assignment<T> {
    //对C type赋值
    fn assignment_c(&mut self, other: &T);
    //对Rust type 赋值
    fn assignment_r(&self, other: &mut T);
}

/// u32之间赋值
impl Assignment<u32> for u32 {
    fn assignment_c(&mut self, other: &u32) {
        *self = *other;
    }

    fn assignment_r(&self, other: &mut u32) {
        *other = *self;
    }
}

/// u64之间赋值
impl Assignment<u64> for u64 {
    fn assignment_c(&mut self, other: &u64) {
        *self = *other;
    }

    fn assignment_r(&self, other: &mut u64) {
        *other = *self;
    }
}

/// i32之间赋值
impl Assignment<i32> for i32 {
    fn assignment_c(&mut self, other: &i32) {
        *self = *other;
    }

    fn assignment_r(&self, other: &mut i32) {
        *other = *self;
    }
}

/// i64之间赋值
impl Assignment<i64> for i64 {
    fn assignment_c(&mut self, other: &i64) {
        *self = *other;
    }

    fn assignment_r(&self, other: &mut i64) {
        *other = *self;
    }
}

/// c struct与rust struct之间赋值
impl<C: CStruct + CR<C, R>, R> Assignment<R> for C {
    fn assignment_c(&mut self, other: &R) {
        *self = C::to_c(other);
    }
    fn assignment_r(&self, other: &mut R) {
        *other = C::to_rust(self);
    }
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

/// d表示 指针的指针
pub fn d_ptr_alloc<T>() -> *mut *mut T {
    Box::into_raw(Box::new(null_mut()))
}

/// d表示 指针的指针
pub fn d_ptr_free<T: CStruct + Any>(d_ptr: &mut *mut *mut T) {
    (*d_ptr).free();
}

#[cfg(test)]
mod tests {
    use std::os::raw::c_char;
    use std::ptr::null_mut;

    use wallets_macro::{DlDefault, DlDrop, DlStruct};

    use crate::kits::{CArray, CStruct, d_ptr_alloc, d_ptr_free, to_c_char};

    #[allow(unused_assignments)]
    #[test]
    fn c_array() {
        #[derive(DlDrop)]
        struct Data {}
        impl CStruct for Data {
            fn free(&mut self) {}
        }
        // Vec::new();
        {
            //正常释放 default对象
            let mut da = CArray::<Data>::default();
            assert_eq!(null_mut(), da.ptr);
            assert_eq!(0, da.len);
            assert_eq!(0, da.cap);
            da.free();
            assert_eq!(null_mut(), da.ptr);
            assert_eq!(0, da.len);
            assert_eq!(0, da.cap);
        }
        {
            let mut da = CArray::<Data>::default();
            da.set(vec![Data {}, Data {}]);
            assert_ne!(null_mut(), da.ptr);
            assert_eq!(2, da.len);
            da.free();
            assert_eq!(null_mut(), da.ptr);
            assert_eq!(0, da.len);
            assert_eq!(0, da.cap);
        }
        {
            //验证在Array中的内存，会自动释放
            let mut ptr = null_mut();
            let mut pptr = &mut ptr as *mut _ as *mut *mut Data;
            {
                let mut da2 = CArray::<Data>::default();
                da2.set(vec![Data {}, Data {}]);
                pptr = &mut da2.ptr as *mut _ as *mut *mut Data;
            }
            unsafe {
                //pptr 使用已释放的内存，是非法操作，但是由于刚释放，正常情况下那个内存不会被再次分配，所以可以拿来检查
                ptr = *pptr;
                assert_eq!(null_mut(), ptr);
            }
        }
    }

    #[test]
    fn test_c_char() {
        let mut cs = to_c_char("test");
        cs.free();
        assert_eq!(null_mut(), cs);
    }

    #[test]
    fn d_ptr_free_test() {
        {
            //c_char
            let mut ptr: *mut c_char = null_mut();
            ptr.free();
            assert_eq!(null_mut(), ptr);
            let mut ptr = to_c_char("test c char");
            ptr.free();
            assert_eq!(null_mut(), ptr);
            let mut dptr: *mut *mut c_char = d_ptr_alloc();
            unsafe {
                *dptr = to_c_char("test2 c char");
            }
            d_ptr_free(&mut dptr);
            assert_eq!(null_mut(), dptr);
        }

        {
            //i32
            let mut ptr: *mut i32 = null_mut();
            ptr.free();
            assert_eq!(null_mut(), ptr);
            let mut ptr = Box::into_raw(Box::new(10i32));
            ptr.free();
            assert_eq!(null_mut(), ptr);
            let mut dptr: *mut *mut i32 = d_ptr_alloc();
            d_ptr_free(&mut dptr);
            assert_eq!(null_mut(), dptr);
            let mut dptr: *mut *mut i32 = d_ptr_alloc();
            unsafe {
                *dptr = Box::into_raw(Box::new(12i32));
            }
            d_ptr_free(&mut dptr);
            assert_eq!(null_mut(), dptr);
        }
        {
            //i64
            let mut ptr: *mut i64 = null_mut();
            ptr.free();
            assert_eq!(null_mut(), ptr);
            let mut ptr = Box::into_raw(Box::new(10i64));
            ptr.free();
            assert_eq!(null_mut(), ptr);
            let mut dptr: *mut *mut i64 = d_ptr_alloc();
            d_ptr_free(&mut dptr);
            assert_eq!(null_mut(), dptr);
            let mut dptr: *mut *mut i64 = d_ptr_alloc();
            unsafe {
                *dptr = Box::into_raw(Box::new(12i64));
            }
            d_ptr_free(&mut dptr);
            assert_eq!(null_mut(), dptr);
        }
        {
            //u32
            let mut ptr: *mut u32 = null_mut();
            ptr.free();
            assert_eq!(null_mut(), ptr);
            let mut ptr = Box::into_raw(Box::new(10u32));
            ptr.free();
            assert_eq!(null_mut(), ptr);
            let mut dptr: *mut *mut u32 = d_ptr_alloc();
            d_ptr_free(&mut dptr);
            assert_eq!(null_mut(), dptr);
            let mut dptr: *mut *mut u32 = d_ptr_alloc();
            unsafe {
                *dptr = Box::into_raw(Box::new(12u32));
            }
            d_ptr_free(&mut dptr);
            assert_eq!(null_mut(), dptr);
        }
        {
            //u64
            let mut ptr: *mut u64 = null_mut();
            ptr.free();
            assert_eq!(null_mut(), ptr);
            let mut ptr = Box::into_raw(Box::new(10u64));
            ptr.free();
            assert_eq!(null_mut(), ptr);
            let mut dptr: *mut *mut u64 = d_ptr_alloc();
            d_ptr_free(&mut dptr);
            assert_eq!(null_mut(), dptr);
            let mut dptr: *mut *mut u64 = d_ptr_alloc();
            unsafe {
                *dptr = Box::into_raw(Box::new(12u64));
            }
            d_ptr_free(&mut dptr);
            assert_eq!(null_mut(), dptr);
        }
        {
            //f32
            let mut ptr: *mut f32 = null_mut();
            ptr.free();
            assert_eq!(null_mut(), ptr);
            let mut ptr = Box::into_raw(Box::new(10f32));
            ptr.free();
            assert_eq!(null_mut(), ptr);
            let mut dptr: *mut *mut f32 = d_ptr_alloc();
            d_ptr_free(&mut dptr);
            assert_eq!(null_mut(), dptr);
            let mut dptr: *mut *mut f32 = d_ptr_alloc();
            unsafe {
                *dptr = Box::into_raw(Box::new(12f32));
            }
            d_ptr_free(&mut dptr);
            assert_eq!(null_mut(), dptr);
        }
        {
            //f64
            let mut ptr: *mut f64 = null_mut();
            ptr.free();
            assert_eq!(null_mut(), ptr);
            let mut ptr = Box::into_raw(Box::new(10f64));
            ptr.free();
            assert_eq!(null_mut(), ptr);
            let mut dptr: *mut *mut f64 = d_ptr_alloc();
            d_ptr_free(&mut dptr);
            assert_eq!(null_mut(), dptr);
            let mut dptr: *mut *mut f64 = d_ptr_alloc();
            unsafe {
                *dptr = Box::into_raw(Box::new(12f64));
            }
            d_ptr_free(&mut dptr);
            assert_eq!(null_mut(), dptr);
        }
        {
            // struct
            #[derive(Debug, DlStruct, DlDefault)]
            struct Data {
                pub name: String,
            }
            let mut ptr: *mut Data = null_mut();
            ptr.free();
            assert_eq!(null_mut(), ptr);
            let mut ptr = Box::into_raw(Box::new(Data {
                name: "struct name".to_owned(),
            }));
            ptr.free();
            assert_eq!(null_mut(), ptr);

            let mut dptr: *mut *mut Data = null_mut();
            d_ptr_free(&mut dptr);
            assert_eq!(null_mut(), dptr);

            let mut dptr: *mut *mut Data = d_ptr_alloc();
            d_ptr_free(&mut dptr);
            assert_eq!(null_mut(), dptr);

            let mut dptr: *mut *mut Data = d_ptr_alloc();
            unsafe {
                *dptr = Box::into_raw(Box::new(Data {
                    name: "name".to_owned(),
                }));
            }
            // let dpstr3 = dptr.clone();
            // let dpstr2 = (unsafe { *dptr }).clone();
            d_ptr_free(&mut dptr);
            assert_eq!(null_mut(), dptr);
        }
    }
}
