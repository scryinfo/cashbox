-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    fee_per_byte INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );