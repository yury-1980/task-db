-- Найти все рейсы, которые задерживались более 2 часов
SELECT actual_departure,
       scheduled_departure,
       extract(hours FROM age(actual_departure, scheduled_departure))    hours_difference,
       extract(minutes FROM age(actual_departure, scheduled_departure))  minutes_difference
FROM flights
WHERE age(actual_departure, scheduled_departure) > INTERVAL '2 hours';