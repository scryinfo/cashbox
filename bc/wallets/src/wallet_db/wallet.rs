use super::*;
use log::error;
use ChainType;

use crate::model::wallet_store::{TbAddress, WalletObj, TbWallet};
use crate::wallet_db::db_helper::DataServiceProvider;

//根据链id,转换为对应的链类型和分组名称
fn chain_id_convert_group_name(chain_id: i16) -> Option<(i64, String)> {
    match chain_id {
        3 => Some((1, "ETH".to_string())),
        4 => Some((0, "ETH".to_string())),
        5 => Some((1, "EEE".to_string())),
        6 => Some((0, "EEE".to_string())),
        _ => None
    }
}

impl DataServiceProvider {
    pub fn update_wallet(&self, wallet: TbWallet) -> WalletResult<bool> {
        let mn_sql = "update Wallet set mnemonic=? where wallet_id=?;";
        let mut statement = self.db_hander.prepare(mn_sql)?;
        statement.bind(1, wallet.mnemonic.as_str())?;
        statement.bind(2, wallet.wallet_id.as_str())?;
        statement.next().map(|_| true).map_err(|err| err.into())
    }

    pub fn save_wallet_address(&mut self, mn: TbWallet, addrs: Vec<TbAddress>) -> WalletResult<()> {
        let wallet_sql = "INSERT into Wallet(wallet_id,mn_digest,fullname,mnemonic,wallet_type,display_chain_id)VALUES(?,?,?,?,?,?)";
        let address_sql = "insert into detail.Address(address_id,wallet_id,chain_id,address,puk_key,status) values(?,?,?,?,?,?);";
        // TODO 增加事务的处理，这个的编码方式还需要修改 才能编译通过
        // TODO 根据链的地址种类 对应的填写代币账户信息
        let save_wallet_flag = match self.db_hander.prepare(wallet_sql) {
            Ok(mut stat) => {
                stat.bind(1, mn.wallet_id.as_str())?;
                stat.bind(2, mn.mn_digest.as_str())?;
                stat.bind(3, mn.full_name.unwrap().as_str())?;
                stat.bind(4, mn.mnemonic.as_str())?;
                stat.bind(5, mn.wallet_type)?;
                stat.bind(6, mn.display_chain_id as i64)?;

                match stat.next() {
                    Ok(_) => {
                        //检查当前钱包 是否只有一个，若是只有一个钱包，则设置它为当前钱包
                        let update_selected = format!("UPDATE Wallet set selected = ( case WHEN (SELECT count(*) FROM Wallet)==1 then 1 else 0 end ) WHERE wallet_id= '{}'", mn.wallet_id);
                        self.db_hander.execute(update_selected)?;
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
                    log::info!("addr length is:{}",addrs.len());
                    for addr in addrs {
                        address_stat.bind(1, addr.address_id.as_str())?;
                        address_stat.bind(2, addr.wallet_id.as_str())?;
                        address_stat.bind(3, addr.chain_id as i64)?;
                        address_stat.bind(4, addr.address.as_str())?;
                        address_stat.bind(5, addr.pub_key.as_str())?;
                        address_stat.bind(6, addr.status as i64)?;
                        address_stat.next()?;
                        address_stat.reset()?;
                        log::debug!("chain type id:{}",addr.chain_id);
                        // todo 处理chain_id异常
                        let convert_ret = chain_id_convert_group_name(addr.chain_id).unwrap();
                        log::debug!("type:{},group name:{}",convert_ret.0,convert_ret.1);
                        let sql = format!("INSERT INTO detail.DigitUseDetail(digit_id,address_id) select id,'{}' from detail.DigitBase where status =1 and is_visible =1 and chain_type={} and group_name = '{}';", addr.address_id, convert_ret.0, convert_ret.1);
                        self.db_hander.execute(sql)?;
                    }
                    Ok(())
                }
                Err(e) => Err(e.to_string())
            };
            if save_address_flag.is_err() {
                // TODO 添加事务的处理
                log::error!("save address error:{:?}",save_address_flag.unwrap_err());
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
    pub fn query_by_wallet_digest(&self, digest: &str, wallet_type: i64) -> Option<TbWallet> {
        let query_sql = "select * from Wallet where mn_digest = ? and wallet_type = ?";
        let mut statement = self.db_hander.prepare(query_sql).unwrap();
        statement.bind(1, digest).expect("query_by_mnemonic_id bind id");
        statement.bind(2, wallet_type).expect("query_by_mnemonic_id bind id");
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
    pub fn query_selected_wallet(&self) -> WalletResult<TbWallet> {
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
            err.into()
        })
    }

    pub fn get_wallet_by_address(&self, address: &str, chain_type: ChainType) -> WalletResult<TbWallet> {
        let query_sql = "SELECT a.* from Wallet a,detail.Address b,detail.Chain c WHERE b.chain_id = c.id and b.wallet_id = a.wallet_id and b.address = ? and c.type=?;";
        let mut statement = self.db_hander.prepare(query_sql)?;
        statement.bind(1, address).expect("get_wallet_by_address bind address");
        statement.bind(2, chain_type as i64).expect("get_wallet_by_address chain_type");

        match statement.cursor().next().unwrap() {
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
                Ok(wallet)
            }
            None => {
                Err(WalletError::NotExist)
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
                mnemonic: String::from(cursor[3].as_string().unwrap()),
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

    pub fn set_selected_wallet(&self, wallet_id: &str) -> WalletResult<()> {
        //需要先查询出那些助记词是被设置为当前选中，将其设置为取消选中，再将指定的id 设置为选中状态
        let sql = "UPDATE Wallet set selected = 0 where wallet_id in (select wallet_id from Wallet WHERE selected=1);";
        self.db_hander.execute(sql)?;
        let set_select_sql = "update Wallet set selected = 1 where wallet_id =?;";
        let mut stat = self.db_hander.prepare(set_select_sql)?;
        stat.bind(1, wallet_id)?;
        stat.next()?;
        Ok(())
    }

    //todo 完善删除钱包逻辑
    pub fn del_mnemonic(&self, mn_id: &str) -> WalletResult<()> {
        let sql = "DELETE from Wallet WHERE wallet_id = ?; ";
        let update_address = "UPDATE Address set status = 0 WHERE wallet_id =?;";
        let mut stat = self.db_hander.prepare(sql)?;
        stat.bind(1, mn_id)?;
        stat.next()?;
        let mut stat = self.db_hander.prepare(update_address)?;
        stat.bind(1, mn_id)?;
        stat.next().map(|_| ()).map_err(|err| err.into())
    }

    pub fn rename_mnemonic(&self, mn_id: &str, mn_name: &str) -> WalletResult<()> {
        let sql = "UPDATE Wallet set fullname = ? WHERE wallet_id=?;";
        let mut stat = self.db_hander.prepare(sql)?;
        stat.bind(1, mn_name)?;
        stat.bind(2, mn_id)?;
        stat.next().map(|_| ()).map_err(|err| err.into())
    }
    // TODO 不同的链有不同的 digit 格式，后续在处理的时候 需要优化 当前没有使用这个函数??
    pub fn display_mnemonic_list(&self) -> WalletResult<Vec<WalletObj>> {
        let all_mn = "select a.wallet_id,a.fullname as wallet_name,b.id as chain_id,c.address,b.address as chain_address,a.selected,b.type as chian_type,d.id as digit_id,d.contract_address,d.short_name,d.full_name,d.balance,d.selected as isvisible,d.decimals,d.url_img
 from Wallet a,detail.Chain b,detail.Address c,detail.EeeDigit d where a.wallet_id=c.wallet_id and c.chain_id = b.id and c.address_id=d.address_id and a.status =1 and c.status =1;";

        let stat = self.db_hander.prepare(all_mn)?;
        let mut cursor = stat.cursor();
        let mut tbwallets = Vec::new();
        while let Some(row) = cursor.next()? {
            let tbwallet = WalletObj {
                wallet_id: row[0].as_string().map(|str| String::from(str)),
                wallet_name: row[1].as_string().map(|str| String::from(str)),
                chain_id: row[2].as_integer(),
                address: row[3].as_string().map(|str| String::from(str)),
                domain: row[4].as_string().map(|str| String::from(str)),
                selected: row[5].as_string().map(|value| Self::get_bool_value(value)),
                chain_type: row[6].as_integer(),
                digit_id: row[7].as_string().map(|str| String::from(str)),
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
