-- MAccountInfoSyncProg

CREATE TABLE IF NOT EXISTS m_account_info_sync_prog (
    id TEXT PRIMARY KEY,
    account TEXT NOT NULL,
    block_no TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
);
