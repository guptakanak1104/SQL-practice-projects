-- =====================================================
-- Ranking Analysis
-- Database: salesAnalytics
-- Purpose:
--   - Rank products and customers based on performance metrics
-- MySQL Workbench version
-- =====================================================

USE salesAnalytics;


-- =====================================================
-- 1. Top 5 Products by Revenue (LIMIT)
-- =====================================================

SELECT
    p.product_name,
    SUM(f.sales_amount) AS total_revenue
FROM sales f
LEFT JOIN products p
    ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_revenue DESC
LIMIT 5;


-- =====================================================
-- 2. Top 5 Products by Revenue (Window Function)
-- =====================================================

SELECT *
FROM (
    SELECT
        p.product_name,
        SUM(f.sales_amount) AS total_revenue,
        RANK() OVER (ORDER BY SUM(f.sales_amount) DESC) AS rank_products
    FROM sales f
    LEFT JOIN products p
        ON p.product_key = f.product_key
    GROUP BY p.product_name
) AS ranked_products
WHERE rank_products <= 5;


-- =====================================================
-- 3. Top 5 Worst-Performing Products
-- =====================================================

SELECT
    p.product_name,
    SUM(f.sales_amount) AS total_revenue
FROM sales f
LEFT JOIN products p
    ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_revenue ASC
LIMIT 5;


-- =====================================================
-- 4. Top 10 Customers by Revenue
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
ORDER BY total_revenue DESC
LIMIT 10;


-- =====================================================
-- 5. Bottom 3 Customers by Order Count
-- =====================================================

SELECT 
    c.customer_key,
    c.first_name,
    c.last_name,
    COUNT(DISTINCT order_number) AS total_orders
FROM sales f
LEFT JOIN customers c
    ON c.customer_key = f.customer_key
GROUP BY 
    c.customer_key,
    c.first_name,
    c.last_name
ORDER BY 
    total_orders ASC, 
    c.customer_key ASC
LIMIT 3;