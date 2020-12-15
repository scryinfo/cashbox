-- MBtcInputTx
CREATE TABLE IF NOT EXISTS m_btc_input_tx
(
    btc_chain_tx_id TEXT    NOT NULL,
    tx_index        INTEGER NOT NULL,
    address         TEXT    NOT NULL,
    pk_script       TEXT    NOT NULL,
    sig_script      TEXT    NOT NULL,
    value           TEXT    NOT NULL,
    id              TEXT PRIMARY KEY,
    create_time     INTEGER NOT NULL,
    update_time     INTEGER NOT NULL
);
