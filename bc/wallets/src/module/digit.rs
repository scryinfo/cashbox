use super::*;

//The tokens that can be operated at present are all related functions of Ethereum
impl Ethereum {
    pub fn add_wallet_digit(&self, wallet_id: &str, chain_id: i64, digit_id: &str) -> WalletResult<()> {
        let instance = wallet_db::DataServiceProvider::instance()?;
        instance.tx_begin()?;
        instance.add_digit_from_base(wallet_id, chain_id, digit_id)
            .and_then(|_| instance.tx_commint())
            .map_err(|error| {
                if let Err(rollback_err) = instance.tx_rollback() {
                    log::error!("rollback error:{}",rollback_err.to_string());
                }
                //The error information needs to be returned to the upper layer, and the Error returned by tx_rollback is not processed
                error
            })
    }
    pub fn show_digit(&self, walletid: &str, chainid: i64, digitid: &str) -> WalletResult<bool> {
        let instance = wallet_db::DataServiceProvider::instance()?;
        instance.show_digit(walletid, chainid, digitid)
    }

    pub fn hide_digit(&self, walletid: &str, chainid: i64, digitid: &str) -> WalletResult<bool> {
        let instance = wallet_db::DataServiceProvider::instance()?;
        instance.hide_digit(walletid, chainid, digitid)
    }
    pub fn update_balance(&self, address: &str, digit_id: &str, balance: &str) -> WalletResult<bool> {
        let instance = wallet_db::DataServiceProvider::instance()?;
        instance.update_digit_balance(address, digit_id, balance)
    }
    pub fn query_auth_digit(&self, chain_type: i64, is_auth: bool, start: i64, page_size: i64) -> WalletResult<model::DigitList> {
        let instance = wallet_db::DataServiceProvider::instance()?;
        instance.get_digit_by_page(chain_type, is_auth, start, page_size)
    }
    pub fn query_digit(&self, chain_type: i64, name: Option<String>, contract_addr: Option<String>) -> WalletResult<model::DigitList> {
        let instance = wallet_db::DataServiceProvider::instance()?;
        if name.is_none() && contract_addr.is_none() {
            return Err(WalletError::Custom("Query conditions is empty".to_string()));
        }
        instance.query_digit(chain_type, name, contract_addr)
    }

    //Receive the authentication token list passed by the client, and update the data to the authentication token list
    //todo processes each token based on whether the passed-in token belongs to the test chain or the main chain
    pub fn update_auth_digit(&self, digits: Vec<model::EthToken>, is_auth: bool, _chain_type: Option<String>) -> WalletResult<()> {
        let instance = wallet_db::DataServiceProvider::instance()?;
        instance.tx_begin()?;
        //At present, the full update method is used to directly delete the existing tokens and update the new tokens.
        match instance.update_digit_base(digits, is_auth) {
            Ok(()) => instance.tx_commint(),
            Err(e) => {
                instance.tx_rollback()?;
                Err(e)
            }
        }
    }

    pub fn update_default_digit(&self, digits: Vec<model::DefaultDigit>) -> WalletResult<()> {
        let helper = wallet_db::DataServiceProvider::instance()?;
        helper.tx_begin()?;
        //At present, the full update method is used to directly delete the existing tokens and update the new tokens.
        match helper.update_default_digits(digits) {
            Ok(()) => helper.tx_commint(),
            Err(e) => {
                helper.tx_rollback()?;
                Err(e)
            }
        }
    }
}




