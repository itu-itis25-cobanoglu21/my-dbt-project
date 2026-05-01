
SELECT
    listing_id,
    price_usd
FROM {{ ref('airbnb_listings') }}
WHERE price_usd <= 0 OR price_usd >= 20000