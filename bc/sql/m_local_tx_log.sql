-- MLocalTxLog
CREATE TABLE IF NOT EXISTS m_local_tx_log (  
    address_from TEXT NOT NULL,
    address_to TEXT NOT NULL,
    value TEXT NOT NULL,
    status TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
