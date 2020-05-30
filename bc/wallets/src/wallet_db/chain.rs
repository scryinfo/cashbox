use super::*;

use model::{WalletObj, SyncStatus};
use log::debug;
use sqlite::{State,Statement};

use substratetx::TransferEvent;

impl DataServiceProvider {

    pub fn get_available_chain(&self)->WalletResult<Vec<i64>>{
        //查询当前可用链类型，启用了哪些链
        let sql = "select type from detail.chain where selected=1 and status=1;";
        let  stat = self.db_hander.prepare(sql)?;
        let mut cursor= stat.cursor();
        let mut chain_type = Vec::new();
        while let Some(row) = cursor.next()? {
           let type_id =  row[0].as_integer().unwrap();//存储的值类型为 i64 是明确的
            chain_type.push(type_id);
        }
        Ok(chain_type)
    }

    pub fn display_eee_chain(&self) -> WalletResult<Vec<WalletObj>> {

        let all_data =   "select  e.wallet_id,e.fullname as wallet_name,e.chain_id,e.address,e.selected,e.is_visible as chain_is_visible,f.domain,f.type as chain_type,
			d.digit_id,d.contract_address,d.short_name,d.full_name,d.balance,d.is_visible as digit_is_visible,d.decimals,d.url_img
	 from (select * from Wallet a ,detail.Address b where a.wallet_id=b.wallet_id and b.chain_id in (5,6)) e,
	 ( select * from detail.DigitUseDetail,detail.DefaultDigitBase
         where digit_id = id and group_name !='ETH' and group_name !='BTC'
         ) as d,detail.Chain f where e.address_id = d.address_id and e.chain_id = f.id  order by wallet_id desc;";

        let  stat = self.db_hander.prepare(all_data)?;
        let mut cursor= stat.cursor();
        let mut tbwallets = Vec::new();

        while let Some(row) = cursor.next()? {
            let tbwallet = WalletObj {
                wallet_id: row[0].as_string().map(|str| String::from(str)),
                wallet_name: row[1].as_string().map(|str| String::from(str)),
                chain_id: row[2].as_integer(),
                address: row[3].as_string().map(|str| String::from(str)),
                selected: row[4].as_string().map(|value| Self::get_bool_value(value)),
                chain_is_visible: row[5].as_string().map(|value| Self::get_bool_value(value)),
                domain: row[6].as_string().map(|str| String::from(str)),
                chain_type: row[7].as_integer(),
                digit_id: row[8].as_string().map(|str| String::from(str)),
                contract_address: row[9].as_string().map(|str| String::from(str)),
                short_name: row[10].as_string().map(|str| String::from(str)),
                full_name: row[11].as_string().map(|str| String::from(str)),
                balance: row[12].as_string().map(|str| String::from(str)),
                digit_is_visible: row[13].as_string().map(|value| Self::get_bool_value(value)),
                decimals: row[14].as_integer(),
                url_img: row[15].as_string().map(|str| String::from(str)),
            };
            tbwallets.push(tbwallet);
        }
        Ok(tbwallets)
    }

