-- The best possible solution I didn't come up with for some reason :)
SELECT
  c.name
FROM children c
JOIN gifts g
  ON c.child_id = g.child_id
WHERE price > (SELECT AVG(price) FROM gifts)
ORDER BY price
LIMIT 1
;