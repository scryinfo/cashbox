-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    show INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
