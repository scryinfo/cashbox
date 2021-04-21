-- MUserAddress
CREATE TABLE IF NOT EXISTS m_user_address (
    key TEXT NOT NULL,
    address TEXT NOT NULL,
    compressed_pub_key TEXT NOT NULL,
    verify TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
