# Olist SQL Analysis

## Overview

This project analyzes the Olist Brazilian e-commerce dataset using MySQL. The analysis covers eight related tables and focuses on customer behavior, revenue trends, product performance, and customer segmentation.

The `orders` table contains 99,441 orders, with purchase dates ranging from September 4, 2016 to October 17, 2018. Customer-level analysis uses `customer_unique_id` because the 99,441 customer records represent 96,096 unique people. Data-quality checks also identified missing order lifecycle dates, 610 products without a category, and monetary fields imported as text; monetary values were therefore converted to `DECIMAL(10,2)` when used in calculations.

> **Revenue definition note:** Q1-Q3 and Q6 use `order_payments.payment_value` to measure customer/payment revenue. Q4, Q5, and Q8 use `order_items.price` to measure product/category revenue. Q8's denominator therefore represents categorized product revenue, not payment revenue.

## Business Questions

1. **Top Customers** - Who are the top 10 customers by total amount spent?
2. **Monthly Revenue Trend** - What is the monthly revenue trend across the dataset?
3. **Month-over-Month Revenue Change** - What is the month-over-month change in revenue?
4. **Revenue by Product Category** - Which product categories generate the most revenue?
5. **Top Products by Category** - What are the top 3 products by revenue within each category?
6. **Customer Spend Segmentation** - How can customers be segmented into Low, Medium, and High spend tiers?
7. **Repeat vs One-Time Buyers** - How many customers are repeat vs one-time buyers?
8. **Top Category Revenue Contribution** - What percentage of categorized product revenue comes from the top category?

## Key Findings

- **Repeat purchasing is limited.** Of 96,096 unique customers, 93,099 (96.88%) are one-time buyers and only 2,997 (3.12%) are repeat buyers.
- **Customer value is highly uneven.** The Low, Medium, and High spend tiers contain roughly one-third of customers each. Average spend is 50.00 for Low, 109.99 for Medium, and 339.80 for High. The maximum spend in the High tier reaches 13,664.08.
- **Beauty & Health leads categorized product revenue.** `beleza_saude` is the top category with 1,258,681.34 in product revenue.
- **Revenue is not dominated by a single category.** The leading category contributes 9.38% of the 13,412,108.42 in categorized product revenue included in Q8.
- **Monthly revenue varies substantially across the analysis period.** Q2 provides the chronological monthly trend, while Q3 uses `LAG()` to measure the absolute and percentage change from the previous available month.
- **The highest-spending customer is an outlier.** The top customer recorded 13,664.08 in payment value, well above the broader customer spending distribution.

## Recommendations

1. **Prioritize repeat-purchase initiatives.** With 96.88% of customers purchasing only once, Olist should investigate post-purchase retention opportunities such as targeted follow-up campaigns, personalized offers, and incentives for a second purchase. Repeat-purchase performance should then be tracked over time to determine whether these initiatives improve retention.

2. **Use customer value and category performance together for targeting.** High-spend customers average 339.80, substantially above the Medium and Low tiers, while Beauty & Health is the largest product category but represents only 9.38% of categorized product revenue. Olist can use these findings to prioritize high-value customers while maintaining a diversified category strategy rather than relying on a single product category.

## Tools & Skills

- **MySQL / SQL**
- Exploratory data analysis and data-quality validation
- Multi-table `JOIN`s
- Aggregations with `COUNT`, `SUM`, `AVG`, `MIN`, and `MAX`
- `CASE` expressions
- Common Table Expressions (CTEs)
- Window functions: `LAG`, `DENSE_RANK`, `NTILE`, and `OVER`
- Customer segmentation
- Revenue trend and month-over-month analysis
- Product/category ranking
- Business insight development

## Files

| File | Analysis |
|---|---|
| `q1_top_customers.sql` | Top 10 customers by total amount spent |
| `q2_monthly_revenue.sql` | Monthly revenue trend |
| `q3_mom_revenue_change.sql` | Month-over-month revenue change and percentage |
| `q4_category_revenue.sql` | Revenue by product category |
| `q5_top_products_by_category.sql` | Top 3 products within each category |
| `q6_customer_spend_segmentation.sql` | Low, Medium, and High customer spend tiers |
| `q7_repeat_vs_one_time_buyers.sql` | Repeat vs one-time buyer behavior |
| `q8_top_category_revenue_share.sql` | Top category share of categorized product revenue |
| `olist_one_page_insight_summary.pdf` | One-page executive insight summary |

## Analysis Notes

- `customer_unique_id` is used for person-level customer analysis because a person may appear under more than one `customer_id`.
- Q3 compares each observed month with the previous **available** month in the query output. If a calendar month is absent from the source data, `LAG()` does not create the missing month.
- Q6 uses `NTILE(3)`, so Low, Medium, and High are relative tertiles of the observed customer spending distribution rather than fixed monetary thresholds.
- Product categories with null or blank category names are excluded from Q4, Q5, and Q8.
