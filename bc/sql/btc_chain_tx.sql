-- BtcChainTx
CREATE TABLE IF NOT EXISTS btc_chain_tx (  
    -- TxShared start
    tx_hash TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    block_number TEXT NOT NULL,
    tx_bytes TEXT NOT NULL,
    -- TxShared end

    total_input TEXT NOT NULL,
    total_output TEXT NOT NULL,
    fees TEXT NOT NULL,
    op_return TEXT DEFAULT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
