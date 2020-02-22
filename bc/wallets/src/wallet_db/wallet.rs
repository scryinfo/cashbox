use super::*;
use log::error;
use ChainType;

use crate::model::wallet_store::{TbAddress, WalletObj, TbWallet};
use crate::wallet_db::db_helper::DataServiceProvider;

impl DataServiceProvider {
    pub fn update_wallet(&self, wallet: TbWallet) -> Result<(), String> {
        let mn_sql = "update Wallet set mnemonic=? where wallet_id=?;";
        let mut statement = self.db_hander.prepare(mn_sql).expect("sql statement is error!");
        statement.bind(1, wallet.mnemonic.as_str()).expect(" mnemonic  bind error");
        statement.bind(2, wallet.wallet_id.as_str()).expect("wallet id bind error");

        match statement.next() {
            Ok(_state) => {
                Ok(())
            }
            Err(e) => Err(e.to_string())
        }
    }

    pub fn save_wallet_address(&mut self, mn: TbWallet, addrs: Vec<TbAddress>) -> Result<(), String> {
        let wallet_sql = "INSERT into Wallet(wallet_id,mn_digest,fullname,mnemonic,wallet_type,display_chain_id)VALUES(?,?,?,?,?,?)";
        let address_sql = "insert into detail.Address(address_id,wallet_id,chain_id,address,puk_key,status) values(?,?,?,?,?,?);";

        // TODO 增加事务的处理，这个的编码方式还需要修改 才能编译通过
        // TODO 根据链的地址种类 对应的填写代币账户信息
        let save_wallet_flag = match self.db_hander.prepare(wallet_sql) {
            Ok(mut stat) => {
                stat.bind(1, mn.wallet_id.as_str()).expect("wallet_id bind mn id error");
                stat.bind(2, mn.mn_digest.as_str()).expect("mn_digest bind mn id error");
                stat.bind(3, mn.full_name.unwrap().as_str()).expect("full_name bind mn id error");
                stat.bind(4, mn.mnemonic.as_str()).expect("mnemonic bind mn id error");
                stat.bind(5, mn.wallet_type).expect("wallet_type bind mn id error");
                stat.bind(6, mn.display_chain_id as i64).expect("display_chain_id  value set ");

                match stat.next() {
                    Ok(_) => {
                        //检查当前钱包 是否只有一个，若是只有一个钱包，则设置它为当前钱包
                        let update_selected = format!("UPDATE Wallet set selected = ( case WHEN (SELECT count(*) FROM Wallet)==1 then 1 else 0 end ) WHERE wallet_id= '{}'", mn.wallet_id);
                        self.db_hander.execute(update_selected).expect("update selected state");
                        Ok(())
                    }
                    Err(e) => Err(e.to_string())
                }
            }
            Err(e) => Err(e.to_string())
        };
        if save_wallet_flag.is_ok() {
            let save_address_flag = match self.db_hander.prepare(address_sql) {
                Ok(mut address_stat) => {
                    for addr in addrs {
                        address_stat.bind(1, addr.address_id.as_str()).expect("save_mnemonic_address  bind addr.status ");
                        address_stat.bind(2, addr.wallet_id.as_str()).expect("save_mnemonic_address bind addr.mnemonic_id ");
                        address_stat.bind(3, addr.chain_id as i64).expect("save_mnemonic_address bind addr.chain_id ");
                        address_stat.bind(4, addr.address.as_str()).expect("save_mnemonic_address bind addr.address ");
                        address_stat.bind(5, addr.pub_key.as_str()).expect("save_mnemonic_address bind addr.pub_key ");
                        address_stat.bind(6, addr.status as i64).expect("save_mnemonic_address  bind addr.status ");
                       // address_stat.next();
                        match address_stat.next() {
                            Ok(_) => {
                                // TODO 后续来完善需要更新的数据详情
                                address_stat.reset();
                                if  addr.chain_id==5||addr.chain_id==6  {//添加eee 或者eee test相关地址代币
                                    let eth_digit_account_sql = format!("INSERT INTO detail.DigitUseDetail(digit_id,address_id)VALUES({},'{}');",1,addr.address_id);
                                    println!("{}",eth_digit_account_sql);
                                    self.db_hander.execute(eth_digit_account_sql).expect("update eee digit");
                                }
                                if addr.chain_id==3||addr.chain_id==4 {//添加eth 或者eth test相关地址代币
                                    let eth_digit_account_sql = format!("INSERT INTO detail.DigitUseDetail(digit_id,address_id)VALUES({},'{}');",2,addr.address_id);
                                    self.db_hander.execute(eth_digit_account_sql).expect("update eth digit");
                                    //在插入eth的时候 添加ddd 代币 //默认在每个钱包，只要启用ETH都包含这个代币
                                    let insert_ddd_digit =  format!("INSERT INTO detail.DigitUseDetail(digit_id,address_id) select id,'{}' from detail.DigitBase a where a.contract_address like '0x9F5F3CFD7a32700C93F971637407ff17b91c7342';",addr.address_id);
                                    self.db_hander.execute(insert_ddd_digit).expect("update eee digit");
                                }
                            }
                            Err(e) => return Err(e.to_string())
                        }
                    }
                    Ok(())
                }
                Err(e) => Err(e.to_string())
            };
            if save_address_flag.is_err() {
                // TODO 添加事务的处理
            }
        }
        Ok(())
    }

