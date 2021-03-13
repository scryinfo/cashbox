-- MEthChainToken
CREATE TABLE IF NOT EXISTS m_eth_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
