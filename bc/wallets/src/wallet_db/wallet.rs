use super::*;

use sqlite::{State, Statement};
use crate::model::wallet_store::{TbAddress, TbWallet};
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
        let update_selected = "update Wallet set selected = 0 where wallet_id = (select wallet_id from Wallet where selected==1 )";
        let wallet_sql = "insert into Wallet(wallet_id,mn_digest,fullname,mnemonic,wallet_type,display_chain_id,selected)values(?,?,?,?,?,?,?)";
        let address_sql = "insert into detail.Address(address_id,wallet_id,chain_id,address,puk_key,status) values(?,?,?,?,?,?);";
        self.db_hander.execute(update_selected)?;

        let mut stat = self.db_hander.prepare(wallet_sql)?;
        stat.bind(1, mn.wallet_id.as_str())?;
        stat.bind(2, mn.mn_digest.as_str())?;
        stat.bind(3, mn.full_name.unwrap().as_str())?;
        stat.bind(4, mn.mnemonic.as_str())?;
        stat.bind(5, mn.wallet_type)?;
        stat.bind(6, mn.display_chain_id as i64)?;
        stat.bind(7, true as i64)?;
        stat.next()?;

        let mut address_stat = self.db_hander.prepare(address_sql)?;
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
            let convert_ret = chain_id_convert_group_name(addr.chain_id).unwrap();
            log::debug!("type:{},group name:{}",convert_ret.0,convert_ret.1);
            let sql = format!("insert into detail.DigitUseDetail(digit_id,address_id) select id,'{}' from detail.DefaultDigitBase where status =1 and is_visible =1 and chain_type={} and group_name = '{}';", addr.address_id, convert_ret.0, convert_ret.1);
            self.db_hander.execute(&sql)?;
        }
        Ok(())
    }

    pub fn query_by_wallet_id(&self, id: &str) -> Option<TbWallet> {
        let query_sql = "select * from Wallet where wallet_id = ?";
        let mut statement = self.db_hander.prepare(query_sql).unwrap();
        statement.bind(1, id).expect("query_by_mnemonic_id bind id");
        self.query_wallet(&mut statement).ok()
    }

    pub fn query_by_wallet_digest(&self, digest: &str, wallet_type: i64) -> Option<TbWallet> {
        let query_sql = "select * from Wallet where mn_digest = ? and wallet_type = ?";
        let mut statement = self.db_hander.prepare(query_sql).unwrap();
        //定义的返回结果为Option,针对错误处理当前还不能使用 `？`方式返回
        statement.bind(1, digest).expect("query_by_mnemonic_id bind id");
        statement.bind(2, wallet_type).expect("query_by_mnemonic_id bind id");
        self.query_wallet(&mut statement).ok()
    }

    pub fn query_selected_wallet(&self) -> WalletResult<TbWallet> {
        //选中钱包 只有一个
        let sql = "select * from Wallet where selected=1;";
        let mut statement = self.db_hander.prepare(sql)?;
        self.query_wallet(&mut statement)
    }
    //通过钱包地址
    pub fn get_wallet_by_address(&self, address: &str, chain_type: ChainType) -> WalletResult<TbWallet> {
        let query_sql = "SELECT a.* from Wallet a,detail.Address b,detail.Chain c WHERE b.chain_id = c.id and b.wallet_id = a.wallet_id and b.address = ? and c.type=?;";
        let mut statement = self.db_hander.prepare(query_sql)?;
        statement.bind(1, address).expect("get_wallet_by_address bind address");
        statement.bind(2, chain_type as i64).expect("get_wallet_by_address chain_type");
        self.query_wallet(&mut statement)
    }
    //返回满足条件的钱包信息，该函数只返回一个元素
    fn query_wallet(&self, statement: &mut Statement) -> WalletResult<TbWallet> {
        let wallets = self.get_wallets_from_database(statement);
        if !wallets.is_empty() {
            Ok(wallets[0].clone())
        } else {
            Err(WalletError::NotExist)
        }
    }

    fn get_wallets_from_database(&self, statement: &mut Statement) -> Vec<TbWallet> {
        let mut wallets = Vec::new();
        while let State::Row = statement.next().unwrap() {
            let wallet = TbWallet {
                wallet_id: statement.read::<String>(0).unwrap(),
                mn_digest: statement.read::<String>(1).unwrap(),
                full_name: statement.read::<String>(2).ok(),
                mnemonic: statement.read::<String>(3).unwrap(),
                wallet_type: statement.read::<i64>(4).unwrap(),
                selected: statement.read::<i64>(5).map(|value| value == 1).ok(),
                status: statement.read::<i64>(6).unwrap(),
                display_chain_id: statement.read::<i64>(7).unwrap(),
                create_time: statement.read::<String>(8).unwrap(),
                update_time: statement.read::<String>(9).ok(),
            };
            wallets.push(wallet);
        }
        wallets
    }

    //当前该功能是返回所有的钱包
    pub fn get_wallets(&self) -> Vec<TbWallet> {
        let sql = "select * from Wallet WHERE status = 1 order by create_time desc;";
        let mut statement = self.db_hander.prepare(sql).unwrap();
        self.get_wallets_from_database(&mut statement)
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


    pub fn del_mnemonic(&self, mn_id: &str) -> WalletResult<()> {
        //删除钱包表中的对应记录
        let sql = "delete from Wallet WHERE wallet_id = ?; ";
        //删除代币相关记录 需要先删除记录详情
        let delete_digit_detail = "delete from detail.DigitUseDetail where address_id in (select address_id from detail.Address where wallet_id =?) ;";
        //删除地址中的记录
        let delete_address = "delete from detail.Address WHERE wallet_id =?;";

        //检测是否删除到当前钱包
        let check_select_wallet = "select count(*) from wallet where selected=1;";

        let mut stat = self.db_hander.prepare(sql)?;
        stat.bind(1, mn_id)?;
        stat.next()?;

        let mut stat = self.db_hander.prepare(delete_digit_detail)?;
        stat.bind(1, mn_id)?;
        stat.next()?;

        let mut stat = self.db_hander.prepare(delete_address)?;
        stat.bind(1, mn_id)?;
        stat.next()?;
        let mut stat = self.db_hander.prepare(check_select_wallet)?;
        stat.next()?;
        if let Ok(count) = stat.read::<i64>(0) {
            if count == 0 {
                let update_selected_sql = "update Wallet set selected = 1 where wallet_id = (select wallet_id from  Wallet order by create_time desc limit 1 offset 0);";
                self.db_hander.execute(update_selected_sql)?;
            }
        }
        Ok(())
    }

    pub fn rename_mnemonic(&self, mn_id: &str, mn_name: &str) -> WalletResult<()> {
        let sql = "UPDATE Wallet set fullname = ? WHERE wallet_id=?;";
        let mut stat = self.db_hander.prepare(sql)?;
        stat.bind(1, mn_name)?;
        stat.bind(2, mn_id)?;
        stat.next().map(|_| ()).map_err(|err| err.into())
    }
}
