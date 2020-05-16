#[derive(Default, Deserialize)]
pub struct TbWallet {
    pub  wallet_id: String,
    pub mn_digest:String,
    pub full_name: Option<String>,
    pub mnemonic: String,
    pub wallet_type:i64,
    pub selected: Option<bool>,
    pub status: i64,
    pub display_chain_id:i64,
    pub create_time: String,
    pub update_time: Option<String>,
}

#[derive(Default)]
pub struct TbAddress {
    pub  address_id: String,
    pub  wallet_id: String,
    pub  chain_id: i16,
    pub  address: String,
    pub  pub_key: String,
    pub  status: i8,
    pub  is_visible:bool,
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
pub struct WalletObj {
    pub wallet_id: Option<String>,
    //助记词id
    pub wallet_name: Option<String>,
    pub selected: Option<bool>,
    pub chain_id: Option<i64>,
    pub address: Option<String>,
    pub digit_id: Option<String>,
    pub chain_type: Option<i64>,
    pub domain: Option<String>,
    pub contract_address: Option<String>,
    pub short_name: Option<String>,
    pub full_name: Option<String>,
    pub balance: Option<String>,
    pub digit_is_visible: Option<bool>,
    pub decimals: Option<i64>,
    pub url_img: Option<String>,
    pub chain_is_visible:Option<bool>,
}
