-- MBtcOutputTx
CREATE TABLE IF NOT EXISTS m_btc_output_tx
(
    btc_chain_tx_foreign TEXT    NOT NULL,
    value                TEXT    NOT NULL,
    pk_script            TEXT    NOT NULL,
    id                   TEXT PRIMARY KEY,
    create_time          INTEGER NOT NULL,
    update_time          INTEGER NOT NULL
);