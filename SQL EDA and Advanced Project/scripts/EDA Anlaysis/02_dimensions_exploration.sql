-- =====================================================
-- Dimensions Exploration
-- Database: salesAnalytics
-- Purpose:
--   - Explore distinct attribute values across dimension tables
-- MySQL Workbench version
-- =====================================================

USE salesAnalytics;


-- =====================================================
-- 1. Retrieve unique customer countries
-- =====================================================

SELECT DISTINCT 
    country 
FROM customers
ORDER BY country;


-- =====================================================
-- 2. Retrieve unique categories, subcategories, and products
-- =====================================================
SELECT *
FROM (
SELECT DISTINCT 
    COALESCE(NULLIF(TRIM(category), ''), 'NULL') AS category,
    COALESCE(NULLIF(TRIM(subcategory), ''), 'NULL') AS subcategory,
    product_name
FROM salesanalytics.products
) AS sub
ORDER BY 
    (category = 'NULL') DESC, 
    category, 
    product_name;