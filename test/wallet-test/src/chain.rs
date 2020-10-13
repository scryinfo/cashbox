use super::*;
use ethereum_types::{H160, U256};
use jni::objects::{JObject, JValue, JClass, JString};
use wallets::model::{EeeChain, BtcChain, EthChain};
use jni::sys::{jint, jobject, jbyteArray};
use wallets::module::Chain;


pub fn get_eee_chain_obj<'a, 'b>(env: &'a JNIEnv<'b>, eee_chain: EeeChain) -> JObject<'a> {
    let eee_digit_list_class = env.find_class("java/util/ArrayList").expect("find ArrayList");
    let eee_digit_class = env.find_class("info/scry/wallet_manager/NativeLib$EeeDigit").expect("NativeLib$EeeDigit class");
    let eee_chain_class = env.find_class("info/scry/wallet_manager/NativeLib$EeeChain").expect("NativeLib$EeeChain class");
    let chain_class_obj = env.alloc_object(eee_chain_class).expect("create eee_chain_class instance");
    env.set_field(chain_class_obj, "status", "I", JValue::Int(eee_chain.status as i32)).expect("set status value");
    let chain_id_str = format!("{}", eee_chain.chain_id);
    env.set_field(chain_class_obj, "chainId", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(chain_id_str).unwrap()))).expect("set chainId value");
    env.set_field(chain_class_obj, "walletId", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(eee_chain.wallet_id).unwrap()))).expect("walletId");
    env.set_field(chain_class_obj, "address", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(eee_chain.address.clone()).unwrap()))).expect("address");
    env.set_field(chain_class_obj, "pubkey", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(eee_chain.pub_key.clone()).unwrap()))).expect("pub_key");

    if eee_chain.domain.is_some() {
        env.set_field(chain_class_obj, "domain", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(eee_chain.domain.unwrap()).unwrap()))).expect("set domain value");
    }

    if eee_chain.is_visible.is_some() {
        let visible = eee_chain.is_visible.unwrap();
        env.set_field(chain_class_obj, "isVisible", "Z", JValue::Bool(visible as u8)).expect("get_eee_chain_obj is_visible");
    } else {
        println!("eee_chain.is_visible is none");
    }
    if eee_chain.chain_type.is_some() {
        let chain_type = eee_chain.chain_type.unwrap();
        env.set_field(chain_class_obj, "chainType", "I", JValue::Int(chain_type as i32)).expect("get_eee_chain_obj chain_type");
    }
    //There are multiple tokens under each chain, need to use List to store
    let digit_list_obj = env.alloc_object(eee_digit_list_class).expect("create digit_list_obj instance");
    env.call_method(digit_list_obj, "<init>", "()V", &[]).expect("chain chain obj init method is exec");

    for digit in eee_chain.digit_list {
        //Instantiate chain
        let digit_class_obj = env.alloc_object(eee_digit_class).expect("create eee_digit_class instance");
        //Set the digit attribute
        env.set_field(digit_class_obj, "status", "I", JValue::Int(digit.status as i32)).expect("set status value");

        env.set_field(digit_class_obj, "digitId", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(digit.digit_id).unwrap()))).expect("set digitId value");
        env.set_field(digit_class_obj, "chainId", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(digit.chain_id).unwrap()))).expect("set chainId value");

        // env.set_field(digit_class_obj, "address", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(eee_chain.address.clone()).unwrap()))).expect("set address value");

        if digit.contract_address.is_some() {
            env.set_field(digit_class_obj, "contractAddress", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(digit.contract_address.unwrap()).unwrap()))).expect("set contractAddress value");
        }
        if digit.shortname.is_some() {
            env.set_field(digit_class_obj, "shortName", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(digit.shortname.unwrap()).unwrap()))).expect("set shortName value");
        }
        if digit.fullname.is_some() {
            env.set_field(digit_class_obj, "fullName", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(digit.fullname.unwrap()).unwrap()))).expect("set fullName value");
        }
        if digit.balance.is_some() {
            env.set_field(digit_class_obj, "balance", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(digit.balance.unwrap()).unwrap()))).expect("set balance value");
        }
        if digit.is_visible.is_some() {
            let visible = digit.is_visible.unwrap();
            env.set_field(digit_class_obj, "isVisible", "Z", JValue::Bool(visible as u8)).expect("set isVisible value");
        }
        if digit.decimal.is_some() {
            let decimal = digit.decimal.unwrap();
            env.set_field(digit_class_obj, "decimal", "I", JValue::Int(decimal as i32)).expect("set decimal value");
        }

        if digit.imgurl.is_some() {
            env.set_field(digit_class_obj, "imgUrl", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(digit.imgurl.unwrap()).unwrap()))).expect("set imgUrl value");
        }

        env.call_method(digit_list_obj, "add", "(Ljava/lang/Object;)Z", &[digit_class_obj.into()]).expect("add chain instance is fail");
    }
    env.set_field(chain_class_obj, "digitList", "Ljava/util/List;", JValue::Object(digit_list_obj)).expect("set digitList");
    chain_class_obj
}


