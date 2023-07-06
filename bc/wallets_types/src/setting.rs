use mav::{ChainType, NetType};
use mav::ma::{Dao, MSetting, SettingType};

use crate::{ContextTrait, WalletError};
use crate::deref_type;

#[derive(Debug, Default)]
pub struct Setting {
    pub m: MSetting,
}
deref_type!(Setting,MSetting);

impl Setting {
    /// 返回当前的wallet and chain，如果没有数据返回None
    pub async fn current_wallet_chain(context: &dyn ContextTrait) -> Result<Option<(String, ChainType)>, WalletError> {
        let wallet_setting = Setting::get_setting(context, &SettingType::CurrentWallet).await?;
        let chain_setting = Setting::get_setting(context, &SettingType::CurrentChain).await?;
        match (wallet_setting, chain_setting) {
            (Some(w), Some(c)) => {
                let chain = ChainType::from(c.value_str.as_str())?;
                Ok(Some((w.value_str, chain)))
            }
            _ => {
                Ok(None)
            }
        }
    }

    pub async fn current_net_type(context: &dyn ContextTrait) -> Result<String, WalletError> {
        let net_type_setting = Setting::get_setting(context, &SettingType::CurrentNetType).await?;
        match net_type_setting {
            Some(item) => Ok(item.value_str),
            None => Ok(NetType::Main.to_string()),
        }
        // net_type_setting.map(|item| item.value_str ).ok_or(WalletError::NotExist)
    }

    pub async fn change_net_type(context: &dyn ContextTrait, net_type: &NetType) -> Result<u64, WalletError> {
        let rb = context.db().wallets_db();
        let mut wallet_setting = Setting::get_setting(context, &SettingType::CurrentNetType).await?.unwrap_or_default();
        wallet_setting.key_str = SettingType::CurrentNetType.to_string();
        wallet_setting.value_str = net_type.to_string();
        wallet_setting.save_update(rb, "").await.map(|ret| ret.rows_affected).map_err(|err| WalletError::RbatisError(err))
    }


    /// save 当前的wallet and chain
    pub async fn save_current_wallet_chain(context: &dyn ContextTrait, wallet_id: &str, chain_type: &ChainType) -> Result<(), WalletError> {
        let rb = context.db().wallets_db();
        let mut wallet_setting = Setting::get_setting(context, &SettingType::CurrentWallet).await?.unwrap_or_default();
        let mut chain_setting = Setting::get_setting(context, &SettingType::CurrentChain).await?.unwrap_or_default();

        //tx 只处理异常情况下，事务的rollback，所以会在事务提交成功后，调用 tx.manager = None; 阻止 [rbatis::tx::TxGuard]再管理事务
        let mut tx = rb.begin_tx_defer(false).await?;
        wallet_setting.key_str = SettingType::CurrentWallet.to_string();
        wallet_setting.value_str = wallet_id.to_owned();
        wallet_setting.save_update(rb, &tx.tx_id).await?;
        chain_setting.value_str = chain_type.to_string();
        chain_setting.key_str = SettingType::CurrentChain.to_string();
        chain_setting.save_update(rb, &tx.tx_id).await?;
        rb.commit(&tx.tx_id).await?;
        tx.manager = None;
        Ok(())
    }

    pub async fn save_current_database_version(context: &dyn ContextTrait, version_value: &str) -> Result<(), WalletError> {
        let rb = context.db().wallets_db();
        let mut wallet_setting = Setting::get_setting(context, &SettingType::CurrentDbVersion).await?.unwrap_or_default();
        wallet_setting.key_str = SettingType::CurrentDbVersion.to_string();
        wallet_setting.value_str = version_value.to_string();
        wallet_setting.save_update(rb, "").await?;
        Ok(())
    }

    ///如果没有找到返回 none
    pub async fn get_setting(context: &dyn ContextTrait, key: &SettingType) -> Result<Option<MSetting>, WalletError> {
        let rb = context.db().wallets_db();
        let wrapper = rb.new_wrapper().eq(MSetting::key_str, key.to_string());
        let r = MSetting::fetch_by_wrapper(rb, "", &wrapper).await?;
        Ok(r)
    }
}

#[cfg(test)]
mod tests {
    use futures::executor::block_on;
    use rbatis::crud::CRUDTable;

    use mav::ChainType;
    use mav::ma::{Dao, Db, DbCreateType, MSetting, SettingType};

    use crate::{ContextTrait, Setting};

    #[test]
    fn setting_test() {
        let context = init_table();
        let re = block_on(Setting::current_wallet_chain(context.as_ref()));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let re = re.unwrap();
        assert_eq!(true, re.is_none(), "{:?}", re);

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
            assert_eq!(false, re.is_err(), "{:?}", re);
            let err = re.unwrap();
            assert_eq!(true, err.is_none(), "{:?}", err);
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
            assert_eq!(false, re.is_none(), "{:?}", re);
            let re = re.unwrap();
            assert_eq!((wallet_id.clone(), chain_type.clone()), re);
        }
        {
            let context = init_table();
            let re = block_on(Setting::current_wallet_chain(context.as_ref()));
            assert_eq!(false, re.is_err(), "{:?}", re);
            let re = re.unwrap();
            assert_eq!(true, re.is_none(), "{:?}", re);
            let re = block_on(Setting::save_current_wallet_chain(context.as_ref(), &wallet_id, &chain_type));
            assert_eq!(false, re.is_err(), "{:?}", re);

            let re = block_on(Setting::current_wallet_chain(context.as_ref()));
            assert_eq!(false, re.is_err(), "{:?}", re);
            let re = re.unwrap();
            assert_eq!(false, re.is_none(), "{:?}", re);
            let re = re.unwrap();
            assert_eq!((wallet_id.clone(), chain_type.clone()), re);
        }
    }

    fn init_table() -> Box<dyn ContextTrait> {
        let context = crate::tests::mock_memory_context();
        let rb = context.db().wallets_db();
        let re = block_on(Db::create_table(rb, MSetting::create_table_script(), &MSetting::table_name(), &DbCreateType::Drop));
        assert_eq!(false, re.is_err(), "{:?}", re);
        context
    }
}

