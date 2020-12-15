use rbatis_macro_driver::crud_enable;
use serde::{Serialize, Deserialize};
use rbatis::rbatis::Rbatis;
use std::ops::Add;
use async_std::task::block_on;
use rbatis::crud::CRUD;
use rbatis::plugin::page::{PageRequest, Page, IPage};
use serde_json::json;

#[crud_enable(table_name: block_header)]
#[derive(Serialize, Deserialize, Clone, Debug)]
pub struct MBlockHeader {
    pub id: Option<u64>,
    pub header: String,
    pub scanned: String,
    pub timestamp: String,
}

#[crud_enable(table_name: progress)]
#[derive(Serialize, Deserialize, Clone, Debug)]
pub struct MProgress {
    pub id: Option<u64>,
    pub header: String,
    pub timestamp: String,
}

pub fn create_chain_sql() -> &'static str {
    "CREATE TABLE IF NOT EXISTS block_header(id INTEGER PRIMARY KEY AUTOINCREMENT,header TEXT,scanned TEXT,timestamp TEXT);"
}

pub fn create_progress_sql() -> &'static str {
    "CREATE TABLE IF NOT EXISTS progress(id INTEGER PRIMARY KEY AUTOINCREMENT,key TEXT,header TEXT,timestamp TEXT);"
}

pub fn create_user_address_sql() -> &'static str {
    "CREATE TABLE IF NOT EXISTS user_address(id INTEGER PRIMARY KEY AUTOINCREMENT,address TEXT NOT NULL,compressed_pub_key TEXT);"
}

pub fn create_tx_input_sql() -> &'static str {
    "CREATE TABLE IF NOT EXISTS tx_input(id INTEGER PRIMARY KEY AUTOINCREMENT,tx TEXT NOT NULL,sig_script TEXT, prev_tx TEXT, prev_vout TEXT, sequence INTEGER);"
}

pub fn create_tx_output_sql() -> &'static str {
    "CREATE TABLE IF NOT EXISTS tx_output(id INTEGER PRIMARY KEY AUTOINCREMENT,tx TEXT not null ,script TEXT, value TEXT, vin TEXT);"
}

pub fn create_local_tx_sql() -> &'static str {
    "CREATE TABLE IF NOT EXISTS local_tx(id INTEGER PRIMARY KEY AUTOINCREMENT,address_from TEXT not null ,address_to TEXT,value TEXT,status TEXT);"
}

pub struct ChainSqlite {
    rb: Rbatis,
    url: String,
}

async fn init_rbatis(db_file_name: &str) -> Rbatis {
    print!("init_rbatis");
    if std::fs::metadata(db_file_name).is_err() {
        let file = std::fs::File::create(db_file_name);
        if file.is_err() {
            print!("init file {:?}", file.err().unwrap());
        }
    }
    let rb = Rbatis::new();
    let url = "sqlite://".to_owned().add(db_file_name);
    print!("file url: {:?}", url);
    let r = rb.link(url.as_str()).await;
    if r.is_err() {
        print!("{:?}", r.err().unwrap());
    }
    rb
}

impl ChainSqlite {
    pub fn init_chain_db(db_file_name: &str) -> Self {
        let sql = create_chain_sql();
        let rb = block_on(init_rbatis(db_file_name));
        let r = block_on(rb.exec("create chain db", sql));
        match r {
            Ok(a) => {
                println!("create {:?}", a);
            }
            Err(e) => {
                println!("create {:?}", e);
            }
        }
        let url = "sqlite://".to_owned().add(db_file_name);
        Self {
            rb,
            url: url.to_string(),
        }
    }

    pub fn save_chain(&self) {
        let block_header = MBlockHeader {
            id: None,
            header: "dadasdasdqwvfev".to_string(),
            scanned: "0".to_string(),
            timestamp: "11".to_string(),
        };

        let r = block_on(self.rb.save("", &block_header));
        match r {
            Ok(a) => {
                println!("save {:?}", a);
            }
            Err(e) => {
                println!("save {:?}", e);
            }
        }

        // let sql = "select count(*) from block_header";
        // let r = block_on(self.rb.exec("", sql));
        // match r {
        //     Ok(a) => {
        //         println!("{:?}",a);
        //     }
        //     Err(e) => {
        //         println!("{:?}",e);
        //     }
        // }
    }

