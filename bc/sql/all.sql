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
-- MSetting
CREATE TABLE IF NOT EXISTS m_setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
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
-- MSetting
CREATE TABLE IF NOT EXISTS m_setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
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
-- MSetting
CREATE TABLE IF NOT EXISTS m_setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
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
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

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
-- MSetting
CREATE TABLE IF NOT EXISTS m_setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
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
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

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
-- MSetting
CREATE TABLE IF NOT EXISTS m_setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
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
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

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
-- MSetting
CREATE TABLE IF NOT EXISTS m_setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
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
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

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
-- MSetting
CREATE TABLE IF NOT EXISTS m_setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
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
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

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
-- MSetting
CREATE TABLE IF NOT EXISTS m_setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
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
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

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
-- MSetting
CREATE TABLE IF NOT EXISTS m_setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
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
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

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
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

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
-- MSetting
CREATE TABLE IF NOT EXISTS m_setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
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
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

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
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

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
-- MSetting
CREATE TABLE IF NOT EXISTS m_setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
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
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenDefault
CREATE TABLE IF NOT EXISTS m_btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

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
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

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
-- MSetting
CREATE TABLE IF NOT EXISTS m_setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
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
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenDefault
CREATE TABLE IF NOT EXISTS m_btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

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
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

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
-- MSetting
CREATE TABLE IF NOT EXISTS m_setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
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
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenDefault
CREATE TABLE IF NOT EXISTS m_btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

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
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

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
-- MSetting
CREATE TABLE IF NOT EXISTS m_setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
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
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenDefault
CREATE TABLE IF NOT EXISTS m_btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

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
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

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
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

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
-- MSetting
CREATE TABLE IF NOT EXISTS m_setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
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
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenDefault
CREATE TABLE IF NOT EXISTS m_btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

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
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

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
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

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
    tx_bytes TEXT NOT NULL,
    -- TxShared end

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
-- MSetting
CREATE TABLE IF NOT EXISTS m_setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
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
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenDefault
CREATE TABLE IF NOT EXISTS m_btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

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
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

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
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

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
    tx_bytes TEXT NOT NULL,
    -- TxShared end

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
-- MSetting
CREATE TABLE IF NOT EXISTS m_setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
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
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenDefault
CREATE TABLE IF NOT EXISTS m_btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

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
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

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
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

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
    tx_bytes TEXT NOT NULL,
    -- TxShared end

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
-- MSetting
CREATE TABLE IF NOT EXISTS m_setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
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
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenDefault
CREATE TABLE IF NOT EXISTS m_btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

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
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

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
    tx_bytes TEXT NOT NULL,
    -- TxShared end

    from_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    value TEXT NOT NULL,
    status TEXT NOT NULL,
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
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

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
    tx_bytes TEXT NOT NULL,
    -- TxShared end

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
-- MSetting
CREATE TABLE IF NOT EXISTS m_setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
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
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenDefault
CREATE TABLE IF NOT EXISTS m_btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

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
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

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
    tx_bytes TEXT NOT NULL,
    -- TxShared end

    from_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    value TEXT NOT NULL,
    status TEXT NOT NULL,
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
    tx_bytes TEXT NOT NULL,
    -- TxShared end

    from_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    value TEXT NOT NULL,
    status TEXT NOT NULL,
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
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

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
    tx_bytes TEXT NOT NULL,
    -- TxShared end

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
-- MSetting
CREATE TABLE IF NOT EXISTS m_setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
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
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenDefault
CREATE TABLE IF NOT EXISTS m_btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

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
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

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
    tx_bytes TEXT NOT NULL,
    -- TxShared end

    from_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    value TEXT NOT NULL,
    status TEXT NOT NULL,
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
    tx_bytes TEXT NOT NULL,
    -- TxShared end

    from_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    value TEXT NOT NULL,
    status TEXT NOT NULL,
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
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

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
    tx_bytes TEXT NOT NULL,
    -- TxShared end

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
-- MSetting
CREATE TABLE IF NOT EXISTS m_setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
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
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenDefault
CREATE TABLE IF NOT EXISTS m_btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

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
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

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
    tx_bytes TEXT NOT NULL,
    -- TxShared end

    from_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    value TEXT NOT NULL,
    status TEXT NOT NULL,
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
    tx_bytes TEXT NOT NULL,
    -- TxShared end

    from_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    value TEXT NOT NULL,
    status TEXT NOT NULL,
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
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

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
    tx_bytes TEXT NOT NULL,
    -- TxShared end

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
-- MSetting
CREATE TABLE IF NOT EXISTS m_setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
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
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenDefault
CREATE TABLE IF NOT EXISTS m_btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

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
-- MBtcInputTx
CREATE TABLE IF NOT EXISTS m_btc_input_tx (  
    btc_chain_tx_id TEXT NOT NULL,
    tx_index INTEGER NOT NULL,
    address TEXT NOT NULL,
    pk_script TEXT NOT NULL,
    sig_script TEXT NOT NULL,
    value TEXT NOT NULL,
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
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

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
    tx_bytes TEXT NOT NULL,
    -- TxShared end

    from_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    value TEXT NOT NULL,
    status TEXT NOT NULL,
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
    tx_bytes TEXT NOT NULL,
    -- TxShared end

    from_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    value TEXT NOT NULL,
    status TEXT NOT NULL,
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
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

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
    tx_bytes TEXT NOT NULL,
    -- TxShared end

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
-- MSetting
CREATE TABLE IF NOT EXISTS m_setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
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
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenDefault
CREATE TABLE IF NOT EXISTS m_btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcChainTokenShared
CREATE TABLE IF NOT EXISTS m_btc_chain_token_shared (  
    -- MTokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

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
-- MBtcInputTx
CREATE TABLE IF NOT EXISTS m_btc_input_tx (  
    btc_chain_tx_id TEXT NOT NULL,
    tx_index INTEGER NOT NULL,
    address TEXT NOT NULL,
    pk_script TEXT NOT NULL,
    sig_script TEXT NOT NULL,
    value TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MBtcOutputTx
CREATE TABLE IF NOT EXISTS m_btc_output_tx (  
    btc_chain_tx_id TEXT NOT NULL,
    tx_index INTEGER NOT NULL,
    address TEXT NOT NULL,
    pk_script TEXT NOT NULL,
    value TEXT NOT NULL,
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
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEeeChainTokenShared
CREATE TABLE IF NOT EXISTS m_eee_chain_token_shared (  
    -- MTokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

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
    tx_bytes TEXT NOT NULL,
    -- TxShared end

    from_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    value TEXT NOT NULL,
    status TEXT NOT NULL,
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
    tx_bytes TEXT NOT NULL,
    -- TxShared end

    from_address TEXT NOT NULL,
    to_address TEXT NOT NULL,
    value TEXT NOT NULL,
    status TEXT NOT NULL,
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
    gas_limit INTEGER NOT NULL,
    gas_price TEXT NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenAuth
CREATE TABLE IF NOT EXISTS m_eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenDefault
CREATE TABLE IF NOT EXISTS m_eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- MEthChainTokenShared
CREATE TABLE IF NOT EXISTS m_eth_chain_token_shared (  
    -- MTokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT NOT NULL,
    logo_bytes TEXT NOT NULL,
    project TEXT NOT NULL,
    auth BOOLEAN NOT NULL,
    -- MTokenShared end

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
    tx_bytes TEXT NOT NULL,
    -- TxShared end

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
-- MSetting
CREATE TABLE IF NOT EXISTS m_setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
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
