/*
AIRBNB portfolio project

SQL querys to create tables to be used in Tableau visulizations

Skills used: Joins, CTEs, Subqueries, Cleaning Strings, Aggregate Functions
*/


SELECT *
From listings


-- General High Level stats

SELECT COUNT(id), AVG(availability_30) as AVGmonthAvailability
FROM listings


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

SELECT id, latitude, longitude, room_type
FROM listings



-- Ditrubtion of room types

SELECT  room_type, COUNT(room_type) as Num_type
FROM listings
GROUP BY room_type
ORDER BY Num_type DESC


-- # of reviews over time

SELECT date, COUNT(listing_id) as ListingCount
FROM reviews
GROUP BY date
ORDER BY date ASC
