use std::os::raw::{c_char, c_int};
use std::ffi::CStr;
use std::ptr::null_mut;

#[no_mangle]
pub extern "C" fn mnemonicGenerate(count : c_int )  -> *mut c_char {
    return null_mut();
}



/// Expose the JNI interface for android below
#[cfg(target_os="android")]
#[allow(non_snake_case)]
pub mod android {

    use super::*;
    use jni::JNIEnv;
    use jni::objects::{JClass, JString};
    use jni::sys::{jint, jlong};

    #[no_mangle]
    pub unsafe extern "C" fn Java_info_scry_wallet_Native_mnemonicGenerate(env: JNIEnv, _: JClass, count: jint) -> JString {
        let m = mnemonicGenerate(count);
        let r = env.new_string(m);
        r.unwrap()
    }
}


#[cfg(test)]
mod tests {
    #[test]
    fn it_works() {
        assert_eq!(2 + 2, 4);
    }
}
