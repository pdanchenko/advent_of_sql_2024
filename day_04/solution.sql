SELECT
    toy_id,
    CARDINALITY(ARRAY(SELECT UNNEST(new_tags)       EXCEPT     SELECT UNNEST(previous_tags)))  AS added_tags_length,
    CARDINALITY(ARRAY(SELECT UNNEST(new_tags)       INTERSECT  SELECT UNNEST(previous_tags)))  AS added_unchanged_tag_length,
    CARDINALITY(ARRAY(SELECT UNNEST(previous_tags)  EXCEPT     SELECT UNNEST(new_tags)))       AS added_removed_tags_length
FROM toy_production
ORDER BY added_tags_length DESC
LIMIT 1
;