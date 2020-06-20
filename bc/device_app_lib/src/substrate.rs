/// Expose the JNI interface for android below
#[cfg(target_os = "android")]
#[allow(non_snake_case)]
pub mod android {
    use jni::JNIEnv;
    use jni::objects::{JClass, JString, JObject, JValue};
    use jni::sys::{jbyteArray, jint, jobject};
    use wallets::StatusCode;

    #[no_mangle]
    #[allow(non_snake_case)]
    pub extern "C" fn Java_info_scry_wallet_1manager_NativeLib_eeeTxSign(env: JNIEnv, _class: JClass, rawTx: JString, walletId: JString, psd: jbyteArray) -> jobject {
        let pwd = env.convert_byte_array(psd).unwrap();
        let raw_tx: String = env.get_string(rawTx).unwrap().into();
        let wallet_id: String = env.get_string(walletId).unwrap().into();

        let wallet_state_class = env.find_class("info/scry/wallet_manager/NativeLib$Message").expect("find NativeLib$Message");
        let state_obj = env.alloc_object(wallet_state_class).expect("create NativeLib$Message instance ");
        match wallets::module::wallet::raw_tx_sign(&raw_tx, &wallet_id, pwd.as_slice()) {
            Ok(data) => {
                env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::OK as i32)).expect("set StatusCode ");
                env.set_field(state_obj, "signedInfo", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(data).unwrap()))).expect("set signedInfo");
            }
            Err(msg) => {
                env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::PwdIsWrong as i32)).expect("set StatusCode ");
                env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(msg.to_string()).unwrap()))).expect("set message ");
            }
        }
        *state_obj
    }

    #[no_mangle]
    #[allow(non_snake_case)]
    pub extern "C" fn Java_info_scry_wallet_1manager_NativeLib_eeeSign(env: JNIEnv, _class: JClass, rawTx: JString, walletId: JString, psd: jbyteArray) -> jobject {
        let pwd = env.convert_byte_array(psd).unwrap();
        let raw_tx: String = env.get_string(rawTx).unwrap().into();
        let wallet_id: String = env.get_string(walletId).unwrap().into();

        let wallet_state_class = env.find_class("info/scry/wallet_manager/NativeLib$Message").expect("find NativeLib$Message");
        let state_obj = env.alloc_object(wallet_state_class).expect("create wallet_state_class instance ");
        match wallets::module::wallet::raw_sign(&raw_tx, &wallet_id, pwd.as_slice()) {
            Ok(data) => {
                env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::OK as i32)).expect("eeeSign set StatusCode value");
                env.set_field(state_obj, "signedInfo", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(data).unwrap()))).expect("set error msg value ");
            }
            Err(msg) => {
                env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::DylibError as i32)).expect("eeeSign set StatusCode value");
                env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(msg.to_string()).unwrap()))).expect("set message ");
            }
        }
        *state_obj
    }

    #[no_mangle]
    #[allow(non_snake_case)]
    pub extern "C" fn Java_info_scry_wallet_1manager_NativeLib_eeeTransfer(env: JNIEnv, _class: JClass, from: JString, to: JString, value: JString, genesisHash: JString, index: jint, runtime_version: jint, pwd: jbyteArray) -> jobject {
        let pwd = env.convert_byte_array(pwd).unwrap();
        let from: String = env.get_string(from).unwrap().into();
        let genesis_hash: String = env.get_string(genesisHash).unwrap().into();
        let to: String = env.get_string(to).unwrap().into();
        let value: String = env.get_string(value).unwrap().into();
        let wallet_state_class = env.find_class("info/scry/wallet_manager/NativeLib$Message").expect("findNativeLib$Message");
        let state_obj = env.alloc_object(wallet_state_class).expect("create NativeLib$Message instance ");
        //  使用钱包方式来构造交易，用户交易index不会达到强制转换造成溢出的问题这个交易量
        let eee = wallets::module::EEE{};
        match eee.generate_transfer(&from, &to, &value, &genesis_hash, index as u32, runtime_version as u32, pwd.as_slice()) {
            Ok(data) => {
                env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::OK as i32)).expect("set StatusCode value");
                env.set_field(state_obj, "signedInfo", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(data).unwrap()))).expect("eeeTransfer set signedInfo value");
            }
            Err(msg) => {
                env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::PwdIsWrong as i32)).expect("eeeTransfer set StatusCode value ");
                env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(msg.to_string()).unwrap()))).expect("eeeTransfer set message value");
            }
        }
        *state_obj
    }

    #[no_mangle]
    #[allow(non_snake_case)]
    pub extern "C" fn Java_info_scry_wallet_1manager_NativeLib_eeeAccountInfoKey(env: JNIEnv, _class: JClass, address: JString) -> jobject {
        let account: String = env.get_string(address).unwrap().into();
        let wallet_msg_class = env.find_class("info/scry/wallet_manager/NativeLib$Message").expect("find NativeLib$Message");
        let state_obj = env.alloc_object(wallet_msg_class).expect("create NativeLib$Message instance");
        match wallets::account_info_key(&account) {
            Ok(key) => {
                env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::OK as i32)).expect("set StatusCode value");
                env.set_field(state_obj, "accountKeyInfo", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(key).unwrap()))).expect("set accountKeyInfo value");
            }
            Err(msg) => {
                env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::DylibError as i32)).expect("set StatusCode value");
                env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(msg.to_string()).unwrap()))).expect("set message value");
            }
        }
        *state_obj
    }

    #[no_mangle]
    #[allow(non_snake_case)]
    pub extern "C" fn Java_info_scry_wallet_1manager_NativeLib_decodeAccountInfo(env: JNIEnv, _class: JClass, encode_info: JString) -> jobject {
        let encode_info: String = env.get_string(encode_info).unwrap().into();
        let wallet_msg_class = env.find_class("info/scry/wallet_manager/NativeLib$Message").expect("find NativeLib$Message");

        let state_obj = env.alloc_object(wallet_msg_class).expect("create NativeLib$Message instance");
        match wallets::decode_account_info(&encode_info) {
            Ok(account_info) => {
                env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::OK as i32)).expect("set StatusCode value");
                let account_info_class = env.find_class("info/scry/wallet_manager/NativeLib$AccountInfo").expect("find NativeLib$AccountInfo");
                let account_obj = env.alloc_object(account_info_class).expect("create NativeLib$AccountInfo instance");
                //start set account info
                env.set_field(account_obj, "nonce", "I", JValue::Int(account_info.nonce as i32)).expect("set StatusCode value");
                env.set_field(account_obj, "refcount", "I", JValue::Int(account_info.refcount as i32)).expect("set StatusCode value");
                env.set_field(account_obj, "free", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(account_info.free.to_string()).unwrap()))).expect("set message value");
                env.set_field(account_obj, "reserved", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(account_info.reserved.to_string()).unwrap()))).expect("set message value");
                env.set_field(account_obj, "misc_frozen", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(account_info.misc_frozen.to_string()).unwrap()))).expect("set message value");
                env.set_field(account_obj, "fee_frozen", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(account_info.fee_frozen.to_string()).unwrap()))).expect("set message value");
                //end set account info
                env.set_field(state_obj, "accountInfo", "Linfo/scry/wallet_manager/NativeLib$AccountInfo;",account_obj.into() ).expect("set decodeAccountInfo value");
            }
            Err(msg) => {
                env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::DylibError as i32)).expect("set StatusCode value");
                env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(msg.to_string()).unwrap()))).expect("set message value");
            }
        }
        *state_obj
    }

    #[no_mangle]
    #[allow(non_snake_case)]
    pub extern "C" fn Java_info_scry_wallet_1manager_NativeLib_saveExtrinsicDetail(env: JNIEnv, _class: JClass, account_id: JString,event_detail: JString,block_hash:JString,extrinsics:JString) -> jobject {
        let account_id: String = env.get_string(account_id).unwrap().into();
        let encode_event_info: String = env.get_string(event_detail).unwrap().into();
        let block_hash: String = env.get_string(block_hash).unwrap().into();
        let block_extrinsics: String = env.get_string(extrinsics).unwrap().into();
        let wallet_msg_class = env.find_class("info/scry/wallet_manager/NativeLib$Message").expect("find NativeLib$Message");
        let state_obj = env.alloc_object(wallet_msg_class).expect("create NativeLib$Message instance");
        let eee = wallets::module::EEE{};
        match eee.save_tx_record(&account_id,&block_hash,&encode_event_info,&block_extrinsics) {
            Ok(_key) => {
                env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::OK as i32)).expect("set StatusCode value");
            }
            Err(msg) => {
                env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::DylibError as i32)).expect("set StatusCode value");
                env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(msg.to_string()).unwrap()))).expect("set message value");
            }
        }
        *state_obj
    }

    #[no_mangle]
    #[allow(non_snake_case)]
    pub extern "C" fn Java_info_scry_wallet_1manager_NativeLib_updateEeeSyncRecord(env: JNIEnv, _class: JClass, account: JString,chain_type: jint,block_num:jint,block_hash:JString) -> jobject {
        let account: String = env.get_string(account).unwrap().into();  //String account,int chain_type,int block_num,String block_hash
        let block_hash: String = env.get_string(block_hash).unwrap().into();

        let wallet_msg_class = env.find_class("info/scry/wallet_manager/NativeLib$Message").expect("find NativeLib$Message");
        let state_obj = env.alloc_object(wallet_msg_class).expect("create NativeLib$Message instance");
        let eee =wallets::module::EEE{};

        match eee.update_sync_record(&account,chain_type,block_num as u32,&block_hash) {
            Ok(_key) => {
                env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::OK as i32)).expect("set StatusCode value");
            }
            Err(msg) => {
                env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::DylibError as i32)).expect("set StatusCode value");
                env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(msg.to_string()).unwrap()))).expect("set message value");
            }
        }
        *state_obj
    }

    #[no_mangle]
    #[allow(non_snake_case)]
    pub extern "C" fn Java_info_scry_wallet_1manager_NativeLib_getEeeSyncRecord(env: JNIEnv, _class: JClass) -> jobject {

        let sync_status_class = env.find_class("info/scry/wallet_manager/NativeLib$SyncStatus").expect("find NativeLib$SyncStatus");
        let sync_status_obj = env.alloc_object(sync_status_class).expect("create NativeLib$Message instance");
        let map_class = env.find_class("java/util/HashMap").expect("HashMap");
        let map_obj = env.alloc_object(map_class).expect("array_list_class");
        env.call_method(map_obj, "<init>", "()V", &[]).expect("array_list_obj init method is exec");
        let eee = wallets::module::EEE{};
        match eee.get_sync_status() {
            Ok(sync_records)=> {
                let account_record_class = env.find_class("info/scry/wallet_manager/NativeLib$AccountRecord").expect("find NativeLib$EthToken class");
                for record in sync_records {
                    let account_record_class_obj = env.alloc_object(account_record_class).expect("alloc eth_token_class object");
                    //设置digit 属性
                    env.set_field(account_record_class_obj, "account", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(&record.account).unwrap()))).expect("account_record_class_obj set account value");
                    env.set_field(account_record_class_obj, "blockHash", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(record.block_hash).unwrap()))).expect("account_record_class_obj set block_hash value");
                    env.set_field(account_record_class_obj, "chainType", "I", JValue::Int(record.chain_type as i32)).expect("account_record_class_obj set chain_type value");
                    env.set_field(account_record_class_obj, "blockNum", "I", JValue::Int(record.block_num as i32)).expect("account_record_class_obj set block_num value");
                    env.call_method(map_obj, "put", "(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;", &[JObject::from(env.new_string(record.account).unwrap()).into(),account_record_class_obj.into()]).expect("map_obj put");
                }
                env.set_field(sync_status_obj, "status", "I", JValue::Int(StatusCode::OK as i32)).expect("set StatusCode value");
                env.set_field(sync_status_obj, "records", "Ljava/util/Map;", JValue::Object(map_obj)).expect("set records");
            },
            Err(msg)=>{
                env.set_field(sync_status_obj, "status", "I", JValue::Int(StatusCode::DylibError as i32)).expect("set status value ");
                env.set_field(sync_status_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(msg.to_string()).unwrap()))).expect("set error msg value ");
            }
        }
        *sync_status_obj

    }

}






