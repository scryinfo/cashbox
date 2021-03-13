-- MBtcTxState
CREATE TABLE IF NOT EXISTS m_btc_tx_state (  
    seq INTEGER NOT NULL,
    state TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
