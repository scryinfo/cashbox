use std::os::raw::{c_char,c_uchar,c_int};

#[no_mangle]
pub extern "C" fn mnemonicGenerate(count : c_int )  -> *mut c_uchar {
    let mut mn = bc_service::crate_mnemonic::<bc_service::account_crypto::Ed25519>(count as u8);

    return mn.mnid.as_mut_ptr();
}


/// Expose the JNI interface for android below
#[cfg(target_os="android")]
#[allow(non_snake_case)]
pub mod android {
    use super::*;
    use jni::JNIEnv;
    use jni::objects::{JClass, JObject, JValue};
    use jni::sys::{jint,jobject};

    #[no_mangle]
    pub unsafe extern "C" fn Java_info_scry_walletassist_NativeLib_mnemonicGenerate(env: JNIEnv, _: JClass, count: jint) -> jobject {
        let mnemonic = bc_service::crate_mnemonic::<bc_service::account_crypto::Ed25519>(count as u8);
        let mn_byte = env.byte_array_from_slice( mnemonic.mn.as_slice()).unwrap();
        let mn_object = JObject::from(mn_byte);
        let mnid = env.new_string(mnemonic.mnid).unwrap();

        let mn_class = env.find_class("info/scry/walletassist/NativeLib$Mnemonic");

        match mn_class {
            Ok(class)=>{
                let jobj = env.alloc_object(class).unwrap();
                env.set_field(jobj,"mnId","Ljava/lang/String;", JValue::Object(mn_id_obj) ).expect("find mnId type is error!");
                env.set_field(jobj,"status","I",JValue::Int(mnemonic.status as i32)).expect("find status type is error!");
                env.set_field(jobj,"mn","[B",JValue::Object(mn_object)).expect("find mn type is error!");
                *jobj

            },
            Err(err)=>{
                let exception = env.find_class("java/lang/Exception").unwrap();
              //  let err_info = mn_class.unwrap_err();
                env.throw_new(exception,err.to_string());

                let exception_object = env.byte_array_from_slice("calss not found".as_bytes()).unwrap();
                exception_object

            }
        }




       // 200
    }
}


#[cfg(test)]
mod tests {
    #[test]
    fn it_works() {
        assert_eq!(2 + 2, 4);
    }
}
