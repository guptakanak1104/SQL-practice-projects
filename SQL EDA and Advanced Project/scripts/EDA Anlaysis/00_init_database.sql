-- =====================================================
-- SQL EDA PROJECT
-- Database: salesAnalytics
-- MySQL Workbench version
-- =====================================================
SET GLOBAL local_infile = 1;
-- 1. Create the database
DROP DATABASE IF EXISTS salesAnalytics;

CREATE DATABASE salesAnalytics;

USE salesAnalytics;


-- =====================================================
-- 2. Create customers table
-- =====================================================

CREATE TABLE customers (
    customer_key INT,
    customer_id INT,
    customer_number VARCHAR(50),
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    country VARCHAR(50),
    marital_status VARCHAR(50),
    gender VARCHAR(50),
    birthdate DATE,
    create_date DATE
);


-- =====================================================
-- 3. Create products table
-- =====================================================

CREATE TABLE products (
    product_key INT,
    product_id INT,
    product_number VARCHAR(50),
    product_name VARCHAR(50),
    category_id VARCHAR(50),
    category VARCHAR(50),
    subcategory VARCHAR(50),
    maintenance VARCHAR(50),
    cost INT,
    product_line VARCHAR(50),
    start_date DATE
);


-- =====================================================
-- 4. Create sales table
-- =====================================================

CREATE TABLE sales (
    order_number VARCHAR(50),
    product_key INT,
    customer_key INT,
    order_date DATE,
    shipping_date DATE,
    due_date DATE,
    sales_amount INT,
    quantity TINYINT,
    price INT
);



-- =====================================================
-- 5. Import customers CSV
-- =====================================================

LOAD DATA LOCAL INFILE
'E:/Data Analytics/Github projects/SQL-practice-projects/SQL EDA project/datasets/files/customers.csv'
INTO TABLE customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;


-- =====================================================
-- 6. Import products CSV
-- =====================================================

LOAD DATA LOCAL INFILE
'E:/Data Analytics/Github projects/SQL-practice-projects/SQL EDA project/datasets/files/products.csv'
INTO TABLE products
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;


-- =====================================================
-- 7. Import sales CSV
-- =====================================================

LOAD DATA LOCAL INFILE
'E:/Data Analytics/Github projects/SQL-practice-projects/SQL EDA project/datasets/files/sales.csv'
INTO TABLE sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;


-- =====================================================
-- 8. Check imported data
-- =====================================================

SELECT * FROM customers LIMIT 10;

SELECT * FROM products LIMIT 10;

SELECT * FROM sales LIMIT 10;


-- =====================================================
-- 9. Check row counts
-- =====================================================

SELECT COUNT(*) AS total_customers
FROM customers;

SELECT COUNT(*) AS total_products
FROM products;

SELECT COUNT(*) AS total_sales
FROM sales;