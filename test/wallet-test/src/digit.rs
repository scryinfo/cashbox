use super::*;

use jni::JNIEnv;
use jni::objects::{JObject, JValue,JClass,JString};
use jni::sys::jobject;

#[no_mangle]
#[allow(non_snake_case)]
pub unsafe extern "C" fn Java_info_scry_wallet_1manager_NativeLib_showDigit(env: JNIEnv, _: JClass, walletId: JString,chainId: JString,digitId: JString) -> jobject {
    let wallet_id: String = env.get_string(walletId).unwrap().into();
    let chain_id: String = env.get_string(chainId).unwrap().into();
    let digit_id: String = env.get_string(digitId).unwrap().into();

    let wallet_state_class = env.find_class("info/scry/wallet_manager/NativeLib$WalletState").expect("find wallet_state_class is error");
    let state_obj = env.alloc_object(wallet_state_class).expect("create wallet_state_class instance is error!");
    match wallets::module::digit::show_digit(wallet_id.as_str(),chain_id.as_str(),digit_id.as_str()) {
        Ok(code) => {
            env.set_field(state_obj, "status", "I", JValue::Int(code as i32)).expect("find status type is error!");
            env.set_field(state_obj, "isShowDigit", "Z", JValue::Bool(1 as u8)).expect("showDigit value is error!");
        },
        Err(msg) => {
            env.set_field(state_obj, "isShowDigit", "Z", JValue::Bool(0 as u8)).expect("showDigit value is error!");
            env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(msg.to_string()).unwrap()))).expect("set error msg value is error!");
        }
    }
    *state_obj
}

#[no_mangle]
#[allow(non_snake_case)]
pub unsafe extern "C" fn Java_info_scry_wallet_1manager_NativeLib_hideDigit(env: JNIEnv, _: JClass, walletId: JString,chainId: JString,digitId: JString) -> jobject {
    let wallet_id: String = env.get_string(walletId).unwrap().into();
    let chain_id: String = env.get_string(chainId).unwrap().into();
    let digit_id: String = env.get_string(digitId).unwrap().into();

    let wallet_state_class = env.find_class("info/scry/wallet_manager/NativeLib$WalletState").expect("find wallet_state_class is error");
    let state_obj = env.alloc_object(wallet_state_class).expect("create wallet_state_class instance is error!");
    match wallets::module::digit::hide_digit(wallet_id.as_str(),chain_id.as_str(),digit_id.as_str()) {
        Ok(code) => {
            env.set_field(state_obj, "status", "I", JValue::Int(code as i32)).expect("find status type is error!");
            env.set_field(state_obj, "isHideDigit", "Z", JValue::Bool(1 as u8)).expect("showDigit value is error!");
        },
        Err(msg) => {
            env.set_field(state_obj, "isHideDigit", "Z", JValue::Bool(0 as u8)).expect("showDigit value is error!");
            env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(msg.to_string()).unwrap()))).expect("set error msg value is error!");
        }
    }
    *state_obj
}

#[no_mangle]
#[allow(non_snake_case)]
pub unsafe extern "C" fn Java_info_scry_wallet_1manager_NativeLib_updateDigitBalance(env: JNIEnv, _: JClass, address: JString,digitId: JString,balance: JString) -> jobject {
    let address: String = env.get_string(address).unwrap().into();
    let digitId: String = env.get_string(digitId).unwrap().into();
    let balance: String = env.get_string(balance).unwrap().into();
    let wallet_state_class = env.find_class("info/scry/wallet_manager/NativeLib$Message").expect("find NativeLib$Message is error");
    let state_obj = env.alloc_object(wallet_state_class).expect("create NativeLib$Message instance is error!");
    match wallets::module::digit::update_balance(&address,&digitId,&balance){
        Ok(data)=>{
            env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::OK as i32)).expect("set status value is error!");
        },
        Err(msg)=>{
            env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::DylibError as i32)).expect("set status value is error!");
            env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(msg.to_string()).unwrap()))).expect("set error msg value is error!");
        }
    }
    *state_obj
}
