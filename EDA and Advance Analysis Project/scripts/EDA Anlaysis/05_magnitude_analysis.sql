-- =====================================================
-- Magnitude Analysis
-- Database: salesAnalytics
-- Purpose:
--   - Quantify data and group results by specific dimensions
-- MySQL Workbench version
-- =====================================================

USE salesAnalytics;


-- =====================================================
-- 1. Total customers by country
-- =====================================================

SELECT
    country,
    COUNT(customer_key) AS total_customers
FROM customers
GROUP BY country
ORDER BY total_customers DESC;


-- =====================================================
-- 2. Total customers by gender
-- =====================================================

SELECT
    gender,
    COUNT(customer_key) AS total_customers
FROM customers
GROUP BY gender
ORDER BY total_customers DESC;


-- =====================================================
-- 3. Total products by category
-- =====================================================

SELECT 
    COALESCE(NULLIF(TRIM(category), ''), 'NULL') AS category,
    COUNT(product_key) AS total_products
FROM products
GROUP BY COALESCE(NULLIF(TRIM(category), ''), 'NULL')
ORDER BY total_products DESC;


-- =====================================================
-- 4. Average cost per category
-- =====================================================

SELECT 
    COALESCE(NULLIF(TRIM(category), ''), 'NULL') AS category,
    ROUND(AVG(cost),2) AS avg_costs
FROM products
GROUP BY COALESCE(NULLIF(TRIM(category), ''), 'NULL')
ORDER BY avg_costs DESC;


-- =====================================================
-- 5. Total revenue per category
-- =====================================================

SELECT
    p.category,
    SUM(f.sales_amount) AS total_revenue
FROM sales f
LEFT JOIN products p
    ON p.product_key = f.product_key
GROUP BY p.category
ORDER BY total_revenue DESC;


-- =====================================================
-- 6. Total revenue per customer
-- =====================================================

SELECT
    c.customer_key,
    c.first_name,
    c.last_name,
    SUM(f.sales_amount) AS total_revenue
FROM sales f
LEFT JOIN customers c
    ON c.customer_key = f.customer_key
GROUP BY 
    c.customer_key,
    c.first_name,
    c.last_name
ORDER BY total_revenue DESC;


-- =====================================================
-- 7. Distribution of sold items across countries
-- =====================================================

SELECT
    c.country,
    SUM(f.quantity) AS total_sold_items
FROM sales f
LEFT JOIN customers c
    ON c.customer_key = f.customer_key
GROUP BY c.country
ORDER BY total_sold_items DESC;