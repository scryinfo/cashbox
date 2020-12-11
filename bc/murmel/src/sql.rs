pub fn create_chain_sql() -> &'static str {
    "CREATE TABLE IF NOT EXISTS block_header(id INTEGER PRIMARY KEY AUTOINCREMENT,header TEXT,scanned TEXT,timestamp TEXT);"
}

pub fn create_progress_sql() -> &'static str {
    "CREATE TABLE IF NOT EXISTS progress(id INTEGER PRIMARY KEY AUTOINCREMENT,header TEXT,timestamp TEXT);"
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