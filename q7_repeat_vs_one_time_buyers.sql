-- ==================================================
-- Q7: REPEAT VS ONE-TIME BUYERS
-- Business Question:
-- How many customers are repeat vs one-time buyers?
-- ==================================================
WITH customer_orders AS (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS total_orders
    FROM customers AS c
    INNER JOIN orders AS o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
)

SELECT
    CASE
        WHEN total_orders = 1 THEN 'One-time'
        ELSE 'Repeat'
    END AS buyer_type,

    COUNT(*) AS total_customers,

    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS customer_percentage

FROM customer_orders
GROUP BY buyer_type
ORDER BY total_customers DESC;

