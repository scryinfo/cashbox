use  super::*;
use sqlite::State;
use failure::_core::option::Option::Some;

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
        let insert_sql = "insert into detail.DefaultDigitBase(id,contract_address,chain_type,group_name,short_name,full_name,url_img,decimals,is_basic,is_default,status)values(?,?,?,?,?,?,?,?,?,?,?);";
        let mut insert_basic_statement = self.db_hander.prepare(insert_sql)?;
        for digit in digits {
            if let Some(id) = digit.id {
                insert_basic_statement.bind(1,id.as_str())?;
            }else {
                insert_basic_statement.bind(1,uuid::Uuid::new_v4().to_string().as_str())?;
            }
            insert_basic_statement.bind(2,digit.contract_address.unwrap_or("".to_string()).as_str())?;
            //代币类型 是正式连还是测试链
            insert_basic_statement.bind(3, self.is_main_chain(&digit.chain_type))?;
            insert_basic_statement.bind(4,digit.group_name.unwrap_or("ETH".to_string()).as_str())?;
            insert_basic_statement.bind(5,digit.short_name.as_str())?;
            insert_basic_statement.bind(6,digit.full_name.as_str())?;
            insert_basic_statement.bind(7,digit.img_url.unwrap_or("".to_string()).as_str())?;
            insert_basic_statement.bind(8,digit.decimal)?;
            insert_basic_statement.bind(9,digit.is_basic.unwrap_or(false) as i64)?;//设置状态，默认为显示
            insert_basic_statement.bind(10,digit.is_default.unwrap_or(true) as i64)?;//设置增加的代币 是否为默认代币
            insert_basic_statement.bind(11,digit.status.unwrap_or(1))?;//最基础的代币（链上代币）
            insert_basic_statement.next()?;
            insert_basic_statement.reset()?;
        }
        Ok(())
    }

    //转换链类型
    fn is_main_chain(&self,chain_type:&str)->i64{
        match chain_type{
            "ETH"=>3,
            "default"=>3,
            "ETH_TEST"=>4,
            "test"=>4,
            _=>3,
        }
    }
    fn convert_chain_type(&self,chain_type:i64)->String{
        match chain_type{
            3=>"ETH".into(),
            4=>"ETH_TEST".into(),
            _=>"ETH".into(),
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
        let delete_sql = "delete from  detail.DefaultDigitBase where is_basic = 0 and is_default =1;";
        self.db_hander.execute(delete_sql)?;
        self.add_digits(digits)
    }

  pub fn update_certification_digit(&self, digits:Vec<model::AuthDigit>, is_auth:bool) ->WalletResult<()>{
        //当更新的为认证代币时。需要删除原来已经存在的代币
        if is_auth {
              let delete_sql = format!("delete from detail.DigitBase where is_auth = {};", is_auth as u16);
              println!("delete sql:{}",delete_sql);
              self.db_hander.execute(delete_sql)?;

        }else{
            //添加自定义代币，需要检查该代币是否已经存在
            let select_sql = "select count(*) from detail.DigitBase where contract = ?;";
            let mut select_sql_statement = self.db_hander.prepare(select_sql)?;
            for digit in digits.clone() {
                select_sql_statement.bind(1,digit.contract.as_str())?;
                select_sql_statement.next()?;
                let count = select_sql_statement.read::<i64>(0).unwrap() as u32;
                if count>0 {
                    return Err(WalletError::Custom(format!("digit {} exist!",digit.contract)))
                }
            }
        }

        let insert_sql = "insert into detail.DigitBase(id,chain_type,contract,accept_id,symbol,name,publisher,project,logo_url,logo_bytes,decimal,gas_limit,mark,version,CREATED_TIME,UPDATED_TIME,is_auth)values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);";
        let mut update_digit_statement = self.db_hander.prepare(insert_sql)?;
        // todo 检查代币之间的关系  新增的认证代币是否为已经存在的非认证代币？新增的非认证代币若为存在的认证代币则直接返回
        for digit in digits {
            //todo 当新增的代币id不存在
            let id = if digit.id.is_empty() { uuid::Uuid::new_v4().to_string()}else { digit.id };
            update_digit_statement.bind(1,id.as_str())?;
            update_digit_statement.bind(2,self.is_main_chain(digit.chain_type.as_str()))?;
            update_digit_statement.bind(3,digit.contract.as_str())?;
            update_digit_statement.bind(4,digit.accept_id.as_str())?;
            update_digit_statement.bind(5,digit.symbol.as_str())?;
            update_digit_statement.bind(6,digit.name.as_str())?;
            update_digit_statement.bind(7,digit.publisher.as_str())?;
            update_digit_statement.bind(8,digit.project.as_str())?;
            update_digit_statement.bind(9,digit.logo_url.as_str())?;
            update_digit_statement.bind(10,digit.logo_bytes.as_str())?;//需要前端传过来的为bytes格式
            update_digit_statement.bind(11,digit.decimal)?;
            update_digit_statement.bind(12,digit.gas_limit)?;
            update_digit_statement.bind(13,digit.mark.as_str())?;
            update_digit_statement.bind(14,digit.version)?;
            update_digit_statement.bind(15,digit.create_time)?;
            update_digit_statement.bind(16,digit.update_time)?;
            update_digit_statement.bind(17, is_auth as i64)?;

            update_digit_statement.next()?;
            update_digit_statement.reset()?;
        }
        Ok(())
    }


    pub fn add_digit(&self,wallet_id:&str,chain_id:&str,digit_id:&str)->WalletResult<()>{
        //todo 判断需要添加的代币对应的链类型是否与传递进来的链类型一致
        // 查看代币是否存在,这里规定新增的代币合约地址不会重复
        let digit_detail_sql = "select contract,chain_type,symbol,name,logo_url,decimal from detail.DigitBase where id = ?;";
        let mut count_statement = self.db_hander.prepare(digit_detail_sql)?;
        count_statement.bind(1,digit_id)?;
       if let State::Done = count_statement.next().unwrap(){
           return Err(WalletError::Custom("digit id not exist".to_string()))
       }else {

         let new_default_digit = model::DigitExport{
               id: Some(digit_id.to_string()),
               contract_address: Some(count_statement.read::<String>(0).unwrap()),
               short_name: count_statement.read::<String>(2).unwrap(),
               full_name: count_statement.read::<String>(3).unwrap(),
               group_name: Some("ETH".to_string()),
               decimal: count_statement.read::<i64>(5).unwrap(),
               chain_type: self.convert_chain_type(count_statement.read::<i64>(1).unwrap()),
               img_url: Some(count_statement.read::<String>(4).unwrap()),
               is_basic: None,
               is_default: Some(false),
               status: None
           };
           self.update_default_digit(vec![new_default_digit]);
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
        let sql = format!("INSERT INTO detail.DigitUseDetail(digit_id,address_id) values('{}','{}');", digit_id,address_id);
        self.db_hander.execute(sql).map_err(|e|e.into())
    }
    //参数照理说定义成无符号数更合理,但后续中会涉及到多次强制类型转换
    pub fn get_digit_by_page(&self,chain_type:i64,is_auth:bool,start_item:i64,page_size:i64)->WalletResult<model::DigitList>{
        //当前假设存放的所有代币都能够有机会返回,计算总共有多少条
        //todo 怎么来处理这个总数的问题呢？
        let count_digit_item = "select count(*) from detail.DigitBase where chain_type = ? and is_auth =?;";
        let mut state = self.db_hander.prepare(count_digit_item)?;

        state.bind(1,chain_type)?;
        state.bind(2,is_auth as i64)?;
        state.next().unwrap();
        let count = state.read::<i64>(0).unwrap();
        let offset = if count<(start_item+page_size) {
          count-start_item
        }else { page_size };
        //返回指定条数的代币
        let select_digit = "select * from detail.DigitBase where chain_type = ? and is_auth =? limit ? offset ?;";
        let mut state = self.db_hander.prepare(select_digit)?;
        state.bind(1,chain_type)?;
        state.bind(2,is_auth as i64)?;
        state.bind(3,offset)?;
        state.bind(4,start_item)?;

        let mut auth_digits = Vec::with_capacity(page_size as usize);
        while let State::Row = state.next().unwrap() {
            let row_data = model::AuthDigit{
                id: state.read::<String>(0).unwrap(),
                chain_type: self.convert_chain_type(state.read::<i64>(1).unwrap()),
                contract: state.read::<String>(2).unwrap(),
                accept_id: state.read::<String>(3).unwrap(),
                symbol: state.read::<String>(4).unwrap(),
                name: state.read::<String>(5).unwrap(),
                publisher: state.read::<String>(6).unwrap(),
                project: state.read::<String>(7).unwrap(),
                logo_url: state.read::<String>(8).unwrap(),
                logo_bytes: state.read::<String>(9).unwrap(),
                decimal: state.read::<i64>(10).unwrap(),
                gas_limit:state.read::<i64>(11).unwrap(),
                mark: state.read::<String>(12).unwrap(),
                create_time: state.read::<i64>(16).unwrap(),
                update_time: state.read::<i64>(17).unwrap(),
                version: state.read::<i64>(18).unwrap(),
            };
            auth_digits.push(row_data);
        }
        Ok( model::DigitList{
            count:count as u32,
            auth_digit:auth_digits,
        })
    }
    // 这个条件查询和分页查询可以合并，当前在输入条件限制下不会出现需要分页的情况
    pub fn query_digit(&self,chain_type:i64,name:Option<String>,contract_addr:Option<String>)->WalletResult<model::DigitList>{
        let mut select_digit = format!("select * from detail.DigitBase where chain_type =? ");
        if contract_addr.is_some(){
            select_digit.push_str("and contract = ? ")
        }
        if name.is_some(){
            select_digit.push_str("and symbol||name like ?")
        }

        println!("query sql is:{}",select_digit);

        let mut state = self.db_hander.prepare(select_digit)?;
        state.bind(1,chain_type)?;
        //Todo 能够优化写法吗

        if let Some(addr) = contract_addr.clone(){
            state.bind(2,addr.as_str())?;

        }
        if let Some(name)=name{
            let query_name = format!("%{}%",name);
            if contract_addr.is_none() {
                state.bind(2,query_name.as_str())?;
            }else {
                state.bind(3,query_name.as_str())?;
            }

        }

        let mut auth_digits = Vec::with_capacity(16 as usize);
        while let State::Row = state.next().unwrap() {
            let row_data = model::AuthDigit{
                id: state.read::<String>(0).unwrap(),
                chain_type: self.convert_chain_type(state.read::<i64>(1).unwrap()),
                contract: state.read::<String>(2).unwrap(),
                accept_id: state.read::<String>(3).unwrap(),
                symbol: state.read::<String>(4).unwrap(),
                name: state.read::<String>(5).unwrap(),
                publisher: state.read::<String>(6).unwrap(),
                project: state.read::<String>(7).unwrap(),
                logo_url: state.read::<String>(8).unwrap(),
                logo_bytes: state.read::<String>(9).unwrap(),
                decimal: state.read::<i64>(10).unwrap(),
                gas_limit:state.read::<i64>(11).unwrap(),
                mark: state.read::<String>(12).unwrap(),
                create_time: state.read::<i64>(16).unwrap(),
                update_time: state.read::<i64>(17).unwrap(),
                version: state.read::<i64>(18).unwrap(),
            };
            auth_digits.push(row_data);
        }
        Ok( model::DigitList{
            count:auth_digits.len() as u32,
            auth_digit:auth_digits,
        })
    }
}
