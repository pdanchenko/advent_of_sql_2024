WITH parsed_wish_lists AS (
    SELECT
	    child_id,
	    wishes ->> 'first_choice' AS primary_wish,
	    wishes ->> 'second_choice' AS backup_wish,
	    wishes -> 'colors' ->> 0 AS favourite_color,
	    wishes -> 'colors' AS colors
    FROM wish_lists
)
SELECT
    c.name,
    wl.primary_wish,
    wl.backup_wish,
    wl.favourite_color,
    json_array_length(wl.colors) AS color_count,
    CASE tc.difficulty_to_make
      WHEN 1 THEN 'Simple Gift'
      WHEN 2 THEN 'Moderate Gift'
      ELSE 'Complex Gift'
    END gift_complexity,
    CASE tc.category
      WHEN 'outdoor' THEN 'Outside Workshop'
      WHEN 'educational' THEN 'Learning Workshop'
      ELSE 'General Workshop'
    END workshop_assignment
FROM children c
JOIN parsed_wish_lists wl
    ON c.child_id = wl.child_id
JOIN toy_catalogue tc
    ON wl.primary_wish = tc.toy_name
ORDER BY c.name
LIMIT 5