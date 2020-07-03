use super::*;
use sqlite::{State, Statement};

impl DataServiceProvider {
    fn change_visible(&self, walletid: &str, chainid: i64, digitid: &str, is_visible_flag: i64) -> WalletResult<bool> {
        let show_digit_sql = "UPDATE detail.DigitUseDetail set is_visible = ? WHERE digit_id = ? and address_id = ( select address_id from detail.Address WHERE wallet_id=? and chain_id=?);";
        let mut show_digit_state = self.db_hander.prepare(show_digit_sql)?;
        show_digit_state.bind(1, is_visible_flag)?;
        show_digit_state.bind(2, digitid)?;
        show_digit_state.bind(3, walletid)?;
        show_digit_state.bind(4, chainid)?;
        show_digit_state.next().map(|_| true).map_err(|e| e.into())
    }
    pub fn show_digit(&self, walletid: &str, chainid: i64, digitid: &str) -> WalletResult<bool> {
        self.change_visible(walletid, chainid, digitid, 1)
    }

    pub fn hide_digit(&self, walletid: &str, chainid: i64, digitid: &str) -> WalletResult<bool> {
        self.change_visible(walletid, chainid, digitid, 0)
    }

    pub fn update_digit_balance(self, address: &str, digit_id: &str, value: &str) -> WalletResult<bool> {
        let update_sql = "update detail.DigitUseDetail set balance = ? where digit_id = ? and address_id = (select address_id from detail.Address where address = ?);";
        let mut update_sql_state = self.db_hander.prepare(update_sql)?;
        update_sql_state.bind(1, value)?;
        update_sql_state.bind(2, digit_id)?;
        update_sql_state.bind(3, address)?;
        update_sql_state.next().map(|_| true).map_err(|e| e.into())
    }
    //Add tokens
    fn add_default_digits(&self, digits: Vec<model::DefaultDigit>) -> WalletResult<()> {
        let insert_sql = "insert into detail.DefaultDigitBase(id,contract_address,chain_type,group_name,short_name,full_name,url_img,decimals,is_basic,is_default,status)values(?,?,?,?,?,?,?,?,?,?,?);";
        let mut insert_basic_statement = self.db_hander.prepare(insert_sql)?;
        for digit in digits {
            if let Some(id) = digit.id {
                insert_basic_statement.bind(1, id.as_str())?;
            } else {
                insert_basic_statement.bind(1, uuid::Uuid::new_v4().to_string().as_str())?;
            }
            insert_basic_statement.bind(2, digit.contract_address.unwrap_or_else(|| "".to_string()).as_str())?;
            //Whether the token type is officially connected or a test chain
            insert_basic_statement.bind(3, self.is_main_chain(&digit.chain_type))?;
            insert_basic_statement.bind(4, digit.group_name.unwrap_or_else(|| "ETH".to_string()).as_str())?;
            insert_basic_statement.bind(5, digit.short_name.as_str())?;
            insert_basic_statement.bind(6, digit.full_name.as_str())?;
            insert_basic_statement.bind(7, digit.img_url.unwrap_or_else(|| "".to_string()).as_str())?;
            insert_basic_statement.bind(8, digit.decimal.as_str().parse::<i64>().unwrap_or(18))?;
            insert_basic_statement.bind(9, digit.is_basic.unwrap_or(false) as i64)?;//The most basic token (chain token)
            insert_basic_statement.bind(10, digit.is_default.unwrap_or(true) as i64)?;//Set whether the added token is the default token
            insert_basic_statement.bind(11, digit.status.unwrap_or(1))?;//Whether to display the status
            insert_basic_statement.next()?;
            insert_basic_statement.reset()?;
        }
        Ok(())
    }

    pub fn init_basic_digit(&self) -> WalletResult<()> {
        let bytecode = include_bytes!("res/chainTokenFile.json");
        let digits = serde_json::from_slice::<Vec<model::DefaultDigit>>(&bytecode[..])?;
        self.add_default_digits(digits)
    }

    /// Update default token logic
    /// Update the status of the original added default token to the status of the non-default token, and start to update the token. This interface is used to import data from outside in batches
    pub fn update_default_digits(&self, digits: Vec<model::DefaultDigit>) -> WalletResult<()> {
        //todo finely handles the case of default tokens. At present, the default tokens that have been added are directly deleted in a simple and crude way, and then the new tokens are inserted into the database table
        let delete_sql = "delete from detail.DefaultDigitBase where is_basic = 0 and is_default =1;";
        self.db_hander.execute(delete_sql)?;
        self.add_default_digits(digits)
    }