    //这个地方 定义成通用的对象查询功能
    pub fn query_by_wallet_id(&self, id: &str) -> Option<TbWallet> {
        let query_sql = "select * from Wallet where wallet_id = ?";
        let mut statement = self.db_hander.prepare(query_sql).unwrap();
        statement.bind(1, id).expect("query_by_mnemonic_id bind id");
        let mut cursor = statement.cursor();

        match cursor.next().unwrap() {
            Some(value) => {
                let wallet = TbWallet {
                    wallet_id: String::from(value[0].as_string().unwrap()),
                    mn_digest: String::from(value[1].as_string().unwrap()),
                    full_name: value[2].as_string().map(|str| String::from(str)),
                    mnemonic: String::from(value[3].as_string().unwrap()),
                    wallet_type: value[4].as_integer().unwrap(),
                    selected: value[5].as_string().map(|value| Self::get_bool_value(value)),
                    status: value[6].as_integer().unwrap(),
                    display_chain_id: value[7].as_integer().unwrap().into(),
                    create_time: format!("{}", value[8].as_integer().unwrap()),
                    update_time: value[9].as_string().map(|str| String::from(str)),
                };
                Some(wallet)
            }
            None => {
                None
            }
        }
    }

    //这个地方 定义成通用的对象查询功能
    pub fn query_by_wallet_digest(&self, digest: &str) -> Option<TbWallet> {
        let query_sql = "select * from Wallet where mn_digest = ?";
        let mut statement = self.db_hander.prepare(query_sql).unwrap();
        statement.bind(1, digest).expect("query_by_mnemonic_id bind id");
        let mut cursor = statement.cursor();

        match cursor.next().unwrap() {
            Some(value) => {
                let wallet = TbWallet {
                    wallet_id: String::from(value[0].as_string().unwrap()),
                    mn_digest: String::from(value[1].as_string().unwrap()),
                    full_name: value[2].as_string().map(|str| String::from(str)),
                    mnemonic: String::from(value[3].as_string().unwrap()),
                    wallet_type: value[4].as_integer().unwrap(),
                    selected: value[5].as_string().map(|value| Self::get_bool_value(value)),
                    status: value[6].as_integer().unwrap(),
                    display_chain_id: value[7].as_integer().unwrap().into(),
                    create_time: format!("{}", value[8].as_integer().unwrap()),
                    update_time: value[9].as_string().map(|str| String::from(str)),
                };
                Some(wallet)
            }
            None => {
                None
            }
        }
    }

    //考虑修改为查询所有指定条件的对象
    pub fn query_selected_wallet(&self) -> Result<TbWallet, String> {
        //选中钱包 只有一个
        let sql = "select * from Wallet where selected=1;";

        self.db_hander.prepare(sql).map(|stmt| {
            let mut rows = stmt.cursor();
            let value = rows.next().unwrap().unwrap(); //必须存在一个指定的钱包
            let wallet = TbWallet {
                wallet_id: String::from(value[0].as_string().unwrap()),
                mn_digest: String::from(value[1].as_string().unwrap()),
                full_name: value[2].as_string().map(|str| String::from(str)),
                mnemonic: String::from(value[3].as_string().unwrap()),
                wallet_type: value[4].as_integer().unwrap(),
                selected: value[5].as_string().map(|value| Self::get_bool_value(value)),
                status: value[6].as_integer().unwrap(),
                display_chain_id: value[7].as_integer().unwrap().into(),
                create_time: format!("{}", value[8].as_integer().unwrap()),
                update_time: value[9].as_string().map(|str| String::from(str)),
            };
            wallet
        }).map_err(|err| {
            error!("query error:{}", err.to_string());
            err.to_string()
        })
    }

    pub fn get_wallet_by_address(&self, address: &str, chain_type: ChainType) -> Option<TbWallet> {
        let query_sql = "SELECT a.* from Wallet a,detail.Address b,detail.Chain c WHERE b.chain_id = c.id and b.wallet_id = a.wallet_id and b.address = ? and c.type=?;";
        let mut statement = self.db_hander.prepare(query_sql).unwrap();
        statement.bind(1, address).expect("get_wallet_by_address bind address");
        statement.bind(2, chain_type as i64).expect("get_wallet_by_address chain_type");
        let mut cursor = statement.cursor();

        match cursor.next().unwrap() {
            Some(value) => {
                let wallet = TbWallet {
                    wallet_id: String::from(value[0].as_string().unwrap()),
                    mn_digest: String::from(value[1].as_string().unwrap()),
                    full_name: value[2].as_string().map(|str| String::from(str)),
                    mnemonic: String::from(value[3].as_string().unwrap()),
                    wallet_type: value[4].as_integer().unwrap(),
                    selected: value[5].as_string().map(|value| Self::get_bool_value(value)),
                    status: value[6].as_integer().unwrap(),
                    display_chain_id: value[7].as_integer().unwrap().into(),
                    create_time: format!("{}", value[8].as_integer().unwrap()),
                    update_time: value[9].as_string().map(|str| String::from(str)),
                };
                Some(wallet)
            }
            None => {
                None
            }
        }
    }

    //当前该功能是返回所有的钱包
    pub fn get_wallets(&self) -> Vec<TbWallet> {
        let sql = "select * from Wallet WHERE status = 1;";

        let mut cursor = self.db_hander.prepare(sql).unwrap().cursor();
        let mut vec = Vec::new();
        while let Some(cursor) = cursor.next().unwrap() {
            let wallet = TbWallet {
                wallet_id: String::from(cursor[0].as_string().unwrap()),
                mn_digest: String::from(cursor[1].as_string().unwrap()),
                full_name: cursor[2].as_string().map(|str| String::from(str)),
                mnemonic:
                String::from(cursor[3].as_string().unwrap()),
                wallet_type: cursor[4].as_integer().unwrap(),
                selected: cursor[5].as_string().map(|value| Self::get_bool_value(value)),

                status: cursor[6].as_integer().unwrap(),
                display_chain_id: cursor[7].as_integer().unwrap().into(),
                create_time: format!("{}", cursor[8].as_integer().unwrap()),
                update_time: cursor[9].as_string().map(|data| String::from(data)),
            };
            vec.push(wallet)
        }
        vec
    }

    pub fn set_selected_wallet(&self, wallet_id: &str) -> Result<(), String> {
        //需要先查询出那些助记词是被设置为当前选中，将其设置为取消选中，再将指定的id 设置为选中状态
        let sql = "UPDATE Wallet set selected = 0 where wallet_id in (select wallet_id from Wallet WHERE selected=1);";
        self.db_hander.execute(sql).expect("exec sql is error!");
        let set_select_sql = "update Wallet set selected = 1 where wallet_id =?;";
        self.db_hander.prepare(set_select_sql).map(|mut stat| {
            stat.bind(1, wallet_id).expect("set_selected_mnemonic bind mn_id");
            stat.next().expect("exec set_selected_mnemonic error");
            ()
        }).map_err(|err| err.to_string())
    }

