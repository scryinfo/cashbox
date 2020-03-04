use crate::wallet_db::db_helper::DataServiceProvider;
use crate::WalletError;

impl DataServiceProvider {

    pub fn change_visible(&mut self, walletid: &str, chainid: &str, digitid: &str, isvisibleflag: i64) -> Result<bool, WalletError> {

        let show_digit_sql =  "UPDATE detail.DigitUseDetail set is_visible = ? WHERE digit_id = ? address_id = ( select address_id from detail.Address WHERE wallet_id=? and chain_id=?);";
        let mut show_digit_state = self.db_hander.prepare(show_digit_sql)?;
        show_digit_state.bind(1, isvisibleflag)?;
        show_digit_state.bind(2, digitid)?;
        show_digit_state.bind(3, walletid)?;
        show_digit_state.bind(4, chainid)?;
        show_digit_state.next().map(|_|true).map_err(|e|e.into())

    }
    pub fn show_digit(&mut self, walletid: &str, chainid: &str, digitid: &str) -> Result<bool, WalletError> {
        return Self::change_visible(self, walletid, chainid, digitid, 1);
    }

    pub fn hide_digit(&mut self, walletid: &str, chainid: &str, digitid: &str) -> Result<bool, WalletError> {
        return Self::change_visible(self, walletid, chainid, digitid, 0);
    }
}
