//导入/创建钱包时生成
//修改密码时修改
//删除钱包时软件删除
//功能是作为备份使用，如果Wallet表中的数据无法读取时，才起用此表
#[derive(Default, Clone, Deserialize)]
pub struct Mnemonic {
    //primary key
    pub wallet_id: String,
    pub mnemonic_digest: String,
    pub mnemonic: String,
    pub wallet_type: String,
    pub create_time: i64,
    pub update_time: i64,
}