-- MSetting
CREATE TABLE IF NOT EXISTS m_setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
