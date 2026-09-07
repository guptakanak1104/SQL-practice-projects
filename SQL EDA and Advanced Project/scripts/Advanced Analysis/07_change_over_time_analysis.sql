-- =====================================================
-- Change Over Time Analysis
-- Database: salesAnalytics
-- Purpose:
--   - Track trends, growth, and changes in key metrics over time
--   - Time-series analysis and identifying seasonality
-- MySQL Workbench version
-- =====================================================

USE salesAnalytics;


-- =====================================================
-- 1. Sales performance over time (Year/Month aggregation)
-- =====================================================

SELECT
    YEAR(order_date) AS order_year,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
FROM sales
WHERE order_date IS NOT NULL
AND YEAR(order_date)>0
GROUP BY YEAR(order_date)
ORDER BY YEAR(order_date);


-- =====================================================
-- 2. Monthly Sales Performance using DATE_FORMAT
-- =====================================================

SELECT
    DATE_FORMAT(order_date, '%Y-%m-01') AS order_date,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
FROM sales
WHERE order_date IS NOT NULL
AND MONTH(order_date)>0
GROUP BY DATE_FORMAT(order_date, '%Y-%m-01')   
ORDER BY order_date;


-- =====================================================
-- 3. Formatted Year-Month Display
-- =====================================================

SELECT
    DATE_FORMAT(order_date, '%Y-%b') AS order_date,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
FROM sales
WHERE order_date IS NOT NULL
AND YEAR (order_date) >0
GROUP BY DATE_FORMAT(order_date, '%Y-%b')
ORDER BY order_date;


-- =====================================================
-- 3. Formatted Year-Month Separately Display
-- =====================================================


SELECT 
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    SUM(sales_amount) AS total_Sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
FROM sales
WHERE order_date IS NOT NULL 
  AND YEAR(order_date) > 0
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY YEAR(order_date), MONTH(order_date);
