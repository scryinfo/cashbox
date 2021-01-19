-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    contract_address TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
