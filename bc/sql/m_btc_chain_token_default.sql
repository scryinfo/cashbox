-- MBtcChainTokenDefault
CREATE TABLE IF NOT EXISTS m_btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    status INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
