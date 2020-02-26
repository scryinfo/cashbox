use crate::wallet_db::db_helper::DataServiceProvider;

impl DataServiceProvider {

    pub fn change_visible(&mut self, walletid: &str, chainid: &str, digitid: &str, isvisibleflag: i64) -> Result<(), String> {

        let show_digit_sql =  "UPDATE detail.DigitUseDetail set is_visible = ? WHERE digit_id = ? address_id = ( select address_id from detail.Address WHERE wallet_id=? and chain_id=?);";
        let mut show_digit_state = self.db_hander.prepare(show_digit_sql).unwrap();
        show_digit_state.bind(1, isvisibleflag).expect("address_id is error!");
        show_digit_state.bind(2, digitid).expect("digitid is error!");
        show_digit_state.bind(3, walletid).expect("walletid is error!");
        show_digit_state.bind(4, chainid).expect("chainid is error!");
        match show_digit_state.next() {
            Ok(_) => {
                Ok(())
            }
            Err(e) => Err(e.to_string())
        }
    }
    pub fn show_digit(&mut self, walletid: &str, chainid: &str, digitid: &str) -> Result<(), String> {
        return Self::change_visible(self, walletid, chainid, digitid, 1);
    }

    pub fn hide_digit(&mut self, walletid: &str, chainid: &str, digitid: &str) -> Result<(), String> {
        return Self::change_visible(self, walletid, chainid, digitid, 0);
    }
}
