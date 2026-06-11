-- =========================================
-- DATA QUALITY CHECKS
-- Dataset: Retail Transactions
-- =========================================


-- 1. Duplicate transactions
SELECT
    "Transaction ID",
    COUNT(*) AS cnt
FROM retail_sales
GROUP BY "Transaction ID"
HAVING COUNT(*) > 1;


-- 2. Missing values check (critical fields)
SELECT *
FROM retail_sales
WHERE "Transaction ID" IS NULL
   OR "Customer ID" IS NULL
   OR "Date" IS NULL
   OR "Total Amount" IS NULL;


-- 3. Invalid values (negative or zero sales)
SELECT *
FROM retail_sales
WHERE "Total Amount" <= 0;


-- 4. Recalculation check (data integrity)
SELECT *
FROM retail_sales
WHERE "Total Amount" <> ("Quantity" * "Price per Unit");


-- 5. Row count validation
SELECT COUNT(*) AS total_rows
FROM retail_sales;