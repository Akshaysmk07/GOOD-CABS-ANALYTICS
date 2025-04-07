-- Business Request - 1: City-Level Fare and Trip Summary Report

-- Generate a report that displays the total trips, average fare per km, average fare per trip, and the percentage contribution of each city's trips to the overall trips. This report will help in assessing trip volume, pricing efficiency, and each city's contribution to the overall trip count.

-- Fields:

-- city_name
-- total_trips
-- avg_fare_per_km
-- avg_fare_per_trip
-- %_contribution_to_total_trips

SELECT 
    c.city_name,
    COUNT(trip_id) AS total_trips,
    AVG(t.fare_amount / NULLIF(t.distance_travelled_km, 0)) AS avg_fare_per_km,
    AVG(t.fare_amount) AS avg_fare_per_trip,
    ROUND((COUNT(trip_id) * 100.0) / SUM(COUNT(trip_id)) OVER (),2) AS pct_contribution_to_total_trips
FROM dim_city c
JOIN fact_trips t ON c.city_id = t.city_id
GROUP BY c.city_name;

-- Business Request - 2: Monthly City-Level Trips Target Performance Report

-- Generate a report that evaluates the target performance for trips at the monthly and city level. For each city and month, compare the actual total trips with the target trips and categorise the performance as follows:

-- If actual trips are greater than target trips, mark it as "Above Target".
-- If actual trips are less than or equal to target trips, mark it as "Below Target".
-- Additionally, calculate the % difference between actual and target trips to quantify the performance gap.

-- Fields:

-- City_name
-- month_name
-- actual_trips
-- target_trips
-- performance_status
-- %_difference

WITH monthly_actual_citywise AS (
    SELECT 
        city_id, 
        MONTHNAME(date) AS month,  
        COUNT(trip_id) AS actual_trips 
    FROM fact_trips 
    GROUP BY city_id, MONTHNAME(date)
),
monthly_target_citywise AS (
    SELECT 
        MONTHNAME(month) AS month, 
        c.city_id, 
        total_target_trips, 
        c.city_name 
    FROM targets_db.monthly_target_trips tt 
    JOIN trips_db.dim_city c ON tt.city_id = c.city_id
)
SELECT 
    tc.city_name, 
    ac.month, 
    ac.actual_trips, 
    tc.total_target_trips,
    CASE 
        WHEN ac.actual_trips > tc.total_target_trips THEN 'Above Target' 
        ELSE 'Below Target' 
    END AS performance_status, 
    ROUND(
        ((ac.actual_trips - tc.total_target_trips) * 100.0) / NULLIF(tc.total_target_trips, 0), 2
    ) AS pct_difference  -- Prevents division by zero
FROM monthly_actual_citywise ac 
JOIN monthly_target_citywise tc 
ON ac.city_id = tc.city_id AND ac.month = tc.month;

-- BASICS

-- Business Request - 3: City-Level Repeat Passenger Trip Frequency Report

-- Generate a report that shows the percentage distribution of repeat passengers by the number of trips they have taken in each city. Calculate the percentage of repeat passengers who took 2 trips, 3 trips, and so on, up to 10 trips.

-- Each column should represent a trip count category, displaying the percentage of repeat passengers who fall into that category out of the total repeat passengers for that city.

-- This report will help identify cities with high repeat trip frequency, which can indicate strong customer loyalty or frequent usage patterns.

-- Fields: city_name, 2-Trips, 3-Trips, 4-Trips, 5-Trips, 6-Trips, 7-Trips, 8-Trips, 9-Trips, 10-Trips

WITH total_passengers AS (
    SELECT city_id, 
           SUM(repeat_passenger_count) AS total_repeat_passenger_count
    FROM trips_db.dim_repeat_trip_distribution
    GROUP BY city_id
)
SELECT 
    t.city_id,
    ROUND((SUM(CASE WHEN t.trip_count = '2-Trips'  THEN t.repeat_passenger_count ELSE 0 END) / tp.total_repeat_passenger_count) * 100, 2) AS "2-Trips",
    ROUND((SUM(CASE WHEN t.trip_count = '3-Trips'  THEN t.repeat_passenger_count ELSE 0 END) / tp.total_repeat_passenger_count) * 100, 2) AS "3-Trips",
    ROUND((SUM(CASE WHEN t.trip_count = '4-Trips'  THEN t.repeat_passenger_count ELSE 0 END) / tp.total_repeat_passenger_count) * 100, 2) AS "4-Trips",
    ROUND((SUM(CASE WHEN t.trip_count = '5-Trips'  THEN t.repeat_passenger_count ELSE 0 END) / tp.total_repeat_passenger_count) * 100, 2) AS "5-Trips",
    ROUND((SUM(CASE WHEN t.trip_count = '6-Trips'  THEN t.repeat_passenger_count ELSE 0 END) / tp.total_repeat_passenger_count) * 100, 2) AS "6-Trips",
    ROUND((SUM(CASE WHEN t.trip_count = '7-Trips'  THEN t.repeat_passenger_count ELSE 0 END) / tp.total_repeat_passenger_count) * 100, 2) AS "7-Trips",
    ROUND((SUM(CASE WHEN t.trip_count = '8-Trips'  THEN t.repeat_passenger_count ELSE 0 END) / tp.total_repeat_passenger_count) * 100, 2) AS "8-Trips",
    ROUND((SUM(CASE WHEN t.trip_count = '9-Trips'  THEN t.repeat_passenger_count ELSE 0 END) / tp.total_repeat_passenger_count) * 100, 2) AS "9-Trips",
    ROUND((SUM(CASE WHEN t.trip_count = '10-Trips' THEN t.repeat_passenger_count ELSE 0 END) / tp.total_repeat_passenger_count) * 100, 2) AS "10-Trips"
