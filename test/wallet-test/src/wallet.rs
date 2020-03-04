use jni::JNIEnv;
use jni::objects::{JClass, JString, JObject, JValue};
use jni::sys::{jint, jobject, jbyteArray};
use wallets::StatusCode;
use wallets::model::Wallet;
use log::info;
use crate::chain;

#[no_mangle]
pub unsafe extern "C" fn Java_info_scry_wallet_1manager_NativeLib_mnemonicGenerate(env: JNIEnv, _: JClass, count: jint) -> jobject {
    let mnemonic = wallets::module::wallet::crate_mnemonic(count as u8);
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
        Err(_err) => {
            let exception_object = env.byte_array_from_slice("calss not found".as_bytes()).unwrap();
            exception_object
        }
    }
}


#[no_mangle]
#[allow(non_snake_case)]
pub unsafe extern "C" fn Java_info_scry_wallet_1manager_NativeLib_isContainWallet(env: JNIEnv, _: JClass) -> jobject {
    //调用获取所有钱包，查看返回值的情况
    let wallet = wallets::module::wallet::is_contain_wallet();
    let state_class = env.find_class("info/scry/wallet_manager/NativeLib$WalletState").expect("can't found NativeLib$WalletState class");
    let state_obj = env.alloc_object(state_class).expect("create state_obj instance is error!");
    match wallet {
        Ok(data) => {
            env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::OK as i32)).expect("find status type is error!");
            if data.len() == 0 {
                env.set_field(state_obj, "isContainWallet", "Z", JValue::Bool(0 as u8)).expect("set isContainWallet value is error!");
            } else {
                env.set_field(state_obj, "isContainWallet", "Z", JValue::Bool(1 as u8)).expect("set isContainWallet value is error!");
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

    let wallet_id = env.new_string(wallet.wallet_id.clone()).unwrap();
    let wallet_id_obj = JObject::from(wallet_id);
    let display_chain_id_str = env.new_string(format!("{}", wallet.display_chain_id)).unwrap();
    let display_chain_id__obj = JObject::from(display_chain_id_str);

    let wallet_create_time = env.new_string(wallet.create_time.clone()).unwrap();
    let wallet_create_time_obj = JObject::from(wallet_create_time);
    let eee_chain = wallet.eee_chain;
    match eee_chain {
        Some(eee_chain) => {
            let chain_class_obj = chain::get_eee_chain_obj(env, eee_chain);
            env.set_field(jobj, "eeeChain", "Linfo/scry/wallet_manager/NativeLib$EeeChain;", JValue::Object(chain_class_obj)).expect("set eee_chain");
        },
        None => {
            info!("eee_chain not used");
        }
    }
    let eth_chain = wallet.eth_chain;
    match eth_chain {
        Some(eth_chain) => {
            let chain_class_obj = chain::get_eth_chain_obj(env, eth_chain);
            env.set_field(jobj, "ethChain", "Linfo/scry/wallet_manager/NativeLib$EthChain;", JValue::Object(chain_class_obj)).expect("set eth_chain");
        },
        None => {
            info!("eth_chain not used");
        }
    }
    let btc_chain = wallet.btc_chain;
    match btc_chain {
        Some(btc_chain) => {
            println!("begin get_btc_chain_obj");
            let chain_class_obj = chain::get_btc_chain_obj(env, btc_chain);
            env.set_field(jobj, "btcChain", "Linfo/scry/wallet_manager/NativeLib$BtcChain;", JValue::Object(chain_class_obj)).expect("set btc_chain");
        },
        None => {
            info!("btc_chain not used");
        }
    }

    env.set_field(jobj, "status", "I", JValue::Int(wallet.status as i32)).expect("find status type is error!");
    env.set_field(jobj, "walletId", "Ljava/lang/String;", JValue::Object(wallet_id_obj)).expect("find walletId type is error!");

    env.set_field(jobj, "creationTime", "Ljava/lang/String;", JValue::Object(wallet_create_time_obj)).expect("find creationTime ");
    env.set_field(jobj, "nowChainId", "Ljava/lang/String;", JValue::Object(display_chain_id__obj)).expect("nowChainId");
    env.set_field(jobj, "isNowWallet", "Z", JValue::Bool(wallet.selected as u8)).expect("set isVisible value is error!");

    let wallet_type_class = env.find_class("info/scry/wallet_manager/NativeLib$WalletType").expect("NativeLib$WalletType ");

    let wallettype = if wallet.wallet_type == 1 {
        env.get_static_field(wallet_type_class, "WALLET", "Linfo/scry/wallet_manager/NativeLib$WalletType;")
    } else {
        env.get_static_field(wallet_type_class, "TEST_WALLET", "Linfo/scry/wallet_manager/NativeLib$WalletType;")
    };
    match wallettype {
        Ok(wallet_type) => {
            env.set_field(jobj, "walletType", "Linfo/scry/wallet_manager/NativeLib$WalletType;", wallet_type).expect("set walletType");
        },
        Err(e) => {
            println!("set wallet type error {}", e.to_string());
        }
    }

    if wallet.wallet_name.is_some() {
        let wallet_name = env.new_string(wallet.wallet_name.unwrap()).unwrap();
        let wallet_name_obj = JObject::from(wallet_name);
        env.set_field(jobj, "walletName", "Ljava/lang/String;", JValue::Object(wallet_name_obj)).expect("find walletName type is error!");
    }
    container.push(jobj);
    container
}

#[no_mangle]
#[allow(non_snake_case)]
pub unsafe extern "C" fn Java_info_scry_wallet_1manager_NativeLib_loadAllWalletList(env: JNIEnv, _: JClass) -> jobject {
    let wallet_list = wallets::module::wallet::get_all_wallet();

    let wallet_list_class = env.find_class("java/util/ArrayList").expect("find chain type is error");
    let wallet_list_class_obj = env.alloc_object(wallet_list_class).expect("create chain_list_class instance is error!");
    env.call_method(wallet_list_class_obj, "<init>", "()V", &[]).expect("wallet_list_class_obj init method is exec");
    match wallet_list {
        Ok(wallet_list) => {
            for wallet in wallet_list {
                let wallet_temp = wallet_jni_obj_util(&env, wallet);
                let ss = wallet_temp.get(0).unwrap();
                env.call_method(wallet_list_class_obj, "add", "(Ljava/lang/Object;)Z", &[JValue::Object(*ss)]).expect("add wallet_temp is fail");
            }
        }
        Err(_msg) => {}
    }
    *wallet_list_class_obj
}

#[no_mangle]
#[allow(non_snake_case)]
pub unsafe extern "C" fn Java_info_scry_wallet_1manager_NativeLib_saveWallet(env: JNIEnv, _: JClass, wallet_name: JString, pwd: jbyteArray, mnemonic: jbyteArray, wallet_type: jint) -> jobject {
    let wallet_name: String = env.get_string(wallet_name).unwrap().into();
    let pwd = env.convert_byte_array(pwd).unwrap();
    let mnemonic = env.convert_byte_array(mnemonic).unwrap();

    /*let value = env.call_method(wallet_type,"ordinal","()I",&[]).expect("get type value error");
    let wallet_type_value = value.i().unwrap();
    println!("wallet type value is {}",wallet_type_value);*/
    let wallet_class = env.find_class("info/scry/wallet_manager/NativeLib$Wallet").expect("can't found NativeLib$Wallet class");

    let wallet = wallets::module::wallet::create_wallet(wallet_name.as_str(), mnemonic.as_slice(), pwd.as_slice(), wallet_type as i64);
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


#[no_mangle]
#[allow(non_snake_case)]
pub unsafe extern "C" fn Java_info_scry_wallet_1manager_NativeLib_resetPwd(env: JNIEnv, _: JClass, walletId: JString, newPwd: jbyteArray, oldPwd: jbyteArray) -> jobject {
    let old_pwd = env.convert_byte_array(oldPwd).unwrap();
    let new_pwd = env.convert_byte_array(newPwd).unwrap();
    let wallet_id: String = env.get_string(walletId).unwrap().into();
    let wallet_state_class = env.find_class("info/scry/wallet_manager/NativeLib$WalletState").expect("find wallet_state_class is error");
    let state_obj = env.alloc_object(wallet_state_class).expect("create wallet_state_class instance is error!");

    match wallets::module::wallet::reset_mnemonic_pwd(wallet_id.as_str(), old_pwd.as_slice(), new_pwd.as_slice()) {
        Ok(code) => {
            env.set_field(state_obj, "status", "I", JValue::Int(code as i32)).expect("find status type is error!");
            env.set_field(state_obj, "isResetPwd", "Z", JValue::Bool(1 as u8)).expect("set isSetNowWallet value is error!");
        },
        Err(msg) => {
            env.set_field(state_obj, "isResetPwd", "Z", JValue::Bool(0 as u8)).expect("set isSetNowWallet value is error!");
            env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(msg.to_string()).unwrap()))).expect("set error msg value is error!");
        }
    }
    *state_obj
}

