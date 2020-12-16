CREATE TABLE IF NOT EXISTS tx_output
(
    id     INTEGER PRIMARY KEY AUTOINCREMENT,
    tx     TEXT NOT NULL,
    script TEXT,
    value  TEXT,
    vin    TEXT
)