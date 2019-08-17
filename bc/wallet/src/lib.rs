use std::os::raw::{c_char, c_uchar, c_int};

#[no_mangle]
pub extern "C" fn mnemonicGenerate(count: c_int) -> *mut c_uchar {
    let mut mn = bc_service::crate_mnemonic::<bc_service::account_crypto::Ed25519>(count as u8);

    return mn.mnid.as_mut_ptr();
}


/// Expose the JNI interface for android below
#[cfg(target_os = "android")]
#[allow(non_snake_case)]
pub mod android {
    use super::*;
    use jni::JNIEnv;
    use jni::objects::{JClass, JObject, JValue};
    use jni::sys::{jint, jobject};
    use bc_service::{StatusCode, Wallet};

    #[no_mangle]
    pub unsafe extern "C" fn Java_info_scry_wallet_1manager_NativeLib_mnemonicGenerate(env: JNIEnv, _: JClass, count: jint) -> jobject {
        let mnemonic = bc_service::crate_mnemonic::<bc_service::account_crypto::Ed25519>(count as u8);
        let mn_byte = env.byte_array_from_slice(mnemonic.mn.as_slice()).unwrap();
        let mn_object = JObject::from(mn_byte);

        let mnid = env.new_string(mnemonic.mnid).unwrap();
        let mn_id_obj = JObject::from(mnid);

        let mn_class = env.find_class("info/scry/wallet_manager/NativeLib$Mnemonic");

        match mn_class {
            Ok(class) => {
                let jobj = env.alloc_object(class).unwrap();
                env.set_field(jobj, "mnId", "Ljava/lang/String;", JValue::Object(mn_id_obj)).expect("find mnId type is error!");//返回字符串
                env.set_field(jobj, "status", "I", JValue::Int(mnemonic.status as i32)).expect("find status type is error!");//返回数字
                env.set_field(jobj, "mn", "[B", JValue::Object(mn_object)).expect("find mn type is error!");//返回数组
                *jobj
            }
            Err(err) => {
                let exception = env.find_class("java/lang/Exception").unwrap();
                //  let err_info = mn_class.unwrap_err();
                env.throw_new(exception, err.to_string());

                let exception_object = env.byte_array_from_slice("calss not found".as_bytes()).unwrap();
                exception_object
            }
        }
    }

