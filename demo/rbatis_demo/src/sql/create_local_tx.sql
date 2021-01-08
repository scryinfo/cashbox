CREATE TABLE IF NOT EXISTS local_tx
(
    id           INTEGER PRIMARY KEY AUTOINCREMENT,
    address_from TEXT not null,
    address_to   TEXT,
    value        TEXT,
    status       TEXT
)