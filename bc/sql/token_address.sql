-- TokenAddress
CREATE TABLE IF NOT EXISTS token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
