use jni::JNIEnv;
use jni::objects::{JClass, JString, JObject, JValue};
use jni::sys::{jbyteArray, jint, jobject};
use wallets::{StatusCode};
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
pub extern "C" fn Java_info_scry_wallet_1manager_NativeLib_eeeEnergyTransfer(env: JNIEnv, _class: JClass,from: JString, pwd:jbyteArray, to:JString,value: JString, extend_msg: JString) -> jobject {
    let pwd = env.convert_byte_array(pwd).unwrap();

    let from: String = env.get_string(from).unwrap().into();
    let to: String = env.get_string(to).unwrap().into();
    let value: String = env.get_string(value).unwrap().into();
    let wallet_state_class = env.find_class("info/scry/wallet_manager/NativeLib$Message").expect("find wallet_state_class is error");
    let state_obj = env.alloc_object(wallet_state_class).expect("create wallet_state_class instance is error!");


    *state_obj
}
