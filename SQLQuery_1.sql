/*
AIRBNB portfolio project

SQL querys to create tables to be used in Tableau visulizations

Skills used: Joins, CTEs, Subqueries, Temp Tables, Cleaning Strings, Aggregate Functions
*/


SELECT *
From listings
WHERE neighbourhood IS NULL

-- Clean Neighbourhood data and look at the distribuitons of neighbourhoods

SELECT neighborhood, COUNT(*) AS neighborhood_count
FROM (
    SELECT SUBSTRING(neighbourhood, 1, CHARINDEX(',', neighbourhood) - 1) as neighborhood
    FROM listings
    WHERE neighbourhood IS NOT NULL
) AS neighborhood_extract
GROUP BY neighborhood
ORDER BY neighborhood_count DESC


-- Average nightly price per guest

WITH NightlyPrice 
AS 
(
    SELECT a.id, a.accommodates, AVG(b.price) AS AveragePrice
    FROM listings a 
    JOIN calendar b 
        ON a.id = b.listing_id
    GROUP BY a.id, a.accommodates
)
SELECT id,
    CASE 
        WHEN accommodates <> 0 THEN (AveragePrice / accommodates)
        ELSE NULL 
    END AS PricePerGuest
FROM NightlyPrice
WHERE accommodates IS NOT NULL AND accommodates <> 0

-- Latitiude and Longitude of each listing to make a map visualization





-- Ditrubtion of room types




-- # of reviews over time

SELECT date, COUNT(listing_id) as ListingCount
FROM reviews
GROUP BY date
ORDER BY date ASC
