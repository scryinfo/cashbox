-- MTxOutput
CREATE TABLE IF NOT EXISTS m_tx_output (  
    tx TEXT NOT NULL,
    script TEXT NOT NULL,
    value TEXT NOT NULL,
    vin TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );