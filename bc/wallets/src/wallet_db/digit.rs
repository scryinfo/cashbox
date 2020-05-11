use  super::*;
use crate::wallet_db::db_helper::DataServiceProvider;
use crate::WalletError;
use crate::model::DigitItem;

impl DataServiceProvider {

    pub fn change_visible(&self, walletid: &str, chainid: &str, digitid: &str, isvisibleflag: i64) -> Result<bool, WalletError> {

        let show_digit_sql =  "UPDATE detail.DigitUseDetail set is_visible = ? WHERE digit_id = ? and address_id = ( select address_id from detail.Address WHERE wallet_id=? and chain_id=?);";
        let mut show_digit_state = self.db_hander.prepare(show_digit_sql)?;
        show_digit_state.bind(1, isvisibleflag)?;
        show_digit_state.bind(2, digitid)?;
        show_digit_state.bind(3, walletid)?;
        show_digit_state.bind(4, chainid)?;
        show_digit_state.next().map(|_|true).map_err(|e|e.into())

    }
    pub fn show_digit(&self, walletid: &str, chainid: &str, digitid: &str) -> Result<bool, WalletError> {
        return Self::change_visible(self, walletid, chainid, digitid, 1);
    }

    pub fn hide_digit(&self, walletid: &str, chainid: &str, digitid: &str) -> Result<bool, WalletError> {
        return Self::change_visible(self, walletid, chainid, digitid, 0);
    }

    pub fn update_digit_balance(self, address: &str, digit_id: &str, value: &str)->Result<bool, WalletError>{
        let update_sql = "update detail.DigitUseDetail set balance = ? where digit_id = ? and address_id = (select address_id from detail.Address where address = ?);";
        let mut update_sql_state = self.db_hander.prepare(update_sql)?;
        update_sql_state.bind(1, value)?;
        update_sql_state.bind(2, digit_id)?;
        update_sql_state.bind(3, address)?;
        update_sql_state.next().map(|_|true).map_err(|e|e.into())
    }

    fn add_digits(&self,digits:Vec<table_desc::DigitExport>)->Result<(),WalletError>{
        let digit_base_insert_sql = "insert into detail.DigitBase('contract_address','type','short_name','full_name','decimals','group_name','url_img','is_visible') values(?,?,?,?,?,?,?,?); ";
        let mut state = self.db_hander.prepare(digit_base_insert_sql)?;

        for digit in digits {
            state.bind(1, digit.address.as_str())?;
            let digit_type = if digit.digit_type.eq("default") {1 }else { 0 };
            state.bind(2, digit_type as i64)?;
            //设置短名称
            state.bind(3, digit.symbol.as_str())?;
            //设置长名称 这里由于数据不足，短名称和长名称相同
            state.bind(4, digit.symbol.as_str())?;
            state.bind(5, digit.decimal)?;
            state.bind(6, "ETH")?;

            match digit.url_img {
                Some(url)=> state.bind(7,url.as_str())?,
                None=> state.bind(7,"")?,
            };
            state.bind(8, 0 as i64)?;
            state.next()?;
            state.reset()?;
        }
        //设置默认代币状态
        Ok(())
    }

    fn set_default_digit(&self)->Result<(),WalletError>{
        let update_digit_status = "update DigitBase set status =1,is_visible =1 where full_name like 'DDD';";
        self.db_hander.execute(update_digit_status)?;
        Ok(())
    }
    pub fn add_digit(self,wallet_id:&str,chain_id:&str,digit_item:table_desc::DigitExport)->Result<(),WalletError>{
        // 查看代币是否存在,这里规定新增的代币合约地址不会重复
        let count_sql = "select count(*) from detail.DigitBase where contract_address = ?;";
        let mut count_statement = self.db_hander.prepare(count_sql)?;
        count_statement.bind(1,digit_item.address.as_str());
        count_statement.next();
        let count = count_statement.read::<i64>(0)?;
        if count!=0 {
            return Err(WalletError::Custom("Digit already exist".to_string()))
        }
        //获取钱包对应的地址id,目前只支持以太坊代币
        let address_id = "select address_id from detail.Address a where a.wallet_id = ? and a.chain_id = ?;";
        let mut statement = self.db_hander.prepare(address_id)?;
        statement.bind(1, wallet_id).expect(" bind wallet_id");
        statement.bind(2, chain_id).expect(" bind chain_id");
        let mut cursor = statement.cursor();
       let value =  cursor.next().unwrap().ok_or(WalletError::NotExist)?;
        let address_id = value[0].as_string().unwrap();

        self.tx_begin()?;
        //添加代币
        self.add_digits(vec![digit_item.clone()])
            .map(|_|{
                //添加代币记录
                let sql = format!("INSERT INTO detail.DigitUseDetail(digit_id,address_id) select id,'{}' from detail.DigitBase where  contract_address = '{}';", address_id, digit_item.address);
                println!("sql：{}",sql);
                self.db_hander.execute(sql) })
            .and_then(|_|{
                //提交事务
                println!("rx tx_commint");
             //   self.tx_rollback()
                self.tx_commint()
            })
            .map_err(|error|{
                //事务回滚
                println!("rx rollbanck");
                self.tx_rollback();
                error
            })
    }
}
