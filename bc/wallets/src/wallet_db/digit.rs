use crate::wallet_db::db_helper::DataServiceProvider;
use crate::WalletError;

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

   /* pub fn update_balance(&mut self,address:&str,digit_id:&str,balance:&str)-> Result<bool, WalletError>{

        let sql = "update detail.DigitUseDetail set balance = ? where digit_id = ? and address_id = (select address_id from detail.address where address = ?);";
        let mut state = self.db_hander.prepare(sql)?;
        state.bind(1,balance)?;
        state.bind(1,digit_id)?;
        state.bind(1,address)?;
        state.cursor().next().map(|_|true).map_err(|e|e.into())
    }*/
}
