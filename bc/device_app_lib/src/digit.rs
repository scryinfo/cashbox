/// Expose the JNI interface for android below
#[cfg(target_os = "android")]
#[allow(non_snake_case)]
pub mod android {

    use jni::JNIEnv;
    use jni::objects::{JObject, JValue,JClass,JString};
    use wallets::model::{EeeChain,BtcChain,EthChain};
    use std::os::raw::{c_uchar, c_int};
    use jni::sys::{jobject,jint};
    use wallets::StatusCode;

    #[no_mangle]
    #[allow(non_snake_case)]
    pub unsafe extern "C" fn Java_info_scry_wallet_1manager_NativeLib_showDigit(env: JNIEnv, _: JClass, walletId: JString,chainId: JString,digitId: JString) -> jobject {
        let wallet_id: String = env.get_string(walletId).unwrap().into();
        let chain_id: String = env.get_string(chainId).unwrap().into();
        let digit_id: String = env.get_string(digitId).unwrap().into();

        let wallet_state_class = env.find_class("info/scry/wallet_manager/NativeLib$WalletState").expect("find NativeLib$WalletState");
        let state_obj = env.alloc_object(wallet_state_class).expect("create wallet_state_class instance ");
        match wallets::module::digit::show_digit(wallet_id.as_str(),chain_id.as_str(),digit_id.as_str()) {
            Ok(_code) => {
                env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::OK as i32)).expect("find status type");
                env.set_field(state_obj, "isShowDigit", "Z", JValue::Bool(1 as u8)).expect("showDigit value");
            },
            Err(msg) => {
                env.set_field(state_obj, "isShowDigit", "Z", JValue::Bool(0 as u8)).expect("showDigit value");
                env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(msg.to_string()).unwrap()))).expect("set error msg value ");
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

        let wallet_state_class = env.find_class("info/scry/wallet_manager/NativeLib$WalletState").expect("find wallet_state_class ");
        let state_obj = env.alloc_object(wallet_state_class).expect("create wallet_state_class instance ");
        match wallets::module::digit::hide_digit(wallet_id.as_str(),chain_id.as_str(),digit_id.as_str()) {
            Ok(_) => {
                env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::OK as i32)).expect("find status type ");
                env.set_field(state_obj, "isHideDigit", "Z", JValue::Bool(1 as u8)).expect("hideDigit value ");
            },
            Err(msg) => {
                env.set_field(state_obj, "isHideDigit", "Z", JValue::Bool(0 as u8)).expect("hideDigit value ");
                env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(msg.to_string()).unwrap()))).expect("set error msg value ");
            }
        }
        *state_obj
    }

    #[no_mangle]
    #[allow(non_snake_case)]
    pub unsafe extern "C" fn Java_info_scry_wallet_1manager_NativeLib_addDigit(env: JNIEnv, _: JClass, walletId:JString, chainId:JString,fullName:JString, shortName:JString, contractAddress:JString, decimal:jint) -> jobject{
        let wallet_id: String = env.get_string(walletId).unwrap().into();
        let chain_id: String = env.get_string(chainId).unwrap().into();
        let fullName: String = env.get_string(fullName).unwrap().into();
        let shortName: String = env.get_string(shortName).unwrap().into();
        let contractAddress: String = env.get_string(contractAddress).unwrap().into();
        //根据链类型转换对应的代币类型
        let digit = wallets::wallet_db::DigitExport{
            address: contractAddress,
            symbol: fullName,
            decimal: decimal as i64,
            digit_type:   if chain_id.eq("3") { "default".to_string()}else{"test".to_string()},
            url_img: None,
            short_name: Some(shortName),
        };

        let wallet_state_class = env.find_class("info/scry/wallet_manager/NativeLib$WalletState").expect("find wallet_state_class ");
        let state_obj = env.alloc_object(wallet_state_class).expect("create wallet_state_class instance ");
        match wallets::module::digit::add_wallet_digit(&wallet_id,&chain_id,digit){
            Ok(_) => {
                env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::OK as i32)).expect("find status type ");
                env.set_field(state_obj, "isAddDigit", "Z", JValue::Bool(1 as u8)).expect("showDigit value ");
            },
            Err(msg) => {
                env.set_field(state_obj, "isAddDigit", "Z", JValue::Bool(0 as u8)).expect("showDigit value ");
                env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(msg.to_string()).unwrap()))).expect("set error msg value ");
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

        let wallet_state_class = env.find_class("info/scry/wallet_manager/NativeLib$WalletState").expect("find wallet_state_class ");
        let state_obj = env.alloc_object(wallet_state_class).expect("create wallet_state_class instance ");
        match wallets::module::digit::update_balance(&address,&digitId,&balance){
            Ok(_)=>{
                env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::OK as i32)).expect("set status value ");
                env.set_field(state_obj, "isUpdateDigitBalance", "Z", JValue::Bool(1 as u8)).expect("showDigit value ");
            },
            Err(msg)=>{
                env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::DylibError as i32)).expect("set status value ");
                env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(msg.to_string()).unwrap()))).expect("set error msg value ");
            }
        }
        *state_obj
    }
}
