CREATE TABLE IF NOT EXISTS m_btc_input_tx
(
    btc_chain_tx_foreign TEXT    NOT NULL,
    tx_id                TEXT    NOT NULL,
    vout                 INTEGER NOT NULL,
    sig_script           TEXT    NOT NULL,
    sequence             INTEGER NOT NULL,
    idx                  INTEGER NOT NULL,
    btc_tx_hash          TEXT    NOT NULL,
    btc_tx_hexbytes      TEXT    NOT NULL,
    id                   TEXT PRIMARY KEY,
    create_time          INTEGER NOT NULL,
    update_time          INTEGER NOT NULL
);