    /// fetch header which needed scan
    /// scan_flag = false scan_flag does not need +1
    /// scan_flag = true scan_flag need +1
    pub fn fetch_scan_header(&self, timestamp: String, scan_flag: bool) -> Vec<String> {
        let w = self.rb.new_wrapper()
                    .gt("timestamp", &timestamp)
                    .and()
                    .lt("scanned", 6)
                    .check().unwrap();
        let req = PageRequest::new(1, 1000);
        let r: Result<Page<MBlockHeader>, _> = block_on(self.rb.fetch_page_by_wrapper("", &w, &req));
        let mut block_headers: Vec<MBlockHeader> = vec![];
        match r {
            Ok(page) => {
                let header_vec = page.get_records();
                block_headers = header_vec.to_vec();
            }
            Err(e) => println!("{:?}", e)
        }
        let mut headers: Vec<String> = vec![];
        for header_block in block_headers {
            headers.push(header_block.header);
        }

        if scan_flag {
            let sql = format!(r#"
            UPDATE block_header SET scanned = scanned+1
                WHERE id IN (
                    SELECT id FROM (
                        SELECT id FROM block_header
                        WHERE timestamp >= {}
                        AND scanned <= 5
                        ORDER BY id ASC
                        LIMIT 0, 1000
                    ) tmp
                )
            "#, timestamp);
            let r = block_on(self.rb.exec("", &sql));
            match r {
                Ok(a) => {
                    println!("{:?}", a);
                }
                Err(e) => {
                    println!("{:?}", e);
                }
            }
        }

        headers
    }

    // how may headers save in block_header table
    pub fn fetch_height(&self) -> u64 {
        let py = r#"
        SELECT * FROM block_header
        Order By id DESC
        LIMIT 1;
        "#;
        let r: Result<MBlockHeader, _> = block_on(self.rb.py_fetch("", py, &""));
        if let Ok(r) = r {
            match r.id {
                Some(id) => id,
                _ => 0
            }
        } else { return 0; }
    }
}


pub struct DetailSqlite {
    rb: Rbatis,
}

impl DetailSqlite {
    pub fn init_detail_db(db_file_name: &str) -> Self {
        let rb = block_on(init_rbatis(db_file_name));
        DetailSqlite::create_progress(&rb);
        DetailSqlite::create_user_address(&rb);
        DetailSqlite::create_tx_input(&rb);
        DetailSqlite::create_tx_output(&rb);
        DetailSqlite::create_local_tx(&rb);
        Self {
            rb,
        }
    }

    fn create_user_address(rb: &Rbatis) {
        let sql = create_user_address_sql();
        let r = block_on(rb.exec("create chain db", sql));
        match r {
            Ok(a) => {
                println!("{:?}", a);
            }
            Err(e) => {
                println!("{:?}", e);
            }
        }
    }

    fn create_tx_input(rb: &Rbatis) {
        let sql = create_tx_input_sql();
        let r = block_on(rb.exec("create chain db", sql));
        match r {
            Ok(a) => {
                println!("{:?}", a);
            }
            Err(e) => {
                println!("{:?}", e);
            }
        }
    }

    fn create_tx_output(rb: &Rbatis) {
        let sql = create_tx_output_sql();
        let r = block_on(rb.exec("create chain db", sql));
        match r {
            Ok(a) => {
                println!("{:?}", a);
            }
            Err(e) => {
                println!("{:?}", e);
            }
        }
    }

    fn create_progress(rb: &Rbatis) {
        let sql = create_progress_sql();
        let r = block_on(rb.exec("create chain db", sql));
        match r {
            Ok(a) => {
                println!("{:?}", a);
            }
            Err(e) => {
                println!("{:?}", e);
            }
        }
    }

    fn create_local_tx(rb: &Rbatis) {
        let sql = create_local_tx_sql();
        let r = block_on(rb.exec("create chain db", sql));
        match r {
            Ok(a) => {
                println!("{:?}", a);
            }
            Err(e) => {
                println!("{:?}", e);
            }
        }
    }

    fn save_progress(&self, header: String, timestamp: String) {
        let progress = MProgress {
            id: None,
            header,
            timestamp,
        };
        let r = block_on(self.rb.save("", &progress));
        match r {
            Ok(a) => {
                println!("save_progress {:?}", a);
            }
            Err(e) => {
                println!("save_progress {:?}", e);
            }
        }
    }

    fn fetch_progress(&self) -> Option<MProgress> {
        let r: Result<Option<MProgress>, _> = block_on(self.rb.fetch_by_id("", &1u64));
        match r {
            Ok(p) => p,
            Err(_) => None
        }
    }

    pub fn update_progress(&self, header: String, timestamp: String) {
        let progress = MProgress {
            id: None,
            header,
            timestamp,
        };
        let w = self.rb.new_wrapper().eq("id", 1).check().unwrap();
        let r = block_on(self.rb.update_by_wrapper("", &progress, &w, false));
        match r {
            Ok(a) => {
                println!("update_progress {:?}", a);
            }
            Err(e) => {
                println!("update_progress {:?}", e);
            }
        }
    }

    pub fn progress(&self) -> MProgress {
        let progress = self.fetch_progress();
        match progress {
            None => {
                let header = "genesis".to_string();
                let timestamp = "000000".to_string();
                println!("scanned newest block from genesis {:?}", &header);
                self.save_progress(header.clone(), timestamp.clone());
                return MProgress {
                    id: None,
                    header,
                    timestamp,
                };
            }
            Some(progress) => {
                progress
            }
        }
    }
}

fn main() {
    let btc_chain = ChainSqlite::init_chain_db(r#"btc_chain.db"#);
    let btc_detail = DetailSqlite::init_detail_db(r#"btc_detail.db"#);
    // let p = btc_detail.progress();
    // println!("{:?}",p);

    // for _ in 0..2000{
    //     btc_chain.save_chain()
    // }
    // let r = btc_chain.fetch_scan_header("0".to_string(),false);
    // println!("{:?}",r);

    // let r = btc_chain.fetch_scan_header("10".to_string(), true);
    // println!("{:?}", r.len())

    let height = btc_chain.fetch_height();
    print!("{}", height);
}