FROM trips_db.dim_repeat_trip_distribution t
JOIN total_passengers tp ON t.city_id = tp.city_id
GROUP BY t.city_id, tp.total_repeat_passenger_count
ORDER BY t.city_id;

-- Business Request - 4: Identify Cities with Highest and Lowest Total New Passengers

-- Generate a report that calculates the total new passengers for each city and ranks them based on this value. Identify the top 3 cities with the highest number of new passengers as well as the bottom 3 cities with the lowest number of new passengers, categorising them as "Top 3" or "Bottom 3" accordingly.

-- Fields

-- city_name
-- total_new_passengers
-- city_category ("Top 3" or "Bottom 3")

WITH total_new_passenger_rank_table AS (
    SELECT 
        c.city_id, 
        c.city_name,
        SUM(ps.new_passengers) AS total_new_passenger,
        DENSE_RANK() OVER (ORDER BY SUM(ps.new_passengers) DESC) AS rnk
    FROM trips_db.fact_passenger_summary ps
    JOIN trips_db.dim_city c ON ps.city_id = c.city_id
    GROUP BY c.city_id, c.city_name
)
SELECT 
    city_name, 
    total_new_passenger, 
    CASE 
        WHEN rnk <= 3 THEN 'TOP 3' 
        ELSE 'BOTTOM 3' 
    END AS city_category
FROM (
    SELECT * 
    FROM total_new_passenger_rank_table 
    WHERE rnk <= 3 OR rnk >= 8
) rnkfiltered;

-- Business Request - 5: Identify Month with Highest Revenue for Each City

-- Generate a report that identifies the month with the highest revenue for each city. For each city, display the month_name, the revenue amount for that month, and the percentage contribution of that month's revenue to the city's total revenue.

-- Fields

-- city_name
-- highest_revenue_month
-- revenue
-- percentage_contribution (%)
with city_total_revenue as (
SELECT 
        c.city_name, 
        SUM(t.fare_amount) AS total_revenue 
    FROM trips_db.fact_trips t
    JOIN trips_db.dim_date d ON t.date = d.date
    JOIN trips_db.dim_city c ON c.city_id = t.city_id 
    GROUP BY c.city_name)
,
monthly_revenue_citywise AS (
    SELECT 
        c.city_name, 
        d.month_name, 
        SUM(t.fare_amount)  total_monthly_revenue, 
        DENSE_RANK() OVER (PARTITION BY c.city_name ORDER BY SUM(t.fare_amount) DESC) AS rnk
    FROM trips_db.fact_trips t
    JOIN trips_db.dim_date d ON t.date = d.date
    JOIN trips_db.dim_city c ON c.city_id = t.city_id 
    GROUP BY c.city_name,d.month_name 
)
SELECT c.city_name, month_name as highest_revenue_month, total_monthly_revenue revenue, round((total_monthly_revenue/nullif(total_revenue,0))*100,2) as percentage_contribution
FROM monthly_revenue_citywise c
join city_total_revenue t on c.city_name = t.city_name
WHERE rnk = 1;
############################################################################################################
##OPTIMIZED SOLUTION
WITH revenue_data AS (
    SELECT 
        c.city_name, 
        d.month_name, 
        SUM(t.fare_amount) AS total_monthly_revenue, 
        SUM(SUM(t.fare_amount)) OVER (PARTITION BY c.city_name) AS total_revenue, 
        DENSE_RANK() OVER (PARTITION BY c.city_name ORDER BY SUM(t.fare_amount) DESC) AS rnk
    FROM trips_db.fact_trips t
    JOIN trips_db.dim_date d ON t.date = d.date
    JOIN trips_db.dim_city c ON c.city_id = t.city_id 
    GROUP BY c.city_name, d.month_name
)
SELECT 
    city_name, 
    month_name AS highest_revenue_month, 
    total_monthly_revenue AS revenue, 
    ROUND((total_monthly_revenue / NULLIF(total_revenue, 0)) * 100, 2) AS percentage_contribution
FROM revenue_data
WHERE rnk = 1;
##########################################################################################################################
-- Business Request - 6: Repeat Passenger Rate Analysis

-- Generate a report that calculates two metrics:

-- Monthly Repeat Passenger Rate: Calculate the repeat passenger rate for each city and month by comparing the number of repeat passengers to the total passengers.
-- City-wide Repeat Passenger Rate: Calculate the overall repeat passenger rate for each city, considering all passengers across months.
-- These metrics will provide insights into monthly repeat trends as well as the overall repeat behaviour for each city.

-- Fields:

-- city_name
-- month
-- total_passengers
-- repeat_passengers
-- monthly_repeat_passenger_rate (%): Repeat passenger rate at the city and month level
-- city_repeat_passenger_rate (%): Overall repeat passenger rate for each city, aggregated across months

WITH passenger_stats AS (
    SELECT 
        c.city_name,
        d.month_name,
        s.total_passengers,
        s.repeat_passengers,
        -- Monthly repeat passenger rate
        ROUND((s.repeat_passengers * 100) / NULLIF(s.total_passengers, 0), 2) AS monthly_repeat_passengers_rate,
        -- City-level repeat passenger rate using window functions
        ROUND(
            (SUM(s.repeat_passengers) OVER (PARTITION BY c.city_name) * 100) / 
            (SUM(s.total_passengers) OVER (PARTITION BY c.city_name)), 
        2) AS city_repeat_passenger_rate
    FROM trips_db.fact_passenger_summary s
    JOIN trips_db.dim_city c ON s.city_id = c.city_id
    JOIN trips_db.dim_date d ON d.date = s.month
)
SELECT * FROM passenger_stats;








