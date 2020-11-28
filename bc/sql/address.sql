-- Address
CREATE TABLE IF NOT EXISTS address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
