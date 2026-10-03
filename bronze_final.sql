/* =============================================================
   Script:  Set up the staging database and bronze schema
   Purpose: Create the objects if they don't exist, then preview
            the preliminary science students' marks table
   ============================================================= */

-- 1. Create the 'staging' database if it doesn't already exist
IF NOT EXISTS (
    SELECT 1
    FROM sys.databases
    WHERE name = 'staging'
)
BEGIN
    CREATE DATABASE staging;
END
GO

-- 2. Switch to the staging database
--    (must happen BEFORE the schema check, so we look in the right database)
USE staging;
GO

-- 3. Create the 'bronze' schema if it doesn't already exist
IF NOT EXISTS (
    SELECT 1
    FROM sys.schemas
    WHERE name = 'bronze'
)
BEGIN
    -- CREATE SCHEMA must be the only statement in a batch,
    -- so it's wrapped in EXEC to run inside the IF block
    EXEC ('CREATE SCHEMA bronze');
END
GO

-- 4. Preview the data in the bronze table
SELECT *
FROM bronze.prelim_science_students_marks;
