PRAGMA foreign_keys = 'off';
BEGIN;
DROP TABLE IF EXISTS [main].[Mnemonic];
CREATE TABLE [main].[Mnemonic](
  [id] VARCHAR(64) PRIMARY KEY NOT NULL, 
  [fullname] VARCHAR(32), 
  [mnemonic] VARCHAR(3072), 
  [selected] VARCHAR(1), 
  [status] INT NOT NULL  DEFAULT 1,
  [create_time] timestamp NOT NULL DEFAULT (DATETIME ('now', 'localtime')), 
  [update_time] timestamp);
COMMIT;
PRAGMA foreign_keys = 'on';
