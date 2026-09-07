-- =====================================================
-- Cumulative Analysis
-- Database: salesAnalytics
-- Purpose:
--   - Calculate running totals and moving averages for key metrics
-- MySQL Workbench version
-- =====================================================

USE salesAnalytics;


-- =====================================================
-- 1. Total sales per year and running total over time
-- =====================================================

SELECT
    order_year,
    total_sales,
    SUM(total_sales) OVER (ORDER BY order_year) AS running_total_sales,
    ROUND(AVG(avg_price) OVER (ORDER BY order_year),2) AS moving_average_price
FROM
(
    SELECT 
        YEAR(order_date) AS order_year,
        SUM(sales_amount) AS total_sales,
        AVG(price) AS avg_price
    FROM sales
    WHERE order_date IS NOT NULL
    AND YEAR(order_date) > 0
    GROUP BY YEAR(order_date)
)t;