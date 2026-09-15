-- =====================================================
-- Q4: REVENUE BY PRODUCT CATEGORY
-- Business Question:
-- Which product categories generate the most revenue?
-- =====================================================
SELECT
    p.product_category_name,
    ROUND(SUM(CAST(oi.price AS DECIMAL(10,2))), 2) AS category_revenue
FROM products AS p
INNER JOIN order_items AS oi    ON p.product_id = oi.product_id
WHERE p.product_category_name IS NOT NULL
    AND TRIM(p.product_category_name) <> ''
GROUP BY p.product_category_name
ORDER BY category_revenue DESC;