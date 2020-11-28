-- EthChainToken
CREATE TABLE IF NOT EXISTS eth_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT DEFAULT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
