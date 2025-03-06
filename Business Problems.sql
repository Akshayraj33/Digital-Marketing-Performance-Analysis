-- 1. Finding the most cost-effective marketing channel
SELECT channel, SUM(revenue) / NULLIF(SUM(spend), 0) AS roi
FROM marketing_data
GROUP BY channel
ORDER BY roi DESC;

-- 2. Identifying regions with the lowest return on ad spend
SELECT region, SUM(revenue) / NULLIF(SUM(spend), 0) AS roi
FROM marketing_data
GROUP BY region
ORDER BY roi ASC
LIMIT 5;

-- 3. Detecting campaigns with overspending but low ROI
SELECT campaign_id, SUM(spend) AS total_spend, 
       SUM(revenue) / NULLIF(SUM(spend), 0) AS roi
FROM marketing_data
GROUP BY campaign_id
HAVING total_spend > 50000 AND roi < 1;

-- 4. Finding underperforming campaigns based on low conversion rates
SELECT campaign_id, 
       (SUM(conversions) * 100.0 / NULLIF(SUM(clicks), 0)) AS conversion_rate
FROM marketing_data
GROUP BY campaign_id
HAVING conversion_rate < 3
ORDER BY conversion_rate ASC
LIMIT 10;

-- 5. Which marketing campaigns have the highest customer retention?
SELECT campaign_id, COUNT(DISTINCT customer_id) AS repeat_customers
FROM marketing_data
WHERE is_repeat_customer = TRUE
GROUP BY campaign_id
ORDER BY repeat_customers DESC;

-- 6. Identifying seasonal trends in revenue generation
SELECT DATE_TRUNC('month', campaign_date) AS month, 
       SUM(revenue) AS total_revenue
FROM marketing_data
GROUP BY month
ORDER BY month;

-- 7. Determining the impact of discounts on conversion rates
SELECT discount_applied, 
       AVG(conversions * 100.0 / NULLIF(clicks, 0)) AS avg_conversion_rate
FROM marketing_data
GROUP BY discount_applied
ORDER BY avg_conversion_rate DESC;

-- 8. Comparing customer acquisition costs by region
SELECT region, 
       SUM(spend) / NULLIF(SUM(conversions), 0) AS cost_per_acquisition
FROM marketing_data
GROUP BY region
ORDER BY cost_per_acquisition ASC;

-- 9. Which product categories bring in the highest revenue?
SELECT product_category, SUM(revenue) AS total_revenue
FROM marketing_data
GROUP BY product_category
ORDER BY total_revenue DESC;

-- 10. Finding high-spend campaigns that are not generating expected revenue
SELECT campaign_id, SUM(spend) AS total_spend, SUM(revenue) AS total_revenue
FROM marketing_data
GROUP BY campaign_id
HAVING total_spend > 20000 AND total_revenue < 20000
ORDER BY total_spend DESC;
