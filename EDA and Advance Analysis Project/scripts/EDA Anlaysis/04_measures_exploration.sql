-- =====================================================
-- Measures Exploration (Key Metrics)
-- Database: salesAnalytics
-- Purpose:
--   - Calculate key overall metrics and business indicators
-- MySQL Workbench version
-- =====================================================

USE salesAnalytics;


-- =====================================================
-- 1. Basic Metrics
-- =====================================================

-- Total Sales
SELECT SUM(sales_amount) AS total_sales FROM sales;

-- Total Quantity Sold
SELECT SUM(quantity) AS total_quantity FROM sales;

-- Average Selling Price
SELECT ROUND(AVG(price)) AS avg_price FROM sales;

-- Total Orders
SELECT COUNT(order_number) AS total_orders FROM sales;
SELECT COUNT(DISTINCT order_number) AS total_orders FROM sales;

-- Total Products
SELECT COUNT(product_name) AS total_products FROM products;

-- Total Customers
SELECT COUNT(customer_key) AS total_customers FROM customers;

-- Total Active Customers (placed at least one order)
SELECT COUNT(DISTINCT customer_key) AS total_customers FROM sales;


-- =====================================================
-- 2. Consolidated Key Metrics Report
-- =====================================================

SELECT 'Total Sales' AS measure_name, CAST(ROUND(SUM(sales_amount)) AS CHAR) AS measure_value FROM sales
UNION ALL
SELECT 'Total Quantity', CAST(SUM(quantity) AS CHAR) FROM sales
UNION ALL
SELECT 'Average Price', FORMAT(AVG(price),2) FROM sales
UNION ALL
SELECT 'Total Orders', CAST(COUNT(DISTINCT order_number) AS CHAR) FROM sales
UNION ALL
SELECT 'Total Products', CAST(COUNT(DISTINCT product_name) AS CHAR) FROM products
UNION ALL
SELECT 'Total Customers', CAST(COUNT(customer_key) AS CHAR) FROM customers;