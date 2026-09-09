-- =====================================================
-- Database Exploration
-- Database: salesAnalytics
-- Purpose:
--   - Explore database structure (tables and columns)
--   - Inspect metadata for specific tables
-- MySQL Workbench version
-- =====================================================

USE salesAnalytics;


-- =====================================================
-- 1. Retrieve list of tables in salesAnalytics
-- =====================================================

SELECT 
    TABLE_CATALOG, 
    TABLE_SCHEMA, 
    TABLE_NAME, 
    TABLE_TYPE
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'salesAnalytics';


-- =====================================================
-- 2. Retrieve all columns for customers table
-- =====================================================

SELECT 
    COLUMN_NAME, 
    DATA_TYPE, 
    IS_NULLABLE, 
    CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'salesAnalytics' 
  AND TABLE_NAME = 'customers';