pub fn get_cashbox_wallet_detail_sql() -> String {
    let sql = r#"
    PRAGMA foreign_keys = 'off';
    BEGIN;
    DROP TABLE IF EXISTS [main].[Address];
    CREATE TABLE [main].[Address](
    [address_id] VARCHAR(64) PRIMARY KEY NOT NULL,
    [wallet_id] VARCHAR(64) NOT NULL,
    [chain_id] INT NOT NULL,
    [address] VARCHAR(64) NOT NULL,
    [puk_key] VARCHAR(128) NOT NULL,
    [status] INT NOT NULL  DEFAULT 1,
    [create_time] timestamp NOT NULL DEFAULT (DATETIME ('now', 'localtime')));

    DROP TABLE IF EXISTS [main].[Chain];
    CREATE TABLE [main].[Chain](
    [id] INTEGER PRIMARY KEY NOT NULL,
    [type] VARCHAR(32),
    [short_name] VARCHAR(32),
    [full_name] VARCHAR(64),
    [address] VARCHAR(128),
    [group_name] VARCHAR(32),
    [next_id] INT,
    [selected] VARCHAR(1),
    [status] INT,
    [more_property] VARCHAR(1),
    [create_time] timestamp NOT NULL DEFAULT (DATETIME ('now', 'localtime')),
    [update_time] DATETIME);

    DROP TABLE IF EXISTS [main].[EthDigit];
    CREATE TABLE [main].[EthDigit](
    [id] INTEGER PRIMARY KEY NOT NULL,
    [address_id] VARCHAR(64),
    [contract_address] VARCHAR(128),
    [short_name] VARCHAR(32),
    [full_name] VARCHAR(32),
    [balance] VARCHAR(32),
    [unit] VARCHAR(32),
    [money] DECIMAL(32, 8),
    [next_id] INT,
    [url_img] VARCHAR(1024),
    [group_name] VARCHAR(32),
    [selected] VARCHAR(1),
    [decimals] INT,
    [status] INT,
    [CREATED_TIME] timestamp NOT NULL DEFAULT (DATETIME ('now', 'localtime')),
    [UPDATED_TIME] DATETIME);

    DROP TABLE IF EXISTS [main].[BtcDigit];
    CREATE TABLE [main].[BtcDigit](
    [id] INTEGER PRIMARY KEY NOT NULL,
    [address_id] VARCHAR(64),
    [contract_address] VARCHAR(128),
    [short_name] VARCHAR(32),
    [full_name] VARCHAR(32),
    [balance] VARCHAR(32),
    [unit] VARCHAR(32),
    [money] DECIMAL(32, 8),
    [next_id] INT,
    [url_img] VARCHAR(1024),
    [group_name] VARCHAR(32),
    [selected] VARCHAR(1),
    [decimals] INT,
    [status] INT,
    [CREATED_TIME] timestamp NOT NULL DEFAULT (DATETIME ('now', 'localtime')),
    [UPDATED_TIME] DATETIME);

    DROP TABLE IF EXISTS [main].[EeeDigit];
    CREATE TABLE [main].[EeeDigit](
    [id] INTEGER PRIMARY KEY NOT NULL,
    [address_id] VARCHAR(64),
    [contract_address] VARCHAR(128),
    [short_name] VARCHAR(32),
    [full_name] VARCHAR(32),
    [balance] VARCHAR(32),
    [unit] VARCHAR(32),
    [money] DECIMAL(32, 8),
    [next_id] INT,
    [url_img] VARCHAR(1024),
    [group_name] VARCHAR(32),
    [selected] VARCHAR(1),
    [decimals] INT,
    [status] INT,
    [CREATED_TIME] timestamp NOT NULL DEFAULT (DATETIME ('now', 'localtime')),
    [UPDATED_TIME] DATETIME);

    DROP TABLE IF EXISTS [main].[TransferRecord];
    CREATE TABLE [main].[TransferRecord](
    [id] VARCHAR(32) PRIMARY KEY NOT NULL,
    [tx_record_hash] VARCHAR(64),
    [chain_id] INT,
    [tx_from] VARCHAR(64),
    [tx_to] VARCHAR(64),
    [amount] VARCHAR(32),
    [unit] VARCHAR(32),
    [status] VARCHAR(32),
    [is_initiator] VARCHAR(1),
    [extra_msg] VARCHAR(3072),
    [CREATED_TIME] timestamp NOT NULL DEFAULT (DATETIME ('now', 'localtime')),
    [UPDATED_TIME] DATETIME);

    insert into Chain(id,short_name,full_name) Values(1,'BTC',"bitcoin");
    insert into Chain(id,short_name,full_name) Values(2,'BTC TEST',"bitcoin test");
    insert into Chain(id,short_name,full_name) Values(3,'ETH',"ethereum");
    insert into Chain(id,short_name,full_name) Values(4,'ETH TEST',"ethereum test");
    insert into Chain(id,short_name,full_name) Values(5,'EEE',"eee");
    insert into Chain(id,short_name,full_name) Values(6,'EEE TEST',"eee test");
    COMMIT;
    PRAGMA foreign_keys = 'on';
    "#;
    String::from(sql)
}

pub fn get_cashbox_wallet_sql() -> String {
    let mnenonic_sql = r#"
        PRAGMA foreign_keys = 'off';
        BEGIN;
        DROP TABLE IF EXISTS [main].[Wallet];
        CREATE TABLE [main].[Wallet](
          [wallet_id] VARCHAR(64) PRIMARY KEY NOT NULL,
          [mn_digest] VARCHAR(64) NOT NULL,
          [fullname] VARCHAR(32),
          [mnemonic] VARCHAR(3072),
          [wallet_type] INT NOT NULL  DEFAULT 1,
          [selected] VARCHAR(1),
          [status] INT NOT NULL  DEFAULT 1,
          [create_time] timestamp NOT NULL DEFAULT (DATETIME ('now', 'localtime')),
          [update_time] timestamp);
        COMMIT;
        PRAGMA foreign_keys = 'on';
    "#;
    String::from(mnenonic_sql)
}