#[no_mangle]
#[allow(non_snake_case)]
pub unsafe extern "C" fn Java_info_scry_wallet_1manager_NativeLib_getNowWallet(env: JNIEnv, _: JClass) -> jobject {
    let wallet_state_class = env.find_class("info/scry/wallet_manager/NativeLib$WalletState").expect("find wallet_state_class is error");
    let state_obj = env.alloc_object(wallet_state_class).expect("create wallet_state_class instance is error!");
    match wallets::module::wallet::get_current_wallet() {
        Ok(wallet) => {
            env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::OK as i32)).expect("find status type is error!");
            env.set_field(state_obj, "walletId", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(wallet.wallet_id).unwrap()))).expect("set error msg value is error!");
        }
        Err(msg) => {
            env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::DylibError as i32)).expect("find status type is error!");
            env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(msg).unwrap()))).expect("set error msg value is error!");
        }
    }
    *state_obj
}

#[no_mangle]
#[allow(non_snake_case)]
pub unsafe extern "C" fn Java_info_scry_wallet_1manager_NativeLib_setNowWallet(env: JNIEnv, _: JClass, walletId: JString) -> jobject {
    let wallet_id: String = env.get_string(walletId).unwrap().into();
    let wallet_state_class = env.find_class("info/scry/wallet_manager/NativeLib$WalletState").expect("find wallet_state_class is error");
    let state_obj = env.alloc_object(wallet_state_class).expect("create wallet_state_class instance is error!");
    match wallets::module::wallet::set_current_wallet(wallet_id.as_str()) {
        Ok(exist) => {
            env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::OK as i32)).expect("find status type is error!");
            env.set_field(state_obj, "isSetNowWallet", "Z", JValue::Bool(exist as u8)).expect("set isSetNowWallet value is error!");
        }
        Err(msg) => {
            env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::DylibError as i32)).expect("find status type is error!");
            env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(msg).unwrap()))).expect("set error msg value is error!");
        }
    }
    *state_obj
}

#[no_mangle]
#[allow(non_snake_case)]
pub unsafe extern "C" fn Java_info_scry_wallet_1manager_NativeLib_deleteWallet(env: JNIEnv, _: JClass, walletId: JString, psd: jbyteArray) -> jobject {
    let wallet_id: String = env.get_string(walletId).unwrap().into();
    let passwd = env.convert_byte_array(psd).unwrap();
    let wallet_state_class = env.find_class("info/scry/wallet_manager/NativeLib$WalletState").expect("find wallet_state_class is error");
    let state_obj = env.alloc_object(wallet_state_class).expect("create wallet_state_class instance is error!");
    match wallets::module::wallet::del_wallet(wallet_id.as_str(), passwd.as_slice()) {
        Ok(exist) => {
            env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::OK as i32)).expect("find status type is error!");
            env.set_field(state_obj, "isDeletWallet", "Z", JValue::Bool(exist as u8)).expect("set isSetNowWallet value is error!");
        }
        Err(msg) => {
            env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::DylibError as i32)).expect("find status type is error!");
            env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(msg.to_string()).unwrap()))).expect("set error msg value is error!");
        }
    }
    *state_obj
}

#[no_mangle]
#[allow(non_snake_case)]
pub unsafe extern "C" fn Java_info_scry_wallet_1manager_NativeLib_rename(env: JNIEnv, _: JClass, walletId: JString, walletName: JString) -> jobject {
    let wallet_id: String = env.get_string(walletId).unwrap().into();
    let wallet_name: String = env.get_string(walletName).unwrap().into();
    let wallet_state_class = env.find_class("info/scry/wallet_manager/NativeLib$WalletState").expect("find wallet_state_class is error");
    let state_obj = env.alloc_object(wallet_state_class).expect("create wallet_state_class instance is error!");
    match wallets::module::wallet::rename_wallet(wallet_id.as_str(), wallet_name.as_str()) {
        Ok(exist) => {
            env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::OK as i32)).expect("find status type is error!");
            env.set_field(state_obj, "isRename", "Z", JValue::Bool(exist as u8)).expect("set isSetNowWallet value is error!");
        }
        Err(msg) => {
            env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::DylibError as i32)).expect("find status type is error!");
            env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(msg.to_string()).unwrap()))).expect("set error msg value is error!");
        }
    }
    *state_obj
}

#[no_mangle]
#[allow(non_snake_case)]
pub unsafe extern "C" fn Java_info_scry_wallet_1manager_NativeLib_exportWallet(env: JNIEnv, _: JClass, walletId: JString, psd: jbyteArray) -> jobject {
    let wallet_id: String = env.get_string(walletId).unwrap().into();
    let passwd = env.convert_byte_array(psd).unwrap();

    let mn_class = env.find_class("info/scry/wallet_manager/NativeLib$Mnemonic").expect("exportWallet NativeLib$Mnemonic");
    let jobj = env.alloc_object(mn_class).unwrap();

    match wallets::module::wallet::export_mnemonic(wallet_id.as_str(), passwd.as_slice()) {
        Ok(mnemonic) => {
            let mn_byte = env.byte_array_from_slice(mnemonic.mn.as_slice()).unwrap();
            let mn_object = JObject::from(mn_byte);
            let mnid = env.new_string(mnemonic.mnid).unwrap();
            let mn_id_obj = JObject::from(mnid);
            env.set_field(jobj, "mnId", "Ljava/lang/String;", JValue::Object(mn_id_obj)).expect("find mnId type is error!");//返回字符串
            env.set_field(jobj, "status", "I", JValue::Int(mnemonic.status as i32)).expect("find status type is error!");//返回数字
            env.set_field(jobj, "mn", "[B", JValue::Object(mn_object)).expect("find mn type is error!");//返回数组
            *jobj
        },
        Err(e) => {
            let msg = env.new_string(e.to_string()).unwrap();
            let msg_obj = JObject::from(msg);
            env.set_field(jobj, "status", "I", JValue::Int(StatusCode::DylibError as i32)).expect("find status type is error!");//返回数字
            env.set_field(jobj, "message", "Ljava/lang/String;", JValue::Object(msg_obj)).expect("find status type is error!");//返回数字
            *jobj
        }
    }
}