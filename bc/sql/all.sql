-- Mnemonic
CREATE TABLE IF NOT EXISTS mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Address
CREATE TABLE IF NOT EXISTS address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- ChainTypeMeta
CREATE TABLE IF NOT EXISTS chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Mnemonic
CREATE TABLE IF NOT EXISTS mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Setting
CREATE TABLE IF NOT EXISTS setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Wallet
CREATE TABLE IF NOT EXISTS wallet (  
    next_id TEXT NOT NULL,
    full_name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Mnemonic
CREATE TABLE IF NOT EXISTS mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Address
CREATE TABLE IF NOT EXISTS address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- ChainTypeMeta
CREATE TABLE IF NOT EXISTS chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Mnemonic
CREATE TABLE IF NOT EXISTS mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Setting
CREATE TABLE IF NOT EXISTS setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Wallet
CREATE TABLE IF NOT EXISTS wallet (  
    next_id TEXT NOT NULL,
    full_name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Mnemonic
CREATE TABLE IF NOT EXISTS mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Wallet
CREATE TABLE IF NOT EXISTS wallet (  
    next_id TEXT NOT NULL,
    full_name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Address
CREATE TABLE IF NOT EXISTS address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- ChainTypeMeta
CREATE TABLE IF NOT EXISTS chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenShared
CREATE TABLE IF NOT EXISTS eth_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Mnemonic
CREATE TABLE IF NOT EXISTS mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Setting
CREATE TABLE IF NOT EXISTS setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Wallet
CREATE TABLE IF NOT EXISTS wallet (  
    next_id TEXT NOT NULL,
    full_name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- ChainTypeMeta
CREATE TABLE IF NOT EXISTS chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Mnemonic
CREATE TABLE IF NOT EXISTS mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Wallet
CREATE TABLE IF NOT EXISTS wallet (  
    next_id TEXT NOT NULL,
    full_name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Address
CREATE TABLE IF NOT EXISTS address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- ChainTypeMeta
CREATE TABLE IF NOT EXISTS chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenAuth
CREATE TABLE IF NOT EXISTS eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenShared
CREATE TABLE IF NOT EXISTS eth_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Mnemonic
CREATE TABLE IF NOT EXISTS mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Setting
CREATE TABLE IF NOT EXISTS setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Wallet
CREATE TABLE IF NOT EXISTS wallet (  
    next_id TEXT NOT NULL,
    full_name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Address
CREATE TABLE IF NOT EXISTS address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- ChainTypeMeta
CREATE TABLE IF NOT EXISTS chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Mnemonic
CREATE TABLE IF NOT EXISTS mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Wallet
CREATE TABLE IF NOT EXISTS wallet (  
    next_id TEXT NOT NULL,
    full_name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Address
CREATE TABLE IF NOT EXISTS address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- ChainTypeMeta
CREATE TABLE IF NOT EXISTS chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenAuth
CREATE TABLE IF NOT EXISTS eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenDefault
CREATE TABLE IF NOT EXISTS eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenShared
CREATE TABLE IF NOT EXISTS eth_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Mnemonic
CREATE TABLE IF NOT EXISTS mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Setting
CREATE TABLE IF NOT EXISTS setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Wallet
CREATE TABLE IF NOT EXISTS wallet (  
    next_id TEXT NOT NULL,
    full_name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Address
CREATE TABLE IF NOT EXISTS address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- ChainTypeMeta
CREATE TABLE IF NOT EXISTS chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenShared
CREATE TABLE IF NOT EXISTS eee_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenAuth
CREATE TABLE IF NOT EXISTS eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenDefault
CREATE TABLE IF NOT EXISTS eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenShared
CREATE TABLE IF NOT EXISTS eth_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Mnemonic
CREATE TABLE IF NOT EXISTS mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Setting
CREATE TABLE IF NOT EXISTS setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Wallet
CREATE TABLE IF NOT EXISTS wallet (  
    next_id TEXT NOT NULL,
    full_name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Address
CREATE TABLE IF NOT EXISTS address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- ChainTypeMeta
CREATE TABLE IF NOT EXISTS chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Mnemonic
CREATE TABLE IF NOT EXISTS mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Setting
CREATE TABLE IF NOT EXISTS setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Wallet
CREATE TABLE IF NOT EXISTS wallet (  
    next_id TEXT NOT NULL,
    full_name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Address
CREATE TABLE IF NOT EXISTS address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- ChainTypeMeta
CREATE TABLE IF NOT EXISTS chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenAuth
CREATE TABLE IF NOT EXISTS eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenShared
CREATE TABLE IF NOT EXISTS eee_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenAuth
CREATE TABLE IF NOT EXISTS eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenDefault
CREATE TABLE IF NOT EXISTS eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenShared
CREATE TABLE IF NOT EXISTS eth_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Mnemonic
CREATE TABLE IF NOT EXISTS mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Setting
CREATE TABLE IF NOT EXISTS setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Wallet
CREATE TABLE IF NOT EXISTS wallet (  
    next_id TEXT NOT NULL,
    full_name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Address
CREATE TABLE IF NOT EXISTS address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- ChainTypeMeta
CREATE TABLE IF NOT EXISTS chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Mnemonic
CREATE TABLE IF NOT EXISTS mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Setting
CREATE TABLE IF NOT EXISTS setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Wallet
CREATE TABLE IF NOT EXISTS wallet (  
    next_id TEXT NOT NULL,
    full_name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Address
CREATE TABLE IF NOT EXISTS address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- ChainTypeMeta
CREATE TABLE IF NOT EXISTS chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenAuth
CREATE TABLE IF NOT EXISTS eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenDefault
CREATE TABLE IF NOT EXISTS eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenShared
CREATE TABLE IF NOT EXISTS eee_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenAuth
CREATE TABLE IF NOT EXISTS eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenDefault
CREATE TABLE IF NOT EXISTS eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenShared
CREATE TABLE IF NOT EXISTS eth_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Mnemonic
CREATE TABLE IF NOT EXISTS mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Setting
CREATE TABLE IF NOT EXISTS setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Wallet
CREATE TABLE IF NOT EXISTS wallet (  
    next_id TEXT NOT NULL,
    full_name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Address
CREATE TABLE IF NOT EXISTS address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- ChainTypeMeta
CREATE TABLE IF NOT EXISTS chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenShared
CREATE TABLE IF NOT EXISTS eth_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Mnemonic
CREATE TABLE IF NOT EXISTS mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Setting
CREATE TABLE IF NOT EXISTS setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Wallet
CREATE TABLE IF NOT EXISTS wallet (  
    next_id TEXT NOT NULL,
    full_name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Address
CREATE TABLE IF NOT EXISTS address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenShared
CREATE TABLE IF NOT EXISTS btc_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- ChainTypeMeta
CREATE TABLE IF NOT EXISTS chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenAuth
CREATE TABLE IF NOT EXISTS eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenDefault
CREATE TABLE IF NOT EXISTS eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenShared
CREATE TABLE IF NOT EXISTS eee_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenAuth
CREATE TABLE IF NOT EXISTS eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenDefault
CREATE TABLE IF NOT EXISTS eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenShared
CREATE TABLE IF NOT EXISTS eth_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Mnemonic
CREATE TABLE IF NOT EXISTS mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Setting
CREATE TABLE IF NOT EXISTS setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Wallet
CREATE TABLE IF NOT EXISTS wallet (  
    next_id TEXT NOT NULL,
    full_name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Address
CREATE TABLE IF NOT EXISTS address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- ChainTypeMeta
CREATE TABLE IF NOT EXISTS chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenAuth
CREATE TABLE IF NOT EXISTS eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenShared
CREATE TABLE IF NOT EXISTS eth_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Mnemonic
CREATE TABLE IF NOT EXISTS mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Setting
CREATE TABLE IF NOT EXISTS setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Wallet
CREATE TABLE IF NOT EXISTS wallet (  
    next_id TEXT NOT NULL,
    full_name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Address
CREATE TABLE IF NOT EXISTS address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenAuth
CREATE TABLE IF NOT EXISTS btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenShared
CREATE TABLE IF NOT EXISTS btc_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- ChainTypeMeta
CREATE TABLE IF NOT EXISTS chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenAuth
CREATE TABLE IF NOT EXISTS eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenDefault
CREATE TABLE IF NOT EXISTS eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenShared
CREATE TABLE IF NOT EXISTS eee_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenAuth
CREATE TABLE IF NOT EXISTS eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenDefault
CREATE TABLE IF NOT EXISTS eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenShared
CREATE TABLE IF NOT EXISTS eth_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Mnemonic
CREATE TABLE IF NOT EXISTS mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Setting
CREATE TABLE IF NOT EXISTS setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Wallet
CREATE TABLE IF NOT EXISTS wallet (  
    next_id TEXT NOT NULL,
    full_name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Address
CREATE TABLE IF NOT EXISTS address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- ChainTypeMeta
CREATE TABLE IF NOT EXISTS chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenAuth
CREATE TABLE IF NOT EXISTS eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenDefault
CREATE TABLE IF NOT EXISTS eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenShared
CREATE TABLE IF NOT EXISTS eth_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Mnemonic
CREATE TABLE IF NOT EXISTS mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Setting
CREATE TABLE IF NOT EXISTS setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Wallet
CREATE TABLE IF NOT EXISTS wallet (  
    next_id TEXT NOT NULL,
    full_name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Address
CREATE TABLE IF NOT EXISTS address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenAuth
CREATE TABLE IF NOT EXISTS btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenDefault
CREATE TABLE IF NOT EXISTS btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenShared
CREATE TABLE IF NOT EXISTS btc_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- ChainTypeMeta
CREATE TABLE IF NOT EXISTS chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenAuth
CREATE TABLE IF NOT EXISTS eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenDefault
CREATE TABLE IF NOT EXISTS eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenShared
CREATE TABLE IF NOT EXISTS eee_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenAuth
CREATE TABLE IF NOT EXISTS eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenDefault
CREATE TABLE IF NOT EXISTS eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenShared
CREATE TABLE IF NOT EXISTS eth_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Mnemonic
CREATE TABLE IF NOT EXISTS mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Setting
CREATE TABLE IF NOT EXISTS setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Wallet
CREATE TABLE IF NOT EXISTS wallet (  
    next_id TEXT NOT NULL,
    full_name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Address
CREATE TABLE IF NOT EXISTS address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- ChainTypeMeta
CREATE TABLE IF NOT EXISTS chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenShared
CREATE TABLE IF NOT EXISTS eee_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenAuth
CREATE TABLE IF NOT EXISTS eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenDefault
CREATE TABLE IF NOT EXISTS eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenShared
CREATE TABLE IF NOT EXISTS eth_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Mnemonic
CREATE TABLE IF NOT EXISTS mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Setting
CREATE TABLE IF NOT EXISTS setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Wallet
CREATE TABLE IF NOT EXISTS wallet (  
    next_id TEXT NOT NULL,
    full_name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Address
CREATE TABLE IF NOT EXISTS address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- ChainTypeMeta
CREATE TABLE IF NOT EXISTS chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenAuth
CREATE TABLE IF NOT EXISTS eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenShared
CREATE TABLE IF NOT EXISTS eee_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenAuth
CREATE TABLE IF NOT EXISTS eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenDefault
CREATE TABLE IF NOT EXISTS eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenShared
CREATE TABLE IF NOT EXISTS eth_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Mnemonic
CREATE TABLE IF NOT EXISTS mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Setting
CREATE TABLE IF NOT EXISTS setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Wallet
CREATE TABLE IF NOT EXISTS wallet (  
    next_id TEXT NOT NULL,
    full_name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Address
CREATE TABLE IF NOT EXISTS address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenAuth
CREATE TABLE IF NOT EXISTS btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenDefault
CREATE TABLE IF NOT EXISTS btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenShared
CREATE TABLE IF NOT EXISTS btc_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- ChainTypeMeta
CREATE TABLE IF NOT EXISTS chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenAuth
CREATE TABLE IF NOT EXISTS eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenDefault
CREATE TABLE IF NOT EXISTS eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenShared
CREATE TABLE IF NOT EXISTS eee_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenAuth
CREATE TABLE IF NOT EXISTS eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenDefault
CREATE TABLE IF NOT EXISTS eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenShared
CREATE TABLE IF NOT EXISTS eth_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Mnemonic
CREATE TABLE IF NOT EXISTS mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Setting
CREATE TABLE IF NOT EXISTS setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- TokenAddress
CREATE TABLE IF NOT EXISTS token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Wallet
CREATE TABLE IF NOT EXISTS wallet (  
    next_id TEXT NOT NULL,
    full_name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Address
CREATE TABLE IF NOT EXISTS address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- ChainTypeMeta
CREATE TABLE IF NOT EXISTS chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenAuth
CREATE TABLE IF NOT EXISTS eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenDefault
CREATE TABLE IF NOT EXISTS eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenShared
CREATE TABLE IF NOT EXISTS eee_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenAuth
CREATE TABLE IF NOT EXISTS eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenDefault
CREATE TABLE IF NOT EXISTS eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenShared
CREATE TABLE IF NOT EXISTS eth_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Mnemonic
CREATE TABLE IF NOT EXISTS mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Setting
CREATE TABLE IF NOT EXISTS setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Wallet
CREATE TABLE IF NOT EXISTS wallet (  
    next_id TEXT NOT NULL,
    full_name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Address
CREATE TABLE IF NOT EXISTS address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenAuth
CREATE TABLE IF NOT EXISTS btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenDefault
CREATE TABLE IF NOT EXISTS btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenShared
CREATE TABLE IF NOT EXISTS btc_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- ChainTypeMeta
CREATE TABLE IF NOT EXISTS chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenAuth
CREATE TABLE IF NOT EXISTS eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenDefault
CREATE TABLE IF NOT EXISTS eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenShared
CREATE TABLE IF NOT EXISTS eee_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenAuth
CREATE TABLE IF NOT EXISTS eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenDefault
CREATE TABLE IF NOT EXISTS eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenShared
CREATE TABLE IF NOT EXISTS eth_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Mnemonic
CREATE TABLE IF NOT EXISTS mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Setting
CREATE TABLE IF NOT EXISTS setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- TokenAddress
CREATE TABLE IF NOT EXISTS token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Wallet
CREATE TABLE IF NOT EXISTS wallet (  
    next_id TEXT NOT NULL,
    full_name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Address
CREATE TABLE IF NOT EXISTS address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenShared
CREATE TABLE IF NOT EXISTS btc_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- ChainTypeMeta
CREATE TABLE IF NOT EXISTS chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenAuth
CREATE TABLE IF NOT EXISTS eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenDefault
CREATE TABLE IF NOT EXISTS eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenShared
CREATE TABLE IF NOT EXISTS eee_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenAuth
CREATE TABLE IF NOT EXISTS eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenDefault
CREATE TABLE IF NOT EXISTS eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenShared
CREATE TABLE IF NOT EXISTS eth_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Mnemonic
CREATE TABLE IF NOT EXISTS mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Setting
CREATE TABLE IF NOT EXISTS setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Wallet
CREATE TABLE IF NOT EXISTS wallet (  
    next_id TEXT NOT NULL,
    full_name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Address
CREATE TABLE IF NOT EXISTS address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenAuth
CREATE TABLE IF NOT EXISTS btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenDefault
CREATE TABLE IF NOT EXISTS btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenShared
CREATE TABLE IF NOT EXISTS btc_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- ChainTypeMeta
CREATE TABLE IF NOT EXISTS chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenAuth
CREATE TABLE IF NOT EXISTS eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenDefault
CREATE TABLE IF NOT EXISTS eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenShared
CREATE TABLE IF NOT EXISTS eee_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainToken
CREATE TABLE IF NOT EXISTS eth_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT DEFAULT NULL,
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
-- EthChainTokenAuth
CREATE TABLE IF NOT EXISTS eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenDefault
CREATE TABLE IF NOT EXISTS eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenShared
CREATE TABLE IF NOT EXISTS eth_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Mnemonic
CREATE TABLE IF NOT EXISTS mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Setting
CREATE TABLE IF NOT EXISTS setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- TokenAddress
CREATE TABLE IF NOT EXISTS token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Wallet
CREATE TABLE IF NOT EXISTS wallet (  
    next_id TEXT NOT NULL,
    full_name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Address
CREATE TABLE IF NOT EXISTS address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenAuth
CREATE TABLE IF NOT EXISTS btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenShared
CREATE TABLE IF NOT EXISTS btc_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- ChainTypeMeta
CREATE TABLE IF NOT EXISTS chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenAuth
CREATE TABLE IF NOT EXISTS eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenDefault
CREATE TABLE IF NOT EXISTS eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenShared
CREATE TABLE IF NOT EXISTS eee_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenAuth
CREATE TABLE IF NOT EXISTS eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenDefault
CREATE TABLE IF NOT EXISTS eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenShared
CREATE TABLE IF NOT EXISTS eth_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Mnemonic
CREATE TABLE IF NOT EXISTS mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Setting
CREATE TABLE IF NOT EXISTS setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Wallet
CREATE TABLE IF NOT EXISTS wallet (  
    next_id TEXT NOT NULL,
    full_name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Address
CREATE TABLE IF NOT EXISTS address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenAuth
CREATE TABLE IF NOT EXISTS btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenDefault
CREATE TABLE IF NOT EXISTS btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenShared
CREATE TABLE IF NOT EXISTS btc_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- ChainTypeMeta
CREATE TABLE IF NOT EXISTS chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenAuth
CREATE TABLE IF NOT EXISTS eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenDefault
CREATE TABLE IF NOT EXISTS eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenShared
CREATE TABLE IF NOT EXISTS eee_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenAuth
CREATE TABLE IF NOT EXISTS eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenDefault
CREATE TABLE IF NOT EXISTS eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenShared
CREATE TABLE IF NOT EXISTS eth_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Mnemonic
CREATE TABLE IF NOT EXISTS mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Setting
CREATE TABLE IF NOT EXISTS setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Wallet
CREATE TABLE IF NOT EXISTS wallet (  
    next_id TEXT NOT NULL,
    full_name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Address
CREATE TABLE IF NOT EXISTS address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenAuth
CREATE TABLE IF NOT EXISTS btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenDefault
CREATE TABLE IF NOT EXISTS btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenShared
CREATE TABLE IF NOT EXISTS btc_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- ChainTypeMeta
CREATE TABLE IF NOT EXISTS chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenAuth
CREATE TABLE IF NOT EXISTS eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenDefault
CREATE TABLE IF NOT EXISTS eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenShared
CREATE TABLE IF NOT EXISTS eee_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainToken
CREATE TABLE IF NOT EXISTS eth_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT DEFAULT NULL,
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
-- EthChainTokenAuth
CREATE TABLE IF NOT EXISTS eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenDefault
CREATE TABLE IF NOT EXISTS eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenShared
CREATE TABLE IF NOT EXISTS eth_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTx
CREATE TABLE IF NOT EXISTS eth_chain_tx (  
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
-- Mnemonic
CREATE TABLE IF NOT EXISTS mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Setting
CREATE TABLE IF NOT EXISTS setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- TokenAddress
CREATE TABLE IF NOT EXISTS token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Wallet
CREATE TABLE IF NOT EXISTS wallet (  
    next_id TEXT NOT NULL,
    full_name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Address
CREATE TABLE IF NOT EXISTS address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenAuth
CREATE TABLE IF NOT EXISTS btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenDefault
CREATE TABLE IF NOT EXISTS btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenShared
CREATE TABLE IF NOT EXISTS btc_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- ChainTypeMeta
CREATE TABLE IF NOT EXISTS chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenAuth
CREATE TABLE IF NOT EXISTS eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenDefault
CREATE TABLE IF NOT EXISTS eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenShared
CREATE TABLE IF NOT EXISTS eee_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenAuth
CREATE TABLE IF NOT EXISTS eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenDefault
CREATE TABLE IF NOT EXISTS eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenShared
CREATE TABLE IF NOT EXISTS eth_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Mnemonic
CREATE TABLE IF NOT EXISTS mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Setting
CREATE TABLE IF NOT EXISTS setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- TokenAddress
CREATE TABLE IF NOT EXISTS token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Wallet
CREATE TABLE IF NOT EXISTS wallet (  
    next_id TEXT NOT NULL,
    full_name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Address
CREATE TABLE IF NOT EXISTS address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenAuth
CREATE TABLE IF NOT EXISTS btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenDefault
CREATE TABLE IF NOT EXISTS btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenShared
CREATE TABLE IF NOT EXISTS btc_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- ChainTypeMeta
CREATE TABLE IF NOT EXISTS chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenAuth
CREATE TABLE IF NOT EXISTS eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenDefault
CREATE TABLE IF NOT EXISTS eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenShared
CREATE TABLE IF NOT EXISTS eee_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenAuth
CREATE TABLE IF NOT EXISTS eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenDefault
CREATE TABLE IF NOT EXISTS eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenShared
CREATE TABLE IF NOT EXISTS eth_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Mnemonic
CREATE TABLE IF NOT EXISTS mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Setting
CREATE TABLE IF NOT EXISTS setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- TokenAddress
CREATE TABLE IF NOT EXISTS token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Wallet
CREATE TABLE IF NOT EXISTS wallet (  
    next_id TEXT NOT NULL,
    full_name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Address
CREATE TABLE IF NOT EXISTS address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenAuth
CREATE TABLE IF NOT EXISTS btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenDefault
CREATE TABLE IF NOT EXISTS btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenShared
CREATE TABLE IF NOT EXISTS btc_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- ChainTypeMeta
CREATE TABLE IF NOT EXISTS chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenAuth
CREATE TABLE IF NOT EXISTS eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenDefault
CREATE TABLE IF NOT EXISTS eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenShared
CREATE TABLE IF NOT EXISTS eee_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainToken
CREATE TABLE IF NOT EXISTS eth_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT DEFAULT NULL,
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
-- EthChainTokenAuth
CREATE TABLE IF NOT EXISTS eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenDefault
CREATE TABLE IF NOT EXISTS eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenShared
CREATE TABLE IF NOT EXISTS eth_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTx
CREATE TABLE IF NOT EXISTS eth_chain_tx (  
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
-- Mnemonic
CREATE TABLE IF NOT EXISTS mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Setting
CREATE TABLE IF NOT EXISTS setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- TokenAddress
CREATE TABLE IF NOT EXISTS token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Wallet
CREATE TABLE IF NOT EXISTS wallet (  
    next_id TEXT NOT NULL,
    full_name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Address
CREATE TABLE IF NOT EXISTS address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenAuth
CREATE TABLE IF NOT EXISTS btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenDefault
CREATE TABLE IF NOT EXISTS btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenShared
CREATE TABLE IF NOT EXISTS btc_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- ChainTypeMeta
CREATE TABLE IF NOT EXISTS chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenAuth
CREATE TABLE IF NOT EXISTS eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenDefault
CREATE TABLE IF NOT EXISTS eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenShared
CREATE TABLE IF NOT EXISTS eee_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainToken
CREATE TABLE IF NOT EXISTS eth_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT DEFAULT NULL,
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
-- EthChainTokenAuth
CREATE TABLE IF NOT EXISTS eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenDefault
CREATE TABLE IF NOT EXISTS eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenShared
CREATE TABLE IF NOT EXISTS eth_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Mnemonic
CREATE TABLE IF NOT EXISTS mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Setting
CREATE TABLE IF NOT EXISTS setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- TokenAddress
CREATE TABLE IF NOT EXISTS token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Wallet
CREATE TABLE IF NOT EXISTS wallet (  
    next_id TEXT NOT NULL,
    full_name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Address
CREATE TABLE IF NOT EXISTS address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenAuth
CREATE TABLE IF NOT EXISTS btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenDefault
CREATE TABLE IF NOT EXISTS btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenShared
CREATE TABLE IF NOT EXISTS btc_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- ChainTypeMeta
CREATE TABLE IF NOT EXISTS chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainToken
CREATE TABLE IF NOT EXISTS eee_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT DEFAULT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenAuth
CREATE TABLE IF NOT EXISTS eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenDefault
CREATE TABLE IF NOT EXISTS eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenShared
CREATE TABLE IF NOT EXISTS eee_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainToken
CREATE TABLE IF NOT EXISTS eth_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT DEFAULT NULL,
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
-- EthChainTokenAuth
CREATE TABLE IF NOT EXISTS eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenDefault
CREATE TABLE IF NOT EXISTS eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenShared
CREATE TABLE IF NOT EXISTS eth_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTx
CREATE TABLE IF NOT EXISTS eth_chain_tx (  
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
-- Mnemonic
CREATE TABLE IF NOT EXISTS mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Setting
CREATE TABLE IF NOT EXISTS setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- TokenAddress
CREATE TABLE IF NOT EXISTS token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Wallet
CREATE TABLE IF NOT EXISTS wallet (  
    next_id TEXT NOT NULL,
    full_name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Address
CREATE TABLE IF NOT EXISTS address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenAuth
CREATE TABLE IF NOT EXISTS btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenDefault
CREATE TABLE IF NOT EXISTS btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenShared
CREATE TABLE IF NOT EXISTS btc_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- ChainTypeMeta
CREATE TABLE IF NOT EXISTS chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenAuth
CREATE TABLE IF NOT EXISTS eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenDefault
CREATE TABLE IF NOT EXISTS eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenShared
CREATE TABLE IF NOT EXISTS eee_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainToken
CREATE TABLE IF NOT EXISTS eth_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT DEFAULT NULL,
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
-- EthChainTokenAuth
CREATE TABLE IF NOT EXISTS eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenDefault
CREATE TABLE IF NOT EXISTS eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenShared
CREATE TABLE IF NOT EXISTS eth_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTx
CREATE TABLE IF NOT EXISTS eth_chain_tx (  
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
-- Mnemonic
CREATE TABLE IF NOT EXISTS mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Setting
CREATE TABLE IF NOT EXISTS setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- TokenAddress
CREATE TABLE IF NOT EXISTS token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Wallet
CREATE TABLE IF NOT EXISTS wallet (  
    next_id TEXT NOT NULL,
    full_name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Address
CREATE TABLE IF NOT EXISTS address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenAuth
CREATE TABLE IF NOT EXISTS btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenDefault
CREATE TABLE IF NOT EXISTS btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenShared
CREATE TABLE IF NOT EXISTS btc_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- ChainTypeMeta
CREATE TABLE IF NOT EXISTS chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainToken
CREATE TABLE IF NOT EXISTS eee_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT DEFAULT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenAuth
CREATE TABLE IF NOT EXISTS eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenDefault
CREATE TABLE IF NOT EXISTS eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenShared
CREATE TABLE IF NOT EXISTS eee_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTx
CREATE TABLE IF NOT EXISTS eee_chain_tx (  
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
-- EthChainToken
CREATE TABLE IF NOT EXISTS eth_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT DEFAULT NULL,
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
-- EthChainTokenAuth
CREATE TABLE IF NOT EXISTS eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenDefault
CREATE TABLE IF NOT EXISTS eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenShared
CREATE TABLE IF NOT EXISTS eth_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTx
CREATE TABLE IF NOT EXISTS eth_chain_tx (  
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
-- Mnemonic
CREATE TABLE IF NOT EXISTS mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Setting
CREATE TABLE IF NOT EXISTS setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- TokenAddress
CREATE TABLE IF NOT EXISTS token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Wallet
CREATE TABLE IF NOT EXISTS wallet (  
    next_id TEXT NOT NULL,
    full_name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Address
CREATE TABLE IF NOT EXISTS address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenAuth
CREATE TABLE IF NOT EXISTS btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenDefault
CREATE TABLE IF NOT EXISTS btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenShared
CREATE TABLE IF NOT EXISTS btc_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- ChainTypeMeta
CREATE TABLE IF NOT EXISTS chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainToken
CREATE TABLE IF NOT EXISTS eee_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT DEFAULT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenAuth
CREATE TABLE IF NOT EXISTS eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenDefault
CREATE TABLE IF NOT EXISTS eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenShared
CREATE TABLE IF NOT EXISTS eee_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTx
CREATE TABLE IF NOT EXISTS eee_chain_tx (  
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
-- EeeTokenxTx
CREATE TABLE IF NOT EXISTS eee_tokenx_tx (  
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
-- EthChainToken
CREATE TABLE IF NOT EXISTS eth_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT DEFAULT NULL,
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
-- EthChainTokenAuth
CREATE TABLE IF NOT EXISTS eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenDefault
CREATE TABLE IF NOT EXISTS eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenShared
CREATE TABLE IF NOT EXISTS eth_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTx
CREATE TABLE IF NOT EXISTS eth_chain_tx (  
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
-- Mnemonic
CREATE TABLE IF NOT EXISTS mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Setting
CREATE TABLE IF NOT EXISTS setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- TokenAddress
CREATE TABLE IF NOT EXISTS token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Wallet
CREATE TABLE IF NOT EXISTS wallet (  
    next_id TEXT NOT NULL,
    full_name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Address
CREATE TABLE IF NOT EXISTS address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenAuth
CREATE TABLE IF NOT EXISTS btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenDefault
CREATE TABLE IF NOT EXISTS btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenShared
CREATE TABLE IF NOT EXISTS btc_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- ChainTypeMeta
CREATE TABLE IF NOT EXISTS chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenAuth
CREATE TABLE IF NOT EXISTS eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenDefault
CREATE TABLE IF NOT EXISTS eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenShared
CREATE TABLE IF NOT EXISTS eee_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainToken
CREATE TABLE IF NOT EXISTS eth_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT DEFAULT NULL,
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
-- EthChainTokenAuth
CREATE TABLE IF NOT EXISTS eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenDefault
CREATE TABLE IF NOT EXISTS eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenShared
CREATE TABLE IF NOT EXISTS eth_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTx
CREATE TABLE IF NOT EXISTS eth_chain_tx (  
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
-- Mnemonic
CREATE TABLE IF NOT EXISTS mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Setting
CREATE TABLE IF NOT EXISTS setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- TokenAddress
CREATE TABLE IF NOT EXISTS token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Wallet
CREATE TABLE IF NOT EXISTS wallet (  
    next_id TEXT NOT NULL,
    full_name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Address
CREATE TABLE IF NOT EXISTS address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainToken
CREATE TABLE IF NOT EXISTS btc_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT DEFAULT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenAuth
CREATE TABLE IF NOT EXISTS btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenDefault
CREATE TABLE IF NOT EXISTS btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenShared
CREATE TABLE IF NOT EXISTS btc_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- ChainTypeMeta
CREATE TABLE IF NOT EXISTS chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainToken
CREATE TABLE IF NOT EXISTS eee_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT DEFAULT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenAuth
CREATE TABLE IF NOT EXISTS eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenDefault
CREATE TABLE IF NOT EXISTS eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenShared
CREATE TABLE IF NOT EXISTS eee_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTx
CREATE TABLE IF NOT EXISTS eee_chain_tx (  
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
-- EeeTokenxTx
CREATE TABLE IF NOT EXISTS eee_tokenx_tx (  
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
-- EthChainToken
CREATE TABLE IF NOT EXISTS eth_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT DEFAULT NULL,
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
-- EthChainTokenAuth
CREATE TABLE IF NOT EXISTS eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenDefault
CREATE TABLE IF NOT EXISTS eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenShared
CREATE TABLE IF NOT EXISTS eth_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTx
CREATE TABLE IF NOT EXISTS eth_chain_tx (  
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
-- Mnemonic
CREATE TABLE IF NOT EXISTS mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Setting
CREATE TABLE IF NOT EXISTS setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- TokenAddress
CREATE TABLE IF NOT EXISTS token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Wallet
CREATE TABLE IF NOT EXISTS wallet (  
    next_id TEXT NOT NULL,
    full_name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Address
CREATE TABLE IF NOT EXISTS address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenAuth
CREATE TABLE IF NOT EXISTS btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenDefault
CREATE TABLE IF NOT EXISTS btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenShared
CREATE TABLE IF NOT EXISTS btc_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- ChainTypeMeta
CREATE TABLE IF NOT EXISTS chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainToken
CREATE TABLE IF NOT EXISTS eee_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT DEFAULT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenAuth
CREATE TABLE IF NOT EXISTS eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenDefault
CREATE TABLE IF NOT EXISTS eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenShared
CREATE TABLE IF NOT EXISTS eee_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainToken
CREATE TABLE IF NOT EXISTS eth_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT DEFAULT NULL,
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
-- EthChainTokenAuth
CREATE TABLE IF NOT EXISTS eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenDefault
CREATE TABLE IF NOT EXISTS eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenShared
CREATE TABLE IF NOT EXISTS eth_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTx
CREATE TABLE IF NOT EXISTS eth_chain_tx (  
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
-- Mnemonic
CREATE TABLE IF NOT EXISTS mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Setting
CREATE TABLE IF NOT EXISTS setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- TokenAddress
CREATE TABLE IF NOT EXISTS token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Wallet
CREATE TABLE IF NOT EXISTS wallet (  
    next_id TEXT NOT NULL,
    full_name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Address
CREATE TABLE IF NOT EXISTS address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainToken
CREATE TABLE IF NOT EXISTS btc_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT DEFAULT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenAuth
CREATE TABLE IF NOT EXISTS btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenDefault
CREATE TABLE IF NOT EXISTS btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenShared
CREATE TABLE IF NOT EXISTS btc_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
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
-- ChainTypeMeta
CREATE TABLE IF NOT EXISTS chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainToken
CREATE TABLE IF NOT EXISTS eee_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT DEFAULT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenAuth
CREATE TABLE IF NOT EXISTS eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenDefault
CREATE TABLE IF NOT EXISTS eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenShared
CREATE TABLE IF NOT EXISTS eee_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTx
CREATE TABLE IF NOT EXISTS eee_chain_tx (  
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
-- EeeTokenxTx
CREATE TABLE IF NOT EXISTS eee_tokenx_tx (  
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
-- EthChainToken
CREATE TABLE IF NOT EXISTS eth_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT DEFAULT NULL,
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
-- EthChainTokenAuth
CREATE TABLE IF NOT EXISTS eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenDefault
CREATE TABLE IF NOT EXISTS eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenShared
CREATE TABLE IF NOT EXISTS eth_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTx
CREATE TABLE IF NOT EXISTS eth_chain_tx (  
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
-- Mnemonic
CREATE TABLE IF NOT EXISTS mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Setting
CREATE TABLE IF NOT EXISTS setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- TokenAddress
CREATE TABLE IF NOT EXISTS token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Wallet
CREATE TABLE IF NOT EXISTS wallet (  
    next_id TEXT NOT NULL,
    full_name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Address
CREATE TABLE IF NOT EXISTS address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenAuth
CREATE TABLE IF NOT EXISTS btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenDefault
CREATE TABLE IF NOT EXISTS btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenShared
CREATE TABLE IF NOT EXISTS btc_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- ChainTypeMeta
CREATE TABLE IF NOT EXISTS chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainToken
CREATE TABLE IF NOT EXISTS eee_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT DEFAULT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenAuth
CREATE TABLE IF NOT EXISTS eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenDefault
CREATE TABLE IF NOT EXISTS eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenShared
CREATE TABLE IF NOT EXISTS eee_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTx
CREATE TABLE IF NOT EXISTS eee_chain_tx (  
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
-- EthChainToken
CREATE TABLE IF NOT EXISTS eth_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT DEFAULT NULL,
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
-- EthChainTokenAuth
CREATE TABLE IF NOT EXISTS eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenDefault
CREATE TABLE IF NOT EXISTS eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenShared
CREATE TABLE IF NOT EXISTS eth_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTx
CREATE TABLE IF NOT EXISTS eth_chain_tx (  
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
-- Mnemonic
CREATE TABLE IF NOT EXISTS mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Setting
CREATE TABLE IF NOT EXISTS setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- TokenAddress
CREATE TABLE IF NOT EXISTS token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Wallet
CREATE TABLE IF NOT EXISTS wallet (  
    next_id TEXT NOT NULL,
    full_name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Address
CREATE TABLE IF NOT EXISTS address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainToken
CREATE TABLE IF NOT EXISTS btc_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT DEFAULT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenAuth
CREATE TABLE IF NOT EXISTS btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenDefault
CREATE TABLE IF NOT EXISTS btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenShared
CREATE TABLE IF NOT EXISTS btc_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
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
-- BtcInputTx
CREATE TABLE IF NOT EXISTS btc_input_tx (  
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
-- ChainTypeMeta
CREATE TABLE IF NOT EXISTS chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainToken
CREATE TABLE IF NOT EXISTS eee_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT DEFAULT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenAuth
CREATE TABLE IF NOT EXISTS eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenDefault
CREATE TABLE IF NOT EXISTS eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenShared
CREATE TABLE IF NOT EXISTS eee_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTx
CREATE TABLE IF NOT EXISTS eee_chain_tx (  
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
-- EeeTokenxTx
CREATE TABLE IF NOT EXISTS eee_tokenx_tx (  
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
-- EthChainToken
CREATE TABLE IF NOT EXISTS eth_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT DEFAULT NULL,
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
-- EthChainTokenAuth
CREATE TABLE IF NOT EXISTS eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenDefault
CREATE TABLE IF NOT EXISTS eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenShared
CREATE TABLE IF NOT EXISTS eth_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTx
CREATE TABLE IF NOT EXISTS eth_chain_tx (  
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
-- Mnemonic
CREATE TABLE IF NOT EXISTS mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Setting
CREATE TABLE IF NOT EXISTS setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- TokenAddress
CREATE TABLE IF NOT EXISTS token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Wallet
CREATE TABLE IF NOT EXISTS wallet (  
    next_id TEXT NOT NULL,
    full_name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Address
CREATE TABLE IF NOT EXISTS address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenAuth
CREATE TABLE IF NOT EXISTS btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenDefault
CREATE TABLE IF NOT EXISTS btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenShared
CREATE TABLE IF NOT EXISTS btc_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- ChainTypeMeta
CREATE TABLE IF NOT EXISTS chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainToken
CREATE TABLE IF NOT EXISTS eee_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT DEFAULT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenAuth
CREATE TABLE IF NOT EXISTS eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenDefault
CREATE TABLE IF NOT EXISTS eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenShared
CREATE TABLE IF NOT EXISTS eee_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTx
CREATE TABLE IF NOT EXISTS eee_chain_tx (  
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
-- EeeTokenxTx
CREATE TABLE IF NOT EXISTS eee_tokenx_tx (  
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
-- EthChainToken
CREATE TABLE IF NOT EXISTS eth_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT DEFAULT NULL,
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
-- EthChainTokenAuth
CREATE TABLE IF NOT EXISTS eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenDefault
CREATE TABLE IF NOT EXISTS eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenShared
CREATE TABLE IF NOT EXISTS eth_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTx
CREATE TABLE IF NOT EXISTS eth_chain_tx (  
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
-- Mnemonic
CREATE TABLE IF NOT EXISTS mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Setting
CREATE TABLE IF NOT EXISTS setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- TokenAddress
CREATE TABLE IF NOT EXISTS token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Wallet
CREATE TABLE IF NOT EXISTS wallet (  
    next_id TEXT NOT NULL,
    full_name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Address
CREATE TABLE IF NOT EXISTS address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainToken
CREATE TABLE IF NOT EXISTS btc_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT DEFAULT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenAuth
CREATE TABLE IF NOT EXISTS btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenDefault
CREATE TABLE IF NOT EXISTS btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenShared
CREATE TABLE IF NOT EXISTS btc_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
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
-- BtcInputTx
CREATE TABLE IF NOT EXISTS btc_input_tx (  
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
-- BtcOutputTx
CREATE TABLE IF NOT EXISTS btc_output_tx (  
    btc_chain_tx_id TEXT NOT NULL,
    tx_index INTEGER NOT NULL,
    address TEXT NOT NULL,
    pk_script TEXT NOT NULL,
    value TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- ChainTypeMeta
CREATE TABLE IF NOT EXISTS chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainToken
CREATE TABLE IF NOT EXISTS eee_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT DEFAULT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenAuth
CREATE TABLE IF NOT EXISTS eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenDefault
CREATE TABLE IF NOT EXISTS eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenShared
CREATE TABLE IF NOT EXISTS eee_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTx
CREATE TABLE IF NOT EXISTS eee_chain_tx (  
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
-- EeeTokenxTx
CREATE TABLE IF NOT EXISTS eee_tokenx_tx (  
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
-- EthChainToken
CREATE TABLE IF NOT EXISTS eth_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT DEFAULT NULL,
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
-- EthChainTokenAuth
CREATE TABLE IF NOT EXISTS eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenDefault
CREATE TABLE IF NOT EXISTS eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenShared
CREATE TABLE IF NOT EXISTS eth_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTx
CREATE TABLE IF NOT EXISTS eth_chain_tx (  
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
-- Mnemonic
CREATE TABLE IF NOT EXISTS mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Setting
CREATE TABLE IF NOT EXISTS setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- TokenAddress
CREATE TABLE IF NOT EXISTS token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Wallet
CREATE TABLE IF NOT EXISTS wallet (  
    next_id TEXT NOT NULL,
    full_name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Address
CREATE TABLE IF NOT EXISTS address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainToken
CREATE TABLE IF NOT EXISTS btc_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT DEFAULT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenAuth
CREATE TABLE IF NOT EXISTS btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenDefault
CREATE TABLE IF NOT EXISTS btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenShared
CREATE TABLE IF NOT EXISTS btc_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- ChainTypeMeta
CREATE TABLE IF NOT EXISTS chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainToken
CREATE TABLE IF NOT EXISTS eee_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT DEFAULT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenAuth
CREATE TABLE IF NOT EXISTS eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenDefault
CREATE TABLE IF NOT EXISTS eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenShared
CREATE TABLE IF NOT EXISTS eee_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTx
CREATE TABLE IF NOT EXISTS eee_chain_tx (  
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
-- EeeTokenxTx
CREATE TABLE IF NOT EXISTS eee_tokenx_tx (  
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
-- EthChainToken
CREATE TABLE IF NOT EXISTS eth_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT DEFAULT NULL,
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
-- EthChainTokenAuth
CREATE TABLE IF NOT EXISTS eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenDefault
CREATE TABLE IF NOT EXISTS eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenShared
CREATE TABLE IF NOT EXISTS eth_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTx
CREATE TABLE IF NOT EXISTS eth_chain_tx (  
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
-- Mnemonic
CREATE TABLE IF NOT EXISTS mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Setting
CREATE TABLE IF NOT EXISTS setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- TokenAddress
CREATE TABLE IF NOT EXISTS token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Wallet
CREATE TABLE IF NOT EXISTS wallet (  
    next_id TEXT NOT NULL,
    full_name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Address
CREATE TABLE IF NOT EXISTS address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainToken
CREATE TABLE IF NOT EXISTS btc_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT DEFAULT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenAuth
CREATE TABLE IF NOT EXISTS btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenDefault
CREATE TABLE IF NOT EXISTS btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenShared
CREATE TABLE IF NOT EXISTS btc_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
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
-- ChainTypeMeta
CREATE TABLE IF NOT EXISTS chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainToken
CREATE TABLE IF NOT EXISTS eee_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT DEFAULT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenAuth
CREATE TABLE IF NOT EXISTS eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenDefault
CREATE TABLE IF NOT EXISTS eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenShared
CREATE TABLE IF NOT EXISTS eee_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTx
CREATE TABLE IF NOT EXISTS eee_chain_tx (  
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
-- EeeTokenxTx
CREATE TABLE IF NOT EXISTS eee_tokenx_tx (  
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
-- EthChainToken
CREATE TABLE IF NOT EXISTS eth_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT DEFAULT NULL,
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
-- EthChainTokenAuth
CREATE TABLE IF NOT EXISTS eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenDefault
CREATE TABLE IF NOT EXISTS eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenShared
CREATE TABLE IF NOT EXISTS eth_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTx
CREATE TABLE IF NOT EXISTS eth_chain_tx (  
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
-- Mnemonic
CREATE TABLE IF NOT EXISTS mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Setting
CREATE TABLE IF NOT EXISTS setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- TokenAddress
CREATE TABLE IF NOT EXISTS token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Wallet
CREATE TABLE IF NOT EXISTS wallet (  
    next_id TEXT NOT NULL,
    full_name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Address
CREATE TABLE IF NOT EXISTS address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainToken
CREATE TABLE IF NOT EXISTS btc_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT DEFAULT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenAuth
CREATE TABLE IF NOT EXISTS btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenDefault
CREATE TABLE IF NOT EXISTS btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenShared
CREATE TABLE IF NOT EXISTS btc_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
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
-- BtcInputTx
CREATE TABLE IF NOT EXISTS btc_input_tx (  
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
-- ChainTypeMeta
CREATE TABLE IF NOT EXISTS chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainToken
CREATE TABLE IF NOT EXISTS eee_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT DEFAULT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenAuth
CREATE TABLE IF NOT EXISTS eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenDefault
CREATE TABLE IF NOT EXISTS eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenShared
CREATE TABLE IF NOT EXISTS eee_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTx
CREATE TABLE IF NOT EXISTS eee_chain_tx (  
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
-- EeeTokenxTx
CREATE TABLE IF NOT EXISTS eee_tokenx_tx (  
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
-- EthChainToken
CREATE TABLE IF NOT EXISTS eth_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT DEFAULT NULL,
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
-- EthChainTokenAuth
CREATE TABLE IF NOT EXISTS eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenDefault
CREATE TABLE IF NOT EXISTS eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenShared
CREATE TABLE IF NOT EXISTS eth_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTx
CREATE TABLE IF NOT EXISTS eth_chain_tx (  
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
-- Mnemonic
CREATE TABLE IF NOT EXISTS mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Setting
CREATE TABLE IF NOT EXISTS setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- TokenAddress
CREATE TABLE IF NOT EXISTS token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Wallet
CREATE TABLE IF NOT EXISTS wallet (  
    next_id TEXT NOT NULL,
    full_name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Address
CREATE TABLE IF NOT EXISTS address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    address TEXT NOT NULL,
    public_key TEXT NOT NULL,
    wallet_address BOOLEAN NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainToken
CREATE TABLE IF NOT EXISTS btc_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT DEFAULT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenAuth
CREATE TABLE IF NOT EXISTS btc_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenDefault
CREATE TABLE IF NOT EXISTS btc_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- BtcChainTokenShared
CREATE TABLE IF NOT EXISTS btc_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
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
-- BtcInputTx
CREATE TABLE IF NOT EXISTS btc_input_tx (  
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
-- BtcOutputTx
CREATE TABLE IF NOT EXISTS btc_output_tx (  
    btc_chain_tx_id TEXT NOT NULL,
    tx_index INTEGER NOT NULL,
    address TEXT NOT NULL,
    pk_script TEXT NOT NULL,
    value TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- ChainTypeMeta
CREATE TABLE IF NOT EXISTS chain_type_meta (  
    chain_type TEXT NOT NULL,
    short_name TEXT NOT NULL,
    full_name TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainToken
CREATE TABLE IF NOT EXISTS eee_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT DEFAULT NULL,
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    show BOOLEAN NOT NULL,
    decimal INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenAuth
CREATE TABLE IF NOT EXISTS eee_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenDefault
CREATE TABLE IF NOT EXISTS eee_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTokenShared
CREATE TABLE IF NOT EXISTS eee_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EeeChainTx
CREATE TABLE IF NOT EXISTS eee_chain_tx (  
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
-- EeeTokenxTx
CREATE TABLE IF NOT EXISTS eee_tokenx_tx (  
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
-- EthChainToken
CREATE TABLE IF NOT EXISTS eth_chain_token (  
    next_id TEXT NOT NULL,
    chain_token_shared_id TEXT DEFAULT NULL,
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
-- EthChainTokenAuth
CREATE TABLE IF NOT EXISTS eth_chain_token_auth (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenDefault
CREATE TABLE IF NOT EXISTS eth_chain_token_default (  
    chain_token_shared_id TEXT NOT NULL,
    position INTEGER NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTokenShared
CREATE TABLE IF NOT EXISTS eth_chain_token_shared (  
    -- TokenShared start
    chain_type TEXT NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    logo_url TEXT DEFAULT NULL,
    logo_bytes TEXT DEFAULT NULL,
    project TEXT DEFAULT NULL,
    auth BOOLEAN NOT NULL,
    -- TokenShared end

    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- EthChainTx
CREATE TABLE IF NOT EXISTS eth_chain_tx (  
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
-- Mnemonic
CREATE TABLE IF NOT EXISTS mnemonic (  
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Setting
CREATE TABLE IF NOT EXISTS setting (  
    key_str TEXT NOT NULL,
    value_str TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- TokenAddress
CREATE TABLE IF NOT EXISTS token_address (  
    wallet_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    token_id TEXT NOT NULL,
    address_id TEXT NOT NULL,
    balance TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
-- Wallet
CREATE TABLE IF NOT EXISTS wallet (  
    next_id TEXT NOT NULL,
    full_name TEXT NOT NULL,
    mnemonic_digest TEXT NOT NULL,
    mnemonic TEXT NOT NULL,
    wallet_type TEXT NOT NULL,
    net_type TEXT NOT NULL,
    id TEXT PRIMARY KEY,
    create_time INTEGER NOT NULL,
    update_time INTEGER NOT NULL
 );
