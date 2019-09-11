use crate::wallet_db::db_helper::DataServiceProvider;
use crate::model::WalletObj;
use log::debug;
impl DataServiceProvider{

    pub fn display_eee_chain(&self) -> Result<Vec<WalletObj>, String> {
        let all_mn = "select a.wallet_id,a.fullname as wallet_name,b.id as chain_id,c.address,b.address as chain_address,a.selected,b.type as chian_type,d.id as digit_id,d.contract_address,d.short_name,d.full_name,d.balance,d.is_visible as digit_is_visible,d.decimals,d.url_img,c.is_visible as chain_is_visible
 from Wallet a,detail.Chain b,detail.Address c,detail.EeeDigit d where a.wallet_id=c.wallet_id and c.chain_id = b.id and c.address_id=d.address_id and a.status =1 and c.status =1;" ;

        let mut cursor = self.db_hander.prepare(all_mn).unwrap().cursor();
        let mut tbwallets = Vec::new();

        while let Some(row) = cursor.next().unwrap() {
           // println!("query wallet_id {:?},wallet_name:{:?}", row[0].as_string(), row[1].as_string());
            let tbwallet = WalletObj {
                wallet_id: row[0].as_string().map(|str| String::from(str)),
                wallet_name: row[1].as_string().map(|str| String::from(str)),
                chain_id: row[2].as_integer(),
                address: row[3].as_string().map(|str| String::from(str)),
                chain_address: row[4].as_string().map(|str| String::from(str)),
                selected: row[5].as_string().map(|value| Self::get_bool_value(value)),
                chain_type: row[6].as_integer(),
                digit_id: row[7].as_integer(),
                contract_address: row[8].as_string().map(|str| String::from(str)),
                short_name: row[9].as_string().map(|str| String::from(str)),
                full_name: row[10].as_string().map(|str| String::from(str)),
                balance: row[11].as_string().map(|str| String::from(str)),
                digit_is_visible: row[12].as_string().map(|value| Self::get_bool_value(value)),
                decimals: row[13].as_integer(),
                url_img: row[14].as_string().map(|str| String::from(str)),
                chain_is_visible: row[15].as_string().map(|value| Self::get_bool_value(value)),
            };
            tbwallets.push(tbwallet);
        }
        Ok(tbwallets)
    }

    pub fn display_eth_chain(&self) -> Result<Vec<WalletObj>, String> {
        let all_mn = " select a.wallet_id,a.fullname as wallet_name,b.id as chain_id,c.address,b.address as chain_address,a.selected,b.type as chian_type,d.id as digit_id,d.contract_address,d.short_name,d.full_name,d.balance,d.is_visible as digit_is_visible,d.decimals,d.url_img,c.is_visible as chain_is_visible
 from Wallet a,detail.Chain b,detail.Address c,detail.EthDigit d where a.wallet_id=c.wallet_id and c.chain_id = b.id and c.address_id=d.address_id and a.status =1 and c.status =1;";

        let mut cursor = self.db_hander.prepare(all_mn).unwrap().cursor();
        let mut tbwallets = Vec::new();
        while let Some(row) = cursor.next().unwrap() {
          //  println!("query wallet_id {:?},wallet_name:{:?}", row[0].as_string(), row[1].as_string());
            let tbwallet = WalletObj {
                wallet_id: row[0].as_string().map(|str| String::from(str)),
                wallet_name: row[1].as_string().map(|str| String::from(str)),
                chain_id: row[2].as_integer(),
                address: row[3].as_string().map(|str| String::from(str)),
                chain_address: row[4].as_string().map(|str| String::from(str)),
                selected: row[5].as_string().map(|value| Self::get_bool_value(value)),
                chain_type: row[6].as_integer(),
                digit_id: row[7].as_integer(),
                contract_address: row[8].as_string().map(|str| String::from(str)),
                short_name: row[9].as_string().map(|str| String::from(str)),
                full_name: row[10].as_string().map(|str| String::from(str)),
                balance: row[11].as_string().map(|str| String::from(str)),
                digit_is_visible: row[12].as_string().map(|value| Self::get_bool_value(value)),
                decimals: row[13].as_integer(),
                url_img: row[14].as_string().map(|str| String::from(str)),
                chain_is_visible: row[15].as_string().map(|value| Self::get_bool_value(value)),
            };
            tbwallets.push(tbwallet);
        }
        Ok(tbwallets)
    }

