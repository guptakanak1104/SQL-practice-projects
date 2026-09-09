-- =====================================================
-- Data Segmentation Analysis
-- Database: salesAnalytics
-- Purpose:
--   - Group products and customers into meaningful ranges/segments
-- MySQL Workbench version
-- =====================================================

USE salesAnalytics;


-- =====================================================
-- 1. Segment products into cost ranges
-- =====================================================

WITH product_segments AS (
    SELECT
        product_key,
        product_name,
        cost,
        CASE 
            WHEN cost < 100 THEN 'Below 100'
            WHEN cost BETWEEN 100 AND 500 THEN '100-500'
            WHEN cost BETWEEN 500 AND 1000 THEN '500-1000'
            ELSE 'Above 1000'
        END AS cost_range
    FROM products
)
SELECT 
    cost_range,
    COUNT(product_key) AS total_products
FROM product_segments
GROUP BY cost_range
ORDER BY total_products DESC;


-- =====================================================
-- 2. Group customers into segments (VIP, Regular, New)
-- =====================================================

WITH customer_spending AS (
    SELECT 
        f.customer_key,
        SUM(f.sales_amount) AS total_spending,
        MIN(f.order_date) AS first_order,
        MAX(f.order_date) AS last_order,
        PERIOD_DIFF(
            DATE_FORMAT(MAX(f.order_date), '%Y%m'), 
            DATE_FORMAT(MIN(f.order_date), '%Y%m')
        ) AS lifespan
    FROM sales f
    WHERE f.order_date IS NOT NULL 
      AND YEAR(f.order_date) > 0
    GROUP BY f.customer_key
)
SELECT 
    customer_segment,
    COUNT(customer_key) AS total_customers
FROM (
    SELECT 
        customer_key,
        CASE 
            WHEN lifespan >= 12 AND total_spending > 5000 THEN 'VIP'
            WHEN lifespan >= 12 AND total_spending <= 5000 THEN 'Regular'
            ELSE 'New'
        END AS customer_segment
    FROM customer_spending
) AS segmented_customers
GROUP BY customer_segment
ORDER BY total_customers DESC;