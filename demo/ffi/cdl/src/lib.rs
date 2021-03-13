use std::os::raw::{
    c_char, c_int, c_ulonglong,
};

use crate::kits::{CStruct, to_str, to_c_char};
use std::ffi::CString;

mod kits;

pub type CBool = u32;
#[allow(non_upper_case_globals)]
pub const CFalse: CBool = 0u32;
#[allow(non_upper_case_globals)]
pub const CTrue: CBool = 1u32;
pub fn is_true(b:CBool) ->bool{
    b != CFalse
}

#[no_mangle]
pub extern "C" fn add(a: c_int, b: c_int) -> c_int {
    return a + b;
}

#[no_mangle]
pub unsafe extern "C" fn multi_i32(v: *mut *mut i32) -> u32 {
    if v.is_null() {
        return CFalse;
    }
    (*v).free();
    // 释放 *v 的内存
    let re = Box::into_raw(Box::new(1));
    *v = re;
    CTrue
}


//调用函数Str_free 释放内存返回的字符
#[no_mangle]
pub extern "C" fn addStr(cs: *mut c_char) -> *mut c_char {
    let s = to_str(cs);
    return to_c_char((s.to_owned() + " 测试").as_str());
}

//释放由动态库分配的内存
#[no_mangle]
pub extern "C" fn Str_free(cs: *mut c_char) {
    unsafe {
        if !cs.is_null() {
            CString::from_raw(cs);
        }
    };
}



// struct

#[no_mangle]
pub extern "C" fn Data_new() -> *mut Data {
    // let mut new_d = unsafe {//直接分配内存时，不能很好的初始化分配的对象
    //     Box::from_raw(std::alloc::alloc(std::alloc::Layout::new::<Data>()) as *mut Data)
    // };

    // let mut new_d = unsafe {//直接分配内存时，不能很好的初始化分配的对象
    //     Box::from_raw(std::alloc::alloc_zeroed(std::alloc::Layout::new::<Data>()) as *mut Data)
    // };

    // see https://stackoverflow.com/questions/31502597/do-values-in-return-position-always-get-allocated-in-the-parents-stack-frame-or/31506225#31506225
    // box的语法可能会被编译器优化，而不会产生 stack上的对象
    let mut new_d = Box::new(Data::default());

    new_d.intType = 10;
    new_d.charType = to_c_char("test 测试");

    {
        let mut v = vec![1, 2];
        new_d.arrayIntLength = v.len() as c_ulonglong;
        new_d.arrayInt = v.as_mut_ptr();
        std::mem::forget(v);
    }
    {
        let mut v = vec![Data::default(), Data::default()];
        v[0].intType = 1;
        v[1].intType = 2;
        new_d.arrayDataLength = v.len() as c_ulonglong;
        new_d.arrayData = v.as_mut_ptr();
        std::mem::forget(v);
    }
    {
        let mut d = Box::new(Data::default());
        d.intType = 3;
        new_d.pointData = Box::into_raw(d);
    }

    let ptr = Box::into_raw(new_d);

    return ptr;
}

#[no_mangle]
pub extern "C" fn Data_free(cd: *mut Data) {
    if !cd.is_null() {
        unsafe { Box::from_raw(cd); }// it will call the function "drop"
    }
}

#[no_mangle]
pub extern "C" fn Data_use(cd: *mut Data) -> *mut Data {
    let d = unsafe {
        Box::from_raw(cd)
    };
    let mut ps = unsafe {
        Box::from_raw(d.pointData)
    };
    ps.intType = 1;
    // d.bBool = true;
    // d.pBool = Box::into_raw(Box::new(true));
    std::mem::forget(d);//不要释放 由外转入的指针
    std::mem::forget(ps);//不要释放 由外转入的指针
    return cd;
}

#[allow(non_snake_case)]
#[repr(C)]
#[derive(Clone)]
pub struct Data {
    pub intType: c_int,
    pub charType: *mut c_char,

    pub arrayInt: *mut c_int,
    pub arrayIntLength: c_ulonglong,

    pub arrayData: *mut Data,
    pub arrayDataLength: c_ulonglong,

    pub pointData: *mut Data,

    // pub bBool: bool,
    // pub intType2: c_int,
    // pub pBool: *mut bool,

}

impl Default for Data {
    fn default() -> Self {
        Data {
            intType: Default::default(),
            charType: std::ptr::null_mut(),
            arrayInt: std::ptr::null_mut(),
            arrayIntLength: 0,
            arrayData: std::ptr::null_mut(),
            arrayDataLength: 0,
            pointData: std::ptr::null_mut(),
            // bBool:false,
            // intType2:22,
            // pBool: std::ptr::null_mut(),
        }
    }
}

impl Drop for Data {
    fn drop(&mut self) {
        unsafe {
            Str_free(self.charType);

            if self.arrayIntLength > 0 && !self.arrayInt.is_null() {
                let p = std::slice::from_raw_parts_mut(self.arrayInt, self.arrayIntLength as usize);
                Box::from_raw(p.as_mut_ptr());//free memory
            }
            if self.arrayDataLength > 0 && !self.arrayData.is_null() {
                let p = std::slice::from_raw_parts_mut(self.arrayData, self.arrayDataLength as usize);
                Box::from_raw(p.as_mut_ptr());
            }
            if !self.pointData.is_null() {
                Box::from_raw(self.pointData);
            }

            // if !self.pBool.is_null() {
            //     Box::from_raw(self.pBool);
            // }
        }
    }
}

// struct end


#[cfg(test)]
mod tests {
    use crate::{add, addStr, to_c_char, to_str, Str_free, Data_new, Data_free, multi_i32};
    use std::ptr::null;
    use crate::kits::{d_ptr_alloc, CStruct};
    use std::os::raw::c_char;

    #[test]
    fn test_add() {
        assert_eq!(add(2, 1), 3);
    }

    #[test]
    fn test_str() {
        let s = to_c_char("str");
        let rs = addStr(s);
        Str_free(s);// s alloc by to_c_char, so free memory
        let news = to_str(rs);
        assert_eq!("str 测试".to_string(), news.to_string());
        Str_free(rs);//rs alloc by str, so free memory
    }

    #[test]
    fn test_struct() {
        let s = unsafe { Box::from_raw(Data_new()) };
        assert_eq!(10, s.intType);
        assert_eq!("test 测试", to_str(s.charType));
        unsafe {
            let ints = std::slice::from_raw_parts_mut(s.arrayInt, s.arrayIntLength as usize);
            assert_eq!(ints.len(), s.arrayIntLength as usize);
            assert_eq!(vec![1, 2], ints);
            //以下这行代码不需要，因为from_raw_parts_mut返回的对象不会释放内存
            // std::mem::forget(ints);//不要释放内存
        }
        unsafe {
            let datas = std::slice::from_raw_parts_mut(s.arrayData, s.arrayDataLength as usize);
            assert_eq!(datas.len(), s.arrayDataLength as usize);
            assert_eq!(1, datas[0].intType);
            assert_eq!(2, datas[1].intType);
            //以下这行代码不需要，因为from_raw_parts_mut返回的对象不会释放内存
            // std::mem::forget(datas);//不要释放内存
        }
        unsafe {
            let data = Box::from_raw(s.pointData);
            assert_eq!(3, data.intType);
            std::mem::forget(data);//不要释放内存
            // Box::into_raw(data); 这个方法与上面的效果是一样的
        }
        Data_free(Box::into_raw(s));//这里已经执行 into_raw了，所以不需要再调用 下面的 forget
        // std::mem::forget(s);//内存由Data_new函数内分配，要使用Data_free释放内存
    }

    #[test]
    fn test_multi_return() {
        unsafe {
            let re: *mut *mut i32 = d_ptr_alloc();
            assert_eq!(null(), *re);
            let _ = multi_i32(re);
            assert_eq!(1, **re);

            let mut pp: *mut *mut c_char = d_ptr_alloc();
            pp.free();

            let mut pp: *mut *mut c_char = d_ptr_alloc();
            *pp = to_c_char("test");
            pp.free();
        }
    }

}
