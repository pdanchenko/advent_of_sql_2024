SELECT STRING_AGG(COALESCE(
    CASE WHEN chr(a.value) ~ '^[a-zA-Z\s!"''(),-.?]$' THEN chr(a.value) ELSE NULL END,
    CASE WHEN chr(b.value) ~ '^[a-zA-Z\s!"''(),-.?]$' THEN chr(b.value) ELSE NULL END), '') AS phrase
FROM letters_a a
JOIN letters_b b
    ON a.id = b.id
;