pub fn get_eth_chain_obj<'a, 'b>(env: &'a JNIEnv<'b>, eth_chain: EthChain) -> JObject<'a> {
    let eth_digit_list_class = env.find_class("java/util/ArrayList").expect("get_eth_chain_obj ArrayList type");
    let eth_digit_class = env.find_class("info/scry/wallet_manager/NativeLib$EthDigit").expect("get_eth_chain_obj NativeLib$EthDigit class");
    let eth_chain_class = env.find_class("info/scry/wallet_manager/NativeLib$EthChain").expect("get_eth_chain_obj NativeLib$EthChain class");
    let chain_class_obj = env.alloc_object(eth_chain_class).expect("get_eth_chain_obj  eth_chain_class");
    env.set_field(chain_class_obj, "status", "I", JValue::Int(eth_chain.status as i32)).expect("get_eth_chain_obj set status value");
    //let chain_id_str = format!("{}", eth_chain.chain_id);

    env.set_field(chain_class_obj, "chainId", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(eth_chain.chain_id).unwrap()))).expect("get_eth_chain_obj set chainId value");
    env.set_field(chain_class_obj, "walletId", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(eth_chain.wallet_id).unwrap()))).expect("get_eth_chain_obj set walletId value");
    env.set_field(chain_class_obj, "address", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(eth_chain.address).unwrap()))).expect("get_eth_chain_obj set address value");
    env.set_field(chain_class_obj, "pubkey", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(eth_chain.pub_key).unwrap()))).expect("get_eth_chain_obj set pub_key value");

    if eth_chain.domain.is_some() {
        env.set_field(chain_class_obj, "domain", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(eth_chain.domain.unwrap()).unwrap()))).expect("get_eth_chain_obj set domain value");
    }

    if eth_chain.is_visible.is_some() {
        let visible = eth_chain.is_visible.unwrap();
        env.set_field(chain_class_obj, "isVisible", "Z", JValue::Bool(visible as u8)).expect("get_eth_chain_obj is_visible");
    }
    if eth_chain.chain_type.is_some() {
        let chain_type = eth_chain.chain_type.unwrap();
        env.set_field(chain_class_obj, "chainType", "I", JValue::Int(chain_type as i32)).expect("get_eth_chain_obj chain_type ");
    }
    //There are multiple tokens under each chain, you need to use List to store
    let digit_list_obj = env.alloc_object(eth_digit_list_class).expect("get_eth_chain_obj eth_digit_list_class");
    env.call_method(digit_list_obj, "<init>", "()V", &[]).expect("get_eth_chain_obj digit_list_obj");

    for digit in eth_chain.digit_list {
        //Instantiate chain
        let digit_class_obj = env.alloc_object(eth_digit_class).expect("eth_digit_class create chain instance");
        //Set the digit attribute
        env.set_field(digit_class_obj, "status", "I", JValue::Int(digit.status as i32)).expect("get_eth_chain_obj set status value");
        env.set_field(digit_class_obj, "chainId", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(digit.chain_id).unwrap()))).expect("get_eth_chain_obj set chainId value");
        env.set_field(digit_class_obj, "digitId", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(digit.digit_id).unwrap()))).expect("get_eth_chain_obj set digitId value");
        /*   if digit.address.is_some() {
               env.set_field(digit_class_obj, "address", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(digit.address.unwrap()).unwrap()))).expect("get_eth_chain_obj set address value");
           }*/
        if digit.contract_address.is_some() {
            env.set_field(digit_class_obj, "contractAddress", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(digit.contract_address.unwrap()).unwrap()))).expect("get_eth_chain_obj set contractAddress value");
        }
        if digit.shortname.is_some() {
            env.set_field(digit_class_obj, "shortName", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(digit.shortname.unwrap()).unwrap()))).expect("get_eth_chain_obj set shortName value");
        }
        if digit.fullname.is_some() {
            env.set_field(digit_class_obj, "fullName", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(digit.fullname.unwrap()).unwrap()))).expect("get_eth_chain_obj set fullName value");
        }
        if digit.balance.is_some() {
            env.set_field(digit_class_obj, "balance", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(digit.balance.unwrap()).unwrap()))).expect("get_eth_chain_obj set balance value");
        }
        if digit.is_visible.is_some() {
            let visible = digit.is_visible.unwrap();
            env.set_field(digit_class_obj, "isVisible", "Z", JValue::Bool(visible as u8)).expect("get_eth_chain_obj set isVisible value");
        }
        if digit.decimal.is_some() {
            let decimal = digit.decimal.unwrap();
            env.set_field(digit_class_obj, "decimal", "I", JValue::Int(decimal as i32)).expect("get_eth_chain_obj set decimal value");
        }

        if digit.imgurl.is_some() {
            env.set_field(digit_class_obj, "imgUrl", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(digit.imgurl.unwrap()).unwrap()))).expect("get_eth_chain_obj set imgUrl value");
        }

        env.call_method(digit_list_obj, "add", "(Ljava/lang/Object;)Z", &[digit_class_obj.into()]).expect("add chain instance is fail");
    }
    env.set_field(chain_class_obj, "digitList", "Ljava/util/List;", JValue::Object(digit_list_obj)).expect("set digitList");
    chain_class_obj
}

pub fn get_btc_chain_obj<'a, 'b>(env: &'a JNIEnv<'b>, btc_chain: BtcChain) -> JObject<'a> {
    let btc_digit_list_class = env.find_class("java/util/ArrayList").expect("ArrayList");
    let btc_digit_class = env.find_class("info/scry/wallet_manager/NativeLib$BtcDigit").expect("NativeLib$BtcDigit class");
    let btc_chain_class = env.find_class("info/scry/wallet_manager/NativeLib$BtcChain").expect("NativeLib$BtcChain class");
    let chain_class_obj = env.alloc_object(btc_chain_class).expect("create chain_class instance");
    env.set_field(chain_class_obj, "status", "I", JValue::Int(btc_chain.status as i32)).expect("get_eth_chain_obj set status value");

    let chain_id_str = format!("{}", btc_chain.chain_id);
    env.set_field(chain_class_obj, "chainId", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(chain_id_str.clone()).unwrap()))).expect("get_btc_chain_obj set chainId value");
    env.set_field(chain_class_obj, "walletId", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(btc_chain.wallet_id).unwrap()))).expect("get_btc_chain_obj set walletId value");
    env.set_field(chain_class_obj, "address", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(btc_chain.address.clone()).unwrap()))).expect("get_btc_chain_obj set address value");
    env.set_field(chain_class_obj, "pubkey", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(btc_chain.pub_key.clone()).unwrap()))).expect("get_btc_chain_obj set pub_key value");

    if btc_chain.domain.is_some() {
        env.set_field(chain_class_obj, "domain", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(btc_chain.domain.unwrap()).unwrap()))).expect("get_btc_chain_obj set domain value");
    }

    if btc_chain.is_visible.is_some() {
        let visible = btc_chain.is_visible.unwrap();
        env.set_field(chain_class_obj, "isVisible", "Z", JValue::Bool(visible as u8)).expect("get_btc_chain_obj isVisible");
    }
    if btc_chain.chain_type.is_some() {
        let chain_type = btc_chain.chain_type.unwrap();
        env.set_field(chain_class_obj, "chainType", "I", JValue::Int(chain_type as i32)).expect("get_btc_chain_obj set chainType");
    }
    //There are multiple tokens under each chain, you need to use List to store
    let digit_list_obj = env.alloc_object(btc_digit_list_class).expect("btc_digit_list_class");
    env.call_method(digit_list_obj, "<init>", "()V", &[]).expect("chain chain obj init method is exec");

    for digit in btc_chain.digit_list {
        //Instantiate chain
        let digit_class_obj = env.alloc_object(btc_digit_class).expect("btc_digit_class");
        //Set the digit attribute
        env.set_field(digit_class_obj, "status", "I", JValue::Int(digit.status as i32)).expect("get_btc_chain_obj set status value");
        env.set_field(digit_class_obj, "chainId", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(chain_id_str.clone()).unwrap()))).expect("get_btc_chain_obj set chainId value");
        env.set_field(digit_class_obj, "digitId", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(digit.digit_id).unwrap()))).expect("get_btc_chain_obj set digitId value");

        if digit.shortname.is_some() {
            env.set_field(digit_class_obj, "shortName", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(digit.shortname.unwrap()).unwrap()))).expect("get_btc_chain_obj set shortName value");
        }
        if digit.fullname.is_some() {
            env.set_field(digit_class_obj, "fullName", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(digit.fullname.unwrap()).unwrap()))).expect("get_btc_chain_obj set fullName value");
        }
        if digit.balance.is_some() {
            env.set_field(digit_class_obj, "balance", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(digit.balance.unwrap()).unwrap()))).expect("get_btc_chain_obj set balance value");
        }
        if digit.is_visible.is_some() {
            let visible = digit.is_visible.unwrap();
            env.set_field(digit_class_obj, "isVisible", "Z", JValue::Bool(visible as u8)).expect("get_btc_chain_obj set isVisible value");
        }
        if digit.decimal.is_some() {
            let decimal = digit.decimal.unwrap();
            env.set_field(digit_class_obj, "decimal", "I", JValue::Int(decimal as i32)).expect("get_btc_chain_obj set decimal value");
        }

        if digit.imgurl.is_some() {
            env.set_field(digit_class_obj, "imgUrl", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(digit.imgurl.unwrap()).unwrap()))).expect("get_btc_chain_obj set imgUrl value");
        }
        env.call_method(digit_list_obj, "add", "(Ljava/lang/Object;)Z", &[digit_class_obj.into()]).expect("get_btc_chain_obj add chain instance");
    }
    env.set_field(chain_class_obj, "digitList", "Ljava/util/List;", JValue::Object(digit_list_obj)).expect("set digitList");
    chain_class_obj
}

#[no_mangle]
#[allow(non_snake_case)]
pub unsafe extern "C" fn Java_info_scry_wallet_1manager_NativeLib_showChain(env: JNIEnv, _: JClass, walletId: JString, wallet_type: jint) -> jobject {
    let wallet_id: JniResult<String> = env.get_string(walletId).map(|value| value.into());
    let wallet_state_class = env.find_class("info/scry/wallet_manager/NativeLib$WalletState").expect("find wallet_state_class is error");
    let state_obj = env.alloc_object(wallet_state_class).expect("create wallet_state_class instance");

    if wallet_id.is_err() {
        env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::ParameterFormatWrong as i32)).expect("set showChain StatusCode ");
        env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string("input parameter incorrect").unwrap()))).expect("set showChain message");
        return *state_obj;
    }
    match wallets::module::EEE::show_chain(&wallet_id.unwrap(), wallet_type as i64) {
        Ok(ret) => {
            env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::OK as i32)).expect("find status type");
            env.set_field(state_obj, "isShowChain", "Z", JValue::Bool(ret as u8)).expect("set isShowChain value");
        }
        Err(msg) => {
            env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::DylibError as i32)).expect("set showChain value ");
            env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(msg.to_string()).unwrap()))).expect("set error msg value");
        }
    }
    *state_obj
}

