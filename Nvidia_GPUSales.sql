-- ==============================================================================
-- Project: Nvidia GPU Sales & Market Dynamics Analysis
-- Description: End-to-end SQL script for data preparation and exploratory analysis
-- ==============================================================================

-- ------------------------------------------------------------------------------
-- 1. CREATE TABLE (Membangun Struktur Database)
-- ------------------------------------------------------------------------------
-- Menyesuaikan tipe data
CREATE TABLE nvidia_gpu_sales (
    sale_id INT PRIMARY KEY,
    sale_date DATE,
    gpu_model VARCHAR(100),
    gpu_family VARCHAR(50),
    launch_year INT,
    msrp_usd DECIMAL(10, 2),
    avg_street_price_usd DECIMAL(10, 2),
    price_premium_pct DECIMAL(5, 2),
    scalping_status VARCHAR(50),
    units_sold INT,
    revenue_usd DECIMAL(15, 2),
    region VARCHAR(50),
    sales_channel VARCHAR(50),
    customer_segment VARCHAR(50),
    stock_status VARCHAR(50),
    customer_satisfaction_score DECIMAL(3, 1),
    bundle_addon VARCHAR(100),
    warranty_months INT
);

-- ------------------------------------------------------------------------------
-- 2. IMPORT DATA (Memasukkan Data dari CSV)
-- ------------------------------------------------------------------------------
-- Catatan untuk Reviewer: Ubah file path di bawah ini sesuai dengan lokasi 
-- file 'nvidia_gpu_sales_.csv' di perangkat Anda sebelum melakukan eksekusi.


USE nvidia_sales;

-- Q1. What is the total revenue and volume of units sold across different GPU families?
SELECT 
    gpu_family,
    SUM(units_sold) AS total_unit_terjual,
    ROUND(SUM(revenue_usd), 2) AS total_pendapatan_usd
FROM nvidia_gpu_sales
GROUP BY gpu_family
ORDER BY total_pendapatan_usd DESC;


-- Q2. How does price scalping (premium pricing) impact the average customer satisfaction score?
SELECT 
    scalping_status,
    COUNT(sale_id) AS jumlah_transaksi,
    ROUND(AVG(customer_satisfaction_score), 2) AS rata_rata_kepuasan
FROM nvidia_gpu_sales
GROUP BY scalping_status
ORDER BY rata_rata_kepuasan DESC;


-- Q3. Which global regions generate the highest total revenue for the company?
SELECT 
    region,
    COUNT(sale_id) AS total_transaksi,
    ROUND(SUM(revenue_usd), 2) AS total_pendapatan_usd
FROM nvidia_gpu_sales
GROUP BY region
ORDER BY total_pendapatan_usd DESC;


-- Q4. What are the top 5 most popular GPU models based on total units sold?
SELECT 
    gpu_model,
    SUM(units_sold) AS total_unit_terjual,
    ROUND(SUM(revenue_usd), 2) AS total_pendapatan
FROM nvidia_gpu_sales
GROUP BY gpu_model
ORDER BY total_unit_terjual DESC
LIMIT 5;


-- Q5. Which sales channels yield the highest number of transactions and total revenue?
SELECT 
    sales_channel,
    COUNT(sale_id) AS total_transaksi,
    ROUND(SUM(revenue_usd), 2) AS total_cuan_usd
FROM nvidia_gpu_sales
GROUP BY sales_channel
ORDER BY total_cuan_usd DESC;


-- Q6. What is the average price premium (scalping markup) percentage across different regions?
SELECT 
    region,
    ROUND(AVG(price_premium_pct), 2) AS rata_rata_markup_harga_persen
FROM nvidia_gpu_sales
GROUP BY region
ORDER BY rata_rata_markup_harga_persen DESC;


-- Q7. Does product availability (stock status) significantly affect the average customer satisfaction rating?
SELECT 
    stock_status,
    COUNT(sale_id) AS jumlah_transaksi,
    ROUND(AVG(customer_satisfaction_score), 2) AS rata_rata_kepuasan
FROM nvidia_gpu_sales
GROUP BY stock_status
ORDER BY rata_rata_kepuasan DESC;


-- Q8. What is the average revenue generated per transaction for each customer segment?
SELECT 
    customer_segment,
    ROUND(AVG(revenue_usd), 2) AS rata_rata_belanja_per_transaksi
FROM nvidia_gpu_sales
GROUP BY customer_segment
ORDER BY rata_rata_belanja_per_transaksi DESC;


-- Q9. Do bundle add-ons (e.g., Cooling Kits, Software) increase the average transaction value?
SELECT 
    bundle_addon,
    COUNT(sale_id) AS jumlah_transaksi,
    ROUND(AVG(revenue_usd), 2) AS rata_rata_pendapatan
FROM nvidia_gpu_sales
GROUP BY bundle_addon
ORDER BY rata_rata_pendapatan DESC;


-- Q10. How many abnormal transactions exist where the scalping markup exceeds 50% of the MSRP?
SELECT 
    COUNT(sale_id) AS total_transaksi_abnormal,
    ROUND(SUM(revenue_usd), 2) AS total_uang_beredar_di_calo
FROM nvidia_gpu_sales
WHERE price_premium_pct > 50.0;