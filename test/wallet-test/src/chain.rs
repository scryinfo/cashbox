use super::*;
use ethereum_types::{H160,U256};
use jni::objects::{JObject, JValue,JClass,JString};
use wallets::model::{EeeChain,BtcChain,EthChain};
use jni::sys::{jint, jobject, jbyteArray};
use wallets::module::Chain;


pub fn get_eee_chain_obj<'a, 'b>(env:  &'a JNIEnv<'b>,eee_chain:EeeChain)->JObject<'a>{
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
    }else{
        println!("eee_chain.is_visible is none");
    }
    if eee_chain.chain_type.is_some() {
        let chain_type = eee_chain.chain_type.unwrap();
        env.set_field(chain_class_obj, "chainType", "I", JValue::Int(chain_type as i32)).expect("get_eee_chain_obj chain_type");
    }
    //每一条链下存在多个代币，需要使用List来存储
    let digit_list_obj = env.alloc_object(eee_digit_list_class).expect("create digit_list_obj instance");
    env.call_method(digit_list_obj, "<init>", "()V", &[]).expect("chain chain obj init method is exec");

    for digit in eee_chain.digit_list {
        //实例化 chain
        let digit_class_obj = env.alloc_object(eee_digit_class).expect("create eee_digit_class instance");
        //设置digit 属性
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
    env.set_field(chain_class_obj,"digitList","Ljava/util/List;",JValue::Object(digit_list_obj)).expect("set digitList");
    chain_class_obj
}


pub fn get_eth_chain_obj<'a, 'b>(env:  &'a JNIEnv<'b>,eth_chain:EthChain)->JObject<'a>{
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
    //每一条链下存在多个代币，需要使用List来存储
    let digit_list_obj = env.alloc_object(eth_digit_list_class).expect("get_eth_chain_obj eth_digit_list_class");
    env.call_method(digit_list_obj, "<init>", "()V", &[]).expect("get_eth_chain_obj digit_list_obj");

    for digit in eth_chain.digit_list {
        //实例化 chain
        let digit_class_obj = env.alloc_object(eth_digit_class).expect("eth_digit_class create chain instance");
        //设置digit 属性
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
    env.set_field(chain_class_obj,"digitList","Ljava/util/List;",JValue::Object(digit_list_obj)).expect("set digitList");
    chain_class_obj
}

pub fn get_btc_chain_obj<'a, 'b>(env:  &'a JNIEnv<'b>,btc_chain:BtcChain)->JObject<'a>{
    let btc_digit_list_class = env.find_class("java/util/ArrayList").expect("ArrayList");
    let btc_digit_class = env.find_class("info/scry/wallet_manager/NativeLib$BtcDigit").expect("NativeLib$BtcDigit class");
    let btc_chain_class = env.find_class("info/scry/wallet_manager/NativeLib$BtcChain").expect("NativeLib$BtcChain class");
    let chain_class_obj = env.alloc_object(btc_chain_class).expect("create chain_class instance");
    env.set_field(chain_class_obj, "status", "I", JValue::Int(btc_chain.status as i32)).expect("get_eth_chain_obj set status value");

    let chain_id_str = format!("{}", btc_chain.chain_id);
    env.set_field(chain_class_obj, "chainId", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(chain_id_str).unwrap()))).expect("get_btc_chain_obj set chainId value");
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
    //每一条链下存在多个代币，需要使用List来存储
    let digit_list_obj = env.alloc_object(btc_digit_list_class).expect("btc_digit_list_class");
    env.call_method(digit_list_obj, "<init>", "()V", &[]).expect("chain chain obj init method is exec");

    for digit in btc_chain.digit_list {
        //实例化 chain
        let digit_class_obj = env.alloc_object(btc_digit_class).expect("btc_digit_class");
        //设置digit 属性
        env.set_field(digit_class_obj, "status", "I", JValue::Int(digit.status as i32)).expect("get_btc_chain_obj set status value");

        env.set_field(digit_class_obj, "digitId", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(digit.digit_id).unwrap()))).expect("get_btc_chain_obj set digitId value");
        //这个值可优化
        // env.set_field(digit_class_obj, "address", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(btc_chain.address.clone()).unwrap()))).expect("get_btc_chain_obj set address value");

        /*   if digit.contract_address.is_some() {
               env.set_field(digit_class_obj, "contractAddress", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(digit.contract_address.unwrap()).unwrap()))).expect("get_btc_chain_obj set contractAddress value");
           }*/
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
    env.set_field(chain_class_obj,"digitList","Ljava/util/List;",JValue::Object(digit_list_obj)).expect("set digitList");
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
        },
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
        },
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
    let eth = wallets::module::Ethereum{};
    match eth.decode_data(input.as_str()) {
        Ok(data)=>{
            env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::OK as i32)).expect("set status");
            env.set_field(state_obj, "inputInfo", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(data).unwrap()))).expect("set inputInfo");
        },
        Err(msg)=>{
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
    match  wallets::module::EEE::get_now_chain_type(wallet_id.as_str()) {
        Ok(code) => {
            env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::OK as i32)).expect("find status type");
            env.set_field(state_obj, "getNowChainType", "I", JValue::Int(code as i32)).expect("get nowChainType value");
        },
        Err(msg) => {
            //env.set_field(state_obj, "status", "Z", JValue::Bool(0 as u8)).expect("set isHideChain value");
            env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(msg.to_string()).unwrap()))).expect("set error message");
        }
    }
    *state_obj
}

