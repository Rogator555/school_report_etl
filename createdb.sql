
/* ============================================================
   1. CREATE STAGING DATABASE
   ------------------------------------------------------------
   The staging database contains incoming/raw data that may
   still require cleaning and transformation.
   ============================================================ */

IF DB_ID('curro_stg') IS NULL
BEGIN
    CREATE DATABASE curro_stg;
END;


/* ============================================================
   2. CREATE BRONZE SCHEMA
   ------------------------------------------------------------
   The Bronze layer stores raw data with minimal transformation.

   IMPORTANT:
   We first switch to the staging database because schemas
   belong to a specific database.
   ============================================================ */

USE curro_stg;

IF NOT EXISTS
(
    SELECT 1
    FROM sys.schemas
    WHERE name = 'bronze'
)
BEGIN
    EXEC('CREATE SCHEMA bronze');
END;


/* ============================================================
   3. CREATE DATA WAREHOUSE DATABASE
   ------------------------------------------------------------
   The data warehouse contains cleaned and transformed data
   that is ready for analytics and reporting.
   ============================================================ */

IF DB_ID('curro_dwh') IS NULL
BEGIN
    CREATE DATABASE curro_dwh;
END;