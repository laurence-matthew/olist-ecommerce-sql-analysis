-- =====================================================
-- Q3: MONTH-OVER-MONTH REVENUE CHANGE
-- Business Question:
-- What is the month-over-month change in revenue?
-- =====================================================
WITH monthly_revenue AS (
    SELECT
        DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS revenue_month,
        ROUND(
            SUM(CAST(op.payment_value AS DECIMAL(10,2))),
            2
        ) AS revenue
    FROM orders AS o
    INNER JOIN order_payments AS op
        ON o.order_id = op.order_id
    GROUP BY revenue_month
),
revenue_with_lag AS (
    SELECT
        revenue_month,
        revenue,
        LAG(revenue) OVER (
            ORDER BY revenue_month
        ) AS previous_month_revenue
    FROM monthly_revenue
)
SELECT
    revenue_month,
    revenue,
    previous_month_revenue,

    ROUND(
        revenue - previous_month_revenue,
        2
    ) AS revenue_change,

    ROUND(
        ((revenue - previous_month_revenue)
        / previous_month_revenue) * 100,
        2
    ) AS mom_change_pct
FROM revenue_with_lag
ORDER BY revenue_month;