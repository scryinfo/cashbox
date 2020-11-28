-- BtcChainTokenShared
CREATE TABLE IF NOT EXISTS btc_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
