use std::os::raw::c_char;
use std::ffi::{CString, CStr};

// call Str_free to free memory
pub fn to_c_char(rs: &str) -> *mut c_char {
    let cstr = CString::new(rs).expect("Failed to create CString");
    return cstr.into_raw();
}

// do not free the cs's memory
pub fn to_str(cs: *mut c_char) -> &'static str {
    let cstr = unsafe {
        assert!(!cs.is_null()); //todo 别的方法处理
        CStr::from_ptr(cs)
    };
    return cstr.to_str().expect("Failed to create str");
}

#[allow(non_snake_case)]
pub fn Str_free(cs: *mut c_char) {
    unsafe {
        if !cs.is_null() {
            Box::from_raw(cs);
        }
    }
}

#[cfg(target_os = "android")]
pub fn init_logger_once() {
    android_logger::init_once(
        android_logger::Config::default()
            .with_min_level(log::Level::Trace) // limit log level
            .with_tag("rust") // logs will show under mytag tag
            .with_filter( // configure messages for specific crate
                          android_logger::FilterBuilder::new()
                              .parse("debug,hello::crate=error")
                              .build())
    );
    log::trace!("init logger");
}

