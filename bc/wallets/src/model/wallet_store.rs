#[derive(Default, Deserialize)]
pub struct TbMnemonic {
    pub  id: Option<String>,
    pub full_name: Option<String>,
    pub mnemonic: Option<String>,
    pub selected: Option<bool>,
    pub status: Option<i64>,
    pub create_time: Option<String>,
    pub update_time: Option<String>,
}

#[derive(Default)]
pub struct TbAddress {
    pub  id: i32,
    pub  mnemonic_id: String,
    pub  chain_id: i16,
    pub  address: String,
    pub  pub_key: String,
    pub  status: i8,
    pub create_time: String,
    pub update_time: String,
}

#[derive(Default)]
struct TbChain {
    pub id: i32,
    pub chain_type: i16,
    pub  short_name: String,
    pub  full_name: String,
    pub  address: String,
    pub  group_name: String,
    pub  next_id: i32,
    pub  selected: bool,
    pub  more_property: bool,
    pub  create_time: String,
    pub  update_time: String,
}

#[derive(Serialize, Deserialize, Debug, PartialEq)]
pub struct TbWallet {
    pub wallet_id: Option<String>,
    //助记词id
    pub wallet_name: Option<String>,
    pub selected: Option<bool>,
    pub chain_id: Option<i64>,
    pub address: Option<String>,
    pub digit_id: Option<i64>,
    pub chain_type: Option<i64>,
    pub chain_address: Option<String>,
    pub contract_address: Option<String>,
    pub short_name: Option<String>,
    pub full_name: Option<String>,
    pub balance: Option<String>,
    pub isvisible: Option<bool>,
    pub decimals: Option<i64>,
    pub url_img: Option<String>,
}
