-- Mnemonic
CREATE TABLE IF NOT EXISTS mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