    pub fn update_digit_base(&self, digits: Vec<model::EthToken>, is_auth: bool) -> WalletResult<()> {
        //When the update is an authentication token. Need to delete the original token
        if is_auth {
            let delete_sql = format!("delete from detail.DigitBase where is_auth = {};", is_auth as u16);
            self.db_hander.execute(delete_sql)?;
        } else {
            //Add custom token, need to check whether the token already exists
            let select_sql = "select count(*) from detail.DigitBase where contract = ?;";
            let mut select_sql_statement = self.db_hander.prepare(select_sql)?;
            for digit in digits.clone() {
                select_sql_statement.bind(1, digit.contract.as_str())?;
                select_sql_statement.next()?;
                let count = select_sql_statement.read::<i64>(0).unwrap() as u32;
                if count > 0 {
                    return Err(WalletError::Custom(format!("digit {} exist!", digit.contract)));
                }
            }
        }

        let insert_sql = "insert into detail.DigitBase(id,chain_type,contract,accept_id,symbol,name,publisher,project,logo_url,logo_bytes,decimal,gas_limit,is_auth)values(?,?,?,?,?,?,?,?,?,?,?,?,?);";
        let mut update_digit_statement = self.db_hander.prepare(insert_sql)?;
        for digit in digits {
            let id = if digit.id.is_empty() { uuid::Uuid::new_v4().to_string() } else { digit.id };
            update_digit_statement.bind(1, id.as_str())?;
            update_digit_statement.bind(2, self.chain_name_to_chain_number(digit.chain_type.as_str()))?;
            update_digit_statement.bind(3, digit.contract.as_str())?;
            update_digit_statement.bind(4, digit.accept_id.unwrap_or_else(|| "".to_string()).as_str())?;
            update_digit_statement.bind(5, digit.symbol.as_str())?;
            update_digit_statement.bind(6, digit.name.as_str())?;
            update_digit_statement.bind(7, digit.publisher.unwrap_or_else(|| "".to_string()).as_str())?;
            update_digit_statement.bind(8, digit.project.unwrap_or_else(|| "".to_string()).as_str())?;
            update_digit_statement.bind(9, digit.logo_url.as_str())?;
            update_digit_statement.bind(10, digit.logo_bytes.unwrap_or_else(|| "".to_string()).as_str())?;//Need to be transmitted in bytes format from the front end
            update_digit_statement.bind(11, digit.decimal.as_str().parse::<i64>().unwrap_or(18))?;
            update_digit_statement.bind(12, digit.gas_limit.unwrap_or(0))?;
            update_digit_statement.bind(13, is_auth as i64)?;

            update_digit_statement.next()?;
            update_digit_statement.reset()?;
        }
        Ok(())
    }

