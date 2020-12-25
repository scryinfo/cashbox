-- MAccountInfoSyncProg
CREATE TABLE IF NOT EXISTS m_account_info_sync_prog
(
    account     TEXT    NOT NULL,
    block_no    TEXT    NOT NULL,
    block_hash  TEXT    NOT NULL,
    id          TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
);
