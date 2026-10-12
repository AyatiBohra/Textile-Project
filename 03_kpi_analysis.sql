SELECT
    ROUND(SUM(Rejection) * 100.0 / SUM(total_pdn_yds), 3) AS rejection_rate_pct,
    SUM(total_pdn_yds)  AS total_production_yds,
    SUM(Rejection)      AS total_rejection_yds
FROM rejection;

SELECT Month, SUM(total_pdn_per_machine) AS total_production
FROM production
GROUP BY Month
ORDER BY total_production DESC;

SELECT
    COUNT(DISTINCT Construction) AS n_constructions,
    COUNT(*)                     AS n_rejection_records
FROM rejection;

SELECT
    SUM(CASE WHEN Rejection = 0 THEN 1 ELSE 0 END) AS zero_rejection_orders,
    SUM(CASE WHEN Rejection > 0 THEN 1 ELSE 0 END) AS orders_with_rejection,
    ROUND(SUM(CASE WHEN Rejection = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS pct_zero_rejection
FROM rejection;

SELECT
    ROUND(AVG(total_pdn_yds), 1) AS avg_order_size_yds,
    MIN(total_pdn_yds)           AS min_order_size_yds,
    MAX(total_pdn_yds)           AS max_order_size_yds
FROM rejection;
