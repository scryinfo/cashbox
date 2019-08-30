use super::*;
use super::model::*;
use std::collections::HashMap;

pub fn get_eth_chain_data() -> Result<HashMap<String, Vec<EthChain>>, String> {
    let instance = wallet_db::db_helper::DataServiceProvider::instance().unwrap();

    let eth_chain = instance.display_eee_chain();

    let mut last_wallet_id = String::from("-1");
    let mut chain_index = 0;

    let mut eth_map = HashMap::new();

    match eth_chain {
        Ok(tbwallets) => {
            for tbwallet in tbwallets {
                let wallet_id = tbwallet.wallet_id.unwrap();
                let chain_id = format!("{}", tbwallet.chain_id.unwrap());//chain id 不会存在为Null的情况

                //不同的钱包 具有相同的链id 要增加钱包的记录
                //同一个钱包 具有相同的链id  只要增加代币的记录
                //同一个钱包 具有不同的链id 要增加链的记录（这种情况 业务暂时不支持，代码保留在这）

                if last_wallet_id.ne(&wallet_id) {

                    //使用last_wallet_id 标识上一个钱包id,当钱包发生变化的时候，表示当前迭代的数据是新钱包 需要更新wallet_index，标识当前处理的是哪个钱包
                    last_wallet_id = wallet_id.clone();

                    //现在的业务是一个钱包，只有这一种类型的链，比如 Eth 只存在主链 没有另外的链，以下判断可以不需要
                    //这个地方需要重新来处理链的关系
                    let chain = EthChain {
                        status: StatusCode::OK,
                        chain_id: chain_id.clone(),
                        wallet_id: wallet_id.clone(),
                        chain_address: tbwallet.chain_address,
                        is_visible: tbwallet.isvisible,
                        chain_type: {
                            if tbwallet.chain_type.is_none() {
                                None
                            } else {
                                Some(ChainType::from(tbwallet.chain_type.unwrap()))
                            }
                        },
                        digit_list: Vec::new(),
                    };
                    //记录该链在钱包下的序号，因为usize 不能为负数，所有在这个地方先使用+1 来标识一个钱包下链的顺序
                    chain_index = 0;
                    eth_map.insert(wallet_id.clone(), vec![chain]);
                }
                let digit_id = format!("{}", tbwallet.digit_id.unwrap());
                let digit = EthDigit {
                    status: StatusCode::OK,
                    digit_id: digit_id,
                    chain_id: chain_id,
                    address: tbwallet.address.clone(),
                    contract_address: tbwallet.contract_address.clone(),
                    fullname: tbwallet.full_name.clone(),
                    shortname: tbwallet.short_name.clone(),
                    balance: tbwallet.balance.clone(),
                    is_visible: tbwallet.isvisible,
                    decimal: tbwallet.decimals,
                    imgurl: tbwallet.url_img,
                };
                let vec_eth_chain = eth_map.get_mut(wallet_id.as_str()).unwrap();

                let chain_list = vec_eth_chain.get_mut(chain_index).unwrap();
                chain_list.digit_list.push(digit);
            }
            Ok(eth_map)
        }
        Err(e) => Err(e)
    }
}

pub fn get_btc_chain_data() -> Result<HashMap<String, Vec<BtcChain>>, String> {
    let instance = wallet_db::db_helper::DataServiceProvider::instance().unwrap();

    let btc_chain = instance.display_btc_chain();

    let mut last_wallet_id = String::from("-1");
    let mut chain_index = 0;

    let mut btc_map = HashMap::new();

    match btc_chain {
        Ok(tbwallets) => {
            for tbwallet in tbwallets {
                let wallet_id = tbwallet.wallet_id.unwrap();
                let chain_id = format!("{}", tbwallet.chain_id.unwrap());//chain id 不会存在为Null的情况

                //不同的钱包 具有相同的链id 要增加钱包的记录
                //同一个钱包 具有相同的链id  只要增加代币的记录
                //同一个钱包 具有不同的链id 要增加链的记录（这种情况 业务暂时不支持，代码保留在这）

                if last_wallet_id.ne(&wallet_id) {

                    //使用last_wallet_id 标识上一个钱包id,当钱包发生变化的时候，表示当前迭代的数据是新钱包 需要更新wallet_index，标识当前处理的是哪个钱包
                    last_wallet_id = wallet_id.clone();
                    //开始新的钱包，记录链的标识需要重新开始计算
                    //这个地方需要重新来处理链的关系
                    let chain = BtcChain {
                        status: StatusCode::OK,
                        chain_id: chain_id.clone(),
                        wallet_id: wallet_id.clone(),
                        chain_address: tbwallet.chain_address,
                        is_visible: tbwallet.isvisible,
                        chain_type: {
                            if tbwallet.chain_type.is_none() {
                                None
                            } else {
                                Some(ChainType::from(tbwallet.chain_type.unwrap()))
                            }
                        },
                        digit_list: Vec::new(),
                    };
                    //记录该链在钱包下的序号，因为usize 不能为负数，所有在这个地方先使用+1 来标识一个钱包下链的顺序
                    chain_index = 0;
                    btc_map.insert(wallet_id.clone(), vec![chain]);
                }
                let digit_id = format!("{}", tbwallet.digit_id.unwrap());
                let digit = BtcDigit {
                    status: StatusCode::OK,
                    digit_id: digit_id,
                    chain_id: chain_id,
                    address: tbwallet.address.clone(),
                    contract_address: tbwallet.contract_address.clone(),
                    fullname: tbwallet.full_name.clone(),
                    shortname: tbwallet.short_name.clone(),
                    balance: tbwallet.balance.clone(),
                    is_visible: tbwallet.isvisible,
                    decimal: tbwallet.decimals,
                    imgurl: tbwallet.url_img,
                };
                let vec_eth_chain = btc_map.get_mut(wallet_id.as_str()).unwrap();

                let chain_list = vec_eth_chain.get_mut(chain_index).unwrap();
                chain_list.digit_list.push(digit);
            }
            Ok(btc_map)
        }
        Err(e) => Err(e)
    }
}
