/* Disable foreign keys */
PRAGMA foreign_keys = 'off';

/* Begin transaction */
BEGIN;

/* Database properties */

/* Drop table [Mnemonic] */
DROP TABLE IF EXISTS [main].[Mnemonic];

/* Table structure [Mnemonic] */
CREATE TABLE [main].[Mnemonic](
  [id] VARCHAR(64) PRIMARY KEY NOT NULL, 
  [fullname] VARCHAR(32), 
  [mnemonic] VARCHAR(3072), 
  [selected] VARCHAR(1), 
  [status] INT NOT NULL  DEFAULT 1,
  [create_time] timestamp NOT NULL DEFAULT (DATETIME ('now', 'localtime')), 
  [update_time] timestamp);

/* Commit transaction */
COMMIT;

/* Enable foreign keys */
PRAGMA foreign_keys = 'on';
