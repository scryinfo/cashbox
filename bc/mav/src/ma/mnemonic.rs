// use rbatis_macro_driver::CRUDTable;
use rbatis::crud;
use serde::Deserialize;
use serde::Serialize;

use wallets_macro::{db_append_shared, DbBeforeSave, DbBeforeUpdate};

use crate::kits;
use crate::ma::dao::{self, Shared};
use crate::ma::MWallet;

//导入/创建钱包时生成
//修改密码时修改
//删除钱包时软件删除
//功能是作为备份使用，如果Wallet表中的数据无法读取时，才起用此表 ,CRUDTable
#[db_append_shared]
#[derive(PartialEq, Serialize, Deserialize, Clone, Debug, Default, DbBeforeSave, DbBeforeUpdate)]
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
crud!(MMnemonic{});

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
    use futures::executor::block_on;
    use rbatis::crud::CRUDTable;
    use rbatis::rbatis::Rbatis;
    use serde::{Deserialize, Serialize};

    use wallets_macro::db_append_shared;

    use crate::kits::test::make_memory_rbatis_test;
    use crate::ma::{Db, DbCreateType};
    use crate::ma::dao::{BeforeSave, BeforeUpdate, Dao, MMnemonic, Shared};

    #[test]
    #[allow(non_snake_case)]
    fn test_Mnemonic() {
        // let colx = Mnemonic::table_columns();
        let mut m = MMnemonic::default();
        assert_eq!("", Shared::get_id(&m));
        assert_eq!(0, m.get_create_time());
        assert_eq!(0, m.get_update_time());
        m.before_save();
        assert_ne!("", Shared::get_id(&m));
        assert_ne!(0, m.get_create_time());
        assert_ne!(0, m.get_update_time());
        assert_eq!(m.get_create_time(), m.get_update_time());

        let mut m = MMnemonic::default();
        m.before_update();
        assert_eq!("", Shared::get_id(&m));
        assert_eq!(0, m.get_create_time());
        assert_ne!(0, m.get_update_time());

        let rb = block_on(init_memory());
        {//exist
            let b = block_on(MMnemonic::exist_by_wrapper(&rb, "", &rb.new_wrapper()));
            assert_eq!(false, b.is_err(), "{:?}", b);
            assert_eq!(false, b.unwrap());

            let wrapper = rb.new_wrapper().eq(MMnemonic::id, "any");
            let b = block_on(MMnemonic::exist_by_wrapper(&rb, "", &wrapper));
            assert_eq!(false, b.is_err(), "{:?}", b);
            assert_eq!(false, b.unwrap());

            let wrapper = rb.new_wrapper().eq("1", 1);
            let b = block_on(MMnemonic::exist_by_wrapper(&rb, "", &wrapper));
            assert_eq!(false, b.is_err(), "{:?}", b);
            assert_eq!(false, b.unwrap());

            let wrapper = rb.new_wrapper().eq("1", 1).eq(MMnemonic::id, "any");
            let b = block_on(MMnemonic::exist_by_wrapper(&rb, "", &wrapper));
            assert_eq!(false, b.is_err(), "{:?}", b);
            assert_eq!(false, b.unwrap());
        }
        let mut m = MMnemonic::default();
        m.mnemonic = "test".to_owned();
        m.wallet_type = "eee".to_owned();
        m.mnemonic_digest = String::new();
        let re = block_on(m.save(&rb, ""));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let re = block_on(MMnemonic::fetch_by_id(&rb, "", &m.id));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let m2 = re.unwrap().unwrap();
        assert_eq!(m.id, m2.id);
        assert_eq!(m.update_time, m2.update_time);
        assert_eq!(m.create_time, m2.create_time);

        assert_eq!(m.mnemonic, m2.mnemonic);
        assert_eq!(m.wallet_type, m2.wallet_type);
        assert_eq!(m.mnemonic_digest, m2.mnemonic_digest);

        let mut m3 = MMnemonic::default();
        m3.mnemonic = "m3".to_owned();
        let re = block_on(m3.save(&rb, ""));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let re = block_on(MMnemonic::list(&rb, ""));
        assert_eq!(false, re.is_err(), "{:?}", re);
        let list = re.unwrap();
        assert_eq!(2, list.len());
        {//exist
            let b = block_on(MMnemonic::exist_by_wrapper(&rb, "", &rb.new_wrapper()));
            assert_eq!(false, b.is_err(), "{:?}", b);
            assert_eq!(true, b.unwrap());

            let wrapper = rb.new_wrapper().eq(MMnemonic::id, "any");
            let b = block_on(MMnemonic::exist_by_wrapper(&rb, "", &wrapper));
            assert_eq!(false, b.is_err(), "{:?}", b);
            assert_eq!(false, b.unwrap());

            let wrapper = rb.new_wrapper().eq("1", 1);
            let b = block_on(MMnemonic::exist_by_wrapper(&rb, "", &wrapper));
            assert_eq!(false, b.is_err(), "{:?}", b);
            assert_eq!(true, b.unwrap());

            let wrapper = rb.new_wrapper().eq("1", 1).eq(MMnemonic::id, "any");
            let b = block_on(MMnemonic::exist_by_wrapper(&rb, "", &wrapper));
            assert_eq!(false, b.is_err(), "{:?}", b);
            assert_eq!(false, b.unwrap());
        }
    }

    async fn init_memory() -> Rbatis {
        let rb = make_memory_rbatis_test().await;
        let r = Db::create_table(&rb, MMnemonic::create_table_script(), &MMnemonic::table_name(), &DbCreateType::Drop).await;
        assert_eq!(false, r.is_err(), "{:?}", r);
        rb
    }

    #[test]
    fn test_flatten() {
        #[db_append_shared]
        #[derive(PartialEq, Serialize, Deserialize, Clone, Debug, Default)]
        struct Big {
            #[serde(default)]
            pub name_: String,
            #[serde(flatten, default)]
            pub one: One,
        }

        #[derive(PartialEq, Serialize, Deserialize, Clone, Debug, Default)]
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
