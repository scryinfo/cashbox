
use rbatis::crud::{CRUD, CRUDEnable};
use rbatis::rbatis::Rbatis;
use serde::Deserialize;
use serde::Serialize;

use wallets_macro::db_append_shared;
use crate::ma::DbBase;
use crate::kits;

//导入/创建钱包时生成
//修改密码时修改
//删除钱包时软件删除
//功能是作为备份使用，如果Wallet表中的数据无法读取时，才起用此表 ,CRUDEnable
#[db_append_shared]
#[derive(Serialize, Deserialize, Clone, Debug, Default,CRUDEnable)]
pub struct Mnemonic {
    pub mnemonic_digest: String,
    pub mnemonic: String,
    pub wallet_type: String,
}

#[cfg(test)]
mod tests {
    use rbatis::crud::{CRUDEnable};

    use crate::ma::Mnemonic;

    #[test]
    fn test_mnemonic() {
        let colx = Mnemonic::table_columns();
        let mut m = Mnemonic::default();
    }
}
