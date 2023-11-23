-- Найти ближайший вылетающий рейс из Екатеринбурга в Москву, на который еще не завершилась регистрация
SELECT flight_no, f.scheduled_departure
FROM flights f
WHERE (f.departure_airport = 'SVX' AND f.arrival_airport IN (SELECT ad.airport_code
                                                             FROM airports_data ad
                                                             WHERE ad.city ->> 'ru' = 'Екатеринбург'
                                                                OR ad.city ->> 'ru' = 'Москва'))
  AND (f.status IN ('Scheduled', 'Delayed', 'On Time'))
ORDER BY f.scheduled_departure
LIMIT 1;

-- SELECT min(f.scheduled_departure) min
--     FROM flights f
/*
Однако для функции bookings.now в любом случае необходимо явно указывать схему, чтобы
отличать её от стандартной функции now.*/

/*(SELECT ad.airport_code
 FROM airports_data ad
 WHERE ad.city ->> 'ru' = 'Екатеринбург'
    OR ad.city ->> 'ru' = 'Москва');
*/

/* f.status = 'Scheduled'
OR f.status = 'Delayed'
OR f.status = 'On Time' */