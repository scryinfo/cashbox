-- EthErc20Tx
CREATE TABLE IF NOT EXISTS eth_erc20_tx (  
    eth_chain_tx_id TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    token TEXT NOT NULL,
    erc20_face TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
