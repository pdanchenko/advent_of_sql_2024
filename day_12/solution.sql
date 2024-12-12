WITH agg AS (
    SELECT
        g.gift_name,
        COUNT(1) AS request_cnt
    FROM gift_requests AS gr
    JOIN gifts AS g
        ON gr.gift_id = g.gift_id
    GROUP BY g.gift_name
)
SELECT DISTINCT ON (percentile)
    gift_name,
    ROUND(PERCENT_RANK() OVER (ORDER BY request_cnt ASC)::NUMERIC, 2) AS percentile
FROM agg
ORDER BY percentile DESC, gift_name
OFFSET 1 LIMIT 1