use rbatis::crud::CRUDEnable;
use rbatis_macro_driver::CRUDEnable;
use serde::Deserialize;
use serde::Serialize;

use wallets_macro::{db_append_shared, DbBeforeSave, DbBeforeUpdate};

use crate::kits;
use crate::ma::db::{self, Shared};

//导入/创建钱包时生成
//修改密码时修改
//删除钱包时软件删除
//功能是作为备份使用，如果Wallet表中的数据无法读取时，才起用此表 ,CRUDEnable
#[db_append_shared]
#[derive(Serialize, Deserialize, Clone, Debug, Default, CRUDEnable, DbBeforeSave, DbBeforeUpdate)]
pub struct Mnemonic {
    pub mnemonic_digest: String,
    pub mnemonic: String,
    pub wallet_type: String,
}


#[cfg(test)]
mod tests {
    use std::ops::Add;

    use rbatis::crud::CRUDEnable;
    use rbatis::rbatis::Rbatis;

    use crate::ma::db::{BeforeSave, BeforeUpdate, Mnemonic, Shared};

    #[test]
    fn test_mnemonic() {
        // let colx = Mnemonic::table_columns();
        let mut m = Mnemonic::default();
        assert_eq!("", m.get_id());
        assert_eq!(0, m.get_create_time());
        assert_eq!(0, m.get_update_time());
        m.before_save();
        assert_ne!("", m.get_id());
        assert_ne!(0, m.get_create_time());
        assert_ne!(0, m.get_update_time());
        assert_eq!(m.get_create_time(), m.get_update_time());

        let mut m = Mnemonic::default();
        m.before_update();
        assert_eq!("", m.get_id());
        assert_eq!(0, m.get_create_time());
        assert_ne!(0, m.get_update_time());

        // let rb = block_on(init_rbatis("mnemonic"));
    }

    async fn init_rbatis(db_file_name: &str) -> Rbatis {
        log::info!("init_rbatis");
        if std::fs::metadata(db_file_name).is_err() {
            let file = std::fs::File::create(db_file_name);
            if file.is_err() {
                log::info!("{:?}",file.err().unwrap());
            }
        }
        let rb = Rbatis::new();
        let url = "sqlite://".to_owned().add(db_file_name);
        log::info!("{:?}",url);
        let r = rb.link(url.as_str()).await;
        if r.is_err() {
            log::info!("{:?}",r.err().unwrap());
        }

        return rb;
    }
}