    pub fn display_btc_chain(&self) -> Result<Vec<WalletObj>, String> {
        let all_mn = "select a.wallet_id,a.fullname as wallet_name,b.id as chain_id,c.address,b.address as chain_address,a.selected,b.type as chian_type,d.id as digit_id,d.contract_address,d.short_name,d.full_name,d.balance,d.is_visible as digit_is_visible,d.decimals,d.url_img,c.is_visible as chain_is_visible
from Wallet a,detail.Chain b,detail.Address c,detail.BtcDigit d where a.wallet_id=c.wallet_id and c.chain_id = b.id and c.address_id=d.address_id and a.status =1 and c.status =1;";

        let mut cursor = self.db_hander.prepare(all_mn).unwrap().cursor();
        let mut tbwallets = Vec::new();
        debug!("get wallet item is:{}", tbwallets.len());
        while let Some(row) = cursor.next().unwrap() {
          //  println!("query wallet_id {:?},wallet_name:{:?}", row[0].as_string(), row[1].as_string());
            let tbwallet = WalletObj {
                wallet_id: row[0].as_string().map(|str| String::from(str)),
                wallet_name: row[1].as_string().map(|str| String::from(str)),
                chain_id: row[2].as_integer(),
                address: row[3].as_string().map(|str| String::from(str)),
                chain_address: row[4].as_string().map(|str| String::from(str)),
                selected: row[5].as_string().map(|value| Self::get_bool_value(value)),
                chain_type: row[6].as_integer(),
                digit_id: row[7].as_integer(),
                contract_address: row[8].as_string().map(|str| String::from(str)),
                short_name: row[9].as_string().map(|str| String::from(str)),
                full_name: row[10].as_string().map(|str| String::from(str)),
                balance: row[11].as_string().map(|str| String::from(str)),
                digit_is_visible:row[12].as_string().map(|value| Self::get_bool_value(value)),
                decimals: row[13].as_integer(),
                url_img: row[14].as_string().map(|str| String::from(str)),
                chain_is_visible: row[15].as_string().map(|value| Self::get_bool_value(value)),
            };
            tbwallets.push(tbwallet);
        }
        Ok(tbwallets)
    }

    pub fn show_chain(&mut self, walletid: &str, wallet_type: i64) -> Result<(), String> {
        let sql = "UPDATE Address set is_visible = 1 WHERE wallet_id=? and chain_id=?;";
        match self.db_hander.prepare(sql) {
            Ok(mut stat) => {
                let bind_wallet_id = stat.bind(1, walletid).map_err(|e| format!("show_chain bind walletid,{}", e.to_string()));
                if bind_wallet_id.is_err() {
                    return Err(bind_wallet_id.unwrap_err());
                }

                let bind_wallet_type = stat.bind(2, wallet_type).map_err(|e| format!("show_chain bind wallet_type,{}", e.to_string()));
                if bind_wallet_type.is_err() {
                    return Err(bind_wallet_type.unwrap_err());
                }
                let exec = stat.next().map_err(|e| format!("exec show_chain,{}", e.to_string()));
                if exec.is_err() {
                    return Err(exec.unwrap_err());
                }
                Ok(())
            }
            Err(e) => Err(e.to_string())
        }
    }

    pub fn hide_chain(&mut self, walletid: &str, wallet_type: i64) -> Result<(), String> {
        let sql = "UPDATE Address set is_visible = 0 WHERE wallet_id=? and chain_id=?;";
        match self.db_hander.prepare(sql) {
            Ok(mut stat) => {
                let bind_wallet_id = stat.bind(1, walletid).map_err(|e| format!("hide_chain bind walletid,{}", e.to_string()));
                if bind_wallet_id.is_err() {
                    return Err(bind_wallet_id.unwrap_err());
                }

                let bind_wallet_type = stat.bind(2, wallet_type).map_err(|e| format!("hide_chain bind wallet_type,{}", e.to_string()));
                if bind_wallet_type.is_err() {
                    return Err(bind_wallet_type.unwrap_err());
                }
                let exec = stat.next().map_err(|e| format!("exec hide_chain,{}", e.to_string()));
                if exec.is_err() {
                    return Err(exec.unwrap_err());
                }
                Ok(())
            }
            Err(e) => Err(e.to_string())
        }
    }
}
