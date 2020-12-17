use mav::ChainType;
use mav::ma::{Dao, MSetting, SettingType};

use crate::{ContextTrait, WalletError};
use crate::deref_type;

#[derive(Debug, Default)]
pub struct Setting {
    pub m: MSetting,
}
deref_type!(Setting,MSetting);

impl Setting {
    pub async fn current_wallet_chain(context: &dyn ContextTrait) -> Result<(String, ChainType), WalletError> {
        let rb = context.db().wallets_db();
        let mut wrapper = rb.new_wrapper();
        wrapper.eq(MSetting::key_str, SettingType::CurrentWallet.to_string()).or().eq(MSetting::key_str, SettingType::CurrentChain.to_string());
        let settings = MSetting::list_by_wrapper(rb, "", &wrapper).await?;
        if settings.len() < 2 {
            Err(WalletError::NoRecord("".to_owned()))
        } else if settings.len() > 2 {
            Err(WalletError::Db(mav::Error::from("the len  > 2")))
        } else {
            let mut re = ("".to_owned(), ChainType::EeeTest);
            for it in &settings {
                let t = SettingType::from(&it.key_str);
                match t {
                    SettingType::CurrentChain => re.1 = ChainType::from(&it.value_str.clone()),
                    SettingType::CurrentWallet => re.0 = it.value_str.clone(),
                    _ => {
                        return Err(WalletError::Db(mav::Error::from("not current chain or wallet")));
                    }
                }
            }
            Ok(re)
        }
    }
    pub async fn save_current_wallet_chain(context: &dyn ContextTrait, wallet_id: &str, chain_type: &ChainType) -> Result<(), WalletError> {
        let rb = context.db().wallets_db();
        let mut chain_setting = MSetting::default();
        let mut wallet_setting = MSetting::default();
        {
            let mut wrapper = rb.new_wrapper();
            wrapper.eq(MSetting::key_str, SettingType::CurrentWallet.to_string()).or().eq(MSetting::key_str, SettingType::CurrentChain.to_string());
            let settings = MSetting::list_by_wrapper(rb, "", &wrapper).await?;
            for it in &settings {
                let t = SettingType::from(&it.key_str);
                match t {
                    SettingType::CurrentChain => chain_setting = it.clone(),
                    SettingType::CurrentWallet => wallet_setting = it.clone(),
                    _ => {
                        return Err(WalletError::Db(mav::Error::from("not current chain or wallet")));
                    }
                }
            }
        }
        let mut tx = rb.begin_tx_defer(false).await?;
        wallet_setting.value_str = wallet_id.to_owned();
        wallet_setting.save_update(rb, &tx.tx_id).await?;
        chain_setting.value_str = chain_type.to_string();
        chain_setting.save_update(rb, &tx.tx_id).await?;

        tx.is_drop_commit = true;
        Ok(())
    }
    pub async fn get_setting(context: &dyn ContextTrait, key: &SettingType) -> Result<MSetting, WalletError> {
        let rb = context.db().wallets_db();
        let mut wrapper = rb.new_wrapper();
        wrapper.eq(MSetting::key_str, key.to_string());
        let r = MSetting::list_by_wrapper(rb, "", &wrapper).await?;
        if r.is_empty() {
            Err(WalletError::NoRecord("".to_owned()))
        } else {
            Ok(r[0].clone())
        }
    }
}

#[cfg(test)]
mod tests {
    use async_std::task::block_on;
    use rbatis::crud::CRUDEnable;

    use mav::ChainType;
    use mav::ma::{Dao, Db, DbCreateType, MSetting, SettingType};

    use crate::{ContextTrait, Setting, WalletError};
    use crate::tests::mock_context;

    #[test]
    fn setting_test() {
        let context = init_table();
        let re = block_on(Setting::current_wallet_chain(context.as_ref()));
        assert_eq!(true, re.is_err(), "{:?}", re);
        let err = re.unwrap_err();
        if let WalletError::NoRecord(_) = err {} else {
            panic!(format!("Error is not  {:?}", err))
        }
        let wallet_id = "test".to_owned();
        let chain_type = ChainType::EEE;
        let rb = context.db().wallets_db();
        {//save current wallet
            let mut m = MSetting::default();
            m.key_str = SettingType::CurrentWallet.to_string();
            m.value_str = wallet_id.clone();
            let re = block_on(m.save(rb, ""));
            assert_eq!(false, re.is_err(), "{:?}", re);
            let re = block_on(Setting::current_wallet_chain(context.as_ref()));
            assert_eq!(true, re.is_err(), "{:?}", re);
            let err = re.unwrap_err();
            if let WalletError::NoRecord(_) = err {} else {
                panic!(format!("Error is not  {:?}", err))
            }
        }
        {//save current chain
            let mut m = MSetting::default();
            m.key_str = SettingType::CurrentChain.to_string();
            m.value_str = chain_type.to_string();
            let re = block_on(m.save(rb, ""));
            assert_eq!(false, re.is_err(), "{:?}", re);
            let re = block_on(Setting::current_wallet_chain(context.as_ref()));
            assert_eq!(false, re.is_err(), "{:?}", re);
            let re = re.unwrap();
            assert_eq!((wallet_id, chain_type), re);
        }
    }

    fn init_table() -> Box<dyn ContextTrait> {
        let context = mock_context();
        let rb = context.db().wallets_db();
        let re = block_on(Db::create_table(rb, MSetting::create_table_script(), &MSetting::table_name(), &DbCreateType::Drop));
        assert_eq!(false, re.is_err(), "{:?}", re);
        context
    }
}

