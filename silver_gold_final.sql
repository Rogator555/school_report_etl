/*==============================================================
  Setup script: create the data warehouse and the silver schema
  Safe to re-run: each object is only created if missing
==============================================================*/

-- Create the data warehouse database if it doesn't already exist
IF NOT EXISTS (
    SELECT 1
    FROM sys.databases
    WHERE name = 'dwh'
)
BEGIN
    CREATE DATABASE dwh;
END;
GO

-- Switch context to the new database
USE dwh;
GO

-- Create the silver schema if it doesn't already exist
-- (EXECUTE is needed because CREATE SCHEMA must be the only
--  statement in its batch, so it can't sit directly inside an IF block)
IF NOT EXISTS (
    SELECT 1
    FROM sys.schemas
    WHERE name = 'silver'
)
BEGIN
    EXECUTE ('CREATE SCHEMA silver');
END;
GO
if not exists (
select 1 from sys.schemas
where name = 'gold')
execute ('create schema gold');
