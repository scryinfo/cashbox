CREATE TABLE IF NOT EXISTS m_btc_output_tx
(
    btc_chain_tx_foreign TEXT    NOT NULL,
    value                INTEGER NOT NULL,
    pk_script            TEXT    NOT NULL,
    idx                  INTEGER NOT NULL,
    btc_tx_hash          TEXT    NOT NULL,
    btc_tx_hexbytes      TEXT    NOT NULL,
    id                   TEXT PRIMARY KEY,
    create_time          INTEGER NOT NULL,
    update_time          INTEGER NOT NULL
);