#[no_mangle]
#[allow(non_snake_case)]
pub unsafe extern "C" fn Java_info_scry_wallet_1manager_NativeLib_setNowChainType(env: JNIEnv, _: JClass, walletId: JString,chain_type: jint) -> jobject {
    let wallet_id: String = env.get_string(walletId).unwrap().into();

    let wallet_state_class = env.find_class("info/scry/wallet_manager/NativeLib$WalletState").expect("setNowChainType wallet_state_class");
    let state_obj = env.alloc_object(wallet_state_class).expect("setNowChainType create state_obj");
    match  wallets::module::EEE::set_now_chain_type(wallet_id.as_str(),chain_type as i64) {
        Ok(_) => {
            env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::OK as i32)).expect("set status");
            env.set_field(state_obj, "isSetNowChain", "Z", JValue::Bool(1 as u8)).expect("setNowChainType isSetNowChain");
        },
        Err(msg) => {
            env.set_field(state_obj, "isSetNowChain", "Z", JValue::Bool(0 as u8)).expect("isSetNowChain");
            env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(msg.to_string()).unwrap()))).expect("set message");
        }
    }
    *state_obj
}

#[no_mangle]
#[allow(non_snake_case)]
pub unsafe extern "C" fn Java_info_scry_wallet_1manager_NativeLib_ethTxSign(env: JNIEnv, _: JClass, walletId:JString,chainType:jint, fromAddress:JString,
                                                                            toAddress:JString, contractAddress:JString, value:JString, backup:JString, pwd:jbyteArray,
                                                                            gasPrice:JString,gasLimit:JString,nonce:JString,decimal:jint) -> jobject {
    //使用的钱包id
    let _wallet_id: String = env.get_string(walletId).unwrap().into();
    //发送方账户地址 通过wallet id 能够关联起来
    let from_address: String = env.get_string(fromAddress).unwrap().into();
    //接收方账户地址
    let to_address: String = env.get_string(toAddress).unwrap().into();
    let to_address = {
        if to_address.is_empty() {
            None
        } else {
            let to = H160::from_slice(hex::decode(&to_address[2..]).unwrap().as_slice());
            Some(to)
        }
    };
    //调用合约地址
    let contract_address: String = env.get_string(contractAddress).unwrap().into();
    //转帐金额 这里都用这个参数来表示
    let amount = {
        let value_str: String = env.get_string(value).unwrap().into();
        //不同的代币，会有不同的精度？？
        wallets::convert_token(&value_str, decimal as usize).unwrap()
    };
    //附加参数
    let data: String = env.get_string(backup).unwrap().into();
    let data = if data.is_empty() {
        None
    } else {
        Some(data)
    };

    //gas价格
    let gas_price: U256 = {
        let price_str: String = env.get_string(gasPrice).unwrap().into();
        //使用单位的是gwei,这点是确定的
        wallets::convert_token(&price_str, 9).unwrap()
        //U256::from_dec_str(&price_str).unwrap()
    };
    //允许最大消耗gas数量
    let gas_limit: U256 = {
        let gas_limit_str: String = env.get_string(gasLimit).unwrap().into();
        U256::from_dec_str(&gas_limit_str).unwrap()
    };
    //当前交易的nonce值
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

    //chain type转换 当前钱包里面默认只使用 3、4来表示以太坊 主链和测试链，这里为方便测试，将链类型id 做如下转换 3->1,4->3,其余的保持不变

    let chain_type = {
        if chainType == 3 {
            1
        } else if chainType == 4 {
            3
        } else {
            chainType
        }
    };

    //使用私钥确认码
    let pwd = env.convert_byte_array(pwd).unwrap();
    let ethereum = wallets::module::Ethereum{};
    //合约地址为空，是普通ETH转账
    let signed_ret = if contract_address.is_empty() {
        ethereum.raw_transfer_sign(&from_address, to_address, amount, &pwd, nonce, gas_limit, gas_price, data, chain_type as u64)
    } else {
        let contract_address = H160::from_slice(hex::decode(&contract_address[2..]).unwrap().as_slice());
        ethereum.raw_erc20_transfer_sign(&from_address, contract_address, to_address, amount, &pwd, nonce, gas_limit, gas_price, data, chain_type as u64)
    };

    let wallet_message_class = env.find_class("info/scry/wallet_manager/NativeLib$Message").expect("find wallet_message_class");
    let state_obj = env.alloc_object(wallet_message_class).expect("state_obj");
    match signed_ret {
        Ok(data) => {
            env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::OK as i32)).expect("set status");
            env.set_field(state_obj, "ethSignedInfo", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(data).unwrap()))).expect("set ethSignedInfo");
        },
        Err(msg) => {
            env.set_field(state_obj, "status", "I", JValue::Int(StatusCode::PwdIsWrong as i32)).expect("set status");
            env.set_field(state_obj, "message", "Ljava/lang/String;", JValue::Object(JObject::from(env.new_string(msg.to_string()).unwrap()))).expect("set message");
        }
    }
    *state_obj
}
