-- Summary Statistics on Marketing Data

-- 1. Average revenue per campaign
SELECT AVG(revenue) AS avg_revenue_per_campaign FROM marketing_data;

-- 2. Average cost per acquisition (CPA)
SELECT AVG(spend / NULLIF(conversions, 0)) AS avg_cpa FROM marketing_data;

-- 3. Maximum and minimum revenue generated in a single campaign
SELECT MAX(revenue) AS max_revenue, MIN(revenue) AS min_revenue FROM marketing_data;

-- 4. Standard deviation of revenue
SELECT STDDEV(revenue) AS revenue_stddev FROM marketing_data;

-- 5. Revenue distribution by marketing channel
SELECT channel, SUM(revenue) AS total_revenue
FROM marketing_data
GROUP BY channel
ORDER BY total_revenue DESC;

-- 6. Most profitable product based on ROI
SELECT product_name, 
       SUM(revenue) / NULLIF(SUM(spend), 0) AS roi
FROM marketing_data
GROUP BY product_name
ORDER BY roi DESC
LIMIT 5;

-- 7. Overall conversion rate across all campaigns
SELECT (SUM(conversions) * 100.0 / SUM(clicks)) AS overall_conversion_rate
FROM marketing_data;

-- 8. Marketing channel with the highest conversion rate
SELECT channel, (SUM(conversions) * 100.0 / SUM(clicks)) AS conversion_rate
FROM marketing_data
GROUP BY channel
ORDER BY conversion_rate DESC
LIMIT 1;

-- 9. Highest and lowest cost-per-click (CPC) by region
SELECT region, AVG(spend / NULLIF(clicks, 0)) AS avg_cpc
FROM marketing_data
GROUP BY region
ORDER BY avg_cpc DESC;

-- 10. Campaign performance breakdown by quarter
SELECT DATE_TRUNC('quarter', campaign_date) AS quarter, 
       SUM(revenue) AS total_revenue,
       SUM(spend) AS total_spend
FROM marketing_data
GROUP BY quarter
ORDER BY quarter;
