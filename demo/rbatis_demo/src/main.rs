#[macro_use]
extern crate rbatis;

use std::ops::Add;

use async_std::task::block_on;
use rbatis::RBatis;
use rbatis::sql::page::{IPage, Page, PageRequest};
use serde::{Deserialize, Serialize};
use serde_json::json;

// #[crud_enable(table_name: block_header)]
#[derive(Serialize, Deserialize, Clone, Debug)]
pub struct MBlockHeader {
    pub id: Option<u64>,
    pub header: String,
    pub scanned: String,
    pub timestamp: String,
}
crud!(MBlockHeader{});
impl_select_page!(MBlockHeader{select_page_by_t(timestamp:&str) =>"`where timestamp > #{timestamp}`"});
impl_select!(MBlockHeader{selec_sql() -> Option => "`order by id DESC limit 1`"});

// #[crud_enable(table_name: progress)]
#[derive(Serialize, Deserialize, Clone, Debug)]
pub struct MProgress {
    pub id: Option<u64>,
    pub header: String,
    pub timestamp: String,
}
crud!(MProgress{});
impl_select!(MProgress{selec_by_id(id:&u64) ->Option => "`where id = #{id} limit 1`"});


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
    rb: RBatis,
    url: String,
}

async fn init_rbatis(db_file_name: &str) -> RBatis {
    print!("init_rbatis");
    if std::fs::metadata(db_file_name).is_err() {
        let file = std::fs::File::create(db_file_name);
        if file.is_err() {
            print!("init file {:?}", file.err().unwrap());
        }
    }
    let rb = RBatis::new();
    let url = "sqlite://".to_owned().add(db_file_name);
    print!("file url: {:?}", url);
    let r = rb.link(rbdc_sqlite::driver::SqliteDriver {}, url.as_str()).await;
    if r.is_err() {
        print!("{:?}", r.err().unwrap());
    }
    rb
}

impl ChainSqlite {
    pub fn init_chain_db(db_file_name: &str) -> Self {
        let sql = include_str!("sql/create_chain.sql");
        let rb = block_on(init_rbatis(db_file_name));
        // "create chain db"
        let r = block_on(rb.exec(sql, vec![]));
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

    pub fn save_chain(&mut self) {
        let block_header = MBlockHeader {
            id: None,
            header: "dadasdasdqwvfev".to_string(),
            scanned: "0".to_string(),
            timestamp: "11".to_string(),
        };

        let r = block_on(MBlockHeader::insert(&mut self.rb, &block_header));
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
    pub fn fetch_scan_header(&mut self, timestamp: String, scan_flag: bool) -> Vec<String> {
        let req = PageRequest::new(1, 1000);
        let r: Result<Page<MBlockHeader>, _> = block_on(MBlockHeader::select_page_by_t(&mut self.rb, &req, &timestamp));
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
            let r = block_on(self.rb.exec(&sql, vec![]));
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
    pub fn fetch_height(&mut self) -> u64 {
        let py = r#"
        SELECT * FROM block_header
        Order By id DESC
        LIMIT 1;
        "#;
        let r: Result<Option<MBlockHeader>, _> = block_on(MBlockHeader::selec_sql(&mut self.rb));
        if let Ok(Some(r)) = r {
            match r.id {
                Some(id) => id,
                _ => 0
            }
        } else { return 0; }
    }
}


pub struct DetailSqlite {
    rb: RBatis,
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

    fn create_user_address(rb: &RBatis) {
        let sql = create_user_address_sql();
        let r = block_on(rb.exec(sql, vec![]));
        match r {
            Ok(a) => {
                println!("{:?}", a);
            }
            Err(e) => {
                println!("{:?}", e);
            }
        }
    }

    fn create_tx_input(rb: &RBatis) {
        let sql = include_str!("sql/create_tx_input.sql");
        let r = block_on(rb.exec(sql, vec![]));
        match r {
            Ok(a) => {
                println!("{:?}", a);
            }
            Err(e) => {
                println!("{:?}", e);
            }
        }
    }

    fn create_tx_output(rb: &RBatis) {
        let sql = create_tx_output_sql();
        let r = block_on(rb.exec(sql, vec![]));
        match r {
            Ok(a) => {
                println!("{:?}", a);
            }
            Err(e) => {
                println!("{:?}", e);
            }
        }
    }

    fn create_progress(rb: &RBatis) {
        let sql = include_str!("sql/create_progress.sql");
        let r = block_on(rb.exec(sql, vec![]));
        match r {
            Ok(a) => {
                println!("{:?}", a);
            }
            Err(e) => {
                println!("{:?}", e);
            }
        }
    }

    fn create_local_tx(rb: &RBatis) {
        let sql = create_local_tx_sql();
        let r = block_on(rb.exec(sql, vec![]));
        match r {
            Ok(a) => {
                println!("{:?}", a);
            }
            Err(e) => {
                println!("{:?}", e);
            }
        }
    }

    fn save_progress(&mut self, header: String, timestamp: String) {
        let progress = MProgress {
            id: None,
            header,
            timestamp,
        };
        let r = block_on(MProgress::insert(&mut self.rb, &progress));
        match r {
            Ok(a) => {
                println!("save_progress {:?}", a);
            }
            Err(e) => {
                println!("save_progress {:?}", e);
            }
        }
    }

    fn fetch_progress(&mut self) -> Option<MProgress> {
        let r: Result<Option<MProgress>, _> = block_on(MProgress::selec_by_id(&mut self.rb, &1u64));
        match r {
            Ok(p) => p,
            Err(_) => None
        }
    }

    pub fn update_progress(&mut self, header: String, timestamp: String) {
        let progress = MProgress {
            id: None,
            header,
            timestamp,
        };
        let r = block_on(MProgress::update_by_column(&mut self.rb, &progress, "id"));
        match r {
            Ok(a) => {
                println!("update_progress {:?}", a);
            }
            Err(e) => {
                println!("update_progress {:?}", e);
            }
        }
    }

    pub fn progress(&mut self) -> MProgress {
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

    //let height = btc_chain.fetch_height();
    //print!("{}", height);
}
