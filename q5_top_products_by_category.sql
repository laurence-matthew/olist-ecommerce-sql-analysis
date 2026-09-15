-- =====================================================
-- Q5: TOP 3 PRODUCTS WITHIN EACH CATEGORY
-- Business Question:
-- What are the top 3 products by revenue within each category?
-- =====================================================
WITH product_revenue AS (
    SELECT
        p.product_category_name,
        oi.product_id,
        ROUND(
            SUM(CAST(oi.price AS DECIMAL(10,2))),
            2
        ) AS revenue
    FROM order_items AS oi
    INNER JOIN products AS p
        ON oi.product_id = p.product_id
    WHERE p.product_category_name IS NOT NULL
        AND TRIM(p.product_category_name) <> ''
    GROUP BY
        p.product_category_name,
        oi.product_id
),
ranked_products AS (
    SELECT
        *,
        DENSE_RANK() OVER (
            PARTITION BY product_category_name
            ORDER BY revenue DESC
        ) AS revenue_rank
    FROM product_revenue
)
SELECT
    product_category_name,
    product_id,
    revenue,
    revenue_rank
FROM ranked_products
WHERE revenue_rank <= 3
ORDER BY
    product_category_name,
    revenue_rank;