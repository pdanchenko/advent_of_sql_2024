SELECT date FROM drinks WHERE drink_name = 'Hot Cocoa'
                        GROUP BY date HAVING SUM(quantity) = 38
INTERSECT

SELECT date FROM drinks WHERE drink_name = 'Peppermint Schnapps'
                        GROUP BY date HAVING SUM(quantity) = 298
INTERSECT

SELECT date FROM drinks WHERE drink_name = 'Eggnog'
                        GROUP BY date HAVING SUM(quantity) = 198
;


-- Good approach with FILTER functionality I didn't know about
-- https://github.com/PetitCoinCoin/advent-of-sql-2024/blob/main/day_10.sql
SELECT
    date
FROM (
    SELECT
        date,
        SUM(quantity) FILTER (WHERE drink_name = 'Eggnog') AS eggnog,
        SUM(quantity) FILTER (WHERE drink_name = 'Hot Cocoa') AS hot_cocoa,
        SUM(quantity) FILTER (WHERE drink_name = 'Peppermint Schnapps') AS schnapps
    FROM drinks
    GROUP BY date
)
WHERE hot_cocoa = '38' AND schnapps = '298' AND eggnog = '198';