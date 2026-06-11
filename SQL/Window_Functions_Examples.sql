-- =========================================
-- WINDOW FUNCTIONS ANALYSIS
-- =========================================


-- 1. Rank customers by spending
SELECT
    "Customer ID",
    SUM("Total Amount") AS total_spent,
    RANK() OVER (ORDER BY SUM("Total Amount") DESC) AS rank
FROM retail_sales
GROUP BY "Customer ID";


-- 2. Running total sales
SELECT
    CAST("Date" AS date) AS order_date,
    "Total Amount",
    SUM("Total Amount") OVER (ORDER BY CAST("Date" AS date)) AS running_total
FROM retail_sales;


-- 3. Customer purchase trend
SELECT
    "Customer ID",
    CAST("Date" AS date) AS order_date,
    "Total Amount",
    LAG("Total Amount") OVER (
        PARTITION BY "Customer ID"
        ORDER BY CAST("Date" AS date)
    ) AS previous_purchase
FROM retail_sales;


-- 4. Moving average sales
SELECT
    CAST("Date" AS date) AS order_date,
    "Total Amount",
    AVG("Total Amount") OVER (
        ORDER BY CAST("Date" AS date)
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS moving_avg
FROM retail_sales;