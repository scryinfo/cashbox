/*
use std::os::raw::{c_uchar, c_int};


#[no_mangle]
pub extern "C" fn mnemonicGenerate(count: c_int) -> *mut c_uchar {

    let mut mn = bc_service::module::wallet::crate_mnemonic::<bc_service::account_generate::Ed25519>(count as u8);

    return mn.mnid.as_mut_ptr();
}

/// Expose the JNI interface for android below
#[cfg(target_os = "android")]
#[allow(non_snake_case)]
pub mod android {
    use jni::JNIEnv;
    use jni::objects::{JClass, JString, JObject, JValue};
    use jni::sys::{jint, jobject, jbyteArray};
    #[no_mangle]
    pub unsafe extern "C" fn Java_info_scry_wallet_1manager_NativeLib_mnemonicGenerate(env: JNIEnv, _: JClass, count: jint) -> jobject {

    }
}*/
