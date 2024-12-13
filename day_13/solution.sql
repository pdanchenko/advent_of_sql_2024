SELECT
    SPLIT_PART(UNNEST(email_addresses), '@', 2) AS "domain",
    COUNT(1) AS cnt
FROM contact_list
GROUP BY "domain"
ORDER BY cnt DESC
LIMIT 1;


-- The solution to preserve "example result" structure
WITH unpivoted AS (
    SELECT
        SPLIT_PART(UNNEST(email_addresses), '@', 2) AS "domain",
        UNNEST(email_addresses) AS email
    FROM contact_list
)
SELECT
    "domain",
    CARDINALITY(ARRAY_AGG("domain" ORDER BY email)) AS total_users,
    ARRAY_AGG(email ORDER BY email) AS users
FROM unpivoted
GROUP BY "domain"
ORDER BY total_users DESC
LIMIT 1
;