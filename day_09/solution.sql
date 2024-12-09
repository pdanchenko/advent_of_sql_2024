WITH average_speed AS (
    SELECT
        r.reindeer_name,
        ts.exercise_name,
        AVG(ts.speed_record) AS avg_speed
    FROM training_sessions ts
    JOIN reindeers r
      ON ts.reindeer_id = r.reindeer_id
    WHERE r.reindeer_name <> 'Rudolph'
    GROUP BY r.reindeer_name, ts.exercise_name
)
SELECT DISTINCT
    reindeer_name,
    ROUND(FIRST_VALUE(avg_speed) OVER (PARTITION BY reindeer_name ORDER BY avg_speed DESC), 2) AS highest_average_score
FROM average_speed
ORDER BY highest_average_score DESC
LIMIT 3;