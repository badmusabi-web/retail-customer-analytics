-- =========================================
-- CUSTOMER SEGMENTATION
-- =========================================


-- 1. Customer summary
SELECT
    "Customer ID",
    COUNT("Transaction ID") AS total_orders,
    SUM("Total Amount") AS total_spent,
    AVG("Total Amount") AS avg_order_value
FROM retail_sales
GROUP BY "Customer ID";


-- 2. Customer segmentation logic
WITH customer_base AS (
    SELECT
        "Customer ID",
        COUNT("Transaction ID") AS total_orders,
        SUM("Total Amount") AS total_spent
    FROM retail_sales
    GROUP BY "Customer ID"
)

SELECT
    "Customer ID",
    total_orders,
    total_spent,
    CASE
        WHEN total_spent >= 1000 THEN 'High Value'
        WHEN total_spent BETWEEN 500 AND 999 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS segment
FROM customer_base;


-- 3. Gender spending analysis
SELECT
    "Gender",
    SUM("Total Amount") AS total_spent
FROM retail_sales
GROUP BY "Gender";