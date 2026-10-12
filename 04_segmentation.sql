SELECT
    yarn_type,
    COUNT(*)                                        AS n_orders,
    SUM(total_pdn_yds)                               AS total_pdn,
    SUM(Rejection)                                    AS total_rej,
    ROUND(SUM(Rejection) * 100.0 / SUM(total_pdn_yds), 3) AS rejection_rate_pct
FROM rejection
GROUP BY yarn_type
ORDER BY rejection_rate_pct DESC;

SELECT
  CASE
    WHEN epi < 100 THEN '<100 EPI'
    WHEN epi BETWEEN 100 AND 129 THEN '100-129 EPI'
    ELSE '130+ EPI'
  END AS epi_band,
  COUNT(*)                                          AS n_orders,
  SUM(total_pdn_yds)                                 AS total_pdn,
  SUM(Rejection)                                     AS total_rej,
  ROUND(SUM(Rejection) * 100.0 / SUM(total_pdn_yds), 3) AS rejection_rate_pct
FROM rejection
GROUP BY epi_band
ORDER BY rejection_rate_pct DESC;

SELECT
    Construction,
    COUNT(*)                                          AS n_orders,
    SUM(total_pdn_yds)                                 AS total_pdn,
    SUM(Rejection)                                     AS total_rej,
    ROUND(SUM(Rejection) * 100.0 / SUM(total_pdn_yds), 3) AS rejection_rate_pct
FROM rejection
GROUP BY Construction
HAVING SUM(total_pdn_yds) > 100000
ORDER BY rejection_rate_pct DESC
LIMIT 5;

SELECT
    Construction,
    COUNT(*)                                          AS n_orders,
    SUM(total_pdn_yds)                                 AS total_pdn,
    SUM(Rejection)                                     AS total_rej,
    ROUND(SUM(Rejection) * 100.0 / SUM(total_pdn_yds), 3) AS rejection_rate_pct
FROM rejection
GROUP BY Construction
HAVING SUM(total_pdn_yds) > 100000
ORDER BY rejection_rate_pct ASC
LIMIT 5;

SELECT Month, SUM(total_pdn_per_machine) AS total_production
FROM production
WHERE Construction = '40x40/110x90'
GROUP BY Month
ORDER BY
  CASE Month WHEN 'January' THEN 1 WHEN 'February' THEN 2 WHEN 'March' THEN 3
  WHEN 'April' THEN 4 WHEN 'May' THEN 5 WHEN 'June' THEN 6 WHEN 'July' THEN 7
  WHEN 'August' THEN 8 WHEN 'September' THEN 9 END;
