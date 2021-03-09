-- MBtcTxState
CREATE TABLE IF NOT EXISTS m_btc_tx_state
(
    seq         INTEGER NOT NULL UNIQUE,
    state       TEXT    NOT NULL UNIQUE,
    id          TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
);