-- MEthChainTokenNonAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_non_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    status INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
