WITH base_calc AS (
	SELECT
		c.name AS child_name,
		g.name AS toy_name,
		g.price,
		AVG(g.price) OVER () AS avg_price
	FROM children c
	JOIN gifts g
	  ON c.child_id = g.child_id
)
SELECT
	child_name,
	toy_name,
	price,
	price - avg_price AS avg_price_diff
FROM base_calc
WHERE price > avg_price
ORDER BY avg_price_diff
LIMIT 1
;