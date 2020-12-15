CREATE TABLE IF NOT EXISTS tx_output
(
    id     INTEGER PRIMARY KEY AUTOINCREMENT,
    tx     TEXT not null,
    script TEXT,
    value  TEXT,
    vin    TEXT
);