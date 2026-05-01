WITH raw_data AS (
    SELECT * FROM {{ ref('raw_airbnb_data') }}
)

SELECT
    CAST(id AS VARCHAR) AS listing_id,
    TRIM(name) AS listing_name,
    CAST(price AS NUMERIC) AS price_usd,
    COALESCE(CAST(NULLIF(rating, 'New') AS FLOAT), 0) AS rating,
    CAST(reviews AS INT) AS review_count,
    COALESCE(CAST(bathrooms AS FLOAT), 1.0) AS bathrooms, -- assume 1 if empty
    COALESCE(CAST(beds AS INT), 1) AS beds, -- assume 1 if empty
    CAST(guests AS INT) AS guest_capacity
FROM raw_data
WHERE id IS NOT NULL 
  AND price > 0 
  AND price < 20000 