-- 1 --
WITH RECURSIVE cte AS (
    SELECT staff_id, staff_name, 1 AS level, ARRAY[staff_id] AS path
    FROM staff
    WHERE staff_id = 1

    UNION ALL

    SELECT staff.staff_id, staff.staff_name, cte.level + 1, cte.path || staff.staff_id
    FROM cte
    JOIN staff
      ON cte.staff_id = staff.manager_id
)
SELECT
    *
FROM cte
ORDER BY "level" DESC, staff_id
;

-- 2 --
WITH RECURSIVE cte AS (
    SELECT staff_id, staff_name, 1 AS level, manager_id, ARRAY[staff_id] AS path
    FROM staff

    UNION ALL

    SELECT cte.staff_id, cte.staff_name, cte.level + 1, staff.manager_id, staff.staff_id || cte.path
    FROM cte
    JOIN staff
      ON cte.manager_id = staff.staff_id
)
SELECT
    staff_id,
    staff_name,
    "level",
    "path"
FROM cte
WHERE manager_id IS NULL
ORDER BY "level" DESC, staff_id
;