    pub fn display_eth_chain(&self) -> WalletResult<Vec<WalletObj>> {
      //这个sql语句关联表较多 关联逻辑： 查询出当前钱包有效钱包，这里是不区分主链或者测试链钱包 得到一个子表 e
        // 查询出当前地址使用详情跟代币的关联情况，得到子表 d
        // 最后和表f做自然连接，根据筛选条件找出符合要求的结果
        let all_mn =   "select  e.wallet_id,e.fullname as wallet_name,e.chain_id,e.address,e.selected,e.is_visible as chain_is_visible,f.domain,f.type as chain_type,
			d.digit_id,d.contract_address,d.short_name,d.full_name,d.balance,d.is_visible as digit_is_visible,d.decimals,d.url_img
	 from (select * from Wallet a ,detail.Address b where a.wallet_id=b.wallet_id and a.status=1 and b.status =1 and b.chain_id in (3,4)) e,
	 ( select * from detail.DigitUseDetail a,detail.DefaultDigitBase b where a.digit_id = b.id  and b.status = 1 and group_name !='EEE' and group_name !='BTC') as d,detail.Chain f
         where e.address_id = d.address_id and e.chain_id = f.id and f.status = 1;";
        let  stat = self.db_hander.prepare(all_mn)?;
        let mut cursor= stat.cursor();
        let mut tbwallets = Vec::new();
        while let Some(row) = cursor.next()?{
            let tbwallet = WalletObj {
                wallet_id: row[0].as_string().map(|str| String::from(str)),
                wallet_name: row[1].as_string().map(|str| String::from(str)),
                chain_id: row[2].as_integer(),
                address: row[3].as_string().map(|str| String::from(str)),
                selected: row[4].as_string().map(|value| Self::get_bool_value(value)),
                chain_is_visible: row[5].as_string().map(|value| Self::get_bool_value(value)),
                domain: row[6].as_string().map(|str| String::from(str)),
                chain_type: row[7].as_integer(),
                digit_id: row[8].as_string().map(|str| String::from(str)),
                contract_address: row[9].as_string().map(|str| String::from(str)),
                short_name: row[10].as_string().map(|str| String::from(str)),
                full_name: row[11].as_string().map(|str| String::from(str)),
                balance: row[12].as_string().map(|str| String::from(str)),
                digit_is_visible: row[13].as_string().map(|value| Self::get_bool_value(value)),
                decimals: row[14].as_integer(),
                url_img: row[15].as_string().map(|str| String::from(str)),
            };
            tbwallets.push(tbwallet);
        }
        Ok(tbwallets)
    }

