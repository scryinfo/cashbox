use crate::wallet_db::db_helper::DataServiceProvider;
use crate::model::WalletObj;
use log::debug;

impl DataServiceProvider {
    fn check_chain_type(chainid: &str) -> String {
        let mut digit_table_type = "";
        match chainid {
            "1" => {
                digit_table_type = "detail.BtcDigit";
            }
            "2" => {
                digit_table_type = "detail.BtcDigit";
            }
            "3" => {
                digit_table_type = "detail.EthDigit";
            }
            "4" => {
                digit_table_type = "detail.EthDigit";
            }
            "5" => {
                digit_table_type = "detail.EeeDigit";
            }
            "6" => {
                digit_table_type = "detail.EeeDigit";
            }
            _ => {
                digit_table_type = "detail.EthDigit";
            }
        }

        return digit_table_type.to_string();
    }

    pub fn change_visible(&mut self, walletid: &str, chainid: &str, digitid: &str, isvisibleflag: i64) -> Result<(), String> {
        let get_address_id_sql = "select address_id from detail.Address WHERE wallet_id=? and chain_id=?;";
        let mut address_state = self.db_hander.prepare(get_address_id_sql).unwrap();
        address_state.bind(1, walletid).expect("walletid is error!");
        address_state.bind(2, chainid).expect("chainid is error!");
        let mut address_id = "";
        let mut cursor_state = address_state.cursor();
        match cursor_state.next() {
            Ok(value) => {
                let data = value.unwrap();
                address_id = data[0].as_string().unwrap();
            }
            Err(e) => {}
        }
        let show_digit_sql = format!("{} {} {} {} {}", "UPDATE", Self::check_chain_type(chainid), "set is_visible = ", isvisibleflag, "WHERE address_id=? ;");
        let mut show_digit_state = self.db_hander.prepare(show_digit_sql).unwrap();
        show_digit_state.bind(1, address_id).expect("address_id is error!");
        match show_digit_state.cursor().next() {
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