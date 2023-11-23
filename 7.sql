-- Получить список аэропортов (airport_name) и количество рейсов, вылетающих из каждого аэропорта,
-- отсортированный по убыванию количества рейсов
SELECT ad.airport_name, f.flight_no, count(flight_no) count
FROM airports_data ad
         join flights f on ad.airport_code = f.departure_airport
group by ad.airport_name, f.flight_no
ORDER BY count DESC;