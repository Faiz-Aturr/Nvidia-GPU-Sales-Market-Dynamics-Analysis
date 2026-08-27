-- =============================================================================
-- NVIDIA GPU Sales & Market Dynamics Analysis
-- Database: MySQL
-- Dataset: Synthetic / Simulated
--
-- Notes:
-- 1. The dataset used for SQL analysis is imported through MySQL Workbench Table Data Import Wizard.
-- 2. The schema below documents the intended final structure of the table.
-- 3. Analytical results should be interpreted as patterns within the simulated
--    dataset, not as empirical claims about NVIDIA's real-world sales.
-- =============================================================================


CREATE DATABASE IF NOT EXISTS nvidia_sales;
USE nvidia_sales;

-- =============================================================================
-- TABLE SCHEMA
-- =============================================================================

CREATE TABLE IF NOT EXISTS nvidia_gpu_sales (
    sale_id INT NOT NULL,
    sale_date DATE NOT NULL,
    gpu_model VARCHAR(30) NOT NULL,
    gpu_family VARCHAR(30) NOT NULL,
    launch_year INT NOT NULL,
    region VARCHAR(30) NOT NULL,
    sales_channel VARCHAR(30) NOT NULL,
    customer_segment VARCHAR(30) NOT NULL,
    units_sold INT NOT NULL,
    msrp_usd DECIMAL(10,2) NOT NULL,
    avg_street_price_usd DECIMAL(10,2) NOT NULL,
    price_premium_pct DECIMAL(6,2) NOT NULL,
    stock_status VARCHAR(20) NOT NULL,
    customer_satisfaction_score DECIMAL(3,2) NOT NULL,
    warranty_months INT NOT NULL,
    bundle_addon VARCHAR(30) NOT NULL,
    revenue_usd DECIMAL(15,2) NOT NULL,
    scalping_status VARCHAR(20) NOT NULL,
    PRIMARY KEY (sale_id)
);

-- =============================================================================
-- BUSINESS QUESTIONS & ANALYTICAL QUERIES
-- =============================================================================

-- Q1. What is the total revenue and sales volume across GPU families?
SELECT
    gpu_family,
    SUM(units_sold) AS total_units_sold,
    SUM(revenue_usd) AS total_revenue_usd
FROM nvidia_gpu_sales
GROUP BY gpu_family
ORDER BY total_revenue_usd DESC;


-- Q2. How does customer satisfaction vary across different scalping status categories?
SELECT
    scalping_status,
    COUNT(*) AS total_transactions,
    ROUND(AVG(price_premium_pct), 2) AS avg_price_premium_pct,
    ROUND(AVG(customer_satisfaction_score), 2) AS avg_customer_satisfaction
FROM nvidia_gpu_sales
GROUP BY scalping_status
ORDER BY avg_customer_satisfaction DESC;


-- Q3. Which global regions generate the highest total revenue?
SELECT
    region,
    COUNT(*) AS total_transactions,
    SUM(units_sold) AS total_units_sold,
    SUM(revenue_usd) AS total_revenue_usd
FROM nvidia_gpu_sales
GROUP BY region
ORDER BY total_revenue_usd DESC;


-- Q4. What are the top 5 most popular GPU models based on total units sold?
SELECT
    gpu_model,
    gpu_family,
    COUNT(*) AS total_transactions,
    SUM(units_sold) AS total_units_sold,
    SUM(revenue_usd) AS total_revenue_usd
FROM nvidia_gpu_sales
GROUP BY gpu_model, gpu_family
ORDER BY total_units_sold DESC
LIMIT 5;


-- Q5. Which sales channels generate the highest transaction volume and total revenue?
SELECT
    sales_channel,
    COUNT(*) AS total_transactions,
    SUM(units_sold) AS total_units_sold,
    SUM(revenue_usd) AS total_revenue_usd
FROM nvidia_gpu_sales
GROUP BY sales_channel
ORDER BY total_revenue_usd DESC;


-- Q6. How does the average price premium vary across global regions?
SELECT
    region,
    COUNT(*) AS total_transactions,
    ROUND(AVG(price_premium_pct), 2) AS avg_price_premium_pct
FROM nvidia_gpu_sales
GROUP BY region
ORDER BY avg_price_premium_pct DESC;


-- Q7. How does customer satisfaction vary across different stock status categories?
SELECT
    stock_status,
    COUNT(*) AS total_transactions,
    ROUND(AVG(price_premium_pct), 2) AS avg_price_premium_pct,
    ROUND(AVG(customer_satisfaction_score), 2) AS avg_customer_satisfaction
FROM nvidia_gpu_sales
GROUP BY stock_status
ORDER BY avg_customer_satisfaction DESC;


-- Q8. What is the average revenue per transaction across customer segments?
SELECT
    customer_segment,
    COUNT(*) AS total_transactions,
    ROUND(AVG(units_sold), 2) AS avg_units_per_transaction,
    ROUND(AVG(revenue_usd), 2) AS avg_revenue_per_transaction
FROM nvidia_gpu_sales
GROUP BY customer_segment
ORDER BY avg_revenue_per_transaction DESC;


-- Q9. How does average transaction value vary across bundle add-on categories?
SELECT
    bundle_addon,
    COUNT(*) AS total_transactions,
    ROUND(AVG(units_sold), 2) AS avg_units_per_transaction,
    ROUND(AVG(revenue_usd), 2) AS avg_revenue_per_transaction
FROM nvidia_gpu_sales
GROUP BY bundle_addon
ORDER BY avg_revenue_per_transaction DESC;


-- Q10. How many transactions have a price premium above 50%,
--      and what share of total transactions and revenue do they represent?
SELECT
    SUM(
        CASE
            WHEN price_premium_pct > 50 THEN 1
            ELSE 0
        END
    ) AS high_premium_transactions,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN price_premium_pct > 50 THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS high_premium_transaction_pct,

    SUM(
        CASE
            WHEN price_premium_pct > 50 THEN revenue_usd
            ELSE 0
        END
    ) AS high_premium_revenue_usd,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN price_premium_pct > 50 THEN revenue_usd
                ELSE 0
            END
        ) / SUM(revenue_usd),
        2
    ) AS high_premium_revenue_pct
FROM nvidia_gpu_sales;
