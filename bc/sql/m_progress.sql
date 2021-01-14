-- MProgress
CREATE TABLE IF NOT EXISTS m_progress (  
    header TEXT NOT NULL,
    timestamp TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
