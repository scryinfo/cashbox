use super::*;

use model::{WalletObj, SyncStatus};
use sqlite::State;
use substratetx::TransferDetail;

impl DataServiceProvider {
    pub fn get_available_chain(&self) -> WalletResult<Vec<i64>> {
        //Query the currently available chain types and which chains are enabled
        let sql = "select type from detail.chain where selected=1 and status=1;";
        let stat = self.db_hander.prepare(sql)?;
        let mut cursor = stat.cursor();
        let mut chain_type = Vec::new();
        while let Some(row) = cursor.next()? {
            let type_id = row[0].as_integer().unwrap();//It is clear that the type of value stored is i64
            chain_type.push(type_id);
        }
        Ok(chain_type)
    }

    pub fn display_chain_detail(&self, chain_type: ChainType) -> WalletResult<Vec<WalletObj>> {
        //There are many association tables in this SQL statement. Association logic: Query the current wallet valid wallet, here is the main chain or test chain wallet is not distinguished to get a sub-table e
        // Query the relationship between the current address usage details and tokens, and get the sub-table d
        // Finally, make a natural connection with table f, find out the results that meet the requirements according to the filtering conditions
        let query_sql = match chain_type {
            ChainType::EthTest | ChainType::ETH => {
                "select  e.wallet_id,e.fullname as wallet_name,e.chain_id,e.address,e.selected,e.is_visible as chain_is_visible,f.domain,f.type as chain_type,
			d.digit_id,d.contract_address,d.short_name,d.full_name,d.balance,d.is_visible as digit_is_visible,d.decimals,d.url_img,e.puk_key
	 from (select * from Wallet a ,detail.Address b where a.wallet_id=b.wallet_id and a.status=1 and b.status =1 and b.chain_id in (3,4)) e,
	 ( select * from detail.DigitUseDetail a,detail.DefaultDigitBase b where a.digit_id = b.id  and b.status = 1 and group_name !='EEE' and group_name !='BTC') as d,detail.Chain f
         where e.address_id = d.address_id and e.chain_id = f.id and f.status = 1;"
            }
            ChainType::EeeTest | ChainType::EEE => {
                "select  e.wallet_id,e.fullname as wallet_name,e.chain_id,e.address,e.selected,e.is_visible as chain_is_visible,f.domain,f.type as chain_type,
			d.digit_id,d.contract_address,d.short_name,d.full_name,d.balance,d.is_visible as digit_is_visible,d.decimals,d.url_img,e.puk_key
	 from (select * from Wallet a ,detail.Address b where a.wallet_id=b.wallet_id and b.chain_id in (5,6)) e,
	 ( select * from detail.DigitUseDetail,detail.DefaultDigitBase
         where digit_id = id and group_name !='ETH' and group_name !='BTC'
         ) as d,detail.Chain f where e.address_id = d.address_id and e.chain_id = f.id  order by wallet_id desc;"
            }
            ChainType::BtcTest | ChainType::BTC => {
                "select  e.wallet_id,e.fullname as wallet_name,e.chain_id,e.address,e.selected,e.is_visible as chain_is_visible,f.domain,f.type as chain_type,
			d.digit_id,d.contract_address,d.short_name,d.full_name,d.balance,d.is_visible as digit_is_visible,d.decimals,d.url_img,e.puk_key
	 from (select * from Wallet a ,detail.Address b where a.wallet_id=b.wallet_id and b.chain_id in (1,2)) e,
	 ( select * from detail.DigitUseDetail,detail.DefaultDigitBase
         where digit_id = id and group_name !='EEE' and group_name !='ETH'
         ) as d,detail.Chain f where e.address_id = d.address_id and e.chain_id = f.id order by wallet_id desc;"
            }
            _ => ""
        };
        if query_sql.is_empty() {
            Err(WalletError::NotExist)
        } else {
            self.query_wallet_obj(query_sql)
        }
    }
    //Query wallet-related data based on the incoming SQL
    fn query_wallet_obj(&self, sql: &str) -> WalletResult<Vec<WalletObj>> {
        let stat = self.db_hander.prepare(sql)?;
        let mut cursor = stat.cursor();
        let mut tbwallets = Vec::new();

        while let Some(row) = cursor.next()? {
            let tbwallet = WalletObj {
                wallet_id: row[0].as_string().map(String::from),
                wallet_name: row[1].as_string().map(String::from),
                chain_id: row[2].as_integer(),
                address: row[3].as_string().map(String::from),
                selected: row[4].as_string().map(|value| Self::get_bool_value(value)),
                chain_is_visible: row[5].as_string().map(|value| Self::get_bool_value(value)),
                domain: row[6].as_string().map(String::from),
                chain_type: row[7].as_integer(),
                digit_id: row[8].as_string().map(String::from),
                contract_address: row[9].as_string().map(String::from),
                short_name: row[10].as_string().map(String::from),
                full_name: row[11].as_string().map(String::from),
                balance: row[12].as_string().map(String::from),
                digit_is_visible: row[13].as_string().map(|value| Self::get_bool_value(value)),
                decimals: row[14].as_integer(),
                url_img: row[15].as_string().map(String::from),
                pub_key: row[16].as_string().map(String::from),
            };
            tbwallets.push(tbwallet);
        }
        Ok(tbwallets)
    }

