-- ==================================================
-- Q8: TOP CATEGORY REVENUE CONTRIBUTION
-- Business Question:
-- What % of total revenue comes from the top category?
-- ==================================================
WITH category_revenue AS (
    SELECT
        p.product_category_name,
        ROUND(
            SUM(CAST(oi.price AS DECIMAL(10,2))),
            2
        ) AS revenue
    FROM products AS p
    INNER JOIN order_items AS oi
        ON p.product_id = oi.product_id
    WHERE p.product_category_name IS NOT NULL
        AND TRIM(p.product_category_name) <> ''
    GROUP BY p.product_category_name
)
SELECT
    product_category_name AS top_category,
    revenue AS category_revenue,
    SUM(revenue) OVER() AS total_revenue,
    ROUND(revenue * 100.0 / SUM(revenue) OVER(), 2) AS revenue_percentage
FROM category_revenue
ORDER BY revenue DESC
LIMIT 1;