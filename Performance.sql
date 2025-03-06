-- Campaign Performance Analysis

-- 1. Best-performing campaigns based on revenue
SELECT campaign_id, SUM(revenue) AS total_revenue
FROM marketing_data
GROUP BY campaign_id
ORDER BY total_revenue DESC
LIMIT 5;

-- 2. Campaigns with the highest return on investment (ROI)
SELECT campaign_id, SUM(revenue) / NULLIF(SUM(spend), 0) AS roi
FROM marketing_data
GROUP BY campaign_id
ORDER BY roi DESC
LIMIT 5;

-- 3. Campaigns with the lowest cost-per-conversion
SELECT campaign_id, SUM(spend) / NULLIF(SUM(conversions), 0) AS cost_per_conversion
FROM marketing_data
GROUP BY campaign_id
ORDER BY cost_per_conversion ASC
LIMIT 5;

-- 4. Which audience segments generate the highest revenue?
SELECT audience_segment, SUM(revenue) AS total_revenue
FROM marketing_data
GROUP BY audience_segment
ORDER BY total_revenue DESC;

-- 5. Which marketing channels bring the most engaged users?
SELECT channel, SUM(clicks) / NULLIF(SUM(impressions), 0) AS engagement_rate
FROM marketing_data
GROUP BY channel
ORDER BY engagement_rate DESC;

-- 6. Analyzing the impact of discount offers on conversion rates
SELECT discount_applied, AVG(conversions * 100.0 / clicks) AS avg_conversion_rate
FROM marketing_data
GROUP BY discount_applied
ORDER BY avg_conversion_rate DESC;

-- 7. How does customer retention differ across campaigns?
SELECT campaign_id, COUNT(DISTINCT customer_id) AS returning_customers
FROM marketing_data
WHERE is_repeat_customer = TRUE
GROUP BY campaign_id
ORDER BY returning_customers DESC;

-- 8. Do longer campaigns perform better?
SELECT CASE 
          WHEN campaign_duration < 10 THEN 'Short'
          WHEN campaign_duration BETWEEN 10 AND 30 THEN 'Medium'
          ELSE 'Long'
       END AS campaign_length_category,
       AVG(revenue) AS avg_revenue,
       AVG(conversions) AS avg_conversions
FROM marketing_data
GROUP BY campaign_length_category
ORDER BY avg_revenue DESC;

-- 9. What is the impact of ad spend on CTR?
SELECT channel, SUM(spend) AS total_spend, 
       SUM(clicks) * 100.0 / SUM(impressions) AS avg_ctr
FROM marketing_data
GROUP BY channel
ORDER BY total_spend DESC;

-- 10. Which quarter had the highest marketing effectiveness?
SELECT DATE_TRUNC('quarter', campaign_date) AS quarter,
       SUM(revenue) / NULLIF(SUM(spend), 0) AS roi
FROM marketing_data
GROUP BY quarter
ORDER BY roi DESC;
