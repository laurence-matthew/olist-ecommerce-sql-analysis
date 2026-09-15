-- =====================================================
-- Q2: MONTHLY REVENUE TREND
-- Business Question:
-- What is the monthly revenue trend across the dataset?
-- =====================================================
SELECT
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS revenue_month,
    ROUND(SUM(CAST(op.payment_value AS DECIMAL(10,2))),2) AS monthly_revenue
FROM orders AS o
INNER JOIN order_payments AS op
    ON o.order_id = op.order_id
GROUP BY revenue_month
ORDER BY revenue_month;