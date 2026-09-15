-- =================================================
-- Q6: CUSTOMER SPEND SEGMENTATION
-- Business Question:
-- How can customers be segmented into
-- Low, Medium, and High spend tiers?
-- =================================================
WITH customer_spending AS (
    SELECT
        c.customer_unique_id,
        ROUND(
            SUM(CAST(op.payment_value AS DECIMAL(10,2))),
            2
        ) AS total_spent
    FROM customers AS c
    INNER JOIN orders AS o
        ON c.customer_id = o.customer_id
    INNER JOIN order_payments AS op
        ON o.order_id = op.order_id
    GROUP BY c.customer_unique_id
),
spending_tiers AS (
    SELECT
        customer_unique_id,
        total_spent,
        NTILE(3) OVER (
            ORDER BY total_spent
        ) AS spend_tier
    FROM customer_spending
)
SELECT
    CASE
        WHEN spend_tier = 1 THEN 'Low'
        WHEN spend_tier = 2 THEN 'Medium'
        ELSE 'High'
    END AS customer_segment,

    COUNT(*) AS total_customers,
    ROUND(AVG(total_spent), 2) AS average_spend,
    ROUND(MIN(total_spent), 2) AS minimum_spend,
    ROUND(MAX(total_spent), 2) AS maximum_spend
FROM spending_tiers
GROUP BY spend_tier
ORDER BY spend_tier;
