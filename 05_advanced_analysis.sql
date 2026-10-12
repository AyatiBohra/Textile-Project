WITH construction_summary AS (
    SELECT
        Construction,
        SUM(total_pdn_yds) AS total_pdn,
        SUM(Rejection)     AS total_rej
    FROM rejection
    GROUP BY Construction
)
SELECT
    Construction,
    total_pdn,
    total_rej,
    ROUND(total_rej * 100.0 / total_pdn, 3) AS rejection_rate_pct,
    RANK() OVER (ORDER BY total_rej * 1.0 / total_pdn DESC) AS rejection_rank
FROM construction_summary
WHERE total_pdn > 100000
ORDER BY rejection_rank
LIMIT 5;

SELECT
    Month,
    SUM(total_pdn_per_machine) AS monthly_production,
    SUM(SUM(total_pdn_per_machine)) OVER (
        ORDER BY CASE Month
            WHEN 'January' THEN 1 WHEN 'February' THEN 2 WHEN 'March' THEN 3
            WHEN 'April' THEN 4 WHEN 'May' THEN 5 WHEN 'June' THEN 6
            WHEN 'July' THEN 7 WHEN 'August' THEN 8 WHEN 'September' THEN 9
        END
    ) AS running_total_production
FROM production
GROUP BY Month
ORDER BY CASE Month
    WHEN 'January' THEN 1 WHEN 'February' THEN 2 WHEN 'March' THEN 3
    WHEN 'April' THEN 4 WHEN 'May' THEN 5 WHEN 'June' THEN 6
    WHEN 'July' THEN 7 WHEN 'August' THEN 8 WHEN 'September' THEN 9
END;

WITH construction_summary AS (
    SELECT
        Construction,
        SUM(total_pdn_yds) AS total_pdn,
        SUM(Rejection)     AS total_rej,
        SUM(Rejection) * 1.0 / SUM(total_pdn_yds) AS rejection_rate
    FROM rejection
    GROUP BY Construction
    HAVING SUM(total_pdn_yds) > 50000
)
SELECT
    Construction,
    ROUND(rejection_rate * 100, 3) AS rejection_rate_pct,
    NTILE(4) OVER (ORDER BY rejection_rate DESC) AS rejection_quartile
FROM construction_summary
ORDER BY rejection_rate DESC;

SELECT
    epi,
    ppi,
    weft_count,
    rejection_rate_pct
FROM rejection;

SELECT
    Construction,
    ROUND(SUM(Rejection) * 100.0 / SUM(total_pdn_yds), 3) AS construction_rejection_rate_pct,
    (SELECT ROUND(SUM(Rejection) * 100.0 / SUM(total_pdn_yds), 3) FROM rejection) AS overall_rejection_rate_pct
FROM rejection
GROUP BY Construction
HAVING SUM(total_pdn_yds) > 100000
ORDER BY construction_rejection_rate_pct DESC
LIMIT 10;
