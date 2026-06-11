-- =========================================
-- SALES TREND ANALYSIS
-- =========================================


-- 1. Monthly sales trend
SELECT
    date_trunc('month', CAST("Date" AS date)) AS sales_month,
    SUM("Total Amount") AS total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 1;


-- 2. Month-over-month growth
WITH monthly_sales AS (
    SELECT
        date_trunc('month', CAST("Date" AS date)) AS sales_month,
        SUM("Total Amount") AS total_sales
    FROM retail_sales
    GROUP BY 1
)

SELECT
    sales_month,
    total_sales,
    LAG(total_sales) OVER (ORDER BY sales_month) AS prev_month,
    total_sales - LAG(total_sales) OVER (ORDER BY sales_month) AS growth
FROM monthly_sales;


-- 3. Category performance over time
SELECT
    date_trunc('month', CAST("Date" AS date)) AS month,
    "Product Category",
    SUM("Total Amount") AS sales
FROM retail_sales
GROUP BY 1, 2
ORDER BY 1;