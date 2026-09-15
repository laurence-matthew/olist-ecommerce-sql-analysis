-- =====================================================
-- Q1: TOP 10 CUSTOMERS BY TOTAL AMOUNT SPENT
-- Business Question:
-- Who are the top 10 customers by total amount spent?
-- =====================================================
SELECT
    c.customer_unique_id,
    ROUND(
        SUM(CAST(op.payment_value AS DECIMAL(10,2))),
        2
    ) AS total_spent,
    COUNT(DISTINCT o.order_id) AS num_orders
FROM customers AS c
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id
INNER JOIN order_payments AS op
    ON o.order_id = op.order_id
GROUP BY c.customer_unique_id
ORDER BY total_spent DESC
LIMIT 10;