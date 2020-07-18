use super::*;
use ethereum_types::{H160, U256};
use jni::objects::{JObject, JValue, JClass, JString};
use wallets::model::{EeeChain, BtcChain, EthChain};
use jni::sys::{jint, jobject, jbyteArray};
use wallets::module::Chain;
use wallets::RawTransaction;


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
    let wallet_id: String = env.get_string(walletId).unwrap().into();
    let wallet_state_class = env.find_class("info/scry/wallet_manager/NativeLib$WalletState").expect("find wallet_state_class is error");
    let state_obj = env.alloc_object(wallet_state_class).expect("create wallet_state_class instance");

    match wallets::module::EEE::show_chain(wallet_id.as_str(), wallet_type as i64) {
        Ok(_) => {
            env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::OK as i32)).expect("find status type");
            env.set_field(state_obj, "isShowChain", "Z", JValue::Bool(1 as u8)).expect("set isShowChain value");
        }
        Err(msg) => {
            env.set_field(state_obj, "isShowChain", "Z", JValue::Bool(0 as u8)).expect("set isShowChain value");
            env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(msg.to_string()).unwrap()))).expect("set error msg value");
        }
    }
    *state_obj
}

#[no_mangle]
#[allow(non_snake_case)]
pub unsafe extern "C" fn Java_info_scry_wallet_1manager_NativeLib_hideChain(env: JNIEnv, _: JClass, walletId: JString, wallet_type: jint) -> jobject {
    let wallet_id: String = env.get_string(walletId).unwrap().into();
    let wallet_state_class = env.find_class("info/scry/wallet_manager/NativeLib$WalletState").expect("find NativeLib$WalletState");
    let state_obj = env.alloc_object(wallet_state_class).expect("create wallet_state_class instance");

    match wallets::module::EEE::hide_chain(wallet_id.as_str(), wallet_type as i64) {
        Ok(_) => {
            env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::OK as i32)).expect("find status type");
            env.set_field(state_obj, "isHideChain", "Z", JValue::Bool(1 as u8)).expect("set isHideChain value");
        }
        Err(msg) => {
            env.set_field(state_obj, "isHideChain", "Z", JValue::Bool(0 as u8)).expect("set isHideChain value");
            env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(msg.to_string()).unwrap()))).expect("set message");
        }
    }
    *state_obj
}


#[no_mangle]
#[allow(non_snake_case)]
pub unsafe extern "C" fn Java_info_scry_wallet_1manager_NativeLib_decodeAdditionData(env: JNIEnv, _: JClass, input: JString) -> jobject {
    let input: String = env.get_string(input).unwrap().into();

    let message_class = env.find_class("info/scry/wallet_manager/NativeLib$Message").expect("decodeAdditionData NativeLib$Message");
    let state_obj = env.alloc_object(message_class).expect("decodeAdditionData create state_obj");
    let eth = wallets::module::Ethereum {};
    match eth.decode_data(input.as_str()) {
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
    let wallet_id: String = env.get_string(walletId).unwrap().into();
    let wallet_state_class = env.find_class("info/scry/wallet_manager/NativeLib$WalletState").expect("find NativeLib$WalletState");
    let state_obj = env.alloc_object(wallet_state_class).expect("create wallet_state_class instance");
    match wallets::module::EEE::get_now_chain_type(wallet_id.as_str()) {
        Ok(code) => {
            env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::OK as i32)).expect("find status type");
            env.set_field(state_obj, "getNowChainType", "I", JValue::Int(code as i32)).expect("get nowChainType value");
        }
        Err(msg) => {
            //env.set_field(state_obj, "status", "Z", JValue::Bool(0 as u8)).expect("set isHideChain value");
            env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(msg.to_string()).unwrap()))).expect("set error message");
        }
    }
    *state_obj
}

#[no_mangle]
#[allow(non_snake_case)]
pub unsafe extern "C" fn Java_info_scry_wallet_1manager_NativeLib_setNowChainType(env: JNIEnv, _: JClass, walletId: JString, chain_type: jint) -> jobject {
    let wallet_id: String = env.get_string(walletId).unwrap().into();

    let wallet_state_class = env.find_class("info/scry/wallet_manager/NativeLib$WalletState").expect("setNowChainType wallet_state_class");
    let state_obj = env.alloc_object(wallet_state_class).expect("setNowChainType create state_obj");
    match wallets::module::EEE::set_now_chain_type(wallet_id.as_str(), chain_type as i64) {
        Ok(_) => {
            env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::OK as i32)).expect("set status");
            env.set_field(state_obj, "isSetNowChain", "Z", JValue::Bool(1 as u8)).expect("setNowChainType isSetNowChain");
        }
        Err(msg) => {
            env.set_field(state_obj, "isSetNowChain", "Z", JValue::Bool(0 as u8)).expect("isSetNowChain");
            env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(msg.to_string()).unwrap()))).expect("set message");
        }
    }
    *state_obj
}

#[no_mangle]
#[allow(non_snake_case)]
pub unsafe extern "C" fn Java_info_scry_wallet_1manager_NativeLib_ethTxSign(env: JNIEnv, _: JClass, walletId: JString, chainType: jint, fromAddress: JString,
                                                                            toAddress: JString, contractAddress: JString, value: JString, backup: JString, pwd: jbyteArray,
                                                                            gasPrice: JString, gasLimit: JString, nonce: JString, decimal: jint) -> jobject {
    let wallet_message_class = env.find_class("info/scry/wallet_manager/NativeLib$Message").expect("find wallet_message_class");
        let state_obj = env.alloc_object(wallet_message_class).expect("state_obj");

        //The sender account address can be linked by wallet id
         let from_address: String = env.get_string(fromAddress).unwrap().into();
         //Receiver account address
         let to_address: String = env.get_string(toAddress).unwrap().into();

         let to_address = {
             if to_address.is_empty() {
                 None
             } else {
                 let to = H160::from_slice(hex::decode(&to_address[2..]).unwrap().as_slice());
                 Some(to)
             }
         };
         //Call contract address
         let contract_address: String = env.get_string(contractAddress).unwrap().into();
         //The transfer amount is expressed here using this parameter
         let amount = {
             let value_str: String = env.get_string(value).unwrap().into();
             //Different tokens will have different accuracy
             wallets::convert_token(&value_str, decimal as usize).unwrap()
         };
         //Additional parameters
        let data: String = env.get_string(backup).unwrap().into();
        let data = if data.is_empty() {
            None
        } else {
            Some(data)
        };

        //gas price
        let gas_price: U256 = {
            let price_str: String = env.get_string(gasPrice).unwrap().into();
            //The unit used is gwei, which is ok
            wallets::convert_token(&price_str, 9).unwrap()
        };
        //Allow maximum gas consumption
        let gas_limit: U256 = {
            let gas_limit_str: String = env.get_string(gasLimit).unwrap().into();
            U256::from_dec_str(&gas_limit_str).unwrap()
        };
        //Nonce value of the current transaction
        let nonce: U256 = {
            let nonce_str: String = env.get_string(nonce).unwrap().into();
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

        //Use the private key confirmation code
        let pwd = env.convert_byte_array(pwd).unwrap();
        //The contract address is empty, it is an ordinary ETH transfer or deployment contract
        let ethereum = wallets::module::Ethereum {};

        let signed_ret = if contract_address.is_empty() {
            ethereum.raw_transfer_sign(&from_address, to_address, amount, &pwd, nonce, gas_limit, gas_price, data, chain_id as u64)
        } else {
            let contract_address = H160::from_slice(hex::decode(&contract_address[2..]).unwrap().as_slice());
            ethereum.raw_erc20_transfer_sign(&from_address, contract_address, to_address, amount, &pwd, nonce, gas_limit, gas_price, data, chain_id as u64)
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
pub extern "C" fn Java_info_scry_wallet_1manager_NativeLib_eeeTxSign(env: JNIEnv, _class: JClass, rawTx: JString, walletId: JString, psd: jbyteArray) -> jobject {
    let pwd = env.convert_byte_array(psd).unwrap();
    let raw_tx: String = env.get_string(rawTx).unwrap().into();
    let wallet_id: String = env.get_string(walletId).unwrap().into();

    let wallet_state_class = env.find_class("info/scry/wallet_manager/NativeLib$Message").expect("find NativeLib$Message");
    let state_obj = env.alloc_object(wallet_state_class).expect("create NativeLib$Message instance ");
    let eee = wallets::module::EEE {};
    match eee.raw_tx_sign(&raw_tx, &wallet_id, pwd.as_slice()) {
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
    let eee = wallets::module::EEE {};
    match eee.raw_sign(&raw_tx, &wallet_id, pwd.as_slice()) {
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
        //  Using the wallet method to construct transactions, the user transaction index will not reach the transaction volume caused by the forced conversion.
         let eee = wallets::module::EEE {};
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
pub extern "C" fn Java_info_scry_wallet_1manager_NativeLib_decodeAccountInfo(env: JNIEnv, _class: JClass, _encode_info: JString) -> jobject {
    let wallet_msg_class = env.find_class("info/scry/wallet_manager/NativeLib$Message").expect("find NativeLib$Message");

        let state_obj = env.alloc_object(wallet_msg_class).expect("create NativeLib$Message instance");
        /* let encode_info: String = env.get_string(encode_info).unwrap().into();
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
         }*/
        *state_obj
}

#[no_mangle]
#[allow(non_snake_case)]
pub extern "C" fn Java_info_scry_wallet_1manager_NativeLib_saveExtrinsicDetail(env: JNIEnv, _class: JClass, account_id: JString, event_detail: JString, block_hash: JString, extrinsics: JString) -> jobject {
    let account_id: String = env.get_string(account_id).unwrap().into();
    let encode_event_info: String = env.get_string(event_detail).unwrap().into();
    let block_hash: String = env.get_string(block_hash).unwrap().into();
    let block_extrinsics: String = env.get_string(extrinsics).unwrap().into();
    let wallet_msg_class = env.find_class("info/scry/wallet_manager/NativeLib$Message").expect("find NativeLib$Message");
    let state_obj = env.alloc_object(wallet_msg_class).expect("create NativeLib$Message instance");
    let eee = wallets::module::EEE {};
    match eee.save_tx_record(&account_id, &block_hash, &encode_event_info, &block_extrinsics) {
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
    let account: String = env.get_string(account).unwrap().into();  //String account,int chain_type,int block_num,String block_hash
    let block_hash: String = env.get_string(block_hash).unwrap().into();

    let wallet_msg_class = env.find_class("info/scry/wallet_manager/NativeLib$Message").expect("find NativeLib$Message");
    let state_obj = env.alloc_object(wallet_msg_class).expect("create NativeLib$Message instance");
    let eee = wallets::module::EEE {};

    match eee.update_sync_record(&account, chain_type, block_num as u32, &block_hash) {
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
                    env.call_method(map_obj, "put", "(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;", &[JObject::from(env.new_string(record.account).unwrap ()).into(), account_record_class_obj.into()]).expect("map_obj put");
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
