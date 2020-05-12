/// Expose the JNI interface for android below
#[cfg(target_os = "android")]
#[allow(non_snake_case)]
pub mod android {
    use jni::JNIEnv;
    use jni::objects::{JClass, JString, JObject, JValue};
    use jni::sys::{jbyteArray, jint,jobject};
    use wallets::StatusCode;
    #[no_mangle]
    #[allow(non_snake_case)]
    pub extern "C" fn Java_info_scry_wallet_1manager_NativeLib_eeeTxSign(env: JNIEnv, _class: JClass, rawTx:JString, walletId: JString, psd: jbyteArray) -> jobject {
        let pwd = env.convert_byte_array(psd).unwrap();
        let raw_tx:String = env.get_string(rawTx).unwrap().into();
        let wallet_id: String = env.get_string(walletId).unwrap().into();

        let wallet_state_class = env.find_class("info/scry/wallet_manager/NativeLib$Message").expect("find wallet_state_class is error");
        let state_obj = env.alloc_object(wallet_state_class).expect("create wallet_state_class instance is error!");
        match wallets::module::wallet::raw_tx_sign(&raw_tx,&wallet_id,pwd.as_slice()){
            Ok(data)=>{
                env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::OK as i32)).expect("set isSetNowWallet value is error!");
                env.set_field(state_obj, "signedInfo", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(data).unwrap()))).expect("set error msg value is error!");
            },
            Err(msg)=>{
                env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::PwdIsWrong as i32)).expect("set isSetNowWallet value is error!");
                env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(msg.to_string()).unwrap()))).expect("set error msg value is error!");
            }
        }
        *state_obj
    }

    #[no_mangle]
    #[allow(non_snake_case)]
    pub extern "C" fn Java_info_scry_wallet_1manager_NativeLib_eeeSign(env: JNIEnv, _class: JClass, rawTx:JString, walletId: JString, psd: jbyteArray) -> jobject {
        let pwd = env.convert_byte_array(psd).unwrap();
        let raw_tx:String = env.get_string(rawTx).unwrap().into();
        let wallet_id: String = env.get_string(walletId).unwrap().into();

        let wallet_state_class = env.find_class("info/scry/wallet_manager/NativeLib$Message").expect("find wallet_state_class is error");
        let state_obj = env.alloc_object(wallet_state_class).expect("create wallet_state_class instance is error!");
        match wallets::module::wallet::raw_sign(&raw_tx,&wallet_id,pwd.as_slice()){
            Ok(data)=>{
                env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::OK as i32)).expect("set isSetNowWallet value is error!");
                env.set_field(state_obj, "signedInfo", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(data).unwrap()))).expect("set error msg value is error!");
            },
            Err(msg)=>{
                env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::DylibError as i32)).expect("set eeeSign value is error!");
                env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(msg.to_string()).unwrap()))).expect("set error msg value is error!");
            }
        }
        *state_obj
    }

    #[no_mangle]
    #[allow(non_snake_case)]
    pub extern "C" fn Java_info_scry_wallet_1manager_NativeLib_eeeTransfer(env: JNIEnv, _class: JClass,from: JString, to:JString,value: JString,genesisHash:JString, index:jint, runtime_version:jint, pwd:jbyteArray) -> jobject {
        let pwd = env.convert_byte_array(pwd).unwrap();
        let from: String = env.get_string(from).unwrap().into();
        let genesis_hash: String = env.get_string(genesisHash).unwrap().into();
        let to: String = env.get_string(to).unwrap().into();
        let value: String = env.get_string(value).unwrap().into();
        let wallet_state_class = env.find_class("info/scry/wallet_manager/NativeLib$Message").expect("find wallet_state_class is error");
        let state_obj = env.alloc_object(wallet_state_class).expect("create wallet_state_class instance is error!");
        //  使用钱包方式来构造交易，用户交易index不会达到强制转换造成溢出的问题这个交易量
        match wallets::module::chain::eee_transfer(&from,&to,&value,&genesis_hash,index as u32,runtime_version as u32,pwd.as_slice()){
            Ok(data)=>{
                env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::OK as i32)).expect("set isSetNowWallet value is error!");
                env.set_field(state_obj, "signedInfo", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(data).unwrap()))).expect("set error msg value is error!");
            },
            Err(msg)=>{
                env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::PwdIsWrong as i32)).expect("set isSetNowWallet value is error!");
                env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(msg.to_string()).unwrap()))).expect("set error msg value is error!");
            }
        }
        *state_obj
    }
}


