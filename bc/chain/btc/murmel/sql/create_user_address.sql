CREATE TABLE IF NOT EXISTS user_address
(
    id                 INTEGER PRIMARY KEY AUTOINCREMENT,
    address            TEXT NOT NULL,
    compressed_pub_key TEXT
)