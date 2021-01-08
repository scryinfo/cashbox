CREATE TABLE IF NOT EXISTS tx_input
(
    id         INTEGER PRIMARY KEY AUTOINCREMENT,
    tx         TEXT NOT NULL,
    sig_script TEXT,
    prev_tx    TEXT,
    prev_vout  TEXT,
    sequence   INTEGER
)