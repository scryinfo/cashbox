use  super::*;

impl DataServiceProvider {

    pub fn change_visible(&self, walletid: &str, chainid: &str, digitid: &str, is_visible_flag: i64) -> WalletResult<bool> {

        let show_digit_sql =  "UPDATE detail.DigitUseDetail set is_visible = ? WHERE digit_id = ? and address_id = ( select address_id from detail.Address WHERE wallet_id=? and chain_id=?);";
        let mut show_digit_state = self.db_hander.prepare(show_digit_sql)?;
        show_digit_state.bind(1, is_visible_flag)?;
        show_digit_state.bind(2, digitid)?;
        show_digit_state.bind(3, walletid)?;
        show_digit_state.bind(4, chainid)?;
        show_digit_state.next().map(|_|true).map_err(|e|e.into())

    }
    pub fn show_digit(&self, walletid: &str, chainid: &str, digitid: &str) -> WalletResult<bool> {
        return self.change_visible(walletid, chainid, digitid, 1);
    }

    pub fn hide_digit(&self, walletid: &str, chainid: &str, digitid: &str) -> WalletResult<bool> {
        return self.change_visible(walletid, chainid, digitid, 0);
    }

    pub fn update_digit_balance(self, address: &str, digit_id: &str, value: &str)->WalletResult<bool>{
        let update_sql = "update detail.DigitUseDetail set balance = ? where digit_id = ? and address_id = (select address_id from detail.Address where address = ?);";
        let mut update_sql_state = self.db_hander.prepare(update_sql)?;
        update_sql_state.bind(1, value)?;
        update_sql_state.bind(2, digit_id)?;
        update_sql_state.bind(3, address)?;
        update_sql_state.next().map(|_|true).map_err(|e|e.into())
    }
    //添加代币
    fn add_digits(&self,digits:Vec<model::DigitExport>)->WalletResult<()>{
        let insert_sql = "insert into detail.DigitBase(id,contract_address,chain_type,group_name,short_name,full_name,url_img,decimals,is_basic,is_default,status)values(?,?,?,?,?,?,?,?,?,?,?);";
        let mut insert_basic_statement = self.db_hander.prepare(insert_sql)?;
        for digit in digits {
            if let Some(id) = digit.id {
                insert_basic_statement.bind(1,id.as_str())?;
            }else {
                insert_basic_statement.bind(1,uuid::Uuid::new_v4().to_string().as_str())?;
            }
            insert_basic_statement.bind(2,digit.contract_address.unwrap_or("".to_string()).as_str());
            //代币类型 是正式连还是测试链
            insert_basic_statement.bind(3, self.is_main_chain(&digit.chain_type))?;
            insert_basic_statement.bind(4,digit.group_name.unwrap_or("ETH".to_string()).as_str());
            insert_basic_statement.bind(5,digit.short_name.as_str());
            insert_basic_statement.bind(6,digit.full_name.as_str());
            insert_basic_statement.bind(7,digit.img_url.unwrap_or("".to_string()).as_str());
            insert_basic_statement.bind(8,digit.decimal);
            insert_basic_statement.bind(9,digit.is_basic.unwrap_or(false) as i64)?;//设置状态，默认为显示
            insert_basic_statement.bind(10,digit.is_default.unwrap_or(true) as i64)?;//设置增加的代币 是否为默认代币
            insert_basic_statement.bind(11,digit.status.unwrap_or(1))?;//最基础的代币（链上代币）
            insert_basic_statement.next()?;
            insert_basic_statement.reset()?;
        }
        Ok(())
    }

    //添加认证代币，供界面展示使用
    fn update_certified_token(){

    }

    //转换链类型
    fn is_main_chain(&self,chain_type:&str)->i64{
        match chain_type{
            "ETH"=>1,
            "default"=>1,
            "ETH_TEST"=>0,
            "test"=>0,
            _=>1,
        }
    }

   pub fn init_basic_digit(&self)->WalletResult<()>{
        let bytecode = include_bytes!("res/chainTokenFile.json");
        //todo 错误处理
        let digits = serde_json::from_slice::<Vec<model::DigitExport>>(&bytecode[..])?;
        self.add_digits(digits)
    }

    /// 更新默认代币逻辑
    /// 将原添加的默认代币状态更新为非默认代币的状态，开始更新代币
    pub fn update_default_digit(&self,digits:Vec<model::DigitExport>)->WalletResult<()>{
        //检查待添加的默认代币是否已经存在，若存在，
        //todo 精细化处理默认代币的情况，当前先使用简单粗暴的方式将已经添加的默认代币直接删除，再将新的代币插入数据库表
        let delete_sql = "delete from  detail.DigitBase where is_basic = 0 and is_default =1;";
        self.db_hander.execute(delete_sql)?;
        self.add_digits(digits)
    }

    pub fn add_digit(&self,wallet_id:&str,chain_id:&str,digit_item:table_desc::DigitExport)->WalletResult<()>{
        // 查看代币是否存在,这里规定新增的代币合约地址不会重复
        let count_sql = "select count(*) from detail.DigitBase where contract_address = ?;";
        let mut count_statement = self.db_hander.prepare(count_sql)?;
        count_statement.bind(1,digit_item.address.as_str())?;
        count_statement.next()?;
        let count = count_statement.read::<i64>(0)?;
        if count!=0 {
            return Err(WalletError::Custom("Digit already exist".to_string()))
        }
        //获取钱包对应的地址id,目前只支持以太坊代币
        let address_id = "select address_id from detail.Address a where a.wallet_id = ? and a.chain_id = ?;";
        let mut statement = self.db_hander.prepare(address_id)?;
        statement.bind(1, wallet_id)?;
        statement.bind(2, chain_id)?;
        let mut cursor = statement.cursor();
        let value =  cursor.next().unwrap().ok_or(WalletError::NotExist)?;
        let address_id = value[0].as_string().unwrap();
        //添加代币
  /*      self.add_digits(vec![digit_item.clone()])?;*/
        let sql = format!("INSERT INTO detail.DigitUseDetail(digit_id,address_id) select id,'{}' from detail.DigitBase where  contract_address = '{}';", address_id, digit_item.address);
        self.db_hander.execute(sql).map_err(|e|e.into())
    }
}
