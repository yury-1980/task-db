-- Найти все рейсы, у которых запланированное время прибытия (scheduled_arrival) было изменено и новое время прибытия
-- (actual_arrival) не совпадает с запланированным
SELECT flight_no
FROM flights
WHERE scheduled_arrival != actual_arrival