#[no_mangle]
#[allow(non_snake_case)]
pub unsafe extern "C" fn Java_info_scry_wallet_1manager_NativeLib_hideChain(env: JNIEnv, _: JClass, walletId: JString, wallet_type: jint) -> jobject {
    let wallet_id: JniResult<String> = env.get_string(walletId).map(|value| value.into());
    let wallet_state_class = env.find_class("info/scry/wallet_manager/NativeLib$WalletState").expect("find NativeLib$WalletState");
    let state_obj = env.alloc_object(wallet_state_class).expect("create wallet_state_class instance");

    if let Ok(wallet_id) = wallet_id{
        match wallets::module::EEE::hide_chain(&wallet_id, wallet_type as i64) {
            Ok(ret) => {
                env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::OK as i32)).expect("find status type");
                env.set_field(state_obj, "isHideChain", "Z", JValue::Bool(ret as u8)).expect("set isHideChain value");
            }
            Err(msg) => {
                env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::DylibError as i32)).expect("set isHideChain value ");
                env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(msg.to_string()).unwrap()))).expect("set message");
            }
        }
    }else {
        env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::ParameterFormatWrong as i32)).expect("set hideChain StatusCode ");
        env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string("input parameter incorrect").unwrap()))).expect("set hideChain message");
    }
    *state_obj
}


#[no_mangle]
#[allow(non_snake_case)]
pub unsafe extern "C" fn Java_info_scry_wallet_1manager_NativeLib_decodeAdditionData(env: JNIEnv, _: JClass, input: JString) -> jobject {
    let input: JniResult<String> = env.get_string(input).map(|value| value.into());

    let message_class = env.find_class("info/scry/wallet_manager/NativeLib$Message").expect("decodeAdditionData NativeLib$Message");
    let state_obj = env.alloc_object(message_class).expect("decodeAdditionData create state_obj");
    if input.is_err() {
        env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::ParameterFormatWrong as i32)).expect("set decodeAdditionData StatusCode ");
        env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string("input parameter incorrect").unwrap()))).expect("set decodeAdditionData message");
        return *state_obj;
    }
    let eth = wallets::module::Ethereum {};
    match eth.decode_data(&input.unwrap()) {
        Ok(data) => {
            env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::OK as i32)).expect("set status");
            env.set_field(state_obj, "inputInfo", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(data).unwrap()))).expect("set inputInfo");
        }
        Err(msg) => {
            env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::DylibError as i32)).expect("set status");
            env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(msg.to_string()).unwrap()))).expect("set message");
        }
    }
    *state_obj
}

#[no_mangle]
#[allow(non_snake_case)]
pub unsafe extern "C" fn Java_info_scry_wallet_1manager_NativeLib_getNowChainType(env: JNIEnv, _: JClass, walletId: JString) -> jobject {
    let wallet_id: JniResult<String> = env.get_string(walletId).map(|value| value.into());
    let wallet_state_class = env.find_class("info/scry/wallet_manager/NativeLib$WalletState").expect("find NativeLib$WalletState");
    let state_obj = env.alloc_object(wallet_state_class).expect("create wallet_state_class instance");
    if let Ok(wallet_id) = wallet_id{
        match wallets::module::EEE::get_now_chain_type(&wallet_id) {
            Ok(code) => {
                env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::OK as i32)).expect("find status type");
                env.set_field(state_obj, "getNowChainType", "I", JValue::Int(code as i32)).expect("get nowChainType value");
            }
            Err(msg) => {
                env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::DylibError as i32)).expect("set status");
                env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(msg.to_string()).unwrap()))).expect("set error message");
            }
        }
    }else {
        env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::ParameterFormatWrong as i32)).expect("set nowChainType StatusCode ");
        env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string("input parameter incorrect").unwrap()))).expect("set nowChainType message");
    }
    *state_obj
}

#[no_mangle]
#[allow(non_snake_case)]
pub unsafe extern "C" fn Java_info_scry_wallet_1manager_NativeLib_setNowChainType(env: JNIEnv, _: JClass, walletId: JString, chain_type: jint) -> jobject {
    let wallet_id: JniResult<String> = env.get_string(walletId).map(|value| value.into());

    let wallet_state_class = env.find_class("info/scry/wallet_manager/NativeLib$WalletState").expect("setNowChainType wallet_state_class");
    let state_obj = env.alloc_object(wallet_state_class).expect("setNowChainType create state_obj");
    if let Ok(wallet_id) = wallet_id{
        match wallets::module::EEE::set_now_chain_type(&wallet_id, chain_type as i64) {
            Ok(_) => {
                env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::OK as i32)).expect("set status");
                env.set_field(state_obj, "isSetNowChain", "Z", JValue::Bool(1 as u8)).expect("setNowChainType isSetNowChain");
            }
            Err(msg) => {
                env.set_field(state_obj, "isSetNowChain", "Z", JValue::Bool(0 as u8)).expect("isSetNowChain");
                env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(msg.to_string()).unwrap()))).expect("set message");
            }
        }
    }else {
        env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::ParameterFormatWrong as i32)).expect("set setNowChainType StatusCode ");
        env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string("input parameter incorrect").unwrap()))).expect("set setNowChainType message");
    }
    *state_obj
}