    pub fn del_mnemonic(&self, mn_id: &str) -> Result<(), String> {
        let sql = "DELETE from Wallet WHERE wallet_id = ?; ";
        let update_address = "UPDATE Address set status = 0 WHERE wallet_id =?;";
        match self.db_hander.prepare(sql) {
            Ok(mut stat) => {
                stat.bind(1, mn_id).expect("del_wallet bind wallet_id");
                stat.next().expect("exec del_wallet");
                match self.db_hander.prepare(update_address) {
                    Ok(mut stat) => {
                        stat.bind(1, mn_id).expect("del_wallet update_address bind wallet_id");
                        stat.next().expect("exec del_wallet update_address");
                        Ok(())
                    }
                    Err(e) => {
                        Err(e.to_string())
                    }
                }
            }
            Err(e) => Err(e.to_string())
        }
    }

    pub fn rename_mnemonic(&self, mn_id: &str, mn_name: &str) -> Result<(), String> {
        let sql = "UPDATE Wallet set fullname = ? WHERE wallet_id=?;";
        match self.db_hander.prepare(sql) {
            Ok(mut stat) => {
                let bind_mn_name = stat.bind(1, mn_name).map_err(|e| format!("rename_mnemonic bind mn name,{}", e.to_string()));
                if bind_mn_name.is_err() {
                    return Err(bind_mn_name.unwrap_err());
                }
                let bind_mn_id = stat.bind(2, mn_id).map_err(|e| format!("rename_mnemonic bind mn id,{}", e.to_string()));
                if bind_mn_id.is_err() {
                    return Err(bind_mn_id.unwrap_err());
                }
                let exec = stat.next().map_err(|e| format!("exec rename_mnemonic,{}", e.to_string()));
                if exec.is_err() {
                    return Err(exec.unwrap_err());
                }
                Ok(())
            }
            Err(e) => Err(e.to_string())
        }
    }
    // TODO 不同的链有不同的 digit 格式，后续在处理的时候 需要优化
    pub fn display_mnemonic_list(&self) -> Result<Vec<WalletObj>, String> {
        let all_mn = "select a.wallet_id,a.fullname as wallet_name,b.id as chain_id,c.address,b.address as chain_address,a.selected,b.type as chian_type,d.id as digit_id,d.contract_address,d.short_name,d.full_name,d.balance,d.selected as isvisible,d.decimals,d.url_img
 from Wallet a,detail.Chain b,detail.Address c,detail.EeeDigit d where a.wallet_id=c.wallet_id and c.chain_id = b.id and c.address_id=d.address_id and a.status =1 and c.status =1;";

        let mut cursor = self.db_hander.prepare(all_mn).unwrap().cursor();
        let mut tbwallets = Vec::new();
        while let Some(row) = cursor.next().unwrap() {
            let tbwallet = WalletObj {
                wallet_id: row[0].as_string().map(|str| String::from(str)),
                wallet_name: row[1].as_string().map(|str| String::from(str)),
                chain_id: row[2].as_integer(),
                address: row[3].as_string().map(|str| String::from(str)),
                domain: row[4].as_string().map(|str| String::from(str)),
                selected: row[5].as_string().map(|value| Self::get_bool_value(value)),
                chain_type: row[6].as_integer(),
                digit_id: row[7].as_integer(),
                contract_address: row[8].as_string().map(|str| String::from(str)),
                short_name: row[9].as_string().map(|str| String::from(str)),
                full_name: row[10].as_string().map(|str| String::from(str)),
                balance: row[11].as_string().map(|str| String::from(str)),
                digit_is_visible: row[12].as_string().map(|value| Self::get_bool_value(value)),
                decimals: row[13].as_integer(),
                url_img: row[14].as_string().map(|str| String::from(str)),
                chain_is_visible: row[15].as_string().map(|value| Self::get_bool_value(value)),
            };
            tbwallets.push(tbwallet);
        }
        Ok(tbwallets)
    }
}