    //Get information from the token library and update the default token
     pub fn add_digit_from_base(&self, wallet_id: &str, chain_id: i64, digit_id: &str) -> WalletResult<()> {
        //todo judge whether the chain type corresponding to the token to be added is consistent with the chain type passed in
        // Check if the token exists, here it is stipulated that the new token contract address will not be repeated
        let digit_detail_sql = "select contract,chain_type,symbol,name,logo_url,decimal from detail.DigitBase where id = ?;";
        let mut count_statement = self.db_hander.prepare(digit_detail_sql)?;
        count_statement.bind(1, digit_id)?;
        if let State::Done = count_statement.next().unwrap() {
            return Err(WalletError::Custom("digit id not exist".to_string()));
        } else {
            let new_default_digit = model::DefaultDigit {
                id: Some(digit_id.to_string()),
                contract_address: Some(count_statement.read::<String>(0).unwrap()),
                short_name: count_statement.read::<String>(2).unwrap(),
                full_name: count_statement.read::<String>(3).unwrap(),
                group_name: Some("ETH".to_string()),
                decimal: count_statement.read::<String>(5).unwrap(),
                chain_type: self.convert_chain_type(count_statement.read::<i64>(1).unwrap()),
                img_url: Some(count_statement.read::<String>(4).unwrap()),
                is_basic: None,
                is_default: Some(false),
                status: None,
            };
            //Add a default token
            self.add_default_digits(vec![new_default_digit])?;
        }

        //Get the address id corresponding to the wallet, currently only supports Ethereum tokens
        let address_id = "select address_id from detail.Address a where a.wallet_id =? and a.chain_id = ?;";
        let mut statement = self.db_hander.prepare(address_id)?;
        statement.bind(1, wallet_id)?;
        statement.bind(2, chain_id)?;
        let mut cursor = statement.cursor();
        let value = cursor.next().unwrap().ok_or(WalletError::NotExist)?;
        let address_id = value[0].as_string().unwrap();
        //Add tokens
        let sql = format!("INSERT INTO detail.DigitUseDetail(digit_id,address_id) values('{}','{}');", digit_id, address_id);
        self.db_hander.execute(sql).map_err(|e| e.into())
    }
    //Parameters are logically defined as unsigned numbers, but many subsequent mandatory type conversions will be involved
    pub fn get_digit_by_page(&self, chain_type: i64, is_auth: bool, start_item: i64, page_size: i64) -> WalletResult<model::DigitList> {
        //Currently assume that all tokens deposited can have a chance to return, and calculate how many tokens there are in total
        let count_digit_item = "select count(*) from detail.DigitBase where chain_type = ? and is_auth =?;";
        let mut state = self.db_hander.prepare(count_digit_item)?;

        state.bind(1, chain_type)?;
        state.bind(2, is_auth as i64)?;
        state.next().unwrap();
        let count = state.read::<i64>(0).unwrap();
        let offset = if count < (start_item + page_size) { count - start_item } else { page_size };
        //Returns the specified number of tokens
        let select_digit = "select * from detail.DigitBase where chain_type = ? and is_auth =? limit ? offset ?;";
        let mut state = self.db_hander.prepare(select_digit)?;
        state.bind(1, chain_type)?;
        state.bind(2, is_auth as i64)?;
        state.bind(3, offset)?;
        state.bind(4, start_item)?;

        let digits = self.fetch_tokens(state);
        Ok(model::DigitList {
            count: digits.len() as u32,
            eth_tokens: digits,
        })
    }
    // This conditional query and paging query can be merged, and there is currently no need for paging under the input conditions.
    pub fn query_digit(&self, chain_type: i64, name: Option<String>, contract_addr: Option<String>) -> WalletResult<model::DigitList> {
        let mut select_digit = "select * from detail.DigitBase where chain_type =? ".to_string();
        if contract_addr.is_some() {
            select_digit.push_str("and contract = ? ")
        }
        if name.is_some() {
            select_digit.push_str("and symbol||name like ?")
        }
        let mut state = self.db_hander.prepare(select_digit)?;
        state.bind(1, chain_type)?;
        if let Some(addr) = contract_addr.clone() {
            state.bind(2, addr.as_str())?;
        }
        if let Some(name) = name {
            let query_name = format!("%{}%", name);
            if contract_addr.is_none() {
                state.bind(2, query_name.as_str())?;
            } else {
                state.bind(3, query_name.as_str())?;
            }
        }
        let auth_digits = self.fetch_tokens(state);
        Ok(model::DigitList {
            count: auth_digits.len() as u32,
            eth_tokens: auth_digits,
        })
    }

    fn fetch_tokens(&self, mut state: Statement) -> Vec<model::EthToken> {
        let mut auth_digits = Vec::with_capacity(32 as usize);
        while let State::Row = state.next().unwrap() {
            let row_data = model::EthToken {
                id: state.read::<String>(0).unwrap(),
                chain_type: self.convert_chain_type(state.read::<i64>(1).unwrap()),
                contract: state.read::<String>(2).unwrap(),
                accept_id: state.read::<String>(3).ok(),
                symbol: state.read::<String>(4).unwrap(),
                name: state.read::<String>(5).unwrap(),
                publisher: state.read::<String>(6).ok(),
                project: state.read::<String>(7).ok(),
                logo_url: state.read::<String>(8).unwrap(),
                logo_bytes: state.read::<String>(9).ok(),
                decimal: state.read::<String>(10).unwrap(),
                gas_limit: state.read::<i64>(11).ok(),
                mark: state.read::<String>(12).ok(),
                create_time: state.read::<i64>(16).ok(),
                update_time: state.read::<i64>(17).ok(),
                version: state.read::<i64>(18).ok(),
            };
            auth_digits.push(row_data);
        }
        auth_digits
    }

    //Conversion chain type, is it a formal chain or a test chain
    fn is_main_chain(&self, chain_type: &str) -> i64 {
        match chain_type {
            "ETH" => 1,
            "default" => 1,
            "ETH_TEST" => 0,
            "test" => 0,
            _ => 1,
        }
    }


    fn chain_name_to_chain_number(&self, chain_type: &str) -> i64 {
        match chain_type {
            "ETH" => 3,
            "default" => 3,
            "ETH_TEST" => 4,
            "test" => 4,
            "EEE" => 5,
            "EEE_TEST" => 6,
            _ => 3,
        }
    }
    fn convert_chain_type(&self, chain_type: i64) -> String {
        match chain_type {
            3 => "ETH".into(),
            4 => "ETH_TEST".into(),
            _ => "ETH".into(),
        }
    }
}