#[no_mangle]
#[allow(non_snake_case)]
pub unsafe extern "C" fn Java_info_scry_wallet_1manager_NativeLib_ethTxSign(env: JNIEnv, _: JClass, _walletId: JString, chainType: jint, fromAddress: JString,
                                                                            toAddress: JString, contractAddress: JString, value: JString, backup: JString, pwd: jbyteArray,
                                                                            gasPrice: JString, gasLimit: JString, nonce: JString, decimal: jint) -> jobject {
    let wallet_message_class = env.find_class("info/scry/wallet_manager/NativeLib$Message").expect("find wallet_message_class");
    let state_obj = env.alloc_object(wallet_message_class).expect("state_obj");
    //The sender account address can be linked by wallet id
    let from_address: JniResult<String> = env.get_string(fromAddress).map(|value| value.into());
    //Receiver account address
    let to_address: JniResult<String> = env.get_string(toAddress).map(|value| value.into());
    //Call contract address
    let contract_address: JniResult<String> = env.get_string(contractAddress).map(|value| value.into());

    let value: JniResult<String> = env.get_string(value).map(|value| value.into());
    let nonce: JniResult<String> = env.get_string(nonce).map(|value| value.into());
    let gas_limit: JniResult<String> = env.get_string(gasLimit).map(|value| value.into());

    let price: JniResult<String> = env.get_string(gasPrice).map(|value| value.into());
    //Additional parameters
    let data: JniResult<String> = env.get_string(backup).map(|value| value.into());
    let pwd = env.convert_byte_array(pwd);

    if from_address.is_err()||to_address.is_err()||contract_address.is_err()||gas_limit.is_err()||price.is_err()||data.is_err()||pwd.is_err()||nonce.is_err(){
        env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::ParameterFormatWrong as i32)).expect("set updateDigitBalance StatusCode ");
        env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string("input parameter incorrect").unwrap()))).expect("set updateDigitBalance message");
        return *state_obj;
    }
    let to_address = {
        let to_address = to_address.unwrap();
        if to_address.is_empty() {
            None
        } else {
            let to = H160::from_slice(hex::decode(&to_address[2..]).unwrap().as_slice());
            Some(to)
        }
    };
    //The transfer amount is expressed here using this parameter
    let amount = {
        //Different tokens will have different accuracy
        wallets::convert_token(&value.unwrap(), decimal as usize).unwrap()
    };
    //Additional parameters
    let data = data.unwrap();
    let data = if data.is_empty() {
        None
    } else {
        Some(data)
    };
    //gas price
    let gas_price: U256 = wallets::convert_token(&price.unwrap(), 9).unwrap();
    //Allow maximum gas consumption
    let gas_limit: U256 = U256::from_dec_str(&gas_limit.unwrap()).unwrap();
    //Nonce value of the current transaction
    let nonce: U256 = {
        let nonce_str = nonce.unwrap();
        let nonce = if nonce_str.starts_with("0x") {
            let nonce_u64 = u64::from_str_radix(&nonce_str[2..], 16);
            format!("{}", nonce_u64.unwrap())
        } else {
            nonce_str
        };
        U256::from_dec_str(&nonce).unwrap()
    };
    //The current wallet only uses 3 and 4 to represent the Ethereum main chain and test chain by default. According to the chain type, it is converted to the chain_id defined by the Ethereum standard, and the conversion is done as follows 3->1,4->3, the rest remain unchanged
    let chain_id = {
        if chainType == 3 {
            1
        } else if chainType == 4 {
            3
        } else {//For this situation, it is used to test with another chain type during the development process
            chainType
        }
    };
    //The contract address is empty, it is an ordinary ETH transfer or deployment contract
    let ethereum = wallets::module::Ethereum {};
    let contract_address = contract_address.unwrap();
    let signed_ret = if contract_address.is_empty() {
        ethereum.raw_transfer_sign(&from_address.unwrap(), to_address, amount, &pwd.unwrap(), nonce, gas_limit, gas_price, data, chain_id as u64)
    } else {
        let contract_address = H160::from_slice(hex::decode(&contract_address[2..]).unwrap().as_slice());
        ethereum.raw_erc20_transfer_sign(&from_address.unwrap(), contract_address, to_address, amount, &pwd.unwrap(), nonce, gas_limit, gas_price, data, chain_id as u64)
    };
    match signed_ret {
        Ok(data) => {
            env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::OK as i32)).expect("set status");
            env.set_field(state_obj, "ethSignedInfo", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(data).unwrap()))).expect("set ethSignedInfo");
        }
        Err(msg) => {
            env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::PwdIsWrong as i32)).expect("set status");
            env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(msg.to_string()).unwrap()))).expect("set message");
        }
    }
    *state_obj
}

