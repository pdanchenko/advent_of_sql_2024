WITH season_sorted AS (
    SELECT
        *,
        CASE season
            WHEN 'Spring' THEN 1
            WHEN 'Summer' THEN 2
            WHEN 'Fall' THEN 3
            WHEN 'Winter' THEN 4
        END season_order
    FROM treeharvests
),
calc_avg AS (
    SELECT AVG(trees_harvested) OVER (PARTITION BY field_name
                                      ORDER BY harvest_year, season_order
                                      ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS three_season_moving_avg
    FROM season_sorted
)
SELECT round(max(three_season_moving_avg), 2) AS max_three_season_moving_avg
FROM calc_avg;


-- More compact but less transparent solution
SELECT ROUND(AVG(trees_harvested) OVER (PARTITION BY field_name
                                  ORDER BY harvest_year, season_order
                                  ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) AS three_season_moving_avg
FROM treeharvests th
JOIN LATERAL (SELECT
    CASE th.season
        WHEN 'Spring' THEN 1
        WHEN 'Summer' THEN 2
        WHEN 'Fall' THEN 3
        WHEN 'Winter' THEN 4
    END season_order) a ON TRUE
ORDER BY three_season_moving_avg DESC
LIMIT 1
;