-- MBlockHeader
CREATE TABLE IF NOT EXISTS m_block_header (  
    header TEXT NOT NULL,
    scanned TEXT NOT NULL,
    timestamp TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