#[no_mangle]
#[allow(non_snake_case)]
pub unsafe extern "C" fn Java_info_scry_wallet_1manager_NativeLib_ethRawTxSign(env: JNIEnv, _: JClass, rawTx: JString, chainType: jint, fromAddress: JString, psd: jbyteArray) -> jobject {
    let wallet_state_class = env.find_class("info/scry/wallet_manager/NativeLib$Message").expect("find NativeLib$Message");
    let state_obj = env.alloc_object(wallet_state_class).expect("create NativeLib$Message instance ");

    let pwd = env.convert_byte_array(psd);
    let raw_tx:JniResult<String> = env.get_string(rawTx).map(|value| value.into());
    let from_address: JniResult<String> = env.get_string(fromAddress).map(|value| value.into());

    if pwd.is_err()||raw_tx.is_err()||from_address.is_err() {
        env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::ParameterFormatWrong as i32)).expect("set ethRawTxSign StatusCode ");
        env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string("input parameter incorrect").unwrap()))).expect("set ethRawTxSign message");
        return *state_obj;
    }
    //The current wallet only uses 3 and 4 to represent the Ethereum main chain and test chain by default. According to the chain type, it is converted to the chain_id defined by the Ethereum standard, and the conversion is done as follows 3->1,4->3, the rest remain unchanged
    let chain_id = {
        if chainType == 3 {
            1
        } else if chainType == 4 {
            3
        } else {//For this situation, it is used to test with another chain type during the development process
            chainType
        }
    };

    let eth = wallets::module::Ethereum {};
    match eth.raw_tx_sign(&raw_tx.unwrap(), chain_id as u64, &from_address.unwrap(), &pwd.unwrap()) {
        Ok(data) => {
            env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::OK as i32)).expect("set StatusCode ");
            env.set_field(state_obj, "ethSignedInfo", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(data).unwrap()))).expect("set signedInfo");
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
pub extern "C" fn Java_info_scry_wallet_1manager_NativeLib_eeeTxSign(env: JNIEnv, _class: JClass, rawTx: JString, walletId: JString, psd: jbyteArray) -> jobject {
    let pwd = env.convert_byte_array(psd);
    let raw_tx: JniResult<String> = env.get_string(rawTx).map(|value| value.into());
    let wallet_id: JniResult<String> = env.get_string(walletId).map(|value| value.into());

    let wallet_state_class = env.find_class("info/scry/wallet_manager/NativeLib$Message").expect("find NativeLib$Message");
    let state_obj = env.alloc_object(wallet_state_class).expect("create NativeLib$Message instance ");

    if pwd.is_err()||raw_tx.is_err()||wallet_id.is_err() {
        env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::ParameterFormatWrong as i32)).expect("set updateDigitBalance StatusCode ");
        env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string("input parameter incorrect").unwrap()))).expect("set updateDigitBalance message");
        return *state_obj;
    }

    let eee = wallets::module::EEE {};
    match eee.raw_tx_sign(&raw_tx.unwrap(), &wallet_id.unwrap(), &pwd.unwrap()) {
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
    let pwd = env.convert_byte_array(psd);
    let raw_tx: JniResult<String> = env.get_string(rawTx).map(|value| value.into());
    let wallet_id: JniResult<String> = env.get_string(walletId).map(|value| value.into());

    let wallet_state_class = env.find_class("info/scry/wallet_manager/NativeLib$Message").expect("find NativeLib$Message");
    let state_obj = env.alloc_object(wallet_state_class).expect("create wallet_state_class instance ");
    if pwd.is_err()||raw_tx.is_err()||wallet_id.is_err() {
        env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::ParameterFormatWrong as i32)).expect("set eeeSign StatusCode ");
        env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string("input parameter incorrect").unwrap()))).expect("set eeeSign message");
        return *state_obj;
    }
    let eee = wallets::module::EEE {};
    match eee.raw_sign(&raw_tx.unwrap(), &wallet_id.unwrap(), &pwd.unwrap()) {
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
pub extern "C" fn Java_info_scry_wallet_1manager_NativeLib_eeeTransfer(env: JNIEnv, _class: JClass, from: JString, to: JString, value: JString, genesisHash: JString, index: jint, runtime_version: jint, tx_version: jint, pwd: jbyteArray) -> jobject {
    let wallet_state_class = env.find_class("info/scry/wallet_manager/NativeLib$Message").expect("findNativeLib$Message");
    let state_obj = env.alloc_object(wallet_state_class).expect("create NativeLib$Message instance ");

    let pwd = env.convert_byte_array(pwd);
    let from:JniResult<String> = env.get_string(from).map(|value| value.into());
    let genesis_hash:JniResult<String> = env.get_string(genesisHash).map(|value| value.into());
    let to :JniResult<String>= env.get_string(to).map(|value| value.into());
    let amount:JniResult<String> = env.get_string(value).map(|value| value.into());
    if pwd.is_err()||from.is_err()||genesis_hash.is_err()||to.is_err()||amount.is_err() {
        env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::ParameterFormatWrong as i32)).expect("eeeTransfer set StatusCode value ");
        env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string("input parameter format not support".to_string()).unwrap()))).expect("eeeTransfer set message value");
    }else {
        let eee = wallets::module::EEE {};
        match eee.generate_eee_transfer(&from.unwrap(), &to.unwrap(), &amount.unwrap(), &genesis_hash.unwrap(), index as u32, runtime_version as u32, tx_version as u32, pwd.unwrap().as_slice()) {
            Ok(data) => {
                env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::OK as i32)).expect("set StatusCode value");
                env.set_field(state_obj, "signedInfo", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(data).unwrap()))).expect("eeeTransfer set signedInfo value");
            }
            Err(msg) => {
                env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::PwdIsWrong as i32)).expect("eeeTransfer set StatusCode value ");
                env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(msg.to_string()).unwrap()))).expect("eeeTransfer set message value");
            }
        }
    }
    *state_obj
}

