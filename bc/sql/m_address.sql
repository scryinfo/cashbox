-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    is_wallet_address INTEGER NOT NULL,
    show INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
