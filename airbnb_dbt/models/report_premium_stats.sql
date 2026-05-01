
WITH features AS (
    SELECT * FROM {{ ref('mart_airbnb_features') }}
)

SELECT
    is_premium_listing,
    COUNT(listing_id) AS total_listings,
    ROUND(AVG(price_usd), 2) AS average_price
FROM features
GROUP BY is_premium_listing
ORDER BY is_premium_listing DESC