#[no_mangle]
#[allow(non_snake_case)]
pub extern "C" fn Java_info_scry_wallet_1manager_NativeLib_tokenXTransfer(env: JNIEnv, _class: JClass, from: JString, to: JString, value: JString, extData: JString, genesisHash: JString, index: jint, runtime_version: jint, tx_version: jint, pwd: jbyteArray) -> jobject {
    let pwd = env.convert_byte_array(pwd);
    let from: JniResult<String> = env.get_string(from).map(|value| value.into());
    let genesis_hash: JniResult<String> = env.get_string(genesisHash).map(|value| value.into());
    let to: JniResult<String> = env.get_string(to).map(|value| value.into());
    let ext_data: JniResult<String> = env.get_string(extData).map(|value| value.into());
    let value: JniResult<String> = env.get_string(value).map(|value| value.into());

    let wallet_state_class = env.find_class("info/scry/wallet_manager/NativeLib$Message").expect("findNativeLib$Message");
    let state_obj = env.alloc_object(wallet_state_class).expect("create NativeLib$Message instance ");
    if value.is_err()||ext_data.is_err()||to.is_err()||genesis_hash.is_err()||from.is_err()||pwd.is_err() {
        env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::ParameterFormatWrong as i32)).expect("set updateDigitBalance StatusCode ");
        env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string("input parameter incorrect").unwrap()))).expect("set updateDigitBalance message");
        return *state_obj;
    }
    //  Using the wallet method to construct transactions, the user transaction index will not reach the transaction volume caused by the forced conversion.
    let eee = wallets::module::EEE {};
    match eee.generate_tokenx_transfer(&from.unwrap(), &to.unwrap(), &value.unwrap(), &ext_data.unwrap(), &genesis_hash.unwrap(), index as u32, runtime_version as u32, tx_version as u32, &pwd.unwrap()) {
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
pub extern "C" fn Java_info_scry_wallet_1manager_NativeLib_eeeStorageKey(env: JNIEnv, _class: JClass, module: JString, storageItem: JString, pub_key: JString) -> jobject {
    let module: JniResult<String> = env.get_string(module).map(|value| value.into());
    let storage_item: JniResult<String> = env.get_string(storageItem).map(|value| value.into());
    let pub_key: JniResult<String> = env.get_string(pub_key).map(|value| value.into());

    let wallet_msg_class = env.find_class("info/scry/wallet_manager/NativeLib$Message").expect("find NativeLib$Message");
    let state_obj = env.alloc_object(wallet_msg_class).expect("create NativeLib$Message instance");

    if module.is_err()||storage_item.is_err()||pub_key.is_err() {
        env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::ParameterFormatWrong as i32)).expect("set updateDigitBalance StatusCode ");
        env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string("input parameter incorrect").unwrap()))).expect("set updateDigitBalance message");
        return *state_obj;
    }

    match wallets::encode_account_storage_key(&module.unwrap(), &storage_item.unwrap(), &pub_key.unwrap()) {
        Ok(key) => {
            env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::OK as i32)).expect("set StatusCode value");
            env.set_field(state_obj, "storageKeyInfo", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(key).unwrap()))).expect("set accountKeyInfo value");
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
    let wallet_msg_class = env.find_class("info/scry/wallet_manager/NativeLib$Message").expect("find NativeLib$Message");
    let state_obj = env.alloc_object(wallet_msg_class).expect("create NativeLib$Message instance");
    let encode_info: JniResult<String> = env.get_string(encode_info).map(|value| value.into());
    if let  Ok(info) = encode_info{
        match wallets::decode_account_info(&info) {
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
    }else {
        env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::ParameterFormatWrong as i32)).expect("set decodeAccountInfo StatusCode ");
        env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string("input parameter incorrect").unwrap()))).expect("set decodeAccountInfo message");
    }
    *state_obj
}

#[no_mangle]
#[allow(non_snake_case)]
pub extern "C" fn Java_info_scry_wallet_1manager_NativeLib_saveExtrinsicDetail(env: JNIEnv, _class: JClass, account_id: JString, event_detail: JString, block_hash: JString, extrinsics: JString) -> jobject {
    let account_id: JniResult<String> = env.get_string(account_id).map(|value| value.into());
    let encode_event_info: JniResult<String> = env.get_string(event_detail).map(|value| value.into());
    let block_hash: JniResult<String> = env.get_string(block_hash).map(|value| value.into());
    let block_extrinsics: JniResult<String> = env.get_string(extrinsics).map(|value| value.into());

    let wallet_msg_class = env.find_class("info/scry/wallet_manager/NativeLib$Message").expect("find NativeLib$Message");
    let state_obj = env.alloc_object(wallet_msg_class).expect("create NativeLib$Message instance");

    if account_id.is_err()||encode_event_info.is_err()||block_hash.is_err()||block_extrinsics.is_err() {
        env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::ParameterFormatWrong as i32)).expect("set saveExtrinsicDetail StatusCode ");
        env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string("input parameter incorrect").unwrap()))).expect("set saveExtrinsicDetail message");
        return *state_obj
    }

    let eee = wallets::module::EEE {};
    match eee.save_tx_record(&account_id.unwrap(), &block_hash.unwrap(), &encode_event_info.unwrap(), &block_extrinsics.unwrap()) {
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
pub extern "C" fn Java_info_scry_wallet_1manager_NativeLib_updateEeeSyncRecord(env: JNIEnv, _class: JClass, account: JString, chain_type: jint, block_num: jint, block_hash: JString) -> jobject {
    let account: JniResult<String> = env.get_string(account).map(|value| value.into());  //String account,int chain_type,int block_num,String block_hash
    let block_hash: JniResult<String> = env.get_string(block_hash).map(|value| value.into());

    let wallet_msg_class = env.find_class("info/scry/wallet_manager/NativeLib$Message").expect("find NativeLib$Message");
    let state_obj = env.alloc_object(wallet_msg_class).expect("create NativeLib$Message instance");

    if account.is_err()||block_hash.is_err() {
        env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::ParameterFormatWrong as i32)).expect("set updateEeeSyncRecord StatusCode ");
        env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string("input parameter incorrect").unwrap()))).expect("set updateEeeSyncRecord message");
        return *state_obj
    }

    let eee = wallets::module::EEE {};
    match eee.update_sync_record(&account.unwrap(), chain_type, block_num as u32, &block_hash.unwrap()) {
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
    let eee = wallets::module::EEE {};
    match eee.get_sync_status() {
        Ok(sync_records) => {
            let account_record_class = env.find_class("info/scry/wallet_manager/NativeLib$AccountRecord").expect("find NativeLib$EthToken class");
            for record in sync_records {
                let account_record_class_obj = env.alloc_object(account_record_class).expect("alloc eth_token_class object");
                //Set digit property
                env.set_field(account_record_class_obj, "account", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(&record.account).unwrap()))).expect("account_record_class_obj set account value");
                env.set_field(account_record_class_obj, "blockHash", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(record.block_hash).unwrap()))).expect("account_record_class_obj set block_hash value");
                env.set_field(account_record_class_obj, "chainType", "I", JValue::Int(record.chain_type as i32)).expect("account_record_class_obj set chain_type value");
                env.set_field(account_record_class_obj, "blockNum", "I", JValue::Int(record.block_num as i32)).expect("account_record_class_obj set block_num value");
                env.call_method(map_obj, "put", "(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;", &[JObject::from(env.new_string(record.account).unwrap()).into(), account_record_class_obj.into()]).expect("map_obj put");
            }
            env.set_field(sync_status_obj, "status", "I", JValue::Int(StatusCode::OK as i32)).expect("set StatusCode value");
            env.set_field(sync_status_obj, "records", "Ljava/util/Map;", JValue::Object(map_obj)).expect("set records");
        }
        Err(msg) => {
            env.set_field(sync_status_obj, "status", "I", JValue::Int(StatusCode::DylibError as i32)).expect("set status value ");
            env.set_field(sync_status_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(msg.to_string()).unwrap()))).expect("set error msg value ");
        }
    }
    *sync_status_obj
}

