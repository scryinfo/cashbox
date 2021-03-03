-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    contract_address TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_price TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    contract_address TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    contract_address TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_price TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    contract_address TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_price TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    contract_address TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_price TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    contract_address TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_price TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    contract_address TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_price TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    contract_address TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_price TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    contract_address TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenAuth
CREATE TABLE IF NOT EXISTS m_btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_price TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    contract_address TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_price TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    contract_address TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenAuth
CREATE TABLE IF NOT EXISTS m_btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenDefault
CREATE TABLE IF NOT EXISTS m_btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_price TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    contract_address TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenAuth
CREATE TABLE IF NOT EXISTS m_btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenDefault
CREATE TABLE IF NOT EXISTS m_btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_price TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    contract_address TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MUserAddress
CREATE TABLE IF NOT EXISTS m_user_address (  
    address TEXT NOT NULL,
    compressed_pub_key TEXT NOT NULL,
    verify TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenAuth
CREATE TABLE IF NOT EXISTS m_btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_price TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    contract_address TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenAuth
CREATE TABLE IF NOT EXISTS m_btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenDefault
CREATE TABLE IF NOT EXISTS m_btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_price TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    contract_address TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenAuth
CREATE TABLE IF NOT EXISTS m_btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenDefault
CREATE TABLE IF NOT EXISTS m_btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_price TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    contract_address TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MProgress
CREATE TABLE IF NOT EXISTS m_progress (  
    header TEXT NOT NULL,
    timestamp TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MUserAddress
CREATE TABLE IF NOT EXISTS m_user_address (  
    address TEXT NOT NULL,
    compressed_pub_key TEXT NOT NULL,
    verify TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenAuth
CREATE TABLE IF NOT EXISTS m_btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenDefault
CREATE TABLE IF NOT EXISTS m_btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_price TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    contract_address TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MLocalTxLog
CREATE TABLE IF NOT EXISTS m_local_tx_log (  
    address_from TEXT NOT NULL,
    address_to TEXT NOT NULL,
    value TEXT NOT NULL,
    status TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MProgress
CREATE TABLE IF NOT EXISTS m_progress (  
    header TEXT NOT NULL,
    timestamp TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MUserAddress
CREATE TABLE IF NOT EXISTS m_user_address (  
    address TEXT NOT NULL,
    compressed_pub_key TEXT NOT NULL,
    verify TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenAuth
CREATE TABLE IF NOT EXISTS m_btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenDefault
CREATE TABLE IF NOT EXISTS m_btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_price TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    contract_address TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MUserAddress
CREATE TABLE IF NOT EXISTS m_user_address (  
    address TEXT NOT NULL,
    compressed_pub_key TEXT NOT NULL,
    verify TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenAuth
CREATE TABLE IF NOT EXISTS m_btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenDefault
CREATE TABLE IF NOT EXISTS m_btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_price TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    contract_address TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MLocalTxLog
CREATE TABLE IF NOT EXISTS m_local_tx_log (  
    address_from TEXT NOT NULL,
    address_to TEXT NOT NULL,
    value TEXT NOT NULL,
    status TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MProgress
CREATE TABLE IF NOT EXISTS m_progress (  
    header TEXT NOT NULL,
    timestamp TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MTokenAddress
CREATE TABLE IF NOT EXISTS m_token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    status INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MUserAddress
CREATE TABLE IF NOT EXISTS m_user_address (  
    address TEXT NOT NULL,
    compressed_pub_key TEXT NOT NULL,
    verify TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenAuth
CREATE TABLE IF NOT EXISTS m_btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenDefault
CREATE TABLE IF NOT EXISTS m_btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_price TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    contract_address TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MProgress
CREATE TABLE IF NOT EXISTS m_progress (  
    header TEXT NOT NULL,
    timestamp TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MUserAddress
CREATE TABLE IF NOT EXISTS m_user_address (  
    address TEXT NOT NULL,
    compressed_pub_key TEXT NOT NULL,
    verify TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenAuth
CREATE TABLE IF NOT EXISTS m_btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenDefault
CREATE TABLE IF NOT EXISTS m_btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_price TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    contract_address TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MLocalTxLog
CREATE TABLE IF NOT EXISTS m_local_tx_log (  
    address_from TEXT NOT NULL,
    address_to TEXT NOT NULL,
    value TEXT NOT NULL,
    status TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MProgress
CREATE TABLE IF NOT EXISTS m_progress (  
    header TEXT NOT NULL,
    timestamp TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MTokenAddress
CREATE TABLE IF NOT EXISTS m_token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    status INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MUserAddress
CREATE TABLE IF NOT EXISTS m_user_address (  
    address TEXT NOT NULL,
    compressed_pub_key TEXT NOT NULL,
    verify TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenAuth
CREATE TABLE IF NOT EXISTS m_btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenDefault
CREATE TABLE IF NOT EXISTS m_btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_price TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    contract_address TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MLocalTxLog
CREATE TABLE IF NOT EXISTS m_local_tx_log (  
    address_from TEXT NOT NULL,
    address_to TEXT NOT NULL,
    value TEXT NOT NULL,
    status TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MProgress
CREATE TABLE IF NOT EXISTS m_progress (  
    header TEXT NOT NULL,
    timestamp TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MUserAddress
CREATE TABLE IF NOT EXISTS m_user_address (  
    address TEXT NOT NULL,
    compressed_pub_key TEXT NOT NULL,
    verify TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenAuth
CREATE TABLE IF NOT EXISTS m_btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenDefault
CREATE TABLE IF NOT EXISTS m_btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_price TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainToken
CREATE TABLE IF NOT EXISTS m_eth_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    contract_address TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MLocalTxLog
CREATE TABLE IF NOT EXISTS m_local_tx_log (  
    address_from TEXT NOT NULL,
    address_to TEXT NOT NULL,
    value TEXT NOT NULL,
    status TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MProgress
CREATE TABLE IF NOT EXISTS m_progress (  
    header TEXT NOT NULL,
    timestamp TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MTokenAddress
CREATE TABLE IF NOT EXISTS m_token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    status INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MUserAddress
CREATE TABLE IF NOT EXISTS m_user_address (  
    address TEXT NOT NULL,
    compressed_pub_key TEXT NOT NULL,
    verify TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenAuth
CREATE TABLE IF NOT EXISTS m_btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenDefault
CREATE TABLE IF NOT EXISTS m_btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_price TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    contract_address TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MLocalTxLog
CREATE TABLE IF NOT EXISTS m_local_tx_log (  
    address_from TEXT NOT NULL,
    address_to TEXT NOT NULL,
    value TEXT NOT NULL,
    status TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MProgress
CREATE TABLE IF NOT EXISTS m_progress (  
    header TEXT NOT NULL,
    timestamp TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MTokenAddress
CREATE TABLE IF NOT EXISTS m_token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    status INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MUserAddress
CREATE TABLE IF NOT EXISTS m_user_address (  
    address TEXT NOT NULL,
    compressed_pub_key TEXT NOT NULL,
    verify TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenAuth
CREATE TABLE IF NOT EXISTS m_btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenDefault
CREATE TABLE IF NOT EXISTS m_btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_price TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    contract_address TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MLocalTxLog
CREATE TABLE IF NOT EXISTS m_local_tx_log (  
    address_from TEXT NOT NULL,
    address_to TEXT NOT NULL,
    value TEXT NOT NULL,
    status TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MProgress
CREATE TABLE IF NOT EXISTS m_progress (  
    header TEXT NOT NULL,
    timestamp TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MTokenAddress
CREATE TABLE IF NOT EXISTS m_token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    status INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MUserAddress
CREATE TABLE IF NOT EXISTS m_user_address (  
    address TEXT NOT NULL,
    compressed_pub_key TEXT NOT NULL,
    verify TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenAuth
CREATE TABLE IF NOT EXISTS m_btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenDefault
CREATE TABLE IF NOT EXISTS m_btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_price TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainToken
CREATE TABLE IF NOT EXISTS m_eth_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    contract_address TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
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
-- MLocalTxLog
CREATE TABLE IF NOT EXISTS m_local_tx_log (  
    address_from TEXT NOT NULL,
    address_to TEXT NOT NULL,
    value TEXT NOT NULL,
    status TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MProgress
CREATE TABLE IF NOT EXISTS m_progress (  
    header TEXT NOT NULL,
    timestamp TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MTokenAddress
CREATE TABLE IF NOT EXISTS m_token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    status INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MUserAddress
CREATE TABLE IF NOT EXISTS m_user_address (  
    address TEXT NOT NULL,
    compressed_pub_key TEXT NOT NULL,
    verify TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenAuth
CREATE TABLE IF NOT EXISTS m_btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenDefault
CREATE TABLE IF NOT EXISTS m_btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_price TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainToken
CREATE TABLE IF NOT EXISTS m_eth_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    contract_address TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MLocalTxLog
CREATE TABLE IF NOT EXISTS m_local_tx_log (  
    address_from TEXT NOT NULL,
    address_to TEXT NOT NULL,
    value TEXT NOT NULL,
    status TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MProgress
CREATE TABLE IF NOT EXISTS m_progress (  
    header TEXT NOT NULL,
    timestamp TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MTokenAddress
CREATE TABLE IF NOT EXISTS m_token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    status INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MUserAddress
CREATE TABLE IF NOT EXISTS m_user_address (  
    address TEXT NOT NULL,
    compressed_pub_key TEXT NOT NULL,
    verify TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenAuth
CREATE TABLE IF NOT EXISTS m_btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenDefault
CREATE TABLE IF NOT EXISTS m_btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_price TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainToken
CREATE TABLE IF NOT EXISTS m_eth_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    contract_address TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
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
-- MEthErc20Tx
CREATE TABLE IF NOT EXISTS m_eth_erc20_tx (  
    eth_chain_tx_id TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    token TEXT NOT NULL,
    erc20_face TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MLocalTxLog
CREATE TABLE IF NOT EXISTS m_local_tx_log (  
    address_from TEXT NOT NULL,
    address_to TEXT NOT NULL,
    value TEXT NOT NULL,
    status TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MProgress
CREATE TABLE IF NOT EXISTS m_progress (  
    header TEXT NOT NULL,
    timestamp TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MTokenAddress
CREATE TABLE IF NOT EXISTS m_token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    status INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MUserAddress
CREATE TABLE IF NOT EXISTS m_user_address (  
    address TEXT NOT NULL,
    compressed_pub_key TEXT NOT NULL,
    verify TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenAuth
CREATE TABLE IF NOT EXISTS m_btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenDefault
CREATE TABLE IF NOT EXISTS m_btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_price TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainToken
CREATE TABLE IF NOT EXISTS m_eth_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    contract_address TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
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
-- MLocalTxLog
CREATE TABLE IF NOT EXISTS m_local_tx_log (  
    address_from TEXT NOT NULL,
    address_to TEXT NOT NULL,
    value TEXT NOT NULL,
    status TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MProgress
CREATE TABLE IF NOT EXISTS m_progress (  
    header TEXT NOT NULL,
    timestamp TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MTokenAddress
CREATE TABLE IF NOT EXISTS m_token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    status INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MUserAddress
CREATE TABLE IF NOT EXISTS m_user_address (  
    address TEXT NOT NULL,
    compressed_pub_key TEXT NOT NULL,
    verify TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenAuth
CREATE TABLE IF NOT EXISTS m_btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenDefault
CREATE TABLE IF NOT EXISTS m_btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainToken
CREATE TABLE IF NOT EXISTS m_eee_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_price TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainToken
CREATE TABLE IF NOT EXISTS m_eth_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    contract_address TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
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
-- MEthErc20Tx
CREATE TABLE IF NOT EXISTS m_eth_erc20_tx (  
    eth_chain_tx_id TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    token TEXT NOT NULL,
    erc20_face TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MLocalTxLog
CREATE TABLE IF NOT EXISTS m_local_tx_log (  
    address_from TEXT NOT NULL,
    address_to TEXT NOT NULL,
    value TEXT NOT NULL,
    status TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MProgress
CREATE TABLE IF NOT EXISTS m_progress (  
    header TEXT NOT NULL,
    timestamp TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MTokenAddress
CREATE TABLE IF NOT EXISTS m_token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    status INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MUserAddress
CREATE TABLE IF NOT EXISTS m_user_address (  
    address TEXT NOT NULL,
    compressed_pub_key TEXT NOT NULL,
    verify TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenAuth
CREATE TABLE IF NOT EXISTS m_btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenDefault
CREATE TABLE IF NOT EXISTS m_btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainToken
CREATE TABLE IF NOT EXISTS m_eee_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_price TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTx
CREATE TABLE IF NOT EXISTS m_eee_chain_tx (  
    -- TxShared start
    tx_hash TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    block_number TEXT NOT NULL,
    signer TEXT NOT NULL,
    tx_bytes TEXT NOT NULL,
    tx_timestamp INTEGER NOT NULL,
    -- TxShared end

    wallet_account TEXT NOT NULL,
    from_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    value TEXT NOT NULL,
    status BOOLEAN NOT NULL,
    extension TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainToken
CREATE TABLE IF NOT EXISTS m_eth_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    contract_address TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
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
-- MEthErc20Tx
CREATE TABLE IF NOT EXISTS m_eth_erc20_tx (  
    eth_chain_tx_id TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    token TEXT NOT NULL,
    erc20_face TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MLocalTxLog
CREATE TABLE IF NOT EXISTS m_local_tx_log (  
    address_from TEXT NOT NULL,
    address_to TEXT NOT NULL,
    value TEXT NOT NULL,
    status TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MProgress
CREATE TABLE IF NOT EXISTS m_progress (  
    header TEXT NOT NULL,
    timestamp TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MTokenAddress
CREATE TABLE IF NOT EXISTS m_token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    status INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MUserAddress
CREATE TABLE IF NOT EXISTS m_user_address (  
    address TEXT NOT NULL,
    compressed_pub_key TEXT NOT NULL,
    verify TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenAuth
CREATE TABLE IF NOT EXISTS m_btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenDefault
CREATE TABLE IF NOT EXISTS m_btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_price TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainToken
CREATE TABLE IF NOT EXISTS m_eth_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    contract_address TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
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
-- MEthErc20Tx
CREATE TABLE IF NOT EXISTS m_eth_erc20_tx (  
    eth_chain_tx_id TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    token TEXT NOT NULL,
    erc20_face TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MLocalTxLog
CREATE TABLE IF NOT EXISTS m_local_tx_log (  
    address_from TEXT NOT NULL,
    address_to TEXT NOT NULL,
    value TEXT NOT NULL,
    status TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MProgress
CREATE TABLE IF NOT EXISTS m_progress (  
    header TEXT NOT NULL,
    timestamp TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MTokenAddress
CREATE TABLE IF NOT EXISTS m_token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    status INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MUserAddress
CREATE TABLE IF NOT EXISTS m_user_address (  
    address TEXT NOT NULL,
    compressed_pub_key TEXT NOT NULL,
    verify TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenAuth
CREATE TABLE IF NOT EXISTS m_btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenDefault
CREATE TABLE IF NOT EXISTS m_btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainToken
CREATE TABLE IF NOT EXISTS m_eee_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_price TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainToken
CREATE TABLE IF NOT EXISTS m_eth_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    contract_address TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
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
-- MEthErc20Tx
CREATE TABLE IF NOT EXISTS m_eth_erc20_tx (  
    eth_chain_tx_id TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    token TEXT NOT NULL,
    erc20_face TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MLocalTxLog
CREATE TABLE IF NOT EXISTS m_local_tx_log (  
    address_from TEXT NOT NULL,
    address_to TEXT NOT NULL,
    value TEXT NOT NULL,
    status TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MProgress
CREATE TABLE IF NOT EXISTS m_progress (  
    header TEXT NOT NULL,
    timestamp TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MTokenAddress
CREATE TABLE IF NOT EXISTS m_token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    status INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MUserAddress
CREATE TABLE IF NOT EXISTS m_user_address (  
    address TEXT NOT NULL,
    compressed_pub_key TEXT NOT NULL,
    verify TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenAuth
CREATE TABLE IF NOT EXISTS m_btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenDefault
CREATE TABLE IF NOT EXISTS m_btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainToken
CREATE TABLE IF NOT EXISTS m_eee_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_price TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTx
CREATE TABLE IF NOT EXISTS m_eee_chain_tx (  
    -- TxShared start
    tx_hash TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    block_number TEXT NOT NULL,
    signer TEXT NOT NULL,
    tx_bytes TEXT NOT NULL,
    tx_timestamp INTEGER NOT NULL,
    -- TxShared end

    wallet_account TEXT NOT NULL,
    from_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    value TEXT NOT NULL,
    status BOOLEAN NOT NULL,
    extension TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeTokenxTx
CREATE TABLE IF NOT EXISTS m_eee_tokenx_tx (  
    -- TxShared start
    tx_hash TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    block_number TEXT NOT NULL,
    signer TEXT NOT NULL,
    tx_bytes TEXT NOT NULL,
    tx_timestamp INTEGER NOT NULL,
    -- TxShared end

    wallet_account TEXT NOT NULL,
    from_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    value TEXT NOT NULL,
    status BOOLEAN NOT NULL,
    extension TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainToken
CREATE TABLE IF NOT EXISTS m_eth_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    contract_address TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
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
-- MEthErc20Tx
CREATE TABLE IF NOT EXISTS m_eth_erc20_tx (  
    eth_chain_tx_id TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    token TEXT NOT NULL,
    erc20_face TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MLocalTxLog
CREATE TABLE IF NOT EXISTS m_local_tx_log (  
    address_from TEXT NOT NULL,
    address_to TEXT NOT NULL,
    value TEXT NOT NULL,
    status TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MProgress
CREATE TABLE IF NOT EXISTS m_progress (  
    header TEXT NOT NULL,
    timestamp TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MTokenAddress
CREATE TABLE IF NOT EXISTS m_token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    status INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MUserAddress
CREATE TABLE IF NOT EXISTS m_user_address (  
    address TEXT NOT NULL,
    compressed_pub_key TEXT NOT NULL,
    verify TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenAuth
CREATE TABLE IF NOT EXISTS m_btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenDefault
CREATE TABLE IF NOT EXISTS m_btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainToken
CREATE TABLE IF NOT EXISTS m_eee_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_price TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTx
CREATE TABLE IF NOT EXISTS m_eee_chain_tx (  
    -- TxShared start
    tx_hash TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    block_number TEXT NOT NULL,
    signer TEXT NOT NULL,
    tx_bytes TEXT NOT NULL,
    tx_timestamp INTEGER NOT NULL,
    -- TxShared end

    wallet_account TEXT NOT NULL,
    from_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    value TEXT NOT NULL,
    status BOOLEAN NOT NULL,
    extension TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainToken
CREATE TABLE IF NOT EXISTS m_eth_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    contract_address TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
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
-- MEthErc20Tx
CREATE TABLE IF NOT EXISTS m_eth_erc20_tx (  
    eth_chain_tx_id TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    token TEXT NOT NULL,
    erc20_face TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MLocalTxLog
CREATE TABLE IF NOT EXISTS m_local_tx_log (  
    address_from TEXT NOT NULL,
    address_to TEXT NOT NULL,
    value TEXT NOT NULL,
    status TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MProgress
CREATE TABLE IF NOT EXISTS m_progress (  
    header TEXT NOT NULL,
    timestamp TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MTokenAddress
CREATE TABLE IF NOT EXISTS m_token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    status INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MUserAddress
CREATE TABLE IF NOT EXISTS m_user_address (  
    address TEXT NOT NULL,
    compressed_pub_key TEXT NOT NULL,
    verify TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenAuth
CREATE TABLE IF NOT EXISTS m_btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenDefault
CREATE TABLE IF NOT EXISTS m_btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainToken
CREATE TABLE IF NOT EXISTS m_eee_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_price TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTx
CREATE TABLE IF NOT EXISTS m_eee_chain_tx (  
    -- TxShared start
    tx_hash TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    block_number TEXT NOT NULL,
    signer TEXT NOT NULL,
    tx_bytes TEXT NOT NULL,
    tx_timestamp INTEGER NOT NULL,
    -- TxShared end

    wallet_account TEXT NOT NULL,
    from_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    value TEXT NOT NULL,
    status BOOLEAN NOT NULL,
    extension TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeTokenxTx
CREATE TABLE IF NOT EXISTS m_eee_tokenx_tx (  
    -- TxShared start
    tx_hash TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    block_number TEXT NOT NULL,
    signer TEXT NOT NULL,
    tx_bytes TEXT NOT NULL,
    tx_timestamp INTEGER NOT NULL,
    -- TxShared end

    wallet_account TEXT NOT NULL,
    from_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    value TEXT NOT NULL,
    status BOOLEAN NOT NULL,
    extension TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainToken
CREATE TABLE IF NOT EXISTS m_eth_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    contract_address TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
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
-- MEthErc20Tx
CREATE TABLE IF NOT EXISTS m_eth_erc20_tx (  
    eth_chain_tx_id TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    token TEXT NOT NULL,
    erc20_face TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MLocalTxLog
CREATE TABLE IF NOT EXISTS m_local_tx_log (  
    address_from TEXT NOT NULL,
    address_to TEXT NOT NULL,
    value TEXT NOT NULL,
    status TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MProgress
CREATE TABLE IF NOT EXISTS m_progress (  
    header TEXT NOT NULL,
    timestamp TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MSubChainBasicInfo
CREATE TABLE IF NOT EXISTS m_sub_chain_basic_info (  
    genesis_hash TEXT NOT NULL,
    metadata TEXT NOT NULL,
    runtime_version INTEGER NOT NULL,
    tx_version INTEGER NOT NULL,
    ss58_format_prefix INTEGER NOT NULL,
    token_decimals INTEGER NOT NULL,
    token_symbol TEXT NOT NULL,
    is_default INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MTokenAddress
CREATE TABLE IF NOT EXISTS m_token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    status INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MUserAddress
CREATE TABLE IF NOT EXISTS m_user_address (  
    address TEXT NOT NULL,
    compressed_pub_key TEXT NOT NULL,
    verify TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenAuth
CREATE TABLE IF NOT EXISTS m_btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenDefault
CREATE TABLE IF NOT EXISTS m_btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainToken
CREATE TABLE IF NOT EXISTS m_eee_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_price TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTx
CREATE TABLE IF NOT EXISTS m_eee_chain_tx (  
    -- TxShared start
    tx_hash TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    block_number TEXT NOT NULL,
    signer TEXT NOT NULL,
    tx_bytes TEXT NOT NULL,
    tx_timestamp INTEGER NOT NULL,
    -- TxShared end

    wallet_account TEXT NOT NULL,
    from_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    value TEXT NOT NULL,
    status BOOLEAN NOT NULL,
    extension TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeTokenxTx
CREATE TABLE IF NOT EXISTS m_eee_tokenx_tx (  
    -- TxShared start
    tx_hash TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    block_number TEXT NOT NULL,
    signer TEXT NOT NULL,
    tx_bytes TEXT NOT NULL,
    tx_timestamp INTEGER NOT NULL,
    -- TxShared end

    wallet_account TEXT NOT NULL,
    from_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    value TEXT NOT NULL,
    status BOOLEAN NOT NULL,
    extension TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainToken
CREATE TABLE IF NOT EXISTS m_eth_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    contract_address TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
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
-- MEthErc20Tx
CREATE TABLE IF NOT EXISTS m_eth_erc20_tx (  
    eth_chain_tx_id TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    token TEXT NOT NULL,
    erc20_face TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MLocalTxLog
CREATE TABLE IF NOT EXISTS m_local_tx_log (  
    address_from TEXT NOT NULL,
    address_to TEXT NOT NULL,
    value TEXT NOT NULL,
    status TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MProgress
CREATE TABLE IF NOT EXISTS m_progress (  
    header TEXT NOT NULL,
    timestamp TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MTokenAddress
CREATE TABLE IF NOT EXISTS m_token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    status INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MUserAddress
CREATE TABLE IF NOT EXISTS m_user_address (  
    address TEXT NOT NULL,
    compressed_pub_key TEXT NOT NULL,
    verify TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAccountInfoSyncProg
CREATE TABLE IF NOT EXISTS m_account_info_sync_prog (  
    account TEXT NOT NULL,
    block_no TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenAuth
CREATE TABLE IF NOT EXISTS m_btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenDefault
CREATE TABLE IF NOT EXISTS m_btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainToken
CREATE TABLE IF NOT EXISTS m_eee_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_price TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTx
CREATE TABLE IF NOT EXISTS m_eee_chain_tx (  
    -- TxShared start
    tx_hash TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    block_number TEXT NOT NULL,
    signer TEXT NOT NULL,
    tx_bytes TEXT NOT NULL,
    tx_timestamp INTEGER NOT NULL,
    -- TxShared end

    wallet_account TEXT NOT NULL,
    from_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    value TEXT NOT NULL,
    status BOOLEAN NOT NULL,
    extension TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeTokenxTx
CREATE TABLE IF NOT EXISTS m_eee_tokenx_tx (  
    -- TxShared start
    tx_hash TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    block_number TEXT NOT NULL,
    signer TEXT NOT NULL,
    tx_bytes TEXT NOT NULL,
    tx_timestamp INTEGER NOT NULL,
    -- TxShared end

    wallet_account TEXT NOT NULL,
    from_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    value TEXT NOT NULL,
    status BOOLEAN NOT NULL,
    extension TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainToken
CREATE TABLE IF NOT EXISTS m_eth_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    contract_address TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
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
-- MEthErc20Tx
CREATE TABLE IF NOT EXISTS m_eth_erc20_tx (  
    eth_chain_tx_id TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    token TEXT NOT NULL,
    erc20_face TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MLocalTxLog
CREATE TABLE IF NOT EXISTS m_local_tx_log (  
    address_from TEXT NOT NULL,
    address_to TEXT NOT NULL,
    value TEXT NOT NULL,
    status TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MProgress
CREATE TABLE IF NOT EXISTS m_progress (  
    header TEXT NOT NULL,
    timestamp TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MSubChainBasicInfo
CREATE TABLE IF NOT EXISTS m_sub_chain_basic_info (  
    genesis_hash TEXT NOT NULL,
    metadata TEXT NOT NULL,
    runtime_version INTEGER NOT NULL,
    tx_version INTEGER NOT NULL,
    ss58_format_prefix INTEGER NOT NULL,
    token_decimals INTEGER NOT NULL,
    token_symbol TEXT NOT NULL,
    is_default INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MTokenAddress
CREATE TABLE IF NOT EXISTS m_token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    status INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MUserAddress
CREATE TABLE IF NOT EXISTS m_user_address (  
    address TEXT NOT NULL,
    compressed_pub_key TEXT NOT NULL,
    verify TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAccountInfoSyncProg
CREATE TABLE IF NOT EXISTS m_account_info_sync_prog (  
    account TEXT NOT NULL,
    block_no TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainToken
CREATE TABLE IF NOT EXISTS m_btc_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenAuth
CREATE TABLE IF NOT EXISTS m_btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenDefault
CREATE TABLE IF NOT EXISTS m_btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainToken
CREATE TABLE IF NOT EXISTS m_eee_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_price TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTx
CREATE TABLE IF NOT EXISTS m_eee_chain_tx (  
    -- TxShared start
    tx_hash TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    block_number TEXT NOT NULL,
    signer TEXT NOT NULL,
    tx_bytes TEXT NOT NULL,
    tx_timestamp INTEGER NOT NULL,
    -- TxShared end

    wallet_account TEXT NOT NULL,
    from_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    value TEXT NOT NULL,
    status BOOLEAN NOT NULL,
    extension TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeTokenxTx
CREATE TABLE IF NOT EXISTS m_eee_tokenx_tx (  
    -- TxShared start
    tx_hash TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    block_number TEXT NOT NULL,
    signer TEXT NOT NULL,
    tx_bytes TEXT NOT NULL,
    tx_timestamp INTEGER NOT NULL,
    -- TxShared end

    wallet_account TEXT NOT NULL,
    from_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    value TEXT NOT NULL,
    status BOOLEAN NOT NULL,
    extension TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainToken
CREATE TABLE IF NOT EXISTS m_eth_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    contract_address TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
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
-- MEthErc20Tx
CREATE TABLE IF NOT EXISTS m_eth_erc20_tx (  
    eth_chain_tx_id TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    token TEXT NOT NULL,
    erc20_face TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MLocalTxLog
CREATE TABLE IF NOT EXISTS m_local_tx_log (  
    address_from TEXT NOT NULL,
    address_to TEXT NOT NULL,
    value TEXT NOT NULL,
    status TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MProgress
CREATE TABLE IF NOT EXISTS m_progress (  
    header TEXT NOT NULL,
    timestamp TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MSubChainBasicInfo
CREATE TABLE IF NOT EXISTS m_sub_chain_basic_info (  
    genesis_hash TEXT NOT NULL,
    metadata TEXT NOT NULL,
    runtime_version INTEGER NOT NULL,
    tx_version INTEGER NOT NULL,
    ss58_format_prefix INTEGER NOT NULL,
    token_decimals INTEGER NOT NULL,
    token_symbol TEXT NOT NULL,
    is_default INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MTokenAddress
CREATE TABLE IF NOT EXISTS m_token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    status INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MUserAddress
CREATE TABLE IF NOT EXISTS m_user_address (  
    address TEXT NOT NULL,
    compressed_pub_key TEXT NOT NULL,
    verify TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenAuth
CREATE TABLE IF NOT EXISTS m_btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenDefault
CREATE TABLE IF NOT EXISTS m_btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainToken
CREATE TABLE IF NOT EXISTS m_eee_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_price TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTx
CREATE TABLE IF NOT EXISTS m_eee_chain_tx (  
    -- TxShared start
    tx_hash TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    block_number TEXT NOT NULL,
    signer TEXT NOT NULL,
    tx_bytes TEXT NOT NULL,
    tx_timestamp INTEGER NOT NULL,
    -- TxShared end

    wallet_account TEXT NOT NULL,
    from_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    value TEXT NOT NULL,
    status BOOLEAN NOT NULL,
    extension TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeTokenxTx
CREATE TABLE IF NOT EXISTS m_eee_tokenx_tx (  
    -- TxShared start
    tx_hash TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    block_number TEXT NOT NULL,
    signer TEXT NOT NULL,
    tx_bytes TEXT NOT NULL,
    tx_timestamp INTEGER NOT NULL,
    -- TxShared end

    wallet_account TEXT NOT NULL,
    from_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    value TEXT NOT NULL,
    status BOOLEAN NOT NULL,
    extension TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainToken
CREATE TABLE IF NOT EXISTS m_eth_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    contract_address TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
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
-- MEthErc20Tx
CREATE TABLE IF NOT EXISTS m_eth_erc20_tx (  
    eth_chain_tx_id TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    token TEXT NOT NULL,
    erc20_face TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MLocalTxLog
CREATE TABLE IF NOT EXISTS m_local_tx_log (  
    address_from TEXT NOT NULL,
    address_to TEXT NOT NULL,
    value TEXT NOT NULL,
    status TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MProgress
CREATE TABLE IF NOT EXISTS m_progress (  
    header TEXT NOT NULL,
    timestamp TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MSubChainBasicInfo
CREATE TABLE IF NOT EXISTS m_sub_chain_basic_info (  
    genesis_hash TEXT NOT NULL,
    metadata TEXT NOT NULL,
    runtime_version INTEGER NOT NULL,
    tx_version INTEGER NOT NULL,
    ss58_format_prefix INTEGER NOT NULL,
    token_decimals INTEGER NOT NULL,
    token_symbol TEXT NOT NULL,
    is_default INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MTokenAddress
CREATE TABLE IF NOT EXISTS m_token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    status INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MUserAddress
CREATE TABLE IF NOT EXISTS m_user_address (  
    address TEXT NOT NULL,
    compressed_pub_key TEXT NOT NULL,
    verify TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAccountInfoSyncProg
CREATE TABLE IF NOT EXISTS m_account_info_sync_prog (  
    account TEXT NOT NULL,
    block_no TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainToken
CREATE TABLE IF NOT EXISTS m_btc_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenAuth
CREATE TABLE IF NOT EXISTS m_btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenDefault
CREATE TABLE IF NOT EXISTS m_btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
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
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainToken
CREATE TABLE IF NOT EXISTS m_eee_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_price TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTx
CREATE TABLE IF NOT EXISTS m_eee_chain_tx (  
    -- TxShared start
    tx_hash TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    block_number TEXT NOT NULL,
    signer TEXT NOT NULL,
    tx_bytes TEXT NOT NULL,
    tx_timestamp INTEGER NOT NULL,
    -- TxShared end

    wallet_account TEXT NOT NULL,
    from_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    value TEXT NOT NULL,
    status BOOLEAN NOT NULL,
    extension TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeTokenxTx
CREATE TABLE IF NOT EXISTS m_eee_tokenx_tx (  
    -- TxShared start
    tx_hash TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    block_number TEXT NOT NULL,
    signer TEXT NOT NULL,
    tx_bytes TEXT NOT NULL,
    tx_timestamp INTEGER NOT NULL,
    -- TxShared end

    wallet_account TEXT NOT NULL,
    from_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    value TEXT NOT NULL,
    status BOOLEAN NOT NULL,
    extension TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainToken
CREATE TABLE IF NOT EXISTS m_eth_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    contract_address TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
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
-- MEthErc20Tx
CREATE TABLE IF NOT EXISTS m_eth_erc20_tx (  
    eth_chain_tx_id TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    token TEXT NOT NULL,
    erc20_face TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MLocalTxLog
CREATE TABLE IF NOT EXISTS m_local_tx_log (  
    address_from TEXT NOT NULL,
    address_to TEXT NOT NULL,
    value TEXT NOT NULL,
    status TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MProgress
CREATE TABLE IF NOT EXISTS m_progress (  
    header TEXT NOT NULL,
    timestamp TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MSubChainBasicInfo
CREATE TABLE IF NOT EXISTS m_sub_chain_basic_info (  
    genesis_hash TEXT NOT NULL,
    metadata TEXT NOT NULL,
    runtime_version INTEGER NOT NULL,
    tx_version INTEGER NOT NULL,
    ss58_format_prefix INTEGER NOT NULL,
    token_decimals INTEGER NOT NULL,
    token_symbol TEXT NOT NULL,
    is_default INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MTokenAddress
CREATE TABLE IF NOT EXISTS m_token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    status INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MUserAddress
CREATE TABLE IF NOT EXISTS m_user_address (  
    address TEXT NOT NULL,
    compressed_pub_key TEXT NOT NULL,
    verify TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAccountInfoSyncProg
CREATE TABLE IF NOT EXISTS m_account_info_sync_prog (  
    account TEXT NOT NULL,
    block_no TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenAuth
CREATE TABLE IF NOT EXISTS m_btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenDefault
CREATE TABLE IF NOT EXISTS m_btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainToken
CREATE TABLE IF NOT EXISTS m_eee_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_price TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTx
CREATE TABLE IF NOT EXISTS m_eee_chain_tx (  
    -- TxShared start
    tx_hash TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    block_number TEXT NOT NULL,
    signer TEXT NOT NULL,
    tx_bytes TEXT NOT NULL,
    tx_timestamp INTEGER NOT NULL,
    -- TxShared end

    wallet_account TEXT NOT NULL,
    from_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    value TEXT NOT NULL,
    status BOOLEAN NOT NULL,
    extension TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeTokenxTx
CREATE TABLE IF NOT EXISTS m_eee_tokenx_tx (  
    -- TxShared start
    tx_hash TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    block_number TEXT NOT NULL,
    signer TEXT NOT NULL,
    tx_bytes TEXT NOT NULL,
    tx_timestamp INTEGER NOT NULL,
    -- TxShared end

    wallet_account TEXT NOT NULL,
    from_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    value TEXT NOT NULL,
    status BOOLEAN NOT NULL,
    extension TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainToken
CREATE TABLE IF NOT EXISTS m_eth_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    contract_address TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
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
-- MEthErc20Tx
CREATE TABLE IF NOT EXISTS m_eth_erc20_tx (  
    eth_chain_tx_id TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    token TEXT NOT NULL,
    erc20_face TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MLocalTxLog
CREATE TABLE IF NOT EXISTS m_local_tx_log (  
    address_from TEXT NOT NULL,
    address_to TEXT NOT NULL,
    value TEXT NOT NULL,
    status TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MProgress
CREATE TABLE IF NOT EXISTS m_progress (  
    header TEXT NOT NULL,
    timestamp TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MSubChainBasicInfo
CREATE TABLE IF NOT EXISTS m_sub_chain_basic_info (  
    genesis_hash TEXT NOT NULL,
    metadata TEXT NOT NULL,
    runtime_version INTEGER NOT NULL,
    tx_version INTEGER NOT NULL,
    ss58_format_prefix INTEGER NOT NULL,
    token_decimals INTEGER NOT NULL,
    token_symbol TEXT NOT NULL,
    is_default INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MTokenAddress
CREATE TABLE IF NOT EXISTS m_token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    status INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MUserAddress
CREATE TABLE IF NOT EXISTS m_user_address (  
    address TEXT NOT NULL,
    compressed_pub_key TEXT NOT NULL,
    verify TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAccountInfoSyncProg
CREATE TABLE IF NOT EXISTS m_account_info_sync_prog (  
    account TEXT NOT NULL,
    block_no TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainToken
CREATE TABLE IF NOT EXISTS m_btc_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenAuth
CREATE TABLE IF NOT EXISTS m_btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenDefault
CREATE TABLE IF NOT EXISTS m_btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
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
-- MBtcInputTx
CREATE TABLE IF NOT EXISTS m_btc_input_tx (  
    btc_chain_tx_foreign TEXT NOT NULL,
    tx_id TEXT NOT NULL,
    vout INTEGER NOT NULL,
    sig_script TEXT NOT NULL,
    sequence INTEGER NOT NULL,
    index INTEGER NOT NULL,
    btc_tx_hash TEXT NOT NULL,
    btc_tx_hexbytes TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainToken
CREATE TABLE IF NOT EXISTS m_eee_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_price TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTx
CREATE TABLE IF NOT EXISTS m_eee_chain_tx (  
    -- TxShared start
    tx_hash TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    block_number TEXT NOT NULL,
    signer TEXT NOT NULL,
    tx_bytes TEXT NOT NULL,
    tx_timestamp INTEGER NOT NULL,
    -- TxShared end

    wallet_account TEXT NOT NULL,
    from_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    value TEXT NOT NULL,
    status BOOLEAN NOT NULL,
    extension TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeTokenxTx
CREATE TABLE IF NOT EXISTS m_eee_tokenx_tx (  
    -- TxShared start
    tx_hash TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    block_number TEXT NOT NULL,
    signer TEXT NOT NULL,
    tx_bytes TEXT NOT NULL,
    tx_timestamp INTEGER NOT NULL,
    -- TxShared end

    wallet_account TEXT NOT NULL,
    from_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    value TEXT NOT NULL,
    status BOOLEAN NOT NULL,
    extension TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainToken
CREATE TABLE IF NOT EXISTS m_eth_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    contract_address TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
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
-- MEthErc20Tx
CREATE TABLE IF NOT EXISTS m_eth_erc20_tx (  
    eth_chain_tx_id TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    token TEXT NOT NULL,
    erc20_face TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MLocalTxLog
CREATE TABLE IF NOT EXISTS m_local_tx_log (  
    address_from TEXT NOT NULL,
    address_to TEXT NOT NULL,
    value TEXT NOT NULL,
    status TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MProgress
CREATE TABLE IF NOT EXISTS m_progress (  
    header TEXT NOT NULL,
    timestamp TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MSubChainBasicInfo
CREATE TABLE IF NOT EXISTS m_sub_chain_basic_info (  
    genesis_hash TEXT NOT NULL,
    metadata TEXT NOT NULL,
    runtime_version INTEGER NOT NULL,
    tx_version INTEGER NOT NULL,
    ss58_format_prefix INTEGER NOT NULL,
    token_decimals INTEGER NOT NULL,
    token_symbol TEXT NOT NULL,
    is_default INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MTokenAddress
CREATE TABLE IF NOT EXISTS m_token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    status INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MUserAddress
CREATE TABLE IF NOT EXISTS m_user_address (  
    address TEXT NOT NULL,
    compressed_pub_key TEXT NOT NULL,
    verify TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAccountInfoSyncProg
CREATE TABLE IF NOT EXISTS m_account_info_sync_prog (  
    account TEXT NOT NULL,
    block_no TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainToken
CREATE TABLE IF NOT EXISTS m_btc_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenAuth
CREATE TABLE IF NOT EXISTS m_btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenDefault
CREATE TABLE IF NOT EXISTS m_btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainToken
CREATE TABLE IF NOT EXISTS m_eee_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_price TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTx
CREATE TABLE IF NOT EXISTS m_eee_chain_tx (  
    -- TxShared start
    tx_hash TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    block_number TEXT NOT NULL,
    signer TEXT NOT NULL,
    tx_bytes TEXT NOT NULL,
    tx_timestamp INTEGER NOT NULL,
    -- TxShared end

    wallet_account TEXT NOT NULL,
    from_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    value TEXT NOT NULL,
    status BOOLEAN NOT NULL,
    extension TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeTokenxTx
CREATE TABLE IF NOT EXISTS m_eee_tokenx_tx (  
    -- TxShared start
    tx_hash TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    block_number TEXT NOT NULL,
    signer TEXT NOT NULL,
    tx_bytes TEXT NOT NULL,
    tx_timestamp INTEGER NOT NULL,
    -- TxShared end

    wallet_account TEXT NOT NULL,
    from_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    value TEXT NOT NULL,
    status BOOLEAN NOT NULL,
    extension TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainToken
CREATE TABLE IF NOT EXISTS m_eth_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    contract_address TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
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
-- MEthErc20Tx
CREATE TABLE IF NOT EXISTS m_eth_erc20_tx (  
    eth_chain_tx_id TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    token TEXT NOT NULL,
    erc20_face TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MLocalTxLog
CREATE TABLE IF NOT EXISTS m_local_tx_log (  
    address_from TEXT NOT NULL,
    address_to TEXT NOT NULL,
    value TEXT NOT NULL,
    status TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MProgress
CREATE TABLE IF NOT EXISTS m_progress (  
    header TEXT NOT NULL,
    timestamp TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MSubChainBasicInfo
CREATE TABLE IF NOT EXISTS m_sub_chain_basic_info (  
    genesis_hash TEXT NOT NULL,
    metadata TEXT NOT NULL,
    runtime_version INTEGER NOT NULL,
    tx_version INTEGER NOT NULL,
    ss58_format_prefix INTEGER NOT NULL,
    token_decimals INTEGER NOT NULL,
    token_symbol TEXT NOT NULL,
    is_default INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MTokenAddress
CREATE TABLE IF NOT EXISTS m_token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    status INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MUserAddress
CREATE TABLE IF NOT EXISTS m_user_address (  
    address TEXT NOT NULL,
    compressed_pub_key TEXT NOT NULL,
    verify TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAccountInfoSyncProg
CREATE TABLE IF NOT EXISTS m_account_info_sync_prog (  
    account TEXT NOT NULL,
    block_no TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainToken
CREATE TABLE IF NOT EXISTS m_btc_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenAuth
CREATE TABLE IF NOT EXISTS m_btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenDefault
CREATE TABLE IF NOT EXISTS m_btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
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
-- MBtcInputTx
CREATE TABLE IF NOT EXISTS m_btc_input_tx (  
    btc_chain_tx_foreign TEXT NOT NULL,
    tx_id TEXT NOT NULL,
    vout INTEGER NOT NULL,
    sig_script TEXT NOT NULL,
    sequence INTEGER NOT NULL,
    index INTEGER NOT NULL,
    btc_tx_hash TEXT NOT NULL,
    btc_tx_hexbytes TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcOutputTx
CREATE TABLE IF NOT EXISTS m_btc_output_tx (  
    btc_chain_tx_foreign TEXT NOT NULL,
    value INTEGER NOT NULL,
    pk_script TEXT NOT NULL,
    index INTEGER NOT NULL,
    btc_tx_hash TEXT NOT NULL,
    btc_tx_hexbytes TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainToken
CREATE TABLE IF NOT EXISTS m_eee_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_price TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTx
CREATE TABLE IF NOT EXISTS m_eee_chain_tx (  
    -- TxShared start
    tx_hash TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    block_number TEXT NOT NULL,
    signer TEXT NOT NULL,
    tx_bytes TEXT NOT NULL,
    tx_timestamp INTEGER NOT NULL,
    -- TxShared end

    wallet_account TEXT NOT NULL,
    from_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    value TEXT NOT NULL,
    status BOOLEAN NOT NULL,
    extension TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeTokenxTx
CREATE TABLE IF NOT EXISTS m_eee_tokenx_tx (  
    -- TxShared start
    tx_hash TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    block_number TEXT NOT NULL,
    signer TEXT NOT NULL,
    tx_bytes TEXT NOT NULL,
    tx_timestamp INTEGER NOT NULL,
    -- TxShared end

    wallet_account TEXT NOT NULL,
    from_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    value TEXT NOT NULL,
    status BOOLEAN NOT NULL,
    extension TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainToken
CREATE TABLE IF NOT EXISTS m_eth_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    contract_address TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
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
-- MEthErc20Tx
CREATE TABLE IF NOT EXISTS m_eth_erc20_tx (  
    eth_chain_tx_id TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    token TEXT NOT NULL,
    erc20_face TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MLocalTxLog
CREATE TABLE IF NOT EXISTS m_local_tx_log (  
    address_from TEXT NOT NULL,
    address_to TEXT NOT NULL,
    value TEXT NOT NULL,
    status TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MProgress
CREATE TABLE IF NOT EXISTS m_progress (  
    header TEXT NOT NULL,
    timestamp TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MSubChainBasicInfo
CREATE TABLE IF NOT EXISTS m_sub_chain_basic_info (  
    genesis_hash TEXT NOT NULL,
    metadata TEXT NOT NULL,
    runtime_version INTEGER NOT NULL,
    tx_version INTEGER NOT NULL,
    ss58_format_prefix INTEGER NOT NULL,
    token_decimals INTEGER NOT NULL,
    token_symbol TEXT NOT NULL,
    is_default INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MTokenAddress
CREATE TABLE IF NOT EXISTS m_token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    status INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MUserAddress
CREATE TABLE IF NOT EXISTS m_user_address (  
    address TEXT NOT NULL,
    compressed_pub_key TEXT NOT NULL,
    verify TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAccountInfoSyncProg
CREATE TABLE IF NOT EXISTS m_account_info_sync_prog (  
    account TEXT NOT NULL,
    block_no TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainToken
CREATE TABLE IF NOT EXISTS m_btc_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenAuth
CREATE TABLE IF NOT EXISTS m_btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenDefault
CREATE TABLE IF NOT EXISTS m_btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
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
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainToken
CREATE TABLE IF NOT EXISTS m_eee_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_price TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTx
CREATE TABLE IF NOT EXISTS m_eee_chain_tx (  
    -- TxShared start
    tx_hash TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    block_number TEXT NOT NULL,
    signer TEXT NOT NULL,
    tx_bytes TEXT NOT NULL,
    tx_timestamp INTEGER NOT NULL,
    -- TxShared end

    wallet_account TEXT NOT NULL,
    from_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    value TEXT NOT NULL,
    status BOOLEAN NOT NULL,
    extension TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeTokenxTx
CREATE TABLE IF NOT EXISTS m_eee_tokenx_tx (  
    -- TxShared start
    tx_hash TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    block_number TEXT NOT NULL,
    signer TEXT NOT NULL,
    tx_bytes TEXT NOT NULL,
    tx_timestamp INTEGER NOT NULL,
    -- TxShared end

    wallet_account TEXT NOT NULL,
    from_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    value TEXT NOT NULL,
    status BOOLEAN NOT NULL,
    extension TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainToken
CREATE TABLE IF NOT EXISTS m_eth_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    contract_address TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
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
-- MEthErc20Tx
CREATE TABLE IF NOT EXISTS m_eth_erc20_tx (  
    eth_chain_tx_id TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    token TEXT NOT NULL,
    erc20_face TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MLocalTxLog
CREATE TABLE IF NOT EXISTS m_local_tx_log (  
    address_from TEXT NOT NULL,
    address_to TEXT NOT NULL,
    value TEXT NOT NULL,
    status TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MProgress
CREATE TABLE IF NOT EXISTS m_progress (  
    header TEXT NOT NULL,
    timestamp TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MSubChainBasicInfo
CREATE TABLE IF NOT EXISTS m_sub_chain_basic_info (  
    genesis_hash TEXT NOT NULL,
    metadata TEXT NOT NULL,
    runtime_version INTEGER NOT NULL,
    tx_version INTEGER NOT NULL,
    ss58_format_prefix INTEGER NOT NULL,
    token_decimals INTEGER NOT NULL,
    token_symbol TEXT NOT NULL,
    is_default INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MTokenAddress
CREATE TABLE IF NOT EXISTS m_token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    status INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MUserAddress
CREATE TABLE IF NOT EXISTS m_user_address (  
    address TEXT NOT NULL,
    compressed_pub_key TEXT NOT NULL,
    verify TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAccountInfoSyncProg
CREATE TABLE IF NOT EXISTS m_account_info_sync_prog (  
    account TEXT NOT NULL,
    block_no TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBlockHeader
CREATE TABLE IF NOT EXISTS m_block_header (  
    header TEXT NOT NULL,
    scanned TEXT NOT NULL,
    timestamp TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainToken
CREATE TABLE IF NOT EXISTS m_btc_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenAuth
CREATE TABLE IF NOT EXISTS m_btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenDefault
CREATE TABLE IF NOT EXISTS m_btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
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
-- MBtcInputTx
CREATE TABLE IF NOT EXISTS m_btc_input_tx (  
    btc_chain_tx_foreign TEXT NOT NULL,
    tx_id TEXT NOT NULL,
    vout INTEGER NOT NULL,
    sig_script TEXT NOT NULL,
    sequence INTEGER NOT NULL,
    index INTEGER NOT NULL,
    btc_tx_hash TEXT NOT NULL,
    btc_tx_hexbytes TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcOutputTx
CREATE TABLE IF NOT EXISTS m_btc_output_tx (  
    btc_chain_tx_foreign TEXT NOT NULL,
    value INTEGER NOT NULL,
    pk_script TEXT NOT NULL,
    index INTEGER NOT NULL,
    btc_tx_hash TEXT NOT NULL,
    btc_tx_hexbytes TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainToken
CREATE TABLE IF NOT EXISTS m_eee_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_price TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTx
CREATE TABLE IF NOT EXISTS m_eee_chain_tx (  
    -- TxShared start
    tx_hash TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    block_number TEXT NOT NULL,
    signer TEXT NOT NULL,
    tx_bytes TEXT NOT NULL,
    tx_timestamp INTEGER NOT NULL,
    -- TxShared end

    wallet_account TEXT NOT NULL,
    from_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    value TEXT NOT NULL,
    status BOOLEAN NOT NULL,
    extension TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeTokenxTx
CREATE TABLE IF NOT EXISTS m_eee_tokenx_tx (  
    -- TxShared start
    tx_hash TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    block_number TEXT NOT NULL,
    signer TEXT NOT NULL,
    tx_bytes TEXT NOT NULL,
    tx_timestamp INTEGER NOT NULL,
    -- TxShared end

    wallet_account TEXT NOT NULL,
    from_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    value TEXT NOT NULL,
    status BOOLEAN NOT NULL,
    extension TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainToken
CREATE TABLE IF NOT EXISTS m_eth_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    contract_address TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
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
-- MEthErc20Tx
CREATE TABLE IF NOT EXISTS m_eth_erc20_tx (  
    eth_chain_tx_id TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    token TEXT NOT NULL,
    erc20_face TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MLocalTxLog
CREATE TABLE IF NOT EXISTS m_local_tx_log (  
    address_from TEXT NOT NULL,
    address_to TEXT NOT NULL,
    value TEXT NOT NULL,
    status TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MProgress
CREATE TABLE IF NOT EXISTS m_progress (  
    header TEXT NOT NULL,
    timestamp TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MSubChainBasicInfo
CREATE TABLE IF NOT EXISTS m_sub_chain_basic_info (  
    genesis_hash TEXT NOT NULL,
    metadata TEXT NOT NULL,
    runtime_version INTEGER NOT NULL,
    tx_version INTEGER NOT NULL,
    ss58_format_prefix INTEGER NOT NULL,
    token_decimals INTEGER NOT NULL,
    token_symbol TEXT NOT NULL,
    is_default INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MTokenAddress
CREATE TABLE IF NOT EXISTS m_token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    status INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MUserAddress
CREATE TABLE IF NOT EXISTS m_user_address (  
    address TEXT NOT NULL,
    compressed_pub_key TEXT NOT NULL,
    verify TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAccountInfoSyncProg
CREATE TABLE IF NOT EXISTS m_account_info_sync_prog (  
    account TEXT NOT NULL,
    block_no TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBlockHeader
CREATE TABLE IF NOT EXISTS m_block_header (  
    header TEXT NOT NULL,
    scanned TEXT NOT NULL,
    timestamp TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainToken
CREATE TABLE IF NOT EXISTS m_btc_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenAuth
CREATE TABLE IF NOT EXISTS m_btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenDefault
CREATE TABLE IF NOT EXISTS m_btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
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
-- MBtcInputTx
CREATE TABLE IF NOT EXISTS m_btc_input_tx (  
    btc_chain_tx_foreign TEXT NOT NULL,
    tx_id TEXT NOT NULL,
    vout INTEGER NOT NULL,
    sig_script TEXT NOT NULL,
    sequence INTEGER NOT NULL,
    index INTEGER NOT NULL,
    btc_tx_hash TEXT NOT NULL,
    btc_tx_hexbytes TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcOutputTx
CREATE TABLE IF NOT EXISTS m_btc_output_tx (  
    btc_chain_tx_foreign TEXT NOT NULL,
    value INTEGER NOT NULL,
    pk_script TEXT NOT NULL,
    index INTEGER NOT NULL,
    btc_tx_hash TEXT NOT NULL,
    btc_tx_hexbytes TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainToken
CREATE TABLE IF NOT EXISTS m_eee_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_price TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTx
CREATE TABLE IF NOT EXISTS m_eee_chain_tx (  
    -- TxShared start
    tx_hash TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    block_number TEXT NOT NULL,
    signer TEXT NOT NULL,
    tx_bytes TEXT NOT NULL,
    tx_timestamp INTEGER NOT NULL,
    -- TxShared end

    wallet_account TEXT NOT NULL,
    from_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    value TEXT NOT NULL,
    status BOOLEAN NOT NULL,
    extension TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeTokenxTx
CREATE TABLE IF NOT EXISTS m_eee_tokenx_tx (  
    -- TxShared start
    tx_hash TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    block_number TEXT NOT NULL,
    signer TEXT NOT NULL,
    tx_bytes TEXT NOT NULL,
    tx_timestamp INTEGER NOT NULL,
    -- TxShared end

    wallet_account TEXT NOT NULL,
    from_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    value TEXT NOT NULL,
    status BOOLEAN NOT NULL,
    extension TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainToken
CREATE TABLE IF NOT EXISTS m_eth_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    contract_address TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
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
-- MEthErc20Tx
CREATE TABLE IF NOT EXISTS m_eth_erc20_tx (  
    eth_chain_tx_id TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    token TEXT NOT NULL,
    erc20_face TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MLocalTxLog
CREATE TABLE IF NOT EXISTS m_local_tx_log (  
    address_from TEXT NOT NULL,
    address_to TEXT NOT NULL,
    value TEXT NOT NULL,
    status TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MProgress
CREATE TABLE IF NOT EXISTS m_progress (  
    header TEXT NOT NULL,
    timestamp TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MSetting
CREATE TABLE IF NOT EXISTS m_setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MSubChainBasicInfo
CREATE TABLE IF NOT EXISTS m_sub_chain_basic_info (  
    genesis_hash TEXT NOT NULL,
    metadata TEXT NOT NULL,
    runtime_version INTEGER NOT NULL,
    tx_version INTEGER NOT NULL,
    ss58_format_prefix INTEGER NOT NULL,
    token_decimals INTEGER NOT NULL,
    token_symbol TEXT NOT NULL,
    is_default INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MTokenAddress
CREATE TABLE IF NOT EXISTS m_token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    status INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MUserAddress
CREATE TABLE IF NOT EXISTS m_user_address (  
    address TEXT NOT NULL,
    compressed_pub_key TEXT NOT NULL,
    verify TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAccountInfoSyncProg
CREATE TABLE IF NOT EXISTS m_account_info_sync_prog (  
    account TEXT NOT NULL,
    block_no TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainToken
CREATE TABLE IF NOT EXISTS m_btc_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenAuth
CREATE TABLE IF NOT EXISTS m_btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenDefault
CREATE TABLE IF NOT EXISTS m_btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
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
-- MBtcInputTx
CREATE TABLE IF NOT EXISTS m_btc_input_tx (  
    btc_chain_tx_foreign TEXT NOT NULL,
    tx_id TEXT NOT NULL,
    vout INTEGER NOT NULL,
    sig_script TEXT NOT NULL,
    sequence INTEGER NOT NULL,
    index INTEGER NOT NULL,
    btc_tx_hash TEXT NOT NULL,
    btc_tx_hexbytes TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainToken
CREATE TABLE IF NOT EXISTS m_eee_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_price TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTx
CREATE TABLE IF NOT EXISTS m_eee_chain_tx (  
    -- TxShared start
    tx_hash TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    block_number TEXT NOT NULL,
    signer TEXT NOT NULL,
    tx_bytes TEXT NOT NULL,
    tx_timestamp INTEGER NOT NULL,
    -- TxShared end

    wallet_account TEXT NOT NULL,
    from_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    value TEXT NOT NULL,
    status BOOLEAN NOT NULL,
    extension TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeTokenxTx
CREATE TABLE IF NOT EXISTS m_eee_tokenx_tx (  
    -- TxShared start
    tx_hash TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    block_number TEXT NOT NULL,
    signer TEXT NOT NULL,
    tx_bytes TEXT NOT NULL,
    tx_timestamp INTEGER NOT NULL,
    -- TxShared end

    wallet_account TEXT NOT NULL,
    from_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    value TEXT NOT NULL,
    status BOOLEAN NOT NULL,
    extension TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainToken
CREATE TABLE IF NOT EXISTS m_eth_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    contract_address TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
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
-- MEthErc20Tx
CREATE TABLE IF NOT EXISTS m_eth_erc20_tx (  
    eth_chain_tx_id TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    token TEXT NOT NULL,
    erc20_face TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MLocalTxLog
CREATE TABLE IF NOT EXISTS m_local_tx_log (  
    address_from TEXT NOT NULL,
    address_to TEXT NOT NULL,
    value TEXT NOT NULL,
    status TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MProgress
CREATE TABLE IF NOT EXISTS m_progress (  
    header TEXT NOT NULL,
    timestamp TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MSubChainBasicInfo
CREATE TABLE IF NOT EXISTS m_sub_chain_basic_info (  
    genesis_hash TEXT NOT NULL,
    metadata TEXT NOT NULL,
    runtime_version INTEGER NOT NULL,
    tx_version INTEGER NOT NULL,
    ss58_format_prefix INTEGER NOT NULL,
    token_decimals INTEGER NOT NULL,
    token_symbol TEXT NOT NULL,
    is_default INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MTokenAddress
CREATE TABLE IF NOT EXISTS m_token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    status INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MUserAddress
CREATE TABLE IF NOT EXISTS m_user_address (  
    address TEXT NOT NULL,
    compressed_pub_key TEXT NOT NULL,
    verify TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAccountInfoSyncProg
CREATE TABLE IF NOT EXISTS m_account_info_sync_prog (  
    account TEXT NOT NULL,
    block_no TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainToken
CREATE TABLE IF NOT EXISTS m_btc_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenAuth
CREATE TABLE IF NOT EXISTS m_btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenDefault
CREATE TABLE IF NOT EXISTS m_btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
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
-- MBtcInputTx
CREATE TABLE IF NOT EXISTS m_btc_input_tx (  
    btc_chain_tx_foreign TEXT NOT NULL,
    tx_id TEXT NOT NULL,
    vout INTEGER NOT NULL,
    sig_script TEXT NOT NULL,
    sequence INTEGER NOT NULL,
    index INTEGER NOT NULL,
    btc_tx_hash TEXT NOT NULL,
    btc_tx_hexbytes TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcOutputTx
CREATE TABLE IF NOT EXISTS m_btc_output_tx (  
    btc_chain_tx_foreign TEXT NOT NULL,
    value INTEGER NOT NULL,
    pk_script TEXT NOT NULL,
    index INTEGER NOT NULL,
    btc_tx_hash TEXT NOT NULL,
    btc_tx_hexbytes TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainToken
CREATE TABLE IF NOT EXISTS m_eee_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_price TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTx
CREATE TABLE IF NOT EXISTS m_eee_chain_tx (  
    -- TxShared start
    tx_hash TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    block_number TEXT NOT NULL,
    signer TEXT NOT NULL,
    tx_bytes TEXT NOT NULL,
    tx_timestamp INTEGER NOT NULL,
    -- TxShared end

    wallet_account TEXT NOT NULL,
    from_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    value TEXT NOT NULL,
    status BOOLEAN NOT NULL,
    extension TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeTokenxTx
CREATE TABLE IF NOT EXISTS m_eee_tokenx_tx (  
    -- TxShared start
    tx_hash TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    block_number TEXT NOT NULL,
    signer TEXT NOT NULL,
    tx_bytes TEXT NOT NULL,
    tx_timestamp INTEGER NOT NULL,
    -- TxShared end

    wallet_account TEXT NOT NULL,
    from_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    value TEXT NOT NULL,
    status BOOLEAN NOT NULL,
    extension TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainToken
CREATE TABLE IF NOT EXISTS m_eth_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    contract_address TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
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
-- MEthErc20Tx
CREATE TABLE IF NOT EXISTS m_eth_erc20_tx (  
    eth_chain_tx_id TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    token TEXT NOT NULL,
    erc20_face TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MLocalTxLog
CREATE TABLE IF NOT EXISTS m_local_tx_log (  
    address_from TEXT NOT NULL,
    address_to TEXT NOT NULL,
    value TEXT NOT NULL,
    status TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MProgress
CREATE TABLE IF NOT EXISTS m_progress (  
    header TEXT NOT NULL,
    timestamp TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MSubChainBasicInfo
CREATE TABLE IF NOT EXISTS m_sub_chain_basic_info (  
    genesis_hash TEXT NOT NULL,
    metadata TEXT NOT NULL,
    runtime_version INTEGER NOT NULL,
    tx_version INTEGER NOT NULL,
    ss58_format_prefix INTEGER NOT NULL,
    token_decimals INTEGER NOT NULL,
    token_symbol TEXT NOT NULL,
    is_default INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MTokenAddress
CREATE TABLE IF NOT EXISTS m_token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    status INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MUserAddress
CREATE TABLE IF NOT EXISTS m_user_address (  
    address TEXT NOT NULL,
    compressed_pub_key TEXT NOT NULL,
    verify TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAccountInfoSyncProg
CREATE TABLE IF NOT EXISTS m_account_info_sync_prog (  
    account TEXT NOT NULL,
    block_no TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBlockHeader
CREATE TABLE IF NOT EXISTS m_block_header (  
    header TEXT NOT NULL,
    scanned TEXT NOT NULL,
    timestamp TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainToken
CREATE TABLE IF NOT EXISTS m_btc_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenAuth
CREATE TABLE IF NOT EXISTS m_btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenDefault
CREATE TABLE IF NOT EXISTS m_btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
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
-- MBtcInputTx
CREATE TABLE IF NOT EXISTS m_btc_input_tx (  
    btc_chain_tx_foreign TEXT NOT NULL,
    tx_id TEXT NOT NULL,
    vout INTEGER NOT NULL,
    sig_script TEXT NOT NULL,
    sequence INTEGER NOT NULL,
    index INTEGER NOT NULL,
    btc_tx_hash TEXT NOT NULL,
    btc_tx_hexbytes TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcOutputTx
CREATE TABLE IF NOT EXISTS m_btc_output_tx (  
    btc_chain_tx_foreign TEXT NOT NULL,
    value INTEGER NOT NULL,
    pk_script TEXT NOT NULL,
    index INTEGER NOT NULL,
    btc_tx_hash TEXT NOT NULL,
    btc_tx_hexbytes TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainToken
CREATE TABLE IF NOT EXISTS m_eee_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_price TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTx
CREATE TABLE IF NOT EXISTS m_eee_chain_tx (  
    -- TxShared start
    tx_hash TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    block_number TEXT NOT NULL,
    signer TEXT NOT NULL,
    tx_bytes TEXT NOT NULL,
    tx_timestamp INTEGER NOT NULL,
    -- TxShared end

    wallet_account TEXT NOT NULL,
    from_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    value TEXT NOT NULL,
    status BOOLEAN NOT NULL,
    extension TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeTokenxTx
CREATE TABLE IF NOT EXISTS m_eee_tokenx_tx (  
    -- TxShared start
    tx_hash TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    block_number TEXT NOT NULL,
    signer TEXT NOT NULL,
    tx_bytes TEXT NOT NULL,
    tx_timestamp INTEGER NOT NULL,
    -- TxShared end

    wallet_account TEXT NOT NULL,
    from_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    value TEXT NOT NULL,
    status BOOLEAN NOT NULL,
    extension TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainToken
CREATE TABLE IF NOT EXISTS m_eth_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    contract_address TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
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
-- MEthErc20Tx
CREATE TABLE IF NOT EXISTS m_eth_erc20_tx (  
    eth_chain_tx_id TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    token TEXT NOT NULL,
    erc20_face TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MLocalTxLog
CREATE TABLE IF NOT EXISTS m_local_tx_log (  
    address_from TEXT NOT NULL,
    address_to TEXT NOT NULL,
    value TEXT NOT NULL,
    status TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MProgress
CREATE TABLE IF NOT EXISTS m_progress (  
    header TEXT NOT NULL,
    timestamp TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MSubChainBasicInfo
CREATE TABLE IF NOT EXISTS m_sub_chain_basic_info (  
    genesis_hash TEXT NOT NULL,
    metadata TEXT NOT NULL,
    runtime_version INTEGER NOT NULL,
    tx_version INTEGER NOT NULL,
    ss58_format_prefix INTEGER NOT NULL,
    token_decimals INTEGER NOT NULL,
    token_symbol TEXT NOT NULL,
    is_default INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MTokenAddress
CREATE TABLE IF NOT EXISTS m_token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    status INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MUserAddress
CREATE TABLE IF NOT EXISTS m_user_address (  
    address TEXT NOT NULL,
    compressed_pub_key TEXT NOT NULL,
    verify TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAccountInfoSyncProg
CREATE TABLE IF NOT EXISTS m_account_info_sync_prog (  
    account TEXT NOT NULL,
    block_no TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MAddress
CREATE TABLE IF NOT EXISTS m_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBlockHeader
CREATE TABLE IF NOT EXISTS m_block_header (  
    header TEXT NOT NULL,
    scanned TEXT NOT NULL,
    timestamp TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainToken
CREATE TABLE IF NOT EXISTS m_btc_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenAuth
CREATE TABLE IF NOT EXISTS m_btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenDefault
CREATE TABLE IF NOT EXISTS m_btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
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
-- MBtcInputTx
CREATE TABLE IF NOT EXISTS m_btc_input_tx (  
    btc_chain_tx_foreign TEXT NOT NULL,
    tx_id TEXT NOT NULL,
    vout INTEGER NOT NULL,
    sig_script TEXT NOT NULL,
    sequence INTEGER NOT NULL,
    index INTEGER NOT NULL,
    btc_tx_hash TEXT NOT NULL,
    btc_tx_hexbytes TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcOutputTx
CREATE TABLE IF NOT EXISTS m_btc_output_tx (  
    btc_chain_tx_foreign TEXT NOT NULL,
    value INTEGER NOT NULL,
    pk_script TEXT NOT NULL,
    index INTEGER NOT NULL,
    btc_tx_hash TEXT NOT NULL,
    btc_tx_hexbytes TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MChainTypeMeta
CREATE TABLE IF NOT EXISTS m_chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainToken
CREATE TABLE IF NOT EXISTS m_eee_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_price TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTx
CREATE TABLE IF NOT EXISTS m_eee_chain_tx (  
    -- TxShared start
    tx_hash TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    block_number TEXT NOT NULL,
    signer TEXT NOT NULL,
    tx_bytes TEXT NOT NULL,
    tx_timestamp INTEGER NOT NULL,
    -- TxShared end

    wallet_account TEXT NOT NULL,
    from_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    value TEXT NOT NULL,
    status BOOLEAN NOT NULL,
    extension TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeTokenxTx
CREATE TABLE IF NOT EXISTS m_eee_tokenx_tx (  
    -- TxShared start
    tx_hash TEXT NOT NULL,
    block_hash TEXT NOT NULL,
    block_number TEXT NOT NULL,
    signer TEXT NOT NULL,
    tx_bytes TEXT NOT NULL,
    tx_timestamp INTEGER NOT NULL,
    -- TxShared end

    wallet_account TEXT NOT NULL,
    from_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    value TEXT NOT NULL,
    status BOOLEAN NOT NULL,
    extension TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainToken
CREATE TABLE IF NOT EXISTS m_eth_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT NOT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    net_type TEXT NOT NULL,
    position INTEGER NOT NULL,
    contract_address TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project_name TEXT NOT NULL,
    project_home TEXT NOT NULL,
    project_note TEXT NOT NULL,
    -- MTokenShared end

    token_type TEXT NOT NULL,
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
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
-- MEthErc20Tx
CREATE TABLE IF NOT EXISTS m_eth_erc20_tx (  
    eth_chain_tx_id TEXT NOT NULL,
    contract_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    token TEXT NOT NULL,
    erc20_face TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MLocalTxLog
CREATE TABLE IF NOT EXISTS m_local_tx_log (  
    address_from TEXT NOT NULL,
    address_to TEXT NOT NULL,
    value TEXT NOT NULL,
    status TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MMnemonic
CREATE TABLE IF NOT EXISTS m_mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MProgress
CREATE TABLE IF NOT EXISTS m_progress (  
    header TEXT NOT NULL,
    timestamp TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MSetting
CREATE TABLE IF NOT EXISTS m_setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MSubChainBasicInfo
CREATE TABLE IF NOT EXISTS m_sub_chain_basic_info (  
    genesis_hash TEXT NOT NULL,
    metadata TEXT NOT NULL,
    runtime_version INTEGER NOT NULL,
    tx_version INTEGER NOT NULL,
    ss58_format_prefix INTEGER NOT NULL,
    token_decimals INTEGER NOT NULL,
    token_symbol TEXT NOT NULL,
    is_default INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MTokenAddress
CREATE TABLE IF NOT EXISTS m_token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    status INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MUserAddress
CREATE TABLE IF NOT EXISTS m_user_address (  
    address TEXT NOT NULL,
    compressed_pub_key TEXT NOT NULL,
    verify TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MWallet
CREATE TABLE IF NOT EXISTS m_wallet (  
    next_id TEXT NOT NULL,
    name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