    pub fn display_btc_chain(&self) -> WalletResult<Vec<WalletObj>> {

        let all_mn =   "select  e.wallet_id,e.fullname as wallet_name,e.chain_id,e.address,e.selected,e.is_visible as chain_is_visible,f.domain,f.type as chain_type,
			d.digit_id,d.contract_address,d.short_name,d.full_name,d.balance,d.is_visible as digit_is_visible,d.decimals,d.url_img
	 from (select * from Wallet a ,detail.Address b where a.wallet_id=b.wallet_id and b.chain_id in (1,2)) e,
	 ( select * from detail.DigitUseDetail,detail.DefaultDigitBase
         where digit_id = id and group_name !='EEE' and group_name !='ETH'
         ) as d,detail.Chain f where e.address_id = d.address_id and e.chain_id = f.id order by wallet_id desc;";

        let state = self.db_hander.prepare(all_mn)?;
        let mut cursor = state.cursor();
        let mut tbwallets = Vec::new();
        debug!("get wallet item is:{}", tbwallets.len());
        while let Some(row) = cursor.next()? {
            let tbwallet = WalletObj {
                wallet_id: row[0].as_string().map(|str| String::from(str)),
                wallet_name: row[1].as_string().map(|str| String::from(str)),
                chain_id: row[2].as_integer(),
                address: row[3].as_string().map(|str| String::from(str)),
                selected: row[4].as_string().map(|value| Self::get_bool_value(value)),
                chain_is_visible: row[5].as_string().map(|value| Self::get_bool_value(value)),
                domain: row[6].as_string().map(|str| String::from(str)),
                chain_type: row[7].as_integer(),
                digit_id: row[8].as_string().map(|str| String::from(str)),
                contract_address: row[9].as_string().map(|str| String::from(str)),
                short_name: row[10].as_string().map(|str| String::from(str)),
                full_name: row[11].as_string().map(|str| String::from(str)),
                balance: row[12].as_string().map(|str| String::from(str)),
                digit_is_visible: row[13].as_string().map(|value| Self::get_bool_value(value)),
                decimals: row[14].as_integer(),
                url_img: row[15].as_string().map(|str| String::from(str)),

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
         stat.next().map(|_|true).map_err(|err|err.into())

    }

    pub fn hide_chain(&self, walletid: &str, wallet_type: i64) -> WalletResult<bool> {
        let sql = "UPDATE Address set is_visible = 0 WHERE wallet_id=? and chain_id=?;";
        let mut stat = self.db_hander.prepare(sql)?;
        stat.bind(1, walletid)?;
        stat.bind(2, wallet_type)?;
        stat.next().map(|_|true).map_err(|err|err.into())

    }

    pub fn get_now_chain_type(&self, walletid: &str) -> WalletResult<i64> {
        let query_sql = "select display_chain_id from Wallet where wallet_id = ?";
        let mut state = self.db_hander.prepare(query_sql)?;
        state.bind(1,walletid)?;
        state.cursor().next().map(|value| value.unwrap()[0].as_integer().unwrap() ).map_err(|e|e.into())
    }

    pub fn set_now_chain_type(&self, walletid: &str, chain_type: i64) -> WalletResult<bool> {
        let sql = "UPDATE Wallet set display_chain_id = ? WHERE wallet_id=?;";
       let mut stat =  self.db_hander.prepare(sql)?;
        stat.bind(1, chain_type)?;
        stat.bind(2, walletid)?;
        stat.next().map(|_|true).map_err(|err|err.into())
    }
    pub fn save_transfer_event(&self,account:&str,block_hash:&str,event:&TransferEvent)-> WalletResult<bool>{

        let insert_sql = "insert into detail.TransferRecord(id,block_hash,chain_id,tx_index,tx_from,tx_to,amount,status,account)values(?,?,?,?,?,?,?,?,?);";
        let mut stat =  self.db_hander.prepare(insert_sql)?;
        stat.bind(1,  uuid::Uuid::new_v4().to_string().as_str())?;
        stat.bind(2, block_hash)?;
        stat.bind(3,3 as i64)?;//todo 链id 需要灵活调整
        stat.bind(4, event.index as i64)?;
        stat.bind(5, event.from.as_ref().unwrap().as_str())?;
        stat.bind(6, event.to.as_ref().unwrap().as_str())?;
        stat.bind(7, event.value.unwrap() as i64)?;
        stat.bind(8, event.result as i64)?;
        stat.bind(9, account)?;
        stat.next().map(|_|true).map_err(|err|err.into())
    }

   pub fn update_account_sync(&self,account:&str,chain_type:i32,block_num:u32,block_hash:&str)-> WalletResult<()>{
       //let insert_sql = "insert into detail.AccountInfoSyncProg(account,chain_type,block_num,block_hash)values(?,?,?,?) ON CONFLICT(account) DO UPDATE set block_num = ? and block_hash=?;";
       let insert_sql = "INSERT OR REPLACE into detail.AccountInfoSyncProg(account,chain_type,block_num,block_hash)values(?,?,?,?);";
       let mut stat =  self.db_hander.prepare(insert_sql)?;
        println!("block_num:{},block_hash:{}",block_num,block_hash);
       stat.bind(1,  account)?;
       stat.bind(2, chain_type as i64)?;
       stat.bind(3,block_num as i64)?;//todo 链id 需要灵活调整
       stat.bind(4, block_hash)?;
       stat.next().map(|_|()).map_err(|err|err.into())
   }

    pub fn get_sync_status(&self)-> WalletResult<Vec<SyncStatus>>{
       let select_sql = "select account,chain_type,block_num,block_hash from detail.AccountInfoSyncProg;";
        let mut select_stat =  self.db_hander.prepare(select_sql)?;
        let mut status_vec = Vec::new();
        while let State::Row = select_stat.next().unwrap() {
           let status =  SyncStatus{
                account: select_stat.read::<String>(0).unwrap(),
                chain_type: select_stat.read::<i64>(1).unwrap(),
                block_num: select_stat.read::<i64>(2).unwrap(),
                block_hash:select_stat.read::<String>(3).unwrap()
            };
            status_vec.push(status);
        }
        Ok(status_vec)
    }
}
