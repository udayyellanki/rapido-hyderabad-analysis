create database rapido;
use rapido;
# 1. all succcessfull bookings
create view successful_bookings as select * from rapido_data where Booking_Status ="success";
select * from successful_bookings;
 
#2. average ride distance for each vechicle type
create view ride_distance_each_vechicle 
as select Vehicle_Type ,avg(Right_Distance)
as avg_distance from rapido_data group by Vehicle_Type;
select * from ride_distance_each_vechicle;
DROP VIEW IF EXISTS rides_cancelled_by_customers ;
#3. rides cancelled by customer
CREATE VIEW rides_cancelled_by_customers AS 
SELECT Customer_ID, COUNT(*) AS cancel_count 
FROM rapido_data 
WHERE Cancel_Ride_by_Customer = "yes" 
GROUP BY Customer_ID;
select count(*) from rides_cancelled_by_customers;

#4. top 5 customers who booked the highest no. of rides
create view top_customers as
select Customer_ID,count(Booking_ID) as
 total_rides from rapido_data group by Customer_ID order by total_rides desc limit 5;
 select * from top_customers;
 
#5. Average customer rating per vehicle type
create view avg_rating_vehicle_type AS
SELECT Vehicle_Type, AVG(Customer_Rating) AS avg_rating
FROM rapido_data
GROUP BY Vehicle_Type;
select * from avg_rating_vehicle_type;

#6.Payment method preference
CREATE VIEW payment_method_stats AS
SELECT Payment_Method, COUNT(*) AS usage_count
FROM rapido_data
GROUP BY Payment_Method
ORDER BY usage_count DESC;
select * from payment_method_stats;

#7.Top 5 Peak Booking Hours
CREATE VIEW peak_booking_hours AS
SELECT 
    HOUR(Data_Time) AS hour_of_day,
    COUNT(*) AS total_bookings
FROM rapido_data
GROUP BY hour_of_day
ORDER BY total_bookings DESC
LIMIT 5;
SELECT * FROM peak_booking_hours;

#8.Most Revenue-Generating Vehicle Type by Hour of Day
CREATE VIEW vehicle_revenue_by_hour AS
SELECT 
    HOUR(Data_Time) AS hour_of_day,
    Vehicle_Type,
    SUM(Booking_Value) AS total_revenue
FROM rapido_data
WHERE Booking_Status = 'success'
GROUP BY hour_of_day, Vehicle_Type
ORDER BY total_revenue DESC
LIMIT 5;
SELECT * FROM vehicle_revenue_by_hour;


