-- =====================================================
-- Customer Report
-- Database: salesAnalytics
-- Purpose:
--   - Create view consolidating customer metrics and behaviors
-- MySQL Workbench version
-- =====================================================

USE salesAnalytics;

DROP VIEW IF EXISTS report_customers;

CREATE VIEW report_customers AS

-- 1) BASE QUERY: Retrieves core columns from tables

WITH base_query AS (
    SELECT
        f.order_number,
        f.product_key,
        -- Force conversion to NULL if string is '0000-00-00' or invalid length
        CASE 
            WHEN CAST(f.order_date AS CHAR) LIKE '0000%' 
              OR CHAR_LENGTH(CAST(f.order_date AS CHAR)) < 8 
            THEN NULL
            ELSE STR_TO_DATE(LEFT(CAST(f.order_date AS CHAR), 10), '%Y-%m-%d')
        END AS clean_order_date,
        f.sales_amount,
        f.quantity,
        f.customer_key,
        c.customer_number,
        CONCAT(IFNULL(c.first_name, ''), ' ', IFNULL(c.last_name, '')) AS customer_name,
        -- Safe age calculation avoiding raw birthdate operations
        CASE 
            WHEN CAST(c.birthdate AS CHAR) LIKE '0000%' 
              OR c.birthdate IS NULL 
              OR CHAR_LENGTH(CAST(c.birthdate AS CHAR)) < 8 
            THEN NULL
            ELSE GREATEST(0, TIMESTAMPDIFF(YEAR, STR_TO_DATE(LEFT(CAST(c.birthdate AS CHAR), 10), '%Y-%m-%d'), '2025-01-01'))
        END AS age
    FROM sales f
    LEFT JOIN customers c
        ON f.customer_key = c.customer_key
),
customer_aggregation AS (

-- 2) CUSTOMER AGGREGATIONS: Summarizes key metrics at the customer level

    SELECT
        customer_key,
        customer_number,
        customer_name,
        age,
        COUNT(DISTINCT order_number) AS total_orders,
        SUM(sales_amount) AS total_sales,
        SUM(quantity) AS total_quantity,
        COUNT(DISTINCT product_key) AS total_products,
        MAX(clean_order_date) AS last_order_date,
        GREATEST(
            0,
            (YEAR(MAX(clean_order_date)) - YEAR(MIN(clean_order_date))) * 12 
            + (MONTH(MAX(clean_order_date)) - MONTH(MIN(clean_order_date)))
        ) AS lifespan
    FROM base_query
    WHERE clean_order_date IS NOT NULL
    GROUP BY
        customer_key,
        customer_number,
        customer_name,
        age
)

-- 3) FINAL QUERY 

SELECT
    customer_key,
    customer_number,
    customer_name,
    IFNULL(age, 0) AS age,
    CASE
        WHEN age IS NULL OR age = 0 THEN 'Unknown'
        WHEN age < 20 THEN 'Under 20'
        WHEN age BETWEEN 20 AND 29 THEN '20-29'
        WHEN age BETWEEN 30 AND 39 THEN '30-39'
        WHEN age BETWEEN 40 AND 49 THEN '40-49'
        ELSE '50 and above'
    END AS age_group,
    CASE
        WHEN lifespan >= 12 AND total_sales > 5000 THEN 'VIP'
        WHEN lifespan >= 12 AND total_sales <= 5000 THEN 'Regular'
        ELSE 'New'
    END AS customer_segment,
    last_order_date,
    GREATEST(0, TIMESTAMPDIFF(MONTH, last_order_date, '2025-01-01')) AS recency,
    total_orders,
    total_sales,
    total_quantity,
    total_products,
    lifespan,
    CASE
        WHEN total_orders = 0 THEN 0
        ELSE total_sales / total_orders
    END AS avg_order_value,
    CASE
        WHEN lifespan = 0 THEN total_sales
        ELSE total_sales / lifespan
    END AS avg_monthly_spend
FROM customer_aggregation;

SELECT 
age_group,               
COUNT(customer_number),
SUM(total_sales) total_sales 
FROM report_customers
GROUP BY age_group;
