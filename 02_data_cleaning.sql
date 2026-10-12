DELETE FROM production_raw
WHERE Previous_pdn IS NULL
   OR act_shrink_pct_raw = 'na';

DELETE FROM production_raw
WHERE Previous_pdn_raw = 'TOTAL';

DELETE FROM production_raw
WHERE rowid NOT IN (
    SELECT MIN(rowid) FROM production_raw GROUP BY
    ID, Month, Construction, Req_Finish_Fabrics, Fabric_Allowance,
    rec_beam_length_yds, Shrink_allow, act_shrink_pct, Previous_pdn,
    Req_grey_fabric, req_beam_length_yds, total_pdn_per_machine,
    Rej_and_cut_Piece, Total_pdn_per_order, warp_count, weft_count, epi, ppi
);

ALTER TABLE rejection_raw DROP COLUMN Previous_pdn;

DELETE FROM rejection_raw
WHERE rowid NOT IN (
    SELECT MIN(rowid) FROM rejection_raw GROUP BY
    Construction, Req_Finish_Fabrics, Fabric_Allowance, rec_beam_length_yds,
    Shrink_allow, Req_grey_fabric, req_beam_length_yds, total_pdn_yds,
    Rejection, warp_count, weft_count, epi, ppi
);

DELETE FROM rejection_raw WHERE total_pdn_yds = 0;

UPDATE rejection_raw
SET rejection_rate_pct = ROUND(Rejection * 100.0 / total_pdn_yds, 4);

UPDATE rejection_raw
SET yarn_type = CASE
    WHEN warp_count LIKE '%double%' OR warp_count LIKE '%/%' THEN 'Double/Blended'
    ELSE 'Single'
END;

SELECT COUNT(*) - COUNT(DISTINCT
    Construction||'|'||total_pdn_yds||'|'||Rejection||'|'||warp_count||'|'||epi||'|'||ppi
) AS residual_duplicates
FROM rejection;

SELECT COUNT(*) AS impossible_rejection_rows
FROM rejection
WHERE Rejection < 0 OR total_pdn_yds < 0;

SELECT order_id, Construction, total_pdn_yds, Rejection, rejection_rate_pct
FROM rejection
WHERE rejection_rate_pct > 100;
