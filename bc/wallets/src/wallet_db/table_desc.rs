
/// Description of a Transaction, pending or in the chain.
#[derive(Debug, Default, Clone, PartialEq, Deserialize, Serialize)]
pub struct DigitExport {
    /// Nonce
    pub address: String,
    /// Recipient (None when contract creation)
    pub symbol: String,
    /// Transfered value
    pub decimal: i64,
    #[serde(rename = "type")]
    pub digit_type: String,
    /// Input data
    #[serde(rename = "urlImg")]
    pub url_img: Option<String>,
}

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
    [is_visible] VARCHAR(1)  NOT NULL DEFAULT 1,
    [create_time] timestamp NOT NULL DEFAULT (strftime('%s','now')));

    DROP TABLE IF EXISTS [main].[Chain];
    CREATE TABLE [main].[Chain](
    [id] INTEGER PRIMARY KEY NOT NULL,
    [type] INT,
    [short_name] VARCHAR(32),
    [full_name] VARCHAR(64),
    [domain] VARCHAR(128),
    [group_name] VARCHAR(32),
    [next_id] INT,
    [selected] VARCHAR(1),
    [status] INT,
    [more_property] VARCHAR(1),
    [create_time] timestamp NOT NULL DEFAULT (strftime('%s','now')),
    [update_time] DATETIME);

   DROP TABLE IF EXISTS [main].[DigitBase];
    CREATE TABLE [main].[DigitBase](
    [id] INTEGER PRIMARY KEY NOT NULL,
    [contract_address] VARCHAR(64),
	[type] VARCHAR(32),
    [short_name] VARCHAR(32),
    [full_name] VARCHAR(32),
    [next_id] INT,
    [url_img] VARCHAR(1024),
    [group_name] VARCHAR(32),
    [is_visible] VARCHAR(1)  NOT NULL DEFAULT 1,
    [decimals] INT,
	[unit]  VARCHAR(32),
    [status] INT,
    [CREATED_TIME] timestamp NOT NULL DEFAULT (strftime('%s','now')),
    [UPDATED_TIME] DATETIME);

    DROP TABLE IF EXISTS [main].[DigitUseDetail];
    CREATE TABLE [main].[DigitUseDetail](
    [digit_id] INTEGER ,
    [address_id] VARCHAR(64) ,
	[balance] VARCHAR(32),
    [is_visible] VARCHAR(1)  NOT NULL DEFAULT 1,
    [status] INT NOT NULL DEFAULT 1,
    [CREATED_TIME] timestamp NOT NULL DEFAULT (strftime('%s','now')),
    [UPDATED_TIME] DATETIME,
	primary key(digit_id,address_id));

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
    [CREATED_TIME] timestamp NOT NULL DEFAULT (strftime('%s','now')),
    [UPDATED_TIME] DATETIME);

    insert into Chain(id,short_name,full_name,type,domain) Values(1,'BTC',"bitcoin",1,"");
    insert into Chain(id,short_name,full_name,type,domain) Values(2,'BTC TEST',"bitcoin test",2,"");
    insert into Chain(id,short_name,full_name,type,domain) Values(3,'ETH',"ethereum",3,"");
    insert into Chain(id,short_name,full_name,type,domain) Values(4,'ETH TEST',"ethereum test",4,"");
    insert into Chain(id,short_name,full_name,type,domain) Values(5,'EEE',"eee",5,"");
    insert into Chain(id,short_name,full_name,type,domain) Values(6,'EEE TEST',"eee test",6,"");
  /*  update Chain set type=5,domain='eee.com' WHERE id = 5;*/
    /*digit基础数据插入EEE代币*/
    insert into DigitBase('type','short_name','full_name','decimals','group_name','is_visible') values("default","EEE","EEE",12,"EEE",1);
    /*digit基础数据插入ETH代币*/
    insert into DigitBase('type','short_name','full_name','decimals','group_name','is_visible') values("default","ETH","ethereum",18,"ETH",1);
    /*digit基础数据插入BTC代币*/
    insert into DigitBase('type','short_name','full_name','decimals','group_name','is_visible') values("default","BTC","bitcoin",18,"BTC",1);
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
          [display_chain_id] INT NOT NULL,
          [create_time] timestamp NOT NULL DEFAULT (strftime('%s','now')),
          [update_time] timestamp);
        COMMIT;
        PRAGMA foreign_keys = 'on';
    "#;
    String::from(mnenonic_sql)
}
