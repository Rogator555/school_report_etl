/*==============================================================
  Script : Split prelim science marks into one table per grade
  Source : staging.bronze.prelim_science_students_marks
  Targets: bronze.prelim_science_students_marks_g10 / _g11 / _g12
  Notes  : Safe to re-run. Tables are only created if missing,
           and each target is emptied before it is reloaded so
           re-running never produces duplicate rows.
==============================================================*/

-- All objects live in the staging database
USE staging;
GO


/*--------------------------------------------------------------
  GRADE 10  (classes 10A and 10B)
--------------------------------------------------------------*/

-- Create the grade 10 table if it doesn't exist yet
IF NOT EXISTS (
    SELECT 1
    FROM sys.tables  t
    JOIN sys.schemas s ON t.schema_id = s.schema_id
    WHERE s.name = 'bronze'
      AND t.name = 'prelim_science_students_marks_g10'
)
BEGIN
    CREATE TABLE bronze.prelim_science_students_marks_g10 (
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

-- Clear any existing rows so a re-run doesn't duplicate data
TRUNCATE TABLE bronze.prelim_science_students_marks_g10;
GO

-- Load grade 10 students from the source table
INSERT INTO bronze.prelim_science_students_marks_g10 (
    student_id, student_name, grade,
    mathematics_mark, physical_science_mark, life_sciences_mark,
    english_home_language_mark, life_orientation_mark,
    information_technology_mark, agricultural_science_mark,
    total_mark, average_mark
)
SELECT
    student_id, student_name, grade,
    mathematics_mark, physical_science_mark, life_sciences_mark,
    english_home_language_mark, life_orientation_mark,
    information_technology_mark, agricultural_science_mark,
    total_mark, average_mark
FROM bronze.prelim_science_students_marks
WHERE grade IN ('10A', '10B');
GO


/*--------------------------------------------------------------
  GRADE 11  (classes 11A and 11B)
--------------------------------------------------------------*/

-- Create the grade 11 table if it doesn't exist yet
IF NOT EXISTS (
    SELECT 1
    FROM sys.tables  t
    JOIN sys.schemas s ON t.schema_id = s.schema_id
    WHERE s.name = 'bronze'
      AND t.name = 'prelim_science_students_marks_g11'
)
BEGIN
    CREATE TABLE bronze.prelim_science_students_marks_g11 (
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

-- Clear any existing rows so a re-run doesn't duplicate data
TRUNCATE TABLE bronze.prelim_science_students_marks_g11;
GO

-- Load grade 11 students from the source table
INSERT INTO bronze.prelim_science_students_marks_g11 (
    student_id, student_name, grade,
    mathematics_mark, physical_science_mark, life_sciences_mark,
    english_home_language_mark, life_orientation_mark,
    information_technology_mark, agricultural_science_mark,
    total_mark, average_mark
)
SELECT
    student_id, student_name, grade,
    mathematics_mark, physical_science_mark, life_sciences_mark,
    english_home_language_mark, life_orientation_mark,
    information_technology_mark, agricultural_science_mark,
    total_mark, average_mark
FROM bronze.prelim_science_students_marks
WHERE grade IN ('11A', '11B');
GO


/*--------------------------------------------------------------
  GRADE 12  (classes 12A and 12B)
--------------------------------------------------------------*/

-- Create the grade 12 table if it doesn't exist yet
IF NOT EXISTS (
    SELECT 1
    FROM sys.tables  t
    JOIN sys.schemas s ON t.schema_id = s.schema_id
    WHERE s.name = 'bronze'
      AND t.name = 'prelim_science_students_marks_g12'
)
BEGIN
    CREATE TABLE bronze.prelim_science_students_marks_g12 (
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

-- Clear any existing rows so a re-run doesn't duplicate data
TRUNCATE TABLE bronze.prelim_science_students_marks_g12;
GO

-- Load grade 12 students from the source table
INSERT INTO bronze.prelim_science_students_marks_g12 (
    student_id, student_name, grade,
    mathematics_mark, physical_science_mark, life_sciences_mark,
    english_home_language_mark, life_orientation_mark,
    information_technology_mark, agricultural_science_mark,
    total_mark, average_mark
)
SELECT
    student_id, student_name, grade,
    mathematics_mark, physical_science_mark, life_sciences_mark,
    english_home_language_mark, life_orientation_mark,
    information_technology_mark, agricultural_science_mark,
    total_mark, average_mark
FROM bronze.prelim_science_students_marks
WHERE grade IN ('12A', '12B');
GO


/*--------------------------------------------------------------
  VERIFY: row counts per grade table vs. the source table
  (the three grade counts should add up to the source total,
   unless the source contains other grade values)
--------------------------------------------------------------*/
SELECT 'g10'    AS table_name, COUNT(*) AS row_count FROM bronze.prelim_science_students_marks_g10
UNION ALL
SELECT 'g11',                  COUNT(*)              FROM bronze.prelim_science_students_marks_g11
UNION ALL
SELECT 'g12',                  COUNT(*)              FROM bronze.prelim_science_students_marks_g12
UNION ALL
SELECT 'source',               COUNT(*)              FROM bronze.prelim_science_students_marks;
GO