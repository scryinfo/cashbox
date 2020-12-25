-- MSubChainBasicInfo
CREATE TABLE IF NOT EXISTS m_sub_chain_basic_info
(
    genesis_hash       TEXT    NOT NULL,
    metadata           TEXT    NOT NULL,
    runtime_version    INTEGER NOT NULL,
    tx_version         INTEGER NOT NULL,
    ss58_format_prefix INTEGER NOT NULL,
    token_decimals     INTEGER NOT NULL,
    token_symbol       TEXT    NOT NULL,
    is_default         BOOLEAN NOT NULL,
    status             INTEGER NOT NULL,
    id                 TEXT PRIMARY KEY,
    create_time        INTEGER NOT NULL,
    update_time        INTEGER NOT NULL
);
