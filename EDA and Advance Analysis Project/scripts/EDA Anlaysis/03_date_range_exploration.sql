-- =====================================================
-- Date Range Exploration 
-- Database: salesAnalytics
-- Purpose:
--   - Determine temporal boundaries and age spans
-- MySQL Workbench version
-- =====================================================

USE salesAnalytics;


-- =====================================================
-- 1. First and last order date and total duration in months
-- =====================================================
SELECT 
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date,
    TIMESTAMPDIFF(YEAR, MIN(order_date), MAX(order_date)) AS order_range_years -- TIMESTAMPDIFF rounds off
FROM sales
WHERE YEAR(order_date) > 0;

-- =====================================================
-- 2. Youngest and oldest customer based on birthdate
-- =====================================================
SELECT 
    MIN(birthdate) AS oldest_birthdate,
    TIMESTAMPDIFF(YEAR, MIN(birthdate), CURDATE()) AS oldest_age,
    MAX(birthdate) AS youngest_birthdate,
    TIMESTAMPDIFF(YEAR, MAX(birthdate), CURDATE()) AS youngest_age
FROM salesanalytics.customers
WHERE YEAR(birthdate) > 0;