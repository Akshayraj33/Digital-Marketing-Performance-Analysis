-- Advanced Analysis on Marketing Data

-- 1. Identifying underperforming campaigns (low conversion rate)
SELECT campaign_id, (SUM(conversions) * 100.0 / SUM(clicks)) AS conversion_rate
FROM marketing_data
GROUP BY campaign_id
HAVING conversion_rate < 5
ORDER BY conversion_rate ASC;

-- 2. Finding the impact of marketing spend on revenue
SELECT SUM(spend) AS total_spend, SUM(revenue) AS total_revenue, 
       SUM(revenue) / NULLIF(SUM(spend), 0) AS roi
FROM marketing_data;

-- 3. Best-performing campaigns by cost-per-conversion
SELECT campaign_id, 
       SUM(spend) / NULLIF(SUM(conversions), 0) AS cost_per_conversion
FROM marketing_data
GROUP BY campaign_id
ORDER BY cost_per_conversion ASC
LIMIT 5;

-- 4. Click-through rate (CTR) trend over time
SELECT DATE_TRUNC('month', campaign_date) AS month, 
       AVG(clicks * 100.0 / impressions) AS avg_ctr
FROM marketing_data
GROUP BY month
ORDER BY month;

-- 5. Channel effectiveness based on spend-to-revenue ratio
SELECT channel, SUM(revenue) / NULLIF(SUM(spend), 0) AS revenue_per_dollar_spent
FROM marketing_data
GROUP BY channel
ORDER BY revenue_per_dollar_spent DESC;

-- 6. Which campaigns have a high CPC but low conversion rates?
SELECT campaign_id, AVG(spend / NULLIF(clicks, 0)) AS avg_cpc,
       (SUM(conversions) * 100.0 / SUM(clicks)) AS conversion_rate
FROM marketing_data
GROUP BY campaign_id
HAVING avg_cpc > 5 AND conversion_rate < 3;
