-- MBtcUtxo
CREATE TABLE IF NOT EXISTS m_btc_utxo (  
    fee INTEGER NOT NULL,
    state TEXT NOT NULL,
    btc_tx_hash TEXT NOT NULL,
    idx INTEGER NOT NULL,
    btc_tx_hexbytes TEXT NOT NULL,
    address TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
