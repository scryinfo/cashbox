-- MTxInput
CREATE TABLE IF NOT EXISTS m_tx_input (  
    tx TEXT NOT NULL,
    sig_script TEXT NOT NULL,
    prev_tx TEXT NOT NULL,
    prev_vout TEXT NOT NULL,
    sequence INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );