-- MEthChainTx
CREATE TABLE IF NOT EXISTS m_eth_chain_tx (  
    -- TxShared start
    tx_hash TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    block_number TEXT NOT NULL,
    signer TEXT NOT NULL,
    tx_bytes TEXT NOT NULL,
    tx_timestamp INTEGER NOT NULL,
    -- TxShared end

    wallet_account TEXT NOT NULL,
    status TEXT NOT NULL,
    tx INTEGER NOT NULL,
    from_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    value TEXT NOT NULL,
    fee TEXT NOT NULL,
    gas_price TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    nonce TEXT NOT NULL,
    input_data TEXT NOT NULL,
    extension TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
