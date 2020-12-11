use rbatis_macro_driver::CRUDEnable;
use serde::Deserialize;
use serde::Serialize;

use wallets_macro::{db_append_shared, DbBeforeSave, DbBeforeUpdate};

use crate::kits;
use crate::ma::dao::{self, Shared};
use crate::ma::MWallet;

//导入/创建钱包时生成
//修改密码时修改
//删除钱包时软件删除
//功能是作为备份使用，如果Wallet表中的数据无法读取时，才起用此表 ,CRUDEnable
#[db_append_shared]
#[derive(Serialize, Deserialize, Clone, Debug, Default, CRUDEnable, DbBeforeSave, DbBeforeUpdate)]
pub struct MMnemonic {
    #[serde(default)]
    pub mnemonic_digest: String,
    #[serde(default)]
    pub mnemonic: String,
    #[serde(default)]
    pub wallet_type: String,
    #[serde(default)]
    pub name: String,
}

impl MMnemonic {
    pub const fn create_table_script() -> &'static str {
        std::include_str!("../../../sql/m_mnemonic.sql")
    }
    pub fn from(&mut self, w: &MWallet) {
        self.mnemonic = w.mnemonic.clone();
        self.wallet_type = w.wallet_type.clone();
        self.mnemonic_digest = w.mnemonic_digest.clone();
        self.name = w.name.clone();
    }
}


#[cfg(test)]
mod tests {
    use async_std::task::block_on;
    use once_cell::sync::Lazy;
    use rbatis::crud::CRUDEnable;
    use rbatis::rbatis::Rbatis;
    use serde::{Deserialize, Serialize};

    use wallets_macro::db_append_shared;

    use crate::ma::dao::{BeforeSave, BeforeUpdate, Dao, MMnemonic, Shared};
    use crate::ma::db_dest;

    const TABLE: &str = MMnemonic::create_table_script();
    static TABLE_NAME: Lazy<String> = Lazy::new(|| MMnemonic::table_name());

    #[test]
    #[allow(non_snake_case)]
    fn test_Mnemonic() {
        // let colx = Mnemonic::table_columns();
        let mut m = MMnemonic::default();
        assert_eq!("", m.get_id());
        assert_eq!(0, m.get_create_time());
        assert_eq!(0, m.get_update_time());
        m.before_save();
        assert_ne!("", m.get_id());
        assert_ne!(0, m.get_create_time());
        assert_ne!(0, m.get_update_time());
        assert_eq!(m.get_create_time(), m.get_update_time());

        let mut m = MMnemonic::default();
        m.before_update();
        assert_eq!("", m.get_id());
        assert_eq!(0, m.get_create_time());
        assert_ne!(0, m.get_update_time());

        let rb = block_on(init_memory());
        let mut m = MMnemonic::default();
        m.mnemonic = "test".to_owned();
        m.wallet_type = "eee".to_owned();
        m.mnemonic_digest = String::new();
        let err = block_on(m.save(&rb, ""));
        assert_eq!(false, err.is_err());
        let re = block_on(MMnemonic::fetch_by_id(&rb, "", &m.id));
        assert_eq!(false, re.is_err());
        let m2 = re.unwrap();
        assert_eq!(m.id, m2.id);
        assert_eq!(m.update_time, m2.update_time);
        assert_eq!(m.create_time, m2.create_time);

        assert_eq!(m.mnemonic, m2.mnemonic);
        assert_eq!(m.wallet_type, m2.wallet_type);
        assert_eq!(m.mnemonic_digest, m2.mnemonic_digest);

        let mut m3 = MMnemonic::default();
        m3.mnemonic = "m3".to_owned();
        let re = block_on(m3.save(&rb, ""));
        assert_eq!(false, re.is_err());
        let re = block_on(MMnemonic::list(&rb, ""));
        assert_eq!(false, re.is_err());
        let list = re.unwrap();
        assert_eq!(2, list.len());
    }

    async fn init_memory() -> Rbatis {
        let rb = db_dest::init_memory(None).await;
        let _ = rb.exec("", format!("drop table {}", TABLE_NAME.as_str()).as_str()).await;
        let r = rb.exec("", TABLE).await;
        assert_eq!(false, r.is_err(), "{:?}", r);
        rb
    }

    #[test]
    fn test_flatten() {
        #[db_append_shared]
        #[derive(Serialize, Deserialize, Clone, Debug, Default)]
        struct Big {
            #[serde(default)]
            pub name_: String,
            #[serde(flatten, default)]
            pub one: One,
        }

        #[derive(Serialize, Deserialize, Clone, Debug, Default)]
        struct One {
            #[serde(default)]
            pub id_: String,
            #[serde(default)]
            pub count_: u64,
        }

        let mut big = Big::default();
        big.name_ = "n".to_owned();
        big.one.id_ = "tt_id".to_owned();
        let s = serde_json::to_string(&big).unwrap();
        println!("{}", s);
        let big2: Big = serde_json::from_str(&s).unwrap();
        println!("{:?}", big2);

        {
            let bean: serde_json::Result<Big> = serde_json::from_str("{}");
            if bean.is_err() {
                println!("debug {}", bean.unwrap_err());
            } else {
                let v = serde_json::json!(&bean.unwrap());
                if !v.is_object() {
                    println!("debug");
                }
                let m = v.as_object().unwrap();
                let mut fields = String::new();
                for (k, _) in m {
                    fields.push_str(k);
                    fields.push_str(",");
                }
                fields.pop();
                let cols = format!("{}", fields);
                println!("{}", cols);
            }
        }
    }
}
