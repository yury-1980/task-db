-- Получить список аэропортов (airport_name) и городов (city), в которых есть рейсы с задержкой
SELECT ad.airport_name,
       ad.city
FROM flights
         join airports_data ad
              on ad.airport_code = flights.departure_airport or ad.airport_code = flights.arrival_airport
WHERE actual_departure > scheduled_departure
   OR actual_arrival > scheduled_arrival;