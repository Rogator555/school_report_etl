/* =============================================================
   Script:  Set up the datawarehouse database and silver schema
   Purpose: Create the objects if they don't exist, then preview
            the preliminary science students' marks table
   ============================================================= */

-- 1. Create the 'dwh' database if it doesn't already exist
IF NOT EXISTS (
    SELECT 1
    FROM sys.databases
    WHERE name = 'dwh'
)
BEGIN
    CREATE DATABASE dwh;
END
GO

-- 2. Switch to the staging database
--    (must happen BEFORE the schema check, so we look in the right database)
USE dwh;
GO

-- 3. Create the 'silver' schema if it doesn't already exist
IF NOT EXISTS (
    SELECT 1
    FROM sys.schemas
    WHERE name = 'silver'
)
BEGIN
    -- CREATE SCHEMA must be the only statement in a batch,
    -- so it's wrapped in EXEC to run inside the IF block
    EXEC ('CREATE SCHEMA silver');
END
GO

---
USE dwh;
GO


/*--------------------------------------------------------------
  GRADE 10  (classes 10A and 10B)
--------------------------------------------------------------*/

-- Create the grade 10 table if it doesn't exist yet
IF NOT EXISTS (
    SELECT 1
    FROM sys.tables  t
    JOIN sys.schemas s ON t.schema_id = s.schema_id
    WHERE s.name = 'silver'
      AND t.name = 'prelim_science_students_marks_g10'
)
BEGIN
    CREATE TABLE silver.prelim_science_students_marks_g10 (
        student_id                  NVARCHAR(50),
        student_name                NVARCHAR(200),
        grade                       NVARCHAR(10),
        mathematics_mark            DECIMAL(5,2),
        physical_science_mark       DECIMAL(5,2),
        life_sciences_mark          DECIMAL(5,2),
        english_home_language_mark  DECIMAL(5,2),
        life_orientation_mark       DECIMAL(5,2),
        information_technology_mark DECIMAL(5,2),
        agricultural_science_mark   DECIMAL(5,2),
        total_mark                  DECIMAL(6,2),
        average_mark                DECIMAL(5,2)
    );
END;
GO

INSERT INTO silver.prelim_science_students_marks_g10
SELECT
    [student_id],
    [student_name],
    [grade],
    [mathematics_mark],
    [physical_science_mark],
    [life_sciences_mark],
    [english_home_language_mark],
    [life_orientation_mark],
    [information_technology_mark],
    [agricultural_science_mark],
    [total_mark],
    [average_mark]
FROM [staging].[bronze].[prelim_science_students_marks]
WHERE grade IN ('10A','10B');
GO


-- Create the grade 11 table if it doesn't exist yet
IF NOT EXISTS (
    SELECT 1
    FROM sys.tables  t
    JOIN sys.schemas s ON t.schema_id = s.schema_id
    WHERE s.name = 'silver'
      AND t.name = 'prelim_science_students_marks_g11'
)
BEGIN
    CREATE TABLE silver.prelim_science_students_marks_g11 (
        student_id                  NVARCHAR(50),
        student_name                NVARCHAR(200),
        grade                       NVARCHAR(10),
        mathematics_mark            DECIMAL(5,2),
        physical_science_mark       DECIMAL(5,2),
        life_sciences_mark          DECIMAL(5,2),
        english_home_language_mark  DECIMAL(5,2),
        life_orientation_mark       DECIMAL(5,2),
        information_technology_mark DECIMAL(5,2),
        agricultural_science_mark   DECIMAL(5,2),
        total_mark                  DECIMAL(6,2),
        average_mark                DECIMAL(5,2)
    );
END;
GO

INSERT INTO silver.prelim_science_students_marks_g11
SELECT
    [student_id],
    [student_name],
    [grade],
    [mathematics_mark],
    [physical_science_mark],
    [life_sciences_mark],
    [english_home_language_mark],
    [life_orientation_mark],
    [information_technology_mark],
    [agricultural_science_mark],
    [total_mark],
    [average_mark]
FROM [staging].[bronze].[prelim_science_students_marks]
WHERE grade IN ('11A','11B');
GO


-- Create the grade 12 table if it doesn't exist yet
IF NOT EXISTS (
    SELECT 1
    FROM sys.tables  t
    JOIN sys.schemas s ON t.schema_id = s.schema_id
    WHERE s.name = 'silver'
      AND t.name = 'prelim_science_students_marks_g12'
)
BEGIN
    CREATE TABLE silver.prelim_science_students_marks_g12 (
        student_id                  NVARCHAR(50),
        student_name                NVARCHAR(200),
        grade                       NVARCHAR(10),
        mathematics_mark            DECIMAL(5,2),
        physical_science_mark       DECIMAL(5,2),
        life_sciences_mark          DECIMAL(5,2),
        english_home_language_mark  DECIMAL(5,2),
        life_orientation_mark       DECIMAL(5,2),
        information_technology_mark DECIMAL(5,2),
        agricultural_science_mark   DECIMAL(5,2),
        total_mark                  DECIMAL(6,2),
        average_mark                DECIMAL(5,2)
    );
END;
GO

INSERT INTO silver.prelim_science_students_marks_g12
SELECT
    [student_id],
    [student_name],
    [grade],
    [mathematics_mark],
    [physical_science_mark],
    [life_sciences_mark],
    [english_home_language_mark],
    [life_orientation_mark],
    [information_technology_mark],
    [agricultural_science_mark],
    [total_mark],
    [average_mark]
FROM [staging].[bronze].[prelim_science_students_marks]
WHERE grade IN ('12A','12B');
GO


-- 4. Preview the data in the silver table
--SELECT *
--FROM silver.prelim_science_students_marks_g10;
