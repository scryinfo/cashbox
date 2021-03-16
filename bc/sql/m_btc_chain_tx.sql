-- MBtcChainTx
CREATE TABLE IF NOT EXISTS m_btc_chain_tx (  
    -- TxShared start
    tx_hash TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    block_number TEXT NOT NULL,
    signer TEXT NOT NULL,
    tx_bytes TEXT NOT NULL,
    tx_timestamp INTEGER NOT NULL,
    -- TxShared end

    wallet_account TEXT NOT NULL,
    total_input TEXT NOT NULL,
    total_output TEXT NOT NULL,
    fees TEXT NOT NULL,
    op_return TEXT DEFAULT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
