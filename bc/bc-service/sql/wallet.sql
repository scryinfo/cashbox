/* Disable foreign keys */
PRAGMA foreign_keys = 'off';

/* Begin transaction */
BEGIN;

/* Database properties */

/* Drop table [Address] */
DROP TABLE IF EXISTS [main].[Address];

/* Table structure [Address] */
CREATE TABLE [main].[Address](
  [address] VARCHAR(64) PRIMARY KEY NOT NULL,
  [mnemonic_id] VARCHAR(64), 
  [chain_id] INT,
  [puk_key] VARCHAR(128), 
  [status] INT NOT NULL  DEFAULT 1,
  [create_time] timestamp NOT NULL DEFAULT (DATETIME ('now', 'localtime')));

/* Drop table [Chain] */
DROP TABLE IF EXISTS [main].[Chain];

/* Table structure [Chain] */
CREATE TABLE [main].[Chain](
  [id] INT PRIMARY KEY NOT NULL, 
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

/* Drop table [Digit] */
DROP TABLE IF EXISTS [main].[Digit];

/* Table structure [Digit] */
CREATE TABLE [main].[Digit](
  [id] INT PRIMARY KEY NOT NULL, 
  [address] VARCHAR(64),
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

/* Drop table [TransferRecord] */
DROP TABLE IF EXISTS [main].[TransferRecord];

/* Table structure [TransferRecord] */
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

/* Commit transaction */
COMMIT;

/* Enable foreign keys */
PRAGMA foreign_keys = 'on';