    pub fn show_chain(&self, walletid: &str, wallet_type: i64) -> WalletResult<bool> {
        let sql = "UPDATE Address set is_visible = 1 WHERE wallet_id=? and chain_id=?;";

        let mut stat = self.db_hander.prepare(sql)?;
        stat.bind(1, walletid)?;
        stat.bind(2, wallet_type)?;
        stat.next().map(|_| true).map_err(|err| err.into())
    }

    pub fn hide_chain(&self, walletid: &str, wallet_type: i64) -> WalletResult<bool> {
        let sql = "UPDATE Address set is_visible = 0 WHERE wallet_id=? and chain_id=?;";
        let mut stat = self.db_hander.prepare(sql)?;
        stat.bind(1, walletid)?;
        stat.bind(2, wallet_type)?;
        stat.next().map(|_| true).map_err(|err| err.into())
    }

    pub fn get_now_chain_type(&self, walletid: &str) -> WalletResult<i64> {
        let query_sql = "select display_chain_id from Wallet where wallet_id = ?";
        let mut state = self.db_hander.prepare(query_sql)?;
        state.bind(1, walletid)?;
        state.cursor().next().map(|value| value.unwrap()[0].as_integer().unwrap()).map_err(|e| e.into())
    }

    pub fn set_now_chain_type(&self, walletid: &str, chain_type: i64) -> WalletResult<bool> {
        let sql = "UPDATE Wallet set display_chain_id = ? WHERE wallet_id=?;";
        let mut stat = self.db_hander.prepare(sql)?;
        stat.bind(1, chain_type)?;
        stat.bind(2, walletid)?;
        stat.next().map(|_| true).map_err(|err| err.into())
    }
    pub fn save_transfer_detail(&self, account: &str, blockhash: &str, tx_detail: &TransferDetail, timestamp: u64, is_successful: bool) -> WalletResult<bool> {
        let insert_sql = "insert into detail.TransferRecord(tx_hash,block_hash,chain_id,token_name,method_name,signer,tx_index,tx_from,tx_to,amount,ext_data,status,tx_timestamp,wallet_account) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?);";
        let mut stat = self.db_hander.prepare(insert_sql)?;
        //tx_hash,block_hash,chain_id,token_name,method_name,signer,tx_index,tx_from,tx_to,amount,ext_data,status,tx_timestamp
        stat.bind(1, tx_detail.hash.as_ref().unwrap().as_str())?;//Transaction hash
        stat.bind(2, blockhash)?;//block hash
        stat.bind(3, 5 as i64)?;// The chain id needs to be flexibly adjusted
        stat.bind(4, tx_detail.token_name.as_str())?;// The chain id needs to be flexibly adjusted
        stat.bind(5, tx_detail.method_name.as_str())?;// The chain id needs to be flexibly adjusted
        stat.bind(6, tx_detail.signer.as_ref().unwrap().as_str())?;// The chain id needs to be flexibly adjusted
        stat.bind(7, tx_detail.index.unwrap() as i64)?;
        stat.bind(8, if let Some(from )= &tx_detail.from{
            from
        }else{
           ""
        })?;//The transaction initiating account
        stat.bind(9, if let Some(to) = &tx_detail.to{
            to
        }else {
            ""
        })?;//Transaction receiving account
        //value is u128 type, the database does not support this type, transcoded as a string to represent
        stat.bind(10, format!("{}", tx_detail.value.unwrap()).as_str())?;
        stat.bind(11, if let Some(ext_data) = &tx_detail.ext_data{
            ext_data
        }else{
            ""
        })?;
        stat.bind(12, is_successful as i64)?;
        stat.bind(13, timestamp as i64)?;//Transaction time
        stat.bind(14, account)?;//Transaction time
        stat.next().map(|_| true).map_err(|err| err.into())
    }

    pub fn update_account_sync(&self, account: &str, chain_type: i32, block_num: u32, block_hash: &str) -> WalletResult<()> {
        let insert_sql = "INSERT OR REPLACE into detail.AccountInfoSyncProg(account,chain_type,block_num,block_hash)values(?,?,?,?);";
        let mut stat = self.db_hander.prepare(insert_sql)?;
        stat.bind(1, account)?;
        stat.bind(2, chain_type as i64)?;
        stat.bind(3, block_num as i64)?;
        stat.bind(4, block_hash)?;
        stat.next().map(|_| ()).map_err(|err| err.into())
    }

    pub fn get_sync_status(&self) -> WalletResult<Vec<SyncStatus>> {
        let select_sql = "select account,chain_type,block_num,block_hash from detail.AccountInfoSyncProg;";
        let mut select_stat = self.db_hander.prepare(select_sql)?;
        let mut status_vec = Vec::new();
        while let State::Row = select_stat.next().unwrap() {
            let status = SyncStatus {
                account: select_stat.read::<String>(0).unwrap(),
                chain_type: select_stat.read::<i64>(1).unwrap(),
                block_num: select_stat.read::<i64>(2).unwrap(),
                block_hash: select_stat.read::<String>(3).unwrap(),
            };
            status_vec.push(status);
        }
        Ok(status_vec)
    }
}