    pub unsafe extern "C" fn Java_info_scry_wallet_1manager_NativeLib_isContainWallet(env: JNIEnv, _: JClass) -> jobject {
        //调用获取所有钱包，查看返回值的情况
        //调用获取所有钱包，查看返回值的情况
        let wallet = bc_service::is_contain_wallet();
        let state_class = env.find_class("info/scry/wallet_manager/NativeLib$WalletState").expect("can't found NativeLib$WalletState class");
        let state_obj = env.alloc_object(state_class).expect("create state_obj instance is error!");
        match wallet {
            Ok(data) => {
                env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::OK as i32)).expect("find status type is error!");
                if data.len() == 0 {
                    env.set_field(state_obj, "isContainWallet", "Z", JValue::Int(0 as i32)).expect("set isContainWallet value is error!");
                } else {
                    env.set_field(state_obj, "isContainWallet", "Z", JValue::Int(1 as i32)).expect("set isContainWallet value is error!");
                }
            }
            Err(e) => {
                println!("isContainWallet method error:{}", e);
                env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::DylibError as i32)).expect("find status type is error!");
                env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(e).unwrap()))).expect("set error msg value is error!");
            }
        }
        *state_obj
    }

    #[no_mangle]
    #[allow(non_snake_case)]
    fn wallet_jni_obj_util<'a, 'b>(env: &'a JNIEnv<'b>, wallet: Wallet) -> Vec<JObject<'a>> {
        let wallet_class = env.find_class("info/scry/wallet_manager/NativeLib$Wallet").expect("can't found NativeLib$Wallet class");
        let mut container = Vec::new();

        let jobj = env.alloc_object(wallet_class).unwrap();

        let wallet_name = env.new_string(wallet.wallet_name).unwrap();
        let wallet_name_obj = JObject::from(wallet_name);
        let wallet_id = env.new_string(wallet.wallet_id).unwrap();
        let wallet_id_obj = JObject::from(wallet_id);
        let list = wallet.chain_list;

        // find List util
        let chain_list_class = env.find_class("java/util/ArrayList").expect("find list type is error");
        let chain_list_class_obj = env.alloc_object(chain_list_class).expect("create chain_list_class instance is error!");

        //find Chain Class define
        let chain_class = env.find_class("info/scry/wallet_manager/NativeLib$Chain").expect("chain class find error");

        //find Digit Class define
        let digit_class = env.find_class("info/scry/wallet_manager/NativeLib$Digit").expect("Digit class not found");

        for chain in list {
            let chain_class_obj = env.alloc_object(chain_class).expect("create chain_class instance is error!");
            env.set_field(chain_class_obj, "status", "I", JValue::Int(chain.status as i32)).expect("set status value is error!");
            let chain_id_str = format!("{}", chain.chain_id);

            env.set_field(chain_class_obj, "chainId", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(chain_id_str).unwrap()))).expect("set chainId value is error!");
            env.set_field(chain_class_obj, "walletId", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(chain.wallet_id).unwrap()))).expect("set digitId value is error!");
            env.set_field(chain_class_obj, "chainAddress", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(chain.chain_address).unwrap()))).expect("set status value is error!");
            env.set_field(chain_class_obj, "isVisible", "Z", JValue::Int(chain.is_visible as i32)).expect("set digitId value is error!");
            env.set_field(chain_class_obj, "chainType", "I", JValue::Int(chain.chain_type as i32)).expect("set digitId value is error!");

            for digit in chain.digit_list {
                //实例化 digit
                let digit_class_obj = env.alloc_object(digit_class).expect("create digit instance is error!");
                //设置digit 属性
                env.set_field(digit_class_obj, "status", "I", JValue::Int(digit.status as i32)).expect("set status value is error!");
                env.set_field(digit_class_obj, "digitId", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(digit.digit_id).unwrap()))).expect("set digitId value is error!");

                env.set_field(digit_class_obj, "address", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(digit.address).unwrap()))).expect("set address value is error!");
                env.set_field(digit_class_obj, "contractAddress", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(digit.contract_address).unwrap()))).expect("set contractAddress value is error!");
                env.set_field(digit_class_obj, "shortName", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(digit.shortname).unwrap()))).expect("set shortName value is error!");
                env.set_field(digit_class_obj, "fullName", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(digit.fullname).unwrap()))).expect("set fullName value is error!");
                env.set_field(digit_class_obj, "balance", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(digit.balance).unwrap()))).expect("set balance value is error!");
                env.set_field(digit_class_obj, "isVisible", "I", JValue::Int(digit.is_visible as i32)).expect("set isVisible value is error!");
                env.set_field(digit_class_obj, "decimal", "I", JValue::Int(digit.decimal as i32)).expect("set decimal value is error!");

                env.set_field(digit_class_obj, "imgUrl", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(digit.imgurl).unwrap()))).expect("set imgUrl value is error!");

                // add digit instance to chain list
                env.call_method(chain_class_obj, "add", "(info/scry/wallet_manager/NativeLib$Digit;)Z", &[digit_class_obj.into()]).expect("add digit instance is fail");
            }
            env.call_method(chain_list_class_obj, "add", "(info/scry/wallet_manager/NativeLib$Chain;)Z", &[chain_class_obj.into()]).expect("add chain instance is fail");
        }

        env.set_field(jobj, "status", "I", JValue::Int(wallet.status as i32)).expect("find status type is error!");
        env.set_field(jobj, "walletId", "Ljava/lang/String;", JValue::Object(wallet_id_obj)).expect("find walletId type is error!");
        env.set_field(jobj, "walletName", "Ljava/lang/String;", JValue::Object(wallet_name_obj)).expect("find walletName type is error!");
        env.set_field(jobj, "chainList", "Ljava/util/List;", JValue::Object(chain_list_class_obj)).expect("find chainList type is error!");

        container.push(jobj);
        println!("container len is:{}", container.len());
        container
    }

    pub unsafe extern "C" fn Java_info_scry_wallet_1manager_NativeLib_saveWallet(env: JNIEnv, _: JClass, mn: jbyteArray, pwd: jbyteArray) -> jobject {
        let wallet_name: String = env.get_string(wallet_name).unwrap().into();
        let pwd = env.convert_byte_array(pwd).unwrap();
        let mnemonic = env.convert_byte_array(mnemonic).unwrap();

        let wallet_class = env.find_class("info/scry/wallet_manager/NativeLib$Wallet").expect("can't found NativeLib$Wallet class");

        let wallet = bc_service::save_mnemonic(wallet_name.as_str(), mnemonic.as_slice(), pwd.as_slice());
        let ret_obj = match wallet {
            Ok(wallet) => {
                let vec_obj = wallet_jni_obj_util(&env, wallet);
                let Obj = vec_obj.get(0).unwrap();
                **Obj
            }
            Err(e) => {
                let jobj = env.alloc_object(wallet_class).unwrap();
                println!("msg:{}", e);
                env.set_field(jobj, "status", "I", JValue::Int(0)).expect("find status type is error!");
                *jobj
            }
        };
        ret_obj
    }

    pub unsafe extern "C" fn Java_info_scry_walletassist_NativeLib_mnemonicList(env: JNIEnv, _: JClass) -> jobject {}

    pub unsafe extern "C" fn Java_info_scry_wallet_1manager_NativeLib_resetPwd(env: JNIEnv, _: JClass, mn: jbyteArray, mnid: jstring, oldpwd: jbyteArray, newpwd: jbyteArray) -> jint {}

    pub unsafe extern "C" fn Java_info_scry_wallet_1manager_NativeLib_getNowWallet(env: JNIEnv, _: JClass) -> jobject {}

    pub unsafe extern "C" fn Java_info_scry_wallet_1manager_NativeLib_setNowWallet(env: JNIEnv, _: JClass) -> jobject {}

    pub unsafe extern "C" fn Java_info_scry_wallet_1manager_NativeLib_deleteWallet(env: JNIEnv, _: JClass) -> jobject {}

    pub unsafe extern "C" fn Java_info_scry_wallet_1manager_NativeLib_rename(env: JNIEnv, _: JClass) -> jobject {}
}


#[cfg(test)]
mod tests {
    #[test]
    fn it_works() {
        assert_eq!(2 + 2, 4);
    }
}
