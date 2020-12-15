-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta
(
    chain_type  TEXT    NOT NULL,
    short_name  TEXT    NOT NULL,
    full_name   TEXT    NOT NULL,
    id          TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
);