#[no_mangle]
#[allow(non_snake_case)]
pub extern "C" fn Java_info_scry_wallet_1manager_NativeLib_loadEeeChainTxListHistory(env: JNIEnv, _class: JClass, account: JString, tokenName: JString, startIndex: jint, offset: jint) -> jobject {
    let history_class = env.find_class("info/scry/wallet_manager/NativeLib$EeeChainTxListHistory").expect("find NativeLib$EeeChainTxListHistory");
    let history_class_obj = env.alloc_object(history_class).expect("create NativeLib$Message instance");
    let account: JniResult<String> = env.get_string(account).map(|value| value.into());
    let tokenName: JniResult<String> = env.get_string(tokenName).map(|value| value.into());

    if account.is_err()||tokenName.is_err() {
        env.set_field(history_class_obj, "status", "I", JValue::Int(StatusCode::ParameterFormatWrong as i32)).expect("set loadEeeChainTxListHistory StatusCode ");
        env.set_field(history_class_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string("input parameter incorrect").unwrap()))).expect("set loadEeeChainTxListHistory message");
        return *history_class_obj
    }

    let array_list_class = env.find_class("java/util/ArrayList").expect("ArrayList");
    let array_list_obj = env.alloc_object(array_list_class).expect("array_list_class");
    env.call_method(array_list_obj, "<init>", "()V", &[]).expect("array_list_obj init method is exec");
    let eee = wallets::module::EEE {};
    match eee.query_tx_record(&account.unwrap(), &tokenName.unwrap(), startIndex as u32, offset as u32) {
        Ok(tx_records) => {
            let tx_record_class = env.find_class("info/scry/wallet_manager/NativeLib$EeeChainTxDetail").expect("find NativeLib$EeeChainTxListHistory class");
            for record in tx_records {
                let tx_record_class_obj = env.alloc_object(tx_record_class).expect("alloc eth_token_class object");
                //Set record property
                env.set_field(tx_record_class_obj, "txHash", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(record.tx_hash).unwrap()))).expect("tx_record_class_obj set blockHash value");
                env.set_field(tx_record_class_obj, "blockHash", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(record.block_hash).unwrap()))).expect("tx_record_class_obj set blockHash value");
                let from = if let Some(from) = record.from { from } else { "".to_string() };
                env.set_field(tx_record_class_obj, "from", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(from).unwrap()))).expect("tx_record_class_obj set from value");
                let to = if let Some(to) = record.to { to } else { "".to_string() };
                env.set_field(tx_record_class_obj, "to", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(to).unwrap()))).expect("tx_record_class_obj set to value");
                let value = if let Some(value) = record.value { value } else { "".to_string() };
                env.set_field(tx_record_class_obj, "value", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(value).unwrap()))).expect("tx_record_class_obj set value value");
                let ext_data = if let Some(ext_data) = record.ext_data { ext_data } else { "".to_string() };
                env.set_field(tx_record_class_obj, "inputMsg", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(ext_data).unwrap()))).expect("tx_record_class_obj set inputMsg value");
                let fees = if let Some(fees) = record.fees { fees } else { "".to_string() };
                env.set_field(tx_record_class_obj, "gasFee", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(fees).unwrap()))).expect("tx_record_class_obj set gasFee value");
                env.set_field(tx_record_class_obj, "signer", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(record.signer).unwrap()))).expect("tx_record_class_obj set signer value");
                env.set_field(tx_record_class_obj, "timestamp", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(record.timestamp).unwrap()))).expect("tx_record_class_obj set timestamp value");
                env.set_field(tx_record_class_obj, "isSuccess", "Z", JValue::Bool(record.is_success as u8)).expect("set isSuccess value");
                env.call_method(array_list_obj, "add", "(Ljava/lang/Object;)Z", &[tx_record_class_obj.into()]).expect("array_list_obj add tx record instance");
            }
            env.set_field(history_class_obj, "status", "I", JValue::Int(StatusCode::OK as i32)).expect("history_class_obj set status value");
            env.set_field(history_class_obj, "eeeChainTxDetail", "Ljava/util/List;", JValue::Object(array_list_obj)).expect("history_class_obj set eeeChainTxDetail");
        }
        Err(msg) => {
            env.set_field(history_class_obj, "status", "I", JValue::Int(StatusCode::DylibError as i32)).expect("set status value ");
            env.set_field(history_class_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(msg.to_string()).unwrap()))).expect("set error msg value ");
        }
    }
    *history_class_obj
}

