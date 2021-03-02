use super::*;

use crate::model::wallet_store::{TbAddress, TbWallet};
use crate::wallet_db::db_helper::DataServiceProvider;
use sqlite::{State, Statement};

//According to the chain id, convert to the corresponding chain type and group name
fn chain_id_convert_group_name(chain_id: i16) -> Option<(i64, String)> {
    match chain_id {
        1 => Some((1, "BTC".to_string())),
        2 => Some((0, "BTC".to_string())),
        3 => Some((1, "ETH".to_string())),
        4 => Some((0, "ETH".to_string())),
        5 => Some((1, "EEE".to_string())),
        6 => Some((0, "EEE".to_string())),
        _ => None,
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

    pub fn delete_user_data(&self) -> WalletResult<()> {
        let delete_sql =
            "delete from detail.AccountInfoSyncProg; delete from detail.TransferRecord;";
        self.db_hander.execute(delete_sql)?;
        Ok(())
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
        log::info!("addr length is:{}", addrs.len());
        for addr in addrs {
            address_stat.bind(1, addr.address_id.as_str())?;
            address_stat.bind(2, addr.wallet_id.as_str())?;
            address_stat.bind(3, addr.chain_id as i64)?;
            address_stat.bind(4, addr.address.as_str())?;
            address_stat.bind(5, addr.pub_key.as_str())?;
            address_stat.bind(6, addr.status as i64)?;
            address_stat.next()?;
            address_stat.reset()?;
            log::debug!("chain type id:{}", addr.chain_id);
            let convert_ret = chain_id_convert_group_name(addr.chain_id).unwrap();
            log::debug!("type:{},group name:{}", convert_ret.0, convert_ret.1);
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
        //The defined return result is Option, which cannot be used for error handling currently? `Way back
        statement
            .bind(1, digest)
            .expect("query_by_mnemonic_id bind id");
        statement
            .bind(2, wallet_type)
            .expect("query_by_mnemonic_id bind id");
        self.query_wallet(&mut statement).ok()
    }

    pub fn query_selected_wallet(&self) -> WalletResult<TbWallet> {
        // Only one wallet is selected
        let sql = "select * from Wallet where selected=1;";
        let mut statement = self.db_hander.prepare(sql)?;
        self.query_wallet(&mut statement)
    }
    //Via wallet address
    pub fn get_wallet_by_address(
        &self,
        address: &str,
        chain_type: ChainType,
    ) -> WalletResult<TbWallet> {
        let query_sql = "SELECT a.* from Wallet a, detail.Address b, detail.Chain c WHERE b.chain_id = c.id and b.wallet_id = a.wallet_id and b.address =? and c.type=?; ";
        let mut statement = self.db_hander.prepare(query_sql)?;
        statement
            .bind(1, address)
            .expect("get_wallet_by_address bind address");
        statement
            .bind(2, chain_type as i64)
            .expect("get_wallet_by_address chain_type");
        self.query_wallet(&mut statement)
    }
    //Return wallet information that satisfies the condition, the function returns only one element
    fn query_wallet(&self, statement: &mut Statement) -> WalletResult<TbWallet> {
        let wallets = self.get_wallets_from_database(statement)?;
        if !wallets.is_empty() {
            Ok(wallets[0].clone())
        } else {
            Err(WalletError::NotExist)
        }
    }

    fn get_wallets_from_database(&self, statement: &mut Statement) -> WalletResult<Vec<TbWallet>> {
        let mut wallets = Vec::new();
        while let State::Row = statement.next()? {
            let wallet = TbWallet {
                wallet_id: statement.read::<String>(0)?,
                mn_digest: statement.read::<String>(1)?,
                full_name: statement.read::<String>(2).ok(),
                mnemonic: statement.read::<String>(3)?,
                wallet_type: statement.read::<i64>(4)?,
                selected: statement.read::<i64>(5).map(|value| value == 1).ok(),
                status: statement.read::<i64>(6)?,
                display_chain_id: statement.read::<i64>(7)?,
                create_time: statement.read::<String>(8)?,
                update_time: statement.read::<String>(9).ok(),
            };
            wallets.push(wallet);
        }
        Ok(wallets)
    }

    //Currently the function is to return all wallets
    pub fn get_wallets(&self) -> WalletResult<Vec<TbWallet>> {
        let sql = "select * from Wallet WHERE status = 1 order by create_time desc;";
        let mut statement = self.db_hander.prepare(sql)?;
        self.get_wallets_from_database(&mut statement)
    }

    pub fn set_selected_wallet(&self, wallet_id: &str) -> WalletResult<()> {
        //Need to find out whether the mnemonic word is set to the currently selected, set it to unchecked, and then set the specified id to the selected state
        let sql = "UPDATE Wallet set selected = 0 where wallet_id in (select wallet_id from Wallet WHERE selected=1);";
        self.db_hander.execute(sql)?;
        let set_select_sql = "update Wallet set selected = 1 where wallet_id =?;";
        let mut stat = self.db_hander.prepare(set_select_sql)?;
        stat.bind(1, wallet_id)?;
        stat.next()?;
        Ok(())
    }

    pub fn del_mnemonic(&self, mn_id: &str) -> WalletResult<()> {
        //Delete the corresponding record in the wallet table
        let sql = "delete from Wallet WHERE wallet_id = ?; ";
        //Delete token related records, need to delete the record details first
        let delete_digit_detail = "delete from detail.DigitUseDetail where address_id in (select address_id from detail.Address where wallet_id =?) ;";
        //Delete the record in the address
        let delete_address = "delete from detail.Address WHERE wallet_id =?;";

        //Check if the current wallet is deleted
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
