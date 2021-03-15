-- MBtcUtxo
CREATE TABLE IF NOT EXISTS m_btc_utxo (  
    fee INTEGER DEFAULT NULL,
    state TEXT NOT NULL FOREIGN KEY REFERENCES m_btc_tx_state(state),
    btc_tx_hash TEXT NOT NULL,
    idx INTEGER NOT NULL,
    btc_tx_hexbytes TEXT NOT NULL,
    output_value TEXT NOT NULL,
    spent_value INTEGER DEFAULT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );