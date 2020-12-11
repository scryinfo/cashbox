-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
