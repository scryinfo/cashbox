-- BtcChainToken
CREATE TABLE IF NOT EXISTS btc_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT DEFAULT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
