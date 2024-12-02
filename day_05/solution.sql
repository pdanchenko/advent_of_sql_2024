WITH base_calc AS (
    SELECT
	    production_date,
	    toys_produced,
	    LAG(toys_produced) OVER (ORDER BY production_date) AS previous_day_production
    FROM toy_production
)
SELECT
    production_date,
    toys_produced,
    previous_day_production,
    toys_produced - previous_day_production AS production_change,
    ROUND((toys_produced / previous_day_production::NUMERIC) * 100, 2) AS production_change_percentage
FROM base_calc
WHERE previous_day_production IS NOT NULL
ORDER BY production_change_percentage DESC
LIMIT 1
;