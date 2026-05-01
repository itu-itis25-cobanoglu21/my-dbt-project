WITH staging AS (
    SELECT * FROM {{ ref('airbnb_listings') }}
)

SELECT
    listing_id,
    price_usd,
    rating,
    review_count,
    bathrooms,
    beds,
    guest_capacity,
    ROUND(beds / NULLIF(guest_capacity, 0), 2) AS beds_per_guest,
    
    CASE 
        WHEN review_count > 50 AND rating >= 4.5 THEN 1 
        ELSE 0 
    END AS is_premium_listing

FROM staging





