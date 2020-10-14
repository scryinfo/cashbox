use super::*;
use std::os::raw::{c_uchar, c_int};

#[no_mangle]
pub extern "C" fn mnemonicGenerate(count: c_int) -> *mut c_uchar {
    let wallet = wallets::module::wallet::WalletManager{};
    let mut mn = wallet.crate_mnemonic(count as u8);
    return mn.mnid.as_mut_ptr();
}

/// Expose the JNI interface for android below
#[cfg(target_os = "android")]
#[allow(non_snake_case)]
pub mod android {
    use super::*;
    use wallets::{module,model::Wallet};

    #[no_mangle]
    pub unsafe extern "C" fn Java_info_scry_wallet_1manager_NativeLib_mnemonicGenerate(env: JNIEnv, _: JClass, count: jint) -> jobject {
        let wallet = module::wallet::WalletManager {};
        let mn_class = env.find_class("info/scry/wallet_manager/NativeLib$Mnemonic").expect("class not found");
        let mn_obj = env.alloc_object(mn_class).expect("alloc Mnemonic object");
        if count>127{
            env.set_field(mn_obj, "status", "I", JValue::Int(StatusCode::DylibError as i32)).expect("find status type ");
            env.set_field(mn_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string("please input correct mnemonic num").unwrap()))).expect("mnemonicGenerate set message ");
        }else{
            let mnemonic = wallet.crate_mnemonic(count as u8);
            let mn_byte = env.byte_array_from_slice(mnemonic.mn.as_slice()).unwrap();
            let mn_id = env.new_string(mnemonic.mnid).unwrap();
            env.set_field(mn_obj, "mnId", "Ljava/lang/String;", JValue::Object(JObject::from(mn_id))).expect("find mnId type ");
            env.set_field(mn_obj, "status", "I", JValue::Int(mnemonic.status as i32)).expect("find status type");
            env.set_field(mn_obj, "mn", "[B", JValue::Object(JObject::from(mn_byte))).expect("find mn type");
        }
        *mn_obj
    }

    #[no_mangle]
    #[allow(non_snake_case)]
    pub unsafe extern "C" fn Java_info_scry_wallet_1manager_NativeLib_isContainWallet(env: JNIEnv, _: JClass) -> jobject {
        //Call to get all wallets and check the return value
        let state_class = env.find_class("info/scry/wallet_manager/NativeLib$WalletState").expect("can't found NativeLib$WalletState class");
        let state_obj = env.alloc_object(state_class).expect("create state_obj instance ");
        let wallet = module::wallet::WalletManager {};
        match wallet.is_contain_wallet() {
            Ok(data) => {
                env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::OK as i32)).expect("find status type ");
                env.set_field(state_obj, "isContainWallet", "Z", JValue::Bool(data as u8)).expect("set isContainWallet value");
            }
            Err(e) => {
                env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::DylibError as i32)).expect("find status type ");
                env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(e.to_string()).unwrap()))).expect("isContainWallet set message ");
            }
        }
        *state_obj
    }


    #[no_mangle]
    #[allow(non_snake_case)]
    fn wallet_jni_obj_util<'a, 'b>(env: &'a JNIEnv<'b>, wallet: Wallet) -> JObject<'a> {
        let wallet_class = env.find_class("info/scry/wallet_manager/NativeLib$Wallet").expect("can't found NativeLib$Wallet class");

        let jobj = env.alloc_object(wallet_class).unwrap();
        let wallet_id = env.new_string(wallet.wallet_id.clone()).unwrap();
        let wallet_id_obj = JObject::from(wallet_id);
        let display_chain_id_str = env.new_string(format!("{}", wallet.display_chain_id)).unwrap();
        let display_chain_id__obj = JObject::from(display_chain_id_str);

        let wallet_create_time = env.new_string(wallet.create_time.clone()).unwrap();
        let wallet_create_time_obj = JObject::from(wallet_create_time);

        if let Some(eee_chain) = wallet.eee_chain {
            let chain_class_obj = chain::android::get_eee_chain_obj(env, eee_chain);
            env.set_field(jobj, "eeeChain", "Linfo/scry/wallet_manager/NativeLib$EeeChain;", JValue::Object(chain_class_obj)).expect("set eee_chain");
        }

        if let Some(eth_chain) = wallet.eth_chain {
            let chain_class_obj = chain::android::get_eth_chain_obj(env, eth_chain);
            env.set_field(jobj, "ethChain", "Linfo/scry/wallet_manager/NativeLib$EthChain;", JValue::Object(chain_class_obj)).expect("set eth_chain");
        }

        if let Some(btc_chain) = wallet.btc_chain {
            let chain_class_obj = chain::android::get_btc_chain_obj(env, btc_chain);
            env.set_field(jobj, "btcChain", "Linfo/scry/wallet_manager/NativeLib$BtcChain;", JValue::Object(chain_class_obj)).expect("set btc_chain");
        }

        env.set_field(jobj, "status", "I", JValue::Int(wallet.status as i32)).expect("find status type ");
        env.set_field(jobj, "walletId", "Ljava/lang/String;", JValue::Object(wallet_id_obj)).expect("find walletId type ");
        env.set_field(jobj, "creationTime", "Ljava/lang/String;", JValue::Object(wallet_create_time_obj)).expect("find creationTime ");
        env.set_field(jobj, "nowChainId", "Ljava/lang/String;", JValue::Object(display_chain_id__obj)).expect("nowChainId");
        env.set_field(jobj, "isNowWallet", "Z", JValue::Bool(wallet.selected as u8)).expect("set isVisible value ");

        let wallet_type_class = env.find_class("info/scry/wallet_manager/NativeLib$WalletType").expect("NativeLib$WalletType ");
        let wallettype = if wallet.wallet_type == 1 {
            env.get_static_field(wallet_type_class, "WALLET", "Linfo/scry/wallet_manager/NativeLib$WalletType;")
        } else {
            env.get_static_field(wallet_type_class, "TEST_WALLET", "Linfo/scry/wallet_manager/NativeLib$WalletType;")
        };
        match wallettype {
            Ok(wallet_type) => {
                env.set_field(jobj, "walletType", "Linfo/scry/wallet_manager/NativeLib$WalletType;", wallet_type).expect("set walletType");
            }
            Err(e) => {
                println!("set wallet type error {}", e.to_string());
            }
        }

        if wallet.wallet_name.is_some() {
            let wallet_name = env.new_string(wallet.wallet_name.unwrap()).unwrap();
            let wallet_name_obj = JObject::from(wallet_name);
            env.set_field(jobj, "walletName", "Ljava/lang/String;", JValue::Object(wallet_name_obj)).expect("find walletName type ");
        }
        jobj
    }

    #[no_mangle]
    #[allow(non_snake_case)]
    pub unsafe extern "C" fn Java_info_scry_wallet_1manager_NativeLib_loadAllWalletList(env: JNIEnv, _: JClass) -> jobject {
        let wallet_list_class = env.find_class("java/util/ArrayList").expect("find ArrayList type");
        let wallet_list_class_obj = env.alloc_object(wallet_list_class).expect("create chain_list_class instance ");
        env.call_method(wallet_list_class_obj, "<init>", "()V", &[]).expect("wallet_list_class_obj init ArrayList");
        let wallet = module::wallet::WalletManager{};
        if let Ok(wallet_list) = wallet.get_all() {
            for wallet in wallet_list {
                let wallet_temp = wallet_jni_obj_util(&env, wallet);
                env.call_method(wallet_list_class_obj, "add", "(Ljava/lang/Object;)Z", &[JValue::Object(wallet_temp)]).expect("add wallet");
            }
        }
        *wallet_list_class_obj
    }

    #[no_mangle]
    #[allow(non_snake_case)]
    pub unsafe extern "C" fn Java_info_scry_wallet_1manager_NativeLib_saveWallet(env: JNIEnv, _: JClass, wallet_name: JString, pwd: jbyteArray, mnemonic: jbyteArray, wallet_type: jint) -> jobject {
        let wallet_name:JniResult<String> = env.get_string(wallet_name).map(|value| value.into());
        let pwd = env.convert_byte_array(pwd);
        let mnemonic = env.convert_byte_array(mnemonic);
        let wallet_class = env.find_class("info/scry/wallet_manager/NativeLib$Wallet").expect("can't found NativeLib$Wallet class");
        let wallet_obj = env.alloc_object(wallet_class).unwrap();
        // ensure input parameter convert correct
        if wallet_name.is_err()||pwd.is_err()||mnemonic.is_err(){
            env.set_field(wallet_obj, "status", "I", JValue::Int(StatusCode::ParameterFormatWrong as i32)).expect("set saveWallet StatusCode ");
            env.set_field(wallet_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string("input parameter incorrect").unwrap()))).expect("set saveWallet message");
            return *wallet_obj
        }
        let wallet = module::wallet::WalletManager {};
        let ret_obj = match wallet.create_wallet(&wallet_name.unwrap(), &mnemonic.unwrap(),  &pwd.unwrap(), wallet_type as i64) {
            Ok(wallet) => {
                wallet_jni_obj_util(&env, wallet)
            }
            Err(e) => {
                env.set_field(wallet_obj, "status", "I", JValue::Int(StatusCode::DylibError as i32)).expect("set saveWallet StatusCode ");
                env.set_field(wallet_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(e.to_string()).unwrap()))).expect("set saveWallet message");
                wallet_obj
            }
        };
        *ret_obj
    }
    #[no_mangle]
    #[allow(non_snake_case)]
    pub unsafe extern "C" fn Java_info_scry_wallet_1manager_NativeLib_resetPwd(env: JNIEnv, _: JClass, walletId: JString, newPwd: jbyteArray, oldPwd: jbyteArray) -> jobject {
        let wallet_state_class = env.find_class("info/scry/wallet_manager/NativeLib$WalletState").expect("find NativeLib$WalletState");
        let state_obj = env.alloc_object(wallet_state_class).expect("create NativeLib$WalletState instance ");

        let old_pwd = env.convert_byte_array(oldPwd);
        let new_pwd = env.convert_byte_array(newPwd);
        let wallet_id:JniResult<String> = env.get_string(walletId).map(|value| value.into());
        // ensure input parameter convert correct
        if old_pwd.is_err()||new_pwd.is_err()||wallet_id.is_err() {
            env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::ParameterFormatWrong as i32)).expect("resetPwd StatusCode ");
            env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string("input parameter incorrect").unwrap()))).expect("set error msg");
            return *state_obj
        }

        let wallet = module::wallet::WalletManager {};
        match wallet.reset_mnemonic_pwd(&wallet_id.unwrap(), &old_pwd.unwrap(), &new_pwd.unwrap()) {
            Ok(_code) => {
                env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::OK as i32)).expect("resetPwd StatusCode ");
                env.set_field(state_obj, "isResetPwd", "Z", JValue::Bool(1 as u8)).expect("set isSetNowWallet value ");
            }
            Err(msg) => {
                env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::DylibError as i32)).expect("resetPwd StatusCode ");
                env.set_field(state_obj, "isResetPwd", "Z", JValue::Bool(0 as u8)).expect("set isSetNowWallet value ");
                env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(msg.to_string()).unwrap()))).expect("set error msg");
            }
        }
        *state_obj
    }

    #[no_mangle]
    #[allow(non_snake_case)]
    pub unsafe extern "C" fn Java_info_scry_wallet_1manager_NativeLib_getNowWallet(env: JNIEnv, _: JClass) -> jobject {
        let wallet_state_class = env.find_class("info/scry/wallet_manager/NativeLib$WalletState").expect("find wallet_state_class is error");
        let state_obj = env.alloc_object(wallet_state_class).expect("create wallet_state_class instance ");
        let wallet = module::wallet::WalletManager{};
        match wallet.get_current_wallet() {
            Ok(wallet) => {
                env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::OK as i32)).expect("find status type ");
                env.set_field(state_obj, "walletId", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(wallet.wallet_id).unwrap()))).expect("set getNowWallet walletId value ");
            }
            Err(msg) => {
                env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::DylibError as i32)).expect("find status type ");
                env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(msg.to_string()).unwrap()))).expect("set getNowWallet  message value ");
            }
        }
        *state_obj
    }

    #[no_mangle]
    #[allow(non_snake_case)]
    pub unsafe extern "C" fn Java_info_scry_wallet_1manager_NativeLib_setNowWallet(env: JNIEnv, _: JClass, walletId: JString) -> jobject {
        let wallet_state_class = env.find_class("info/scry/wallet_manager/NativeLib$WalletState").expect("find NativeLib$WalletState");
        let state_obj = env.alloc_object(wallet_state_class).expect("create wallet_state_class instance ");
        let wallet = module::wallet::WalletManager {};
        if let Ok(wallet_id) =  env.get_string(walletId){
            let wallet_id :String = wallet_id.into();
            match wallet.set_current_wallet(wallet_id.as_str()) {
                Ok(_exist) => {
                    env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::OK as i32)).expect("find status type ");
                    env.set_field(state_obj, "isSetNowWallet", "Z", JValue::Bool(1 as u8)).expect("set isSetNowWallet value ");
                }
                Err(msg) => {
                    env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::DylibError as i32)).expect("find status type ");
                    env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(msg.to_string()).unwrap()))).expect("set setNowWallet message");
                }
            }
        }else {
            env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::ParameterFormatWrong as i32)).expect("find status type ");
            env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string("input parameter incorrect").unwrap()))).expect("set setNowWallet message");
        }
        *state_obj
    }

    #[no_mangle]
    #[allow(non_snake_case)]
    pub unsafe extern "C" fn Java_info_scry_wallet_1manager_NativeLib_deleteWallet(env: JNIEnv, _: JClass, walletId: JString, psd: jbyteArray) -> jobject {
        let wallet_id:JniResult<String> = env.get_string(walletId).map(|value| value.into());
        let passwd = env.convert_byte_array(psd);
        let wallet_state_class = env.find_class("info/scry/wallet_manager/NativeLib$WalletState").expect("find NativeLib$WalletState");
        let state_obj = env.alloc_object(wallet_state_class).expect("create wallet_state_class instance ");
        let wallet = module::wallet::WalletManager {};
        if wallet_id.is_err()||passwd.is_err(){
            env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::ParameterFormatWrong as i32)).expect("find status type ");
            env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string("input parameter incorrect").unwrap()))).expect("set setNowWallet message");
            return *state_obj
        }
        match wallet.del_wallet(&wallet_id.unwrap(), &passwd.unwrap()) {
            Ok(_exist) => {
                env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::OK as i32)).expect("find status type ");
                env.set_field(state_obj, "isDeletWallet", "Z", JValue::Bool(true as u8)).expect("set isSetNowWallet value ");
            }
            Err(msg) => {
                env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::DylibError as i32)).expect("find status type ");
                env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(msg.to_string()).unwrap()))).expect("set deleteWallet message value ");
            }
        }
        *state_obj
    }

    #[no_mangle]
    #[allow(non_snake_case)]
    pub unsafe extern "C" fn Java_info_scry_wallet_1manager_NativeLib_rename(env: JNIEnv, _: JClass, walletId: JString, walletName: JString) -> jobject {
        let wallet_state_class = env.find_class("info/scry/wallet_manager/NativeLib$WalletState").expect("find NativeLib$WalletState");
        let state_obj = env.alloc_object(wallet_state_class).expect("create wallet_state_class instance ");
        let wallet_id:JniResult<String> = env.get_string(walletId).map(|value| value.into());
        let wallet_name:JniResult<String>  = env.get_string(walletName).map(|value| value.into());

        if wallet_id.is_err()||wallet_name.is_err() {
            env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::ParameterFormatWrong as i32)).expect("find status type ");
            env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string("input parameter incorrect").unwrap()))).expect("set setNowWallet message");
            return *state_obj
        }
        let wallet = module::wallet::WalletManager {};
        match wallet.rename_wallet(&wallet_id.unwrap(), &wallet_name.unwrap()) {
            Ok(exist) => {
                env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::OK as i32)).expect("find status type ");
                env.set_field(state_obj, "isRename", "Z", JValue::Bool(exist as u8)).expect("set isSetNowWallet value ");
            }
            Err(msg) => {
                env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::DylibError as i32)).expect("find rename StatusCode");
                env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(msg.to_string()).unwrap()))).expect("set message value ");
            }
        }
        *state_obj
    }

    #[no_mangle]
    #[allow(non_snake_case)]
    pub unsafe extern "C" fn Java_info_scry_wallet_1manager_NativeLib_exportWallet(env: JNIEnv, _: JClass, walletId: JString, psd: jbyteArray) -> jobject {
        let mn_class = env.find_class("info/scry/wallet_manager/NativeLib$Mnemonic").expect("exportWallet NativeLib$Mnemonic");
        let jobj = env.alloc_object(mn_class).unwrap();
        let wallet_id:JniResult<String> = env.get_string(walletId).map(|value| value.into());
        let passwd = env.convert_byte_array(psd);
        if wallet_id.is_err()||passwd.is_err() {
            env.set_field(jobj, "status", "I", JValue::Int(StatusCode::ParameterFormatWrong as i32)).expect("find status type ");
            env.set_field(jobj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string("input parameter incorrect").unwrap()))).expect("find message type ");
            return *jobj
        }
        let wallet = module::wallet::WalletManager {};
        match wallet.export_mnemonic(&wallet_id.unwrap(), &passwd.unwrap()) {
            Ok(mnemonic) => {
                let mn_byte = env.byte_array_from_slice(mnemonic.mn.as_slice()).unwrap();
                let mn_object = JObject::from(mn_byte);
                let mnid = env.new_string(mnemonic.mnid).unwrap();
                let mn_id_obj = JObject::from(mnid);
                env.set_field(jobj, "mnId", "Ljava/lang/String;", JValue::Object(mn_id_obj)).expect("find mnId type ");
                env.set_field(jobj, "status", "I", JValue::Int(mnemonic.status as i32)).expect("find status type ");
                env.set_field(jobj, "mn", "[B", JValue::Object(mn_object)).expect("find mn type ");
                *jobj
            }
            Err(e) => {
                let msg_obj = JObject::from(env.new_string(e.to_string()).unwrap());
                env.set_field(jobj, "status", "I", JValue::Int(StatusCode::DylibError as i32)).expect("find status type ");
                env.set_field(jobj, "message", "Ljava/lang/String;", JValue::Object(msg_obj)).expect("find status type ");
                *jobj
            }
        }
    }

    #[no_mangle]
    #[allow(non_snake_case)]
    pub unsafe extern "C" fn Java_info_scry_wallet_1manager_NativeLib_initWalletBasicData(env: JNIEnv, _: JClass) -> jobject {
        let wallet_state_class = env.find_class("info/scry/wallet_manager/NativeLib$WalletState").expect("find NativeLib$WalletState");
        let state_obj = env.alloc_object(wallet_state_class).expect("create wallet_state_class instance ");
        match wallets::wallet_db::init_wallet_database() {
            Ok(_) => {
                env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::OK as i32)).expect("find status type ");
                env.set_field(state_obj, "isInitWalletBasicData", "Z", JValue::Bool(1 as u8)).expect("set isInitWalletBasicData value ");
            }
            Err(msg) => {
                env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::DylibError as i32)).expect("find rename StatusCode");
                env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(msg.to_string()).unwrap()))).expect("set message value ");
            }
        }
        *state_obj
    }

    #[no_mangle]
    #[allow(non_snake_case)]
    pub unsafe extern "C" fn Java_info_scry_wallet_1manager_NativeLib_updateWalletDbData(env: JNIEnv, _: JClass,newVersion: JString) -> jobject {
        let wallet_state_class = env.find_class("info/scry/wallet_manager/NativeLib$WalletState").expect("find NativeLib$WalletState");
        let state_obj = env.alloc_object(wallet_state_class).expect("create wallet_state_class instance ");
        let new_version: JniResult<String> = env.get_string(newVersion).map(|value| value.into());
        if  new_version.is_err() {
            env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::ParameterFormatWrong as i32)).expect("find rename StatusCode");
            env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string("input parameter format not support").unwrap()))).expect("set message value ");
        } else {
            match wallets::wallet_db::update_db_version( &new_version.unwrap()) {
                Ok(_) => {
                    env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::OK as i32)).expect("find status type ");
                    env.set_field(state_obj, "isUpdateDbData", "Z", JValue::Bool(1 as u8)).expect("set isUpdateDbData value ");
                }
                Err(msg) => {
                    env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::DylibError as i32)).expect("find rename StatusCode");
                    env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(msg.to_string()).unwrap()))).expect("set message value ");
                }
            }
        }
        *state_obj
    }

    #[no_mangle]
    #[allow(non_snake_case)]
    pub unsafe extern "C" fn Java_info_scry_wallet_1manager_NativeLib_cleanWalletsDownloadData(env: JNIEnv, _: JClass)-> jobject {
        let wallet_state_class = env.find_class("info/scry/wallet_manager/NativeLib$WalletState").expect("find NativeLib$WalletState");
        let state_obj = env.alloc_object(wallet_state_class).expect("create wallet_state_class instance ");
        let wallet = module::wallet::WalletManager {};
        match wallet.clean_wallets_data() {
            Ok(_) => {
                env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::OK as i32)).expect("find status type ");
                env.set_field(state_obj, "isCleanWalletsData", "Z", JValue::Bool(1 as u8)).expect("set isCleanWalletsData value ");
            }
            Err(msg) => {
                env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::DylibError as i32)).expect("find rename StatusCode");
                env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(msg.to_string()).unwrap()))).expect("set message value ");
            }
        }
        *state_obj